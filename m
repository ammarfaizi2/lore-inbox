Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263719AbTCUSXZ>; Fri, 21 Mar 2003 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263714AbTCUSWV>; Fri, 21 Mar 2003 13:22:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49027
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263719AbTCUSWE>; Fri, 21 Mar 2003 13:22:04 -0500
Date: Fri, 21 Mar 2003 19:37:18 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211937.h2LJbIe7025839@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: move mac-hid to C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/macintosh/mac_hid.c linux-2.5.65-ac2/drivers/macintosh/mac_hid.c
--- linux-2.5.65/drivers/macintosh/mac_hid.c	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.65-ac2/drivers/macintosh/mac_hid.c	2003-02-16 23:46:38.000000000 +0000
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
