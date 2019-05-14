USE `ticket-tracker`;

CREATE TABLE IF NOT EXISTS `user` (
    `id` CHAR(6),
    `first name` VARCHAR(20) NOT NULL,
    `last name` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS `project` (
    `id` INT AUTO_INCREMENT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `description` VARCHAR(4000) NOT NULL,
    `version` VARCHAR(5),
    `start_date` DATE,
    `expected_end_date` DATE,
    `actual_end_date` DATE,
    
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS `subproject` (
    `id` INT AUTO_INCREMENT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `start_date` DATE,
    `expected_end_date` DATE,
    `actual_end_date` DATE,
    `project_id` INT NOT NULL,

    PRIMARY KEY(id),

    FOREIGN KEY(project_id)
        REFERENCES project(id)
);


CREATE TABLE IF NOT EXISTS `dev_ticket` (
    `id` INT AUTO_INCREMENT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `project_id` INT NOT NULL,
    `subproject_id` INT DEFAULT NULL,
    `state` VARCHAR(20) NOT NULL,
    `assignee` CHAR(6),
    `created_by` CHAR(6),
    `version` VARCHAR(5),
    `start_date` DATE,
    `due_date` DATE,
    `date_started` DATE,
    `date_completed` DATE,
    `date_closed` DATE,
    `date_created` DATE,
    `date_reviewed` DATE,
    `date_tested` DATE,
    `time_worked` SMALLINT,
    `time_expected` SMALLINT,
    
    PRIMARY KEY(id),

    FOREIGN KEY(project_id)
        REFERENCES project(id),
    
    FOREIGN KEY(subproject_id)
        REFERENCES subproject(id)
);

ALTER TABLE `dev_ticket` AUTO_INCREMENT = 100;



CREATE TABLE IF NOT EXISTS `ticket_link` (
    `ticket_id` INT NOT NULL,
    `linked_ticket_id` INT NOT NULL,
    `relationship` VARCHAR(20) NOT NULL,

    
    PRIMARY KEY(ticket_id, linked_ticket_id),

    FOREIGN KEY(ticket_id)
        REFERENCES dev_ticket(id),
    
    FOREIGN KEY(linked_ticket_id)
        REFERENCES dev_ticket(id)
);


CREATE TABLE IF NOT EXISTS `ticket_github_links` (
    `id` INT AUTO_INCREMENT NOT NULL,
    `ticket_id` INT NOT NULL,
    `url` VARCHAR(1000) NOT NULL,
    `repo` VARCHAR(50) NOT NULL,

    
    PRIMARY KEY(id),

    FOREIGN KEY(ticket_id)
        REFERENCES dev_ticket(id)
);


CREATE TABLE IF NOT EXISTS `project_github_links` (
    `id` INT AUTO_INCREMENT NOT NULL,
    `project_id` INT NOT NULL,
    `url` VARCHAR(1000) NOT NULL,
    `repo` VARCHAR(50) NOT NULL,

    
    PRIMARY KEY(id),

    FOREIGN KEY(project_id)
        REFERENCES project(id)
);