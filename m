Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTBOUfa>; Sat, 15 Feb 2003 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTBOUec>; Sat, 15 Feb 2003 15:34:32 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:39173 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265126AbTBOUeY>; Sat, 15 Feb 2003 15:34:24 -0500
Date: Sat, 15 Feb 2003 14:36:08 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/cdrom/cdrom.c
Message-ID: <20030215203608.GA20146@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch switches the file to use C99 initializers in an effort to
improve readability and remove warnings if '-W' is used.

Art Haas

===== drivers/cdrom/cdrom.c 1.33 vs edited =====
--- 1.33/drivers/cdrom/cdrom.c	Wed Jan  8 06:03:30 2003
+++ edited/drivers/cdrom/cdrom.c	Sat Feb 15 12:14:19 2003
@@ -2542,33 +2542,81 @@
 
 /* Place files in /proc/sys/dev/cdrom */
 ctl_table cdrom_table[] = {
-	{DEV_CDROM_INFO, "info", &cdrom_sysctl_settings.info, 
-		CDROM_STR_SIZE, 0444, NULL, &cdrom_sysctl_info},
-	{DEV_CDROM_AUTOCLOSE, "autoclose", &cdrom_sysctl_settings.autoclose,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_AUTOEJECT, "autoeject", &cdrom_sysctl_settings.autoeject,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_DEBUG, "debug", &cdrom_sysctl_settings.debug,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_LOCK, "lock", &cdrom_sysctl_settings.lock,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_CHECK_MEDIA, "check_media", &cdrom_sysctl_settings.check,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{0}
-	};
+	{
+		.ctl_name	= DEV_CDROM_INFO,
+		.procname	= "info",
+		.data		= &cdrom_sysctl_settings.info, 
+		.maxlen		= CDROM_STR_SIZE,
+		.mode		= 0444,
+		.proc_handler	= &cdrom_sysctl_info,
+	},
+	{
+		.ctl_name	= DEV_CDROM_AUTOCLOSE,
+		.procname	= "autoclose",
+		.data		= &cdrom_sysctl_settings.autoclose,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cdrom_sysctl_handler,
+	},
+	{
+		.ctl_name	= DEV_CDROM_AUTOEJECT,
+		.procname	= "autoeject",
+		.data		= &cdrom_sysctl_settings.autoeject,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cdrom_sysctl_handler,
+	},
+	{
+		.ctl_name	= DEV_CDROM_DEBUG,
+		.procname	= "debug",
+		.data		= &cdrom_sysctl_settings.debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cdrom_sysctl_handler,
+	},
+	{
+		.ctl_name	= DEV_CDROM_LOCK,
+		.procname	= "lock",
+		.data		= &cdrom_sysctl_settings.lock,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cdrom_sysctl_handler,
+	},
+	{
+		.ctl_name	= DEV_CDROM_CHECK_MEDIA,
+		.procname	= "check_media",
+		.data		= &cdrom_sysctl_settings.check,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cdrom_sysctl_handler
+	},
+	{ .ctl_name = 0 }
+};
 
 ctl_table cdrom_cdrom_table[] = {
-	{DEV_CDROM, "cdrom", NULL, 0, 0555, cdrom_table},
-	{0}
-	};
+	{
+		.ctl_name	= DEV_CDROM,
+		.procname	= "cdrom",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= cdrom_table,
+	},
+	{ .ctl_name = 0 }
+};
 
 /* Make sure that /proc/sys/dev is there */
 ctl_table cdrom_root_table[] = {
 #ifdef CONFIG_PROC_FS
-	{CTL_DEV, "dev", NULL, 0, 0555, cdrom_cdrom_table},
+	{
+		.ctl_name	= CTL_DEV,
+		.procname	= "dev",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= cdrom_cdrom_table,
+	},
 #endif /* CONFIG_PROC_FS */
-	{0}
-	};
+	{ .ctl_name = 0 }
+};
 static struct ctl_table_header *cdrom_sysctl_header;
 
 static void cdrom_sysctl_register(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
