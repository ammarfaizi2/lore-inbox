Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbSLEKqG>; Thu, 5 Dec 2002 05:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSLEKqF>; Thu, 5 Dec 2002 05:46:05 -0500
Received: from holomorphy.com ([66.224.33.161]:42889 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267271AbSLEKqD>;
	Thu, 5 Dec 2002 05:46:03 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [8/8] fix unused function warning in drivers/block/floppy.c
Message-ID: <0212050252.MctaabnbwaWbhc0aKbXazasdVdqd7cIb20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.8aFdwcdaVbOapagccaab9crbMb9dlcUa20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move unregister_devfs_entries under the #ifdef MODULE section to
avoid the warning about unused functions. viro, this is your to ack.

===== drivers/block/floppy.c 1.63 vs edited =====
--- 1.63/drivers/block/floppy.c	Tue Dec  3 10:14:11 2002
+++ edited/drivers/block/floppy.c	Thu Dec  5 02:07:27 2002
@@ -3977,18 +3977,6 @@
     }
 }
 
-static void unregister_devfs_entries (int drive)
-{
-    int i;
-
-    if (UDP->cmos < NUMBER(default_drive_params)) {
-	i = 0;
-	do {
-	    devfs_remove("floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
-	} while (table_sup[UDP->cmos][i++]);
-    }
-}
-
 /*
  * Floppy Driver initialization
  * =============================
@@ -4542,6 +4530,18 @@
 #ifdef MODULE
 
 char *floppy;
+
+static void unregister_devfs_entries (int drive)
+{
+    int i;
+
+    if (UDP->cmos < NUMBER(default_drive_params)) {
+	i = 0;
+	do {
+	    devfs_remove("floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	} while (table_sup[UDP->cmos][i++]);
+    }
+}
 
 static void __init parse_floppy_cfg_string(char *cfg)
 {
