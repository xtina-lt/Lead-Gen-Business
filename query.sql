--------------------------------------------------------------
--                    #  XTINA.CODES  #                     --
--                INSERT INTO table() VALUE()               --
--              UPDATE table SET table.id = 'y'             --
--                  DELETE FROM table WHERE                 --
--                       WHERE id = #                       --
--                   SELECT * FROM table                    --
--                   GROUP BY column DESC                   --
--                     ORDER BY column                      --
--    CONCAT_WS(' ', YEAR(datetime), MONTHNAME(datetime))   --
--            GROUP_CONCAT(list_of_variable_values)         --
--                       SUM(amount)                        --
--   GROUP BY client_id, YEAR(datetime), MONTH(datetime)    --
-- ORDER BY client_id, YEAR(datetime) DESC, MONTH(datetime) --
--------------------------------------------------------------
-- # https://popsql.com/learn-sql/sql-server/how-to-query-date-and-time-in-sql-server
-- # https://www.geeksforgeeks.org/sql-date-functions/

-- # total_revenue for march 2012
-- SELECT SUM(amount) FROM billing
-- WHERE charged_datetime BETWEEN '2012-03-01' AND '2012-04-01'

-- # total_revenue wheere client.id = 2
-- SELECT SUM(amount) FROM billing
-- WHERE client_id = 2

-- # * sites where client.id = 10
-- SELECT domain_name, CONCAT_WS(', ', last_name, first_name) AS owner FROM sites
-- JOIN clients ON clients.client_id = sites.client_id
-- WHERE clients.client_id = 10

-- # count(sites per month), year where client = 1; where client = 1
-- SELECT domain_name, 
-- CONCAT_WS( ' ', YEAR(created_datetime), MONTHNAME(created_datetime) ) AS created,
-- CONCAT_WS(', ', last_name, first_name) AS owner 
-- FROM sites
-- JOIN clients ON clients.client_id = sites.client_id
-- WHERE sites. client_id = 1
-- ORDER BY YEAR(created_datetime) DESC, MONTH(created_datetime)

-- # count(leads) for each of the sites, where date = between jan 1, 2011 and feb 15, 2011
-- SELECT COUNT(leads.leads_id) AS lead_count, domain_name, created_datetime FROM leads
-- JOIN sites ON sites.site_id = leads.site_id
-- WHERE created_datetime BETWEEN '2011-01-01' AND '2011-02-15'
-- GROUP BY leads.site_id
-- ORDER BY lead_count DESC

-- # * clients names, count(leads) between months 1 - 6 of Year 2011
-- SELECT COUNT(leads.leads_id) FROM leads
-- JOIN sites ON leads.site_id = sites.site_id
-- JOIN clients ON sites.client_id = clients.client_id
-- WHERE registered_datetime BETWEEN '2011-01-01' AND '2011-06-01'

-- # client names and the total # of leads we've generated for each of our clients' sites between January 1, 2011 to December 31, 2011? 
-- SELECT domain_name, COUNT(leads_id), CONCAT_WS(', ', clients.last_name, clients.first_name) AS clients FROM leads
-- JOIN sites ON leads.site_id = sites.site_id
-- JOIN clients ON clients.client_id = sites.client_id
-- WHERE registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
-- GROUP BY domain_name
-- ORDER BY clients

-- # CODE REVIEW ASK TO COLLAB FOR SHORTER SOLUTION?!
-- # retrieves total revenue collected from each client for each month of the year
-- # order by client id
-- SELECT SUM(amount) AS amount, 
-- CONCAT_WS(' ', YEAR(charged_datetime), MONTHNAME(charged_datetime)) AS timeframe, 
-- CONCAT_WS(', ', last_name, first_name) AS client 
-- FROM billing
-- JOIN clients ON clients.client_id = billing.client_id
-- GROUP BY billing.client_id, YEAR(charged_datetime), MONTH(charged_datetime)
-- ORDER BY billing.client_id, YEAR(charged_datetime) DESC, MONTH(charged_datetime)

-- # retrieves all the sites that each client owns.
-- # GROUP sites for each client are displayed in a single field
SELECT GROUP_CONCAT(domain_name) AS domain_names, CONCAT_WS(', ', last_name, first_name) AS owner FROM sites
JOIN clients ON clients.client_id = sites.client_id
GROUP BY sites.client_id