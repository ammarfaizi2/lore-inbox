Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVAGXCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVAGXCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVAGXBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:01:41 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:18184 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261679AbVAGW6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:58:48 -0500
Date: Fri, 7 Jan 2005 16:58:43 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2.6] cciss update to version 2.6.4
Message-ID: <20050107225843.GA26037@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes support for 2 controllers that were recently cancelled and
it adds support for the P600, a cciss based SAS controller due to ship in 
late March/early April '05.
Neither of these controllers have made it to the field.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 Documentation/cciss.txt |    3 +--
 drivers/block/cciss.c   |   17 +++++++----------
 include/linux/pci_ids.h |    2 +-
 3 files changed, 9 insertions(+), 13 deletions(-)
-------------------------------------------------------------------------------
diff -burNp lx2610.orig/Documentation/cciss.txt lx2610/Documentation/cciss.txt
--- lx2610.orig/Documentation/cciss.txt	2004-12-24 15:34:00.000000000 -0600
+++ lx2610/Documentation/cciss.txt	2005-01-07 11:51:15.590391280 -0600
@@ -14,8 +14,7 @@ This driver is known to work with the fo
 	* SA 6400
 	* SA 6400 U320 Expansion Module
 	* SA 6i
-	* SA 6422
-	* SA V100
+	* SA P600
 
 If nodes are not already created in the /dev/cciss directory
 
diff -burNp lx2610.orig/drivers/block/cciss.c lx2610/drivers/block/cciss.c
--- lx2610.orig/drivers/block/cciss.c	2004-12-24 15:35:39.000000000 -0600
+++ lx2610/drivers/block/cciss.c	2005-01-07 11:50:43.366290088 -0600
@@ -46,14 +46,14 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.6.2)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,2)
+#define DRIVER_NAME "HP CISS Driver (v 2.6.4)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,4)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.2");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.4");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-			" SA6i V100");
+			" SA6i P600");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -80,10 +80,8 @@ const struct pci_device_id cciss_pci_dev
 		0x0E11, 0x409D, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
 		0x0E11, 0x4091, 0, 0, 0},
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
-		0x0E11, 0x409E, 0, 0, 0},
-	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISS,
-		0x103C, 0x3211, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSA,
+		0x103C, 0x3225, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -104,8 +102,7 @@ static struct board_type products[] = {
 	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 	{ 0x40910E11, "Smart Array 6i", &SA5_access},
-	{ 0x409E0E11, "Smart Array 6422", &SA5_access},
-	{ 0x3211103C, "Smart Array V100", &SA5_access},
+	{ 0x3225103C, "Smart Array P600", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
diff -burNp lx2610.orig/include/linux/pci_ids.h lx2610/include/linux/pci_ids.h
--- lx2610.orig/include/linux/pci_ids.h	2004-12-24 15:35:50.000000000 -0600
+++ lx2610/include/linux/pci_ids.h	2005-01-07 11:54:24.945604912 -0600
@@ -680,7 +680,7 @@
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
-#define PCI_DEVICE_ID_HP_CISS		0x3210
+#define PCI_DEVICE_ID_HP_CISSA		0x3220
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
