Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTBOUh6>; Sat, 15 Feb 2003 15:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTBOUgm>; Sat, 15 Feb 2003 15:36:42 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:40453 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265130AbTBOUe1>; Sat, 15 Feb 2003 15:34:27 -0500
Date: Sat, 15 Feb 2003 14:40:44 -0600
From: Art Haas <ahaas@airmail.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for drivers/md/md.c
Message-ID: <20030215204044.GD20146@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers to improve
readabillity and remove warnings if '-W' is used.

Art Haas

===== drivers/md/md.c 1.135 vs edited =====
--- 1.135/drivers/md/md.c	Tue Feb 11 16:57:51 2003
+++ edited/drivers/md/md.c	Sat Feb 15 13:20:13 2003
@@ -83,21 +83,45 @@
 static struct ctl_table_header *raid_table_header;
 
 static ctl_table raid_table[] = {
-	{DEV_RAID_SPEED_LIMIT_MIN, "speed_limit_min",
-	 &sysctl_speed_limit_min, sizeof(int), 0644, NULL, &proc_dointvec},
-	{DEV_RAID_SPEED_LIMIT_MAX, "speed_limit_max",
-	 &sysctl_speed_limit_max, sizeof(int), 0644, NULL, &proc_dointvec},
-	{0}
+	{
+		.ctl_name	= DEV_RAID_SPEED_LIMIT_MIN,
+		.procname	= "speed_limit_min",
+		.data		= &sysctl_speed_limit_min,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= DEV_RAID_SPEED_LIMIT_MAX,
+		.procname	= "speed_limit_max",
+		.data		= &sysctl_speed_limit_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table raid_dir_table[] = {
-	{DEV_RAID, "raid", NULL, 0, 0555, raid_table},
-	{0}
+	{
+		.ctl_name	= DEV_RAID,
+		.procname	= "raid",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= raid_table,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table raid_root_table[] = {
-	{CTL_DEV, "dev", NULL, 0, 0555, raid_dir_table},
-	{0}
+	{
+		.ctl_name	= CTL_DEV,
+		.procname	= "dev",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.proc_handler	= raid_dir_table,
+	},
+	{ .ctl_name = 0 }
 };
 
 static void md_recover_arrays(void);
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
