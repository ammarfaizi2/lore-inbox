Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUBEAHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUBEAF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:05:59 -0500
Received: from mailout.zma.compaq.com ([161.114.64.104]:28421 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264392AbUBEAE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:04:58 -0500
Date: Wed, 4 Feb 2004 18:09:20 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [3 of 11]
Message-ID: <Pine.LNX.4.58.0402041807340.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3 of 11. Please apply in order.
This patch adds support for the next generation embedded cciss controller.
It also bumps the version and changes the author to HP.
Please consider this for inclusion.
This patch is in 2.4.
--------------------------------------------------------------------------------------
diff -burN lx261-p002/Documentation/cciss.txt lx261/Documentation/cciss.txt
--- lx261-p002/Documentation/cciss.txt	2004-01-09 00:59:09.000000000 -0600
+++ lx261/Documentation/cciss.txt	2004-01-21 16:24:43.000000000 -0600
@@ -13,6 +13,7 @@
 	* SA 642
 	* SA 6400
 	* SA 6400 U320 Expansion Module
+	* SA 6i

 If nodes are not already created in the /dev/cciss directory

diff -burN lx261-p002/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p002/drivers/block/cciss.c	2004-01-21 16:16:41.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-21 16:31:59.000000000 -0600
@@ -45,12 +45,14 @@
 #include <linux/completion.h>

 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.5.0)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,0)
+#define DRIVER_NAME "Compaq CISS Driver (v 2.6.0)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,0)

 /* Embedded module documentation macros - see modules.h */
-MODULE_AUTHOR("Charles M. White III - Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.0");
+MODULE_AUTHOR("Hewlett-Packard Company");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.0");
+MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
+			" SA6i");
 MODULE_LICENSE("GPL");

 #include "cciss_cmd.h"
@@ -75,6 +77,8 @@
 		0x0E11, 0x409C, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
 		0x0E11, 0x409D, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x0E11, 0x4091, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -94,6 +98,7 @@
 	{ 0x409B0E11, "Smart Array 642", &SA5_access},
 	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
+	{ 0x40910E11, "Smart Array 6i", &SA5_access},
 };

 /* How long to wait (in millesconds) for board to go into simple mode */

Thanks,
mikem
mike.miller@hp.com

