Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUEGUIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUEGUIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUEGUG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:06:58 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:63246 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263740AbUEGUFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:05:12 -0400
Date: Fri, 7 May 2004 12:20:29 -0500
From: mikem@beardog.cca.cpqcorp.net
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update for 2.4.27
Message-ID: <20040507172029.GA5904@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 2 new controllers. One is 6422, a PCI-Express version of the 6400. The other is a SATA controller that uses the cciss interface.
This controller is also the first Smart Array to use the HP vendor ID.
Please consider this for inclusion.

Thanks,
mikem
------------------------------------------------------------------------------
 Documentation/cciss.txt |    2 ++
 drivers/block/cciss.c   |   14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff -burpN lx2426.orig/Documentation/cciss.txt lx2426/Documentation/cciss.txt
--- lx2426.orig/Documentation/cciss.txt	2003-11-28 12:26:19.000000000 -0600
+++ lx2426/Documentation/cciss.txt	2004-05-07 11:55:41.000000000 -0500
@@ -14,6 +14,8 @@ This driver is known to work with the fo
 	* SA 6400
 	* SA 6400 U320 Expansion Module
 	* SA 6i
+	* SA 6422
+	* SA V100
 
 If nodes are not already created in the /dev/cciss directory
 
diff -burpN lx2426.orig/drivers/block/cciss.c lx2426/drivers/block/cciss.c
--- lx2426.orig/drivers/block/cciss.c	2004-04-14 08:05:29.000000000 -0500
+++ lx2426/drivers/block/cciss.c	2004-05-07 11:56:25.000000000 -0500
@@ -45,13 +45,13 @@
 #include <linux/genhd.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.4.50)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,50)
+#define DRIVER_NAME "HP CISS Driver (v 2.4.52)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,52)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.50");
-MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400 6i"); 
+MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.52");
+MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400 6i SA6422 V100"); 
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -78,6 +78,10 @@ const struct pci_device_id cciss_pci_dev
                         0x0E11, 0x409D, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
                         0x0E11, 0x4091, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+                        0x0E11, 0x409E, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+                        0x103C, 0x3211, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -98,6 +102,8 @@ static struct board_type products[] = {
 	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 	{ 0x40910E11, "Smart Array 6i", &SA5_access},
+	{ 0x409E0E11, "Smart Array 6422", &SA5_access},
+	{ 0x3211103C, "Smart Array V100", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
