Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTDXV7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTDXV7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:59:05 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:8209 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263759AbTDXV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:59:02 -0400
Date: Thu, 24 Apr 2003 17:10:44 -0500
From: mikem@beardog.cca.cpqcorp.net
Message-Id: <200304242210.h3OMAiD01134@beardog.cca.cpqcorp.net>
To: axboe@suse.de
Subject: cciss patches for 2.4.21-rc1, 1 of 4
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, steve.cameron@hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003/04/24

Changes:
	1. Changes marketing name of 6400 to 6402.
	2. Adds support for the 6404/256 expansion module.

diff -urN lx2421p7.orig/Documentation/cciss.txt lx2421p7-1/Documentation/cciss.txt
--- lx2421p7.orig/Documentation/cciss.txt	Mon Apr  7 10:23:52 2003
+++ lx2421p7-1/Documentation/cciss.txt	Mon Apr  7 15:27:12 2003
@@ -11,7 +11,8 @@
 	* SA 5312
 	* SA 641
 	* SA 642
-	* SA 6400
+	* SA 6402
+	* SA 6404/256
 
 If nodes are not already created in the /dev/cciss directory
 
diff -urN lx2421p7.orig/drivers/block/cciss.c lx2421p7-1/drivers/block/cciss.c
--- lx2421p7.orig/drivers/block/cciss.c	Mon Apr  7 10:23:53 2003
+++ lx2421p7-1/drivers/block/cciss.c	Mon Apr  7 15:33:15 2003
@@ -44,12 +44,12 @@
 #include <linux/genhd.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.4.42)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,42)
+#define DRIVER_NAME "HP CISS Driver (v 2.4.44)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,44)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Charles M. White III - Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.42");
+MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.44");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"); 
 MODULE_LICENSE("GPL");
 
@@ -73,6 +73,8 @@
                         0x0E11, 0x409B, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
                         0x0E11, 0x409C, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+                        0x0E11, 0x409D, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -90,7 +92,8 @@
 	{ 0x40830E11, "Smart Array 5312", &SA5B_access},
 	{ 0x409A0E11, "Smart Array 641", &SA5_access},
 	{ 0x409B0E11, "Smart Array 642", &SA5_access},
-	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
+	{ 0x409C0E11, "Smart Array 6402", &SA5_access},
+	{ 0x409C0E11, "Smart Array 6404/256", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
