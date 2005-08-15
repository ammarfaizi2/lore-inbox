Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVHOVSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVHOVSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVHOVSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:18:34 -0400
Received: from palrel12.hp.com ([156.153.255.237]:22949 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S964924AbVHOVSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:18:33 -0400
Date: Mon, 15 Aug 2005 16:17:50 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/4] cciss 2.4.52 to 2.4.60 updates
Message-ID: <20050815211750.GB12760@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/4
This patch
        1) adds support for next series of Smart Array contollers.
        2) bumps version to 2.4.60.
        3) changes our copyright dates.
        4) adds code to bind to any HP controller with a cciss signature.
Built against 2.4.31. Please consider this for inclusion.

Signed-off-by: Mike Miller

 Documentation/cciss.txt |    6 ++++
 drivers/block/cciss.c   |   60 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/pci_ids.h |    4 +++
 3 files changed, 57 insertions(+), 13 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2431.orig/Documentation/cciss.txt lx2431/Documentation/cciss.txt
--- lx2431.orig/Documentation/cciss.txt	2004-08-07 18:26:04.000000000 -0500
+++ lx2431/Documentation/cciss.txt	2005-08-15 14:16:58.722350496 -0500
@@ -15,7 +15,11 @@ This driver is known to work with the fo
 	* SA 6400 U320 Expansion Module
 	* SA 6i
 	* SA 6422
-	* SA V100
+	* SA P600
+	* SA P400
+	* SA P400i
+	* SA E200
+	* SA E200i
 
 If nodes are not already created in the /dev/cciss directory
 
diff -burNp lx2431.orig/drivers/block/cciss.c lx2431/drivers/block/cciss.c
--- lx2431.orig/drivers/block/cciss.c	2005-05-31 19:56:56.000000000 -0500
+++ lx2431/drivers/block/cciss.c	2005-08-15 14:43:50.375342000 -0500
@@ -1,6 +1,6 @@
 /*
  *    Disk Array driver for HP SA 5xxx and 6xxx Controllers
- *    Copyright 2000, 2002 Hewlett-Packard Development Company, L.P. 
+ *    Copyright 2000, 2005 Hewlett-Packard Development Company, L.P. 
  *
  *    This program is free software; you can redistribute it and/or modify
  *    it under the terms of the GNU General Public License as published by
@@ -45,13 +45,13 @@
 #include <linux/genhd.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.4.52)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,52)
+#define DRIVER_NAME "HP CISS Driver (v 2.4.60)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,60)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
 MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.52");
-MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400 6i SA6422 V100"); 
+MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400 6i SA6422 P600 P400 P400i E200i E200"); 
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -80,8 +80,24 @@ const struct pci_device_id cciss_pci_dev
                         0x0E11, 0x4091, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
                         0x0E11, 0x409E, 0, 0, 0},
-	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISS,
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSA,
+                        0x103C, 0x3225, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
+                        0x103C, 0x3234, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
+                        0x103C, 0x3235, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
                         0x103C, 0x3211, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+                        0x103C, 0x3212, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+                        0x103C, 0x3213, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+                        0x103C, 0x3214, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+                        0x103C, 0x3215, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 
+		PCI_CLASS_STORAGE_RAID << 8, 0xffff << 8, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -103,7 +119,14 @@ static struct board_type products[] = {
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 	{ 0x40910E11, "Smart Array 6i", &SA5_access},
 	{ 0x409E0E11, "Smart Array 6422", &SA5_access},
-	{ 0x3211103C, "Smart Array V100", &SA5_access},
+	{ 0x3234103c, "Smart Array P400", &SA5_access},
+	{ 0x3235103c, "Smart Array P400i", &SA5_access},
+	{ 0x3211103c, "Smart Array E200i", &SA5_access},
+	{ 0x3212103c, "Smart Array E200", &SA5_access},
+	{ 0x3213103c, "Smart Array E200i", &SA5_access},
+	{ 0x3214103c, "Smart Array E200i", &SA5_access},
+	{ 0x3215103c, "Smart Array E200i", &SA5_access},
+	{ 0xFFFF103C, "Unknown Smart Array", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
@@ -2805,12 +2828,6 @@ static int cciss_pci_init(ctlr_info_t *c
 			break;
 		}
 	}
-	if (i == NR_PRODUCTS) {
-		printk(KERN_WARNING "cciss: Sorry, I don't know how"
-			" to access the Smart Array controller %08lx\n", 
-				(unsigned long)board_id);
-		return -1;
-	}
 	if (  (readb(&c->cfgtable->Signature[0]) != 'C') ||
 	      (readb(&c->cfgtable->Signature[1]) != 'I') ||
 	      (readb(&c->cfgtable->Signature[2]) != 'S') ||
@@ -2818,6 +2835,25 @@ static int cciss_pci_init(ctlr_info_t *c
 		printk("Does not appear to be a valid CISS config table\n");
 		return -1;
 	}
+	/* We didn't find the controller in our list. We know the
+	 * signature is valid. If it's an HP device let's try to
+	 * bind to the device and fire it up. Otherwise we bail.
+	 */
+	if (i == NR_PRODUCTS) {
+		if (subsystem_vendor_id == PCI_VENDOR_ID_HP) {
+			c->product_name = products[NR_PRODUCTS-1].product_name;
+			c->access = *(products[NR_PRODUCTS-1].access);
+			printk(KERN_WARNING "cciss: This is an unknown "
+				"Smart Array controller.\n"
+				"cciss: Please update to the latest driver "
+				"available from www.hp.com.\n");
+		} else {
+			printk(KERN_WARNING "cciss: Sorry, I don't know how"
+				" to access the Smart Array controller %08lx\n"
+					, (unsigned long)board_id);
+			return -1;
+		}
+	}
 
 #ifdef CONFIG_X86
 {
diff -burNp lx2431.orig/include/linux/pci_ids.h lx2431/include/linux/pci_ids.h
--- lx2431.orig/include/linux/pci_ids.h	2005-05-31 19:56:56.000000000 -0500
+++ lx2431/include/linux/pci_ids.h	2005-08-15 14:19:21.844592608 -0500
@@ -608,6 +608,10 @@
 #define PCI_DEVICE_ID_HP_PCIX_LBA	0x122e
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_CISS		0x3210
+#define PCI_DEVICE_ID_HP_CISSA		0x3220
+#define PCI_DEVICE_ID_HP_CISSB		0x3222
+#define PCI_DEVICE_ID_HP_CISSC		0x3230
+#define PCI_DEVICE_ID_HP_CISSD		0x3238
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
