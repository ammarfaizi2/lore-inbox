Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbVIIWAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVIIWAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVIIWAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:00:52 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:28822 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030381AbVIIWAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:00:51 -0400
Date: Fri, 9 Sep 2005 17:00:26 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/8] cciss: new controller pci/subsystem ids
Message-ID: <20050909220026.GA4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: All patches in this set have been tested.

Patch 1 of 8

This patch adds new PCI and subsystem ID's that finally made the spec. It also
include a name change for one controller. I know there's a lot of duplicat names
 but the fw folks wanted this for the different implementations.
Even though the same ASIC is used it may be embedded on some platforms,
standup card in others, and a mezzanine in other servers.
Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 Documentation/cciss.txt |    4 +++-
 drivers/block/cciss.c   |   33 ++++++++++++++++++++++++---------
 include/linux/pci_ids.h |    4 +++-
 3 files changed, 30 insertions(+), 11 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613.orig/Documentation/cciss.txt lx2613/Documentation/cciss.txt
--- lx2613.orig/Documentation/cciss.txt	2005-08-28 18:41:01.000000000 -0500
+++ lx2613/Documentation/cciss.txt	2005-09-07 13:28:14.743543592 -0500
@@ -17,7 +17,9 @@ This driver is known to work with the fo
 	* SA P600
 	* SA P800
 	* SA E400
-	* SA E300
+	* SA P400i
+	* SA E200
+	* SA E200i
 
 If nodes are not already created in the /dev/cciss directory, run as root:
 
diff -burNp lx2613.orig/drivers/block/cciss.c lx2613/drivers/block/cciss.c
--- lx2613.orig/drivers/block/cciss.c	2005-08-28 18:41:01.000000000 -0500
+++ lx2613/drivers/block/cciss.c	2005-09-07 13:27:05.390086920 -0500
@@ -47,14 +47,14 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.6.6)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,6)
+#define DRIVER_NAME "HP CISS Driver (v 2.6.8)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,8)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.6");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.8");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-			" SA6i P600 P800 E400 E300");
+			" SA6i P600 P800 P400 P400i E200 E200i");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -83,12 +83,22 @@ static const struct pci_device_id cciss_
 		0x0E11, 0x4091, 0, 0, 0},
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSA,
 		0x103C, 0x3225, 0, 0, 0},
-	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSB,
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
 		0x103c, 0x3223, 0, 0, 0},
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
-		0x103c, 0x3231, 0, 0, 0},
+		0x103c, 0x3234, 0, 0, 0},
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
-		0x103c, 0x3233, 0, 0, 0},
+		0x103c, 0x3235, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+		0x103c, 0x3211, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+		0x103c, 0x3212, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+		0x103c, 0x3213, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+		0x103c, 0x3214, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
+		0x103c, 0x3215, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -111,8 +121,13 @@ static struct board_type products[] = {
 	{ 0x40910E11, "Smart Array 6i", &SA5_access},
 	{ 0x3225103C, "Smart Array P600", &SA5_access},
 	{ 0x3223103C, "Smart Array P800", &SA5_access},
-	{ 0x3231103C, "Smart Array E400", &SA5_access},
-	{ 0x3233103C, "Smart Array E300", &SA5_access},
+	{ 0x3234103C, "Smart Array P400", &SA5_access},
+	{ 0x3235103C, "Smart Array P400i", &SA5_access},
+	{ 0x3211103C, "Smart Array E200i", &SA5_access},
+	{ 0x3212103C, "Smart Array E200", &SA5_access},
+	{ 0x3213103C, "Smart Array E200i", &SA5_access},
+	{ 0x3214103C, "Smart Array E200i", &SA5_access},
+	{ 0x3215103C, "Smart Array E200i", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
diff -burNp lx2613.orig/include/linux/pci_ids.h lx2613/include/linux/pci_ids.h
--- lx2613.orig/include/linux/pci_ids.h	2005-08-28 18:41:01.000000000 -0500
+++ lx2613/include/linux/pci_ids.h	2005-09-07 13:29:55.946158456 -0500
@@ -713,10 +713,12 @@
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
 #define PCI_DEVICE_ID_HP_DIVA_RMP3	0x1301
+#define PCI_DEVICE_ID_HP_CISS		0x3210
 #define PCI_DEVICE_ID_HP_CISSA		0x3220
 #define PCI_DEVICE_ID_HP_CISSB		0x3222
-#define PCI_DEVICE_ID_HP_ZX2_IOC	0x4031
 #define PCI_DEVICE_ID_HP_CISSC		0x3230
+#define PCI_DEVICE_ID_HP_CISSD		0x3238
+#define PCI_DEVICE_ID_HP_ZX2_IOC	0x4031
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
