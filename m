Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTBOUgJ>; Sat, 15 Feb 2003 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTBOUfn>; Sat, 15 Feb 2003 15:35:43 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:44037 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265126AbTBOUej>; Sat, 15 Feb 2003 15:34:39 -0500
Date: Sat, 15 Feb 2003 14:39:28 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] C99 initializers for drivers/macintosh/mac_hid.c
Message-ID: <20030215203928.GC20146@debian>
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

===== drivers/macintosh/mac_hid.c 1.8 vs edited =====
--- 1.8/drivers/macintosh/mac_hid.c	Tue Oct  8 05:51:31 2002
+++ edited/drivers/macintosh/mac_hid.c	Sat Feb 15 13:19:37 2003
@@ -25,38 +25,56 @@
 
 #if defined(CONFIG_SYSCTL)
 /* file(s) in /proc/sys/dev/mac_hid */
-ctl_table mac_hid_files[] =
-{
-  {
-    DEV_MAC_HID_MOUSE_BUTTON_EMULATION,
-    "mouse_button_emulation", &mouse_emulate_buttons, sizeof(int),
-    0644, NULL, &proc_dointvec
-  },
-  {
-    DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE,
-    "mouse_button2_keycode", &mouse_button2_keycode, sizeof(int),
-    0644, NULL, &proc_dointvec
-  },
-  {
-    DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE,
-    "mouse_button3_keycode", &mouse_button3_keycode, sizeof(int),
-    0644, NULL, &proc_dointvec
-  },
-  { 0 }
+ctl_table mac_hid_files[] = {
+	{
+		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON_EMULATION,
+		.procname	= "mouse_button_emulation",
+		.data		= &mouse_emulate_buttons,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE,
+		.procname	= "mouse_button2_keycode",
+		.data		= &mouse_button2_keycode,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE,
+		.procname	= "mouse_button3_keycode",
+		.data		= &mouse_button3_keycode,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 /* dir in /proc/sys/dev */
-ctl_table mac_hid_dir[] =
-{
-  { DEV_MAC_HID, "mac_hid", NULL, 0, 0555, mac_hid_files },
-  { 0 }
+ctl_table mac_hid_dir[] = {
+	{
+		.ctl_name	= DEV_MAC_HID,
+		.procname	= "mac_hid",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= mac_hid_files,
+	},
+	{ .ctl_name = 0 }
 };
 
 /* /proc/sys/dev itself, in case that is not there yet */
-ctl_table mac_hid_root_dir[] =
-{
-  { CTL_DEV, "dev", NULL, 0, 0555, mac_hid_dir },
-  { 0 }
+ctl_table mac_hid_root_dir[] = {
+	{
+		.ctl_name	= CTL_DEV,
+		.procname	= "dev",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= mac_hid_dir,
+	},
+	{ .ctl_name = 0 }
 };
 
 static struct ctl_table_header *mac_hid_sysctl_header;
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
