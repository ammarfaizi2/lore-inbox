Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTBOUeZ>; Sat, 15 Feb 2003 15:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbTBOUeZ>; Sat, 15 Feb 2003 15:34:25 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:38661 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265114AbTBOUeV>; Sat, 15 Feb 2003 15:34:21 -0500
Date: Sat, 15 Feb 2003 14:37:07 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/char/rtc.c
Message-ID: <20030215203707.GB20146@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers to improve
readability and remove warnings if '-W' is used.

Art Haas

===== drivers/char/rtc.c 1.21 vs edited =====
--- 1.21/drivers/char/rtc.c	Sun Feb  9 19:29:56 2003
+++ edited/drivers/char/rtc.c	Sat Feb 15 12:17:36 2003
@@ -211,19 +211,37 @@
  * sysctl-tuning infrastructure.
  */
 static ctl_table rtc_table[] = {
-    { 1, "max-user-freq", &rtc_max_user_freq, sizeof(int), 0644, NULL,
-      &proc_dointvec, NULL, },
-    { 0, }
+	{
+		.ctl_name	= 1,
+		.procname	= "max-user-freq",
+		.data		= &rtc_max_user_freq,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table rtc_root[] = {
-    { 1, "rtc", NULL, 0, 0555, rtc_table, },
-    { 0, }
+	{
+		.ctl_name	= 1,
+		.procname	= "rtc",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= rtc_table,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table dev_root[] = {
-    { CTL_DEV, "dev", NULL, 0, 0555, rtc_root, },
-    { 0, }
+	{
+		.ctl_name	= CTL_DEV,
+		.procname	= "dev",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= rtc_root,
+	},
+	{ .ctl_name = 0 }
 };
 
 static struct ctl_table_header *sysctl_header;
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
