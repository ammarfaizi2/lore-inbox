Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTBOUh7>; Sat, 15 Feb 2003 15:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTBOUgf>; Sat, 15 Feb 2003 15:36:35 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:42757 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265134AbTBOUea>; Sat, 15 Feb 2003 15:34:30 -0500
Date: Sat, 15 Feb 2003 14:43:23 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/net/arlan-proc.c
Message-ID: <20030215204323.GF20146@debian>
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

===== drivers/net/arlan-proc.c 1.5 vs edited =====
--- 1.5/drivers/net/arlan-proc.c	Tue Feb  5 01:49:26 2002
+++ edited/drivers/net/arlan-proc.c	Sat Feb 15 14:17:42 2003
@@ -816,14 +816,18 @@
 
 /* Place files in /proc/sys/dev/arlan */
 #define CTBLN(num,card,nam) \
-        {num , #nam, &(arlan_conf[card].nam), \
-         sizeof(int), 0600, NULL, &proc_dointvec}
+        { .ctl_name = num,\
+          .procname = #nam,\
+          .data = &(arlan_conf[card].nam),\
+          .maxlen = sizeof(int), .mode = 0600, .proc_handler = &proc_dointvec}
 #ifdef ARLAN_DEBUGGING
 
-#define ARLAN_PROC_DEBUG_ENTRIES	{48, "entry_exit_debug", &arlan_entry_and_exit_debug, \
-                sizeof(int), 0600, NULL, &proc_dointvec},\
-	{49, "debug", &arlan_debug, \
-                sizeof(int), 0600, NULL, &proc_dointvec},
+#define ARLAN_PROC_DEBUG_ENTRIES \
+        { .ctl_name = 48, .procname = "entry_exit_debug",\
+          .data = &arlan_entry_and_exit_debug,\
+          .maxlen = sizeof(int), .mode = 0600, .proc_handler = &proc_dointvec},\
+	{ .ctl_name = 49, .procname = "debug", .data = &arlan_debug,\
+          .maxlen = sizeof(int), .mode = 0600, .proc_handler = &proc_dointvec},
 #else 
 #define ARLAN_PROC_DEBUG_ENTRIES
 #endif
@@ -858,8 +862,9 @@
 	CTBLN(27,cardNo, txTimeoutMs),\
 	CTBLN(28,cardNo, waitCardTimeout),\
 	CTBLN(29,cardNo, channelSet), \
-	{30, "name", arlan_conf[cardNo].siteName, \
-                16, 0600, NULL, &proc_dostring},\
+	{.ctl_name = 30, .procname = "name",\
+	 .data = arlan_conf[cardNo].siteName,\
+	 .maxlen = 16, .mode = 0600, .proc_handler = &proc_dostring},\
 	CTBLN(31,cardNo,waitTime),\
 	CTBLN(32,cardNo,lParameter),\
 	CTBLN(33,cardNo,_15),\
@@ -897,22 +902,64 @@
 	ARLAN_SYSCTL_TABLE_TOTAL(0)
 
 #ifdef ARLAN_PROC_SHM_DUMP
-	{150, "arlan0-txRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_infotxRing},
-	{151, "arlan0-rxRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_inforxRing},
-	{152, "arlan0-18", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info18},
-	{153, "arlan0-ring", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info161719},
-	{154, "arlan0-shm-cpy", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info},
-#endif
-	{155, "config0", &conf_reset_result, \
-	 100, 0400, NULL, &arlan_configure}, \
-	{156, "reset0", &conf_reset_result, \
-	 100, 0400, NULL, &arlan_sysctl_reset}, \
-	{0}
+	{
+		.ctl_name	= 150,
+		.procname	= "arlan0-txRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_infotxRing,
+	},
+	{
+		.ctl_name	= 151,
+		.procname	= "arlan0-rxRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_inforxRing,
+	},
+	{
+		.ctl_name	= 152,
+		.procname	= "arlan0-18",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info18,
+	},
+	{
+		.ctl_name	= 153,
+		.procname	= "arlan0-ring",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info161719,
+	},
+	{
+		.ctl_name	= 154,
+		.procname	= "arlan0-shm-cpy",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info,
+	},
+#endif
+	{
+		.ctl_name	= 155,
+		.procname	= "config0",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_configure
+	},
+	{
+		.ctl_name	= 156,
+		.procname	= "reset0",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_reset,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table arlan_conf_table1[] =
@@ -921,22 +968,64 @@
 	ARLAN_SYSCTL_TABLE_TOTAL(1)
 
 #ifdef ARLAN_PROC_SHM_DUMP
-	{150, "arlan1-txRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_infotxRing},
-	{151, "arlan1-rxRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_inforxRing},
-	{152, "arlan1-18", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info18},
-	{153, "arlan1-ring", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info161719},
-	{154, "arlan1-shm-cpy", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info},
-#endif
-	{155, "config1", &conf_reset_result,
-	 100, 0400, NULL, &arlan_configure},
-	{156, "reset1", &conf_reset_result,
-	 100, 0400, NULL, &arlan_sysctl_reset},
-	{0}
+	{
+		.ctl_name	= 150,
+		.procname	= "arlan1-txRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_infotxRing,
+	},
+	{
+		.ctl_name	= 151,
+		.procname	= "arlan1-rxRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_inforxRing,
+	},
+	{
+		.ctl_name	= 152,
+		.procname	= "arlan1-18",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info18,
+	},
+	{
+		.ctl_name	= 153,
+		.procname	= "arlan1-ring",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info161719,
+	},
+	{
+		.ctl_name	= 154,
+		.procname	= "arlan1-shm-cpy",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info,
+	},
+#endif
+	{
+		.ctl_name	= 155,
+		.procname	= "config1",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_configure,
+	},
+	{
+		.ctl_name	= 156,
+		.procname	= "reset1",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_reset,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table arlan_conf_table2[] =
@@ -945,22 +1034,64 @@
 	ARLAN_SYSCTL_TABLE_TOTAL(2)
 
 #ifdef ARLAN_PROC_SHM_DUMP
-	{150, "arlan2-txRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_infotxRing},
-	{151, "arlan2-rxRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_inforxRing},
-	{152, "arlan2-18", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info18},
-	{153, "arlan2-ring", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info161719},
-	{154, "arlan2-shm-cpy", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info},
-#endif
-	{155, "config2", &conf_reset_result,
-	 100, 0400, NULL, &arlan_configure},
-	{156, "reset2", &conf_reset_result,
-	 100, 0400, NULL, &arlan_sysctl_reset},
-	{0}
+	{
+		.ctl_name	= 150,
+		.procname	= "arlan2-txRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_infotxRing,
+	},
+	{
+		.ctl_name	= 151,
+		.procname	= "arlan2-rxRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_inforxRing,
+	},
+	{
+		.ctl_name	= 152,
+		.procname	= "arlan2-18",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info18,
+	},
+	{
+		.ctl_name	= 153,
+		.procname	= "arlan2-ring",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info161719,
+	},
+	{
+		.ctl_name	= 154,
+		.procname	= "arlan2-shm-cpy",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info,
+	},
+#endif
+	{
+		.ctl_name	= 155,
+		.procname	= "config2",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_configure,
+	},
+	{
+		.ctl_name	= 156,
+		.procname	= "reset2",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_reset,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table arlan_conf_table3[] =
@@ -969,47 +1100,113 @@
 	ARLAN_SYSCTL_TABLE_TOTAL(3)
 
 #ifdef ARLAN_PROC_SHM_DUMP
-	{150, "arlan3-txRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_infotxRing},
-	{151, "arlan3-rxRing", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_inforxRing},
-	{152, "arlan3-18", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info18},
-	{153, "arlan3-ring", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info161719},
-	{154, "arlan3-shm-cpy", &arlan_drive_info,
-	 ARLAN_STR_SIZE, 0400, NULL, &arlan_sysctl_info},
-#endif
-	{155, "config3", &conf_reset_result,
-	 100, 0400, NULL, &arlan_configure},
-	{156, "reset3", &conf_reset_result,
-	 100, 0400, NULL, &arlan_sysctl_reset},
-	{0}
+	{
+		.ctl_name	= 150,
+		.procname	= "arlan3-txRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_infotxRing,
+	},
+	{
+		.ctl_name	= 151,
+		.procname	= "arlan3-rxRing",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_inforxRing,
+	},
+	{
+		.ctl_name	= 152,
+		.procname	= "arlan3-18",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info18,
+	},
+	{
+		.ctl_name	= 153,
+		.procname	= "arlan3-ring",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info161719,
+	},
+	{
+		.ctl_name	= 154,
+		.procname	= "arlan3-shm-cpy",
+		.data		= &arlan_drive_info,
+		.maxlen		= ARLAN_STR_SIZE,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_info,
+	},
+#endif
+	{
+		.ctl_name	= 155,
+		.procname	= "config3",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_configure,
+	},
+	{
+		.ctl_name	= 156,
+		.procname	= "reset3",
+		.data		= &conf_reset_result,
+		.maxlen		= 100,
+		.mode		= 0400,
+		.proc_handler	= &arlan_sysctl_reset,
+	},
+	{ .ctl_name = 0 }
 };
 
 
 
 static ctl_table arlan_table[] =
 {
-	{0, "arlan0", NULL, 0, 0600, arlan_conf_table0},
-	{0, "arlan1", NULL, 0, 0600, arlan_conf_table1},
-	{0, "arlan2", NULL, 0, 0600, arlan_conf_table2},
-	{0, "arlan3", NULL, 0, 0600, arlan_conf_table3},
-	{0}
+	{
+		.ctl_name	= 0,
+		.procname	= "arlan0",
+		.maxlen		= 0,
+		.mode		= 0600,
+		.child		= arlan_conf_table0,
+	},
+	{
+		.ctl_name	= 0,
+		.procname	= "arlan1",
+		.maxlen		= 0,
+		.mode		= 0600,
+		.child		= arlan_conf_table1,
+	},
+	{
+		.ctl_name	= 0,
+		.procname	= "arlan2",
+		.maxlen		= 0,
+		.mode		= 0600,
+		.child		= arlan_conf_table2,
+	},
+	{
+		.ctl_name	= 0,
+		.procname	= "arlan3",
+		.maxlen		= 0,
+		.mode		= 0600,
+		.child		= arlan_conf_table3,
+	},
+	{ .ctl_name = 0 }
 };
 
 #else
 
 static ctl_table arlan_table[MAX_ARLANS + 1] =
 {
-	{0}
+	{ .ctl_name = 0 }
 };
 #endif
 #else
 
 static ctl_table arlan_table[MAX_ARLANS + 1] =
 {
-	{0}
+	{ .ctl_name = 0 }
 };
 #endif
 
@@ -1018,8 +1215,14 @@
 
 static ctl_table arlan_root_table[] =
 {
-	{254, "arlan", NULL, 0, 0555, arlan_table},
-	{0}
+	{
+		.ctl_name	= 254,
+		.procname	= "arlan",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= arlan_table,
+	},
+	{ .ctl_name = 0 }
 };
 
 /* Make sure that /proc/sys/dev is there */
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
