Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVCIXFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVCIXFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVCIXBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:01:49 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:60688 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262448AbVCIWXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:23:31 -0500
Date: Wed, 9 Mar 2005 16:23:39 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/3] cciss: new controller support
Message-ID: <20050309222339.GA32723@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 2 new SAS controllers due out this summer.
It also bumps the version to 2.6.6.

Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 Documentation/cciss.txt |    2 ++
 drivers/block/cciss.c   |   14 ++++++++++----
 include/linux/pci_ids.h |    1 +
 3 files changed, 13 insertions(+), 4 deletions(-)
-------------------------------------------------------------------------------
diff -burNp lx2611.orig/Documentation/cciss.txt lx2611-266/Documentation/cciss.txt
--- lx2611.orig/Documentation/cciss.txt	2005-03-03 13:48:36.000000000 -0600
+++ lx2611-266/Documentation/cciss.txt	2005-03-08 16:39:12.097839144 -0600
@@ -15,6 +15,8 @@ This driver is known to work with the fo
 	* SA 6400 U320 Expansion Module
 	* SA 6i
 	* SA P600
+	* SA P800
+	* SA E400
 
 If nodes are not already created in the /dev/cciss directory, run as root:
 
diff -burNp lx2611.orig/drivers/block/cciss.c lx2611-266/drivers/block/cciss.c
--- lx2611.orig/drivers/block/cciss.c	2005-03-03 13:48:46.000000000 -0600
+++ lx2611-266/drivers/block/cciss.c	2005-03-08 16:39:01.650427392 -0600
@@ -46,14 +46,14 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.6.4)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,4)
+#define DRIVER_NAME "HP CISS Driver (v 2.6.6)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,6)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.4");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.6");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-			" SA6i P600");
+			" SA6i P600 P800 E400");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -82,6 +82,10 @@ const struct pci_device_id cciss_pci_dev
 		0x0E11, 0x4091, 0, 0, 0},
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSA,
 		0x103C, 0x3225, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSB,
+		0x103c, 0x3223, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSB,
+		0x103c, 0x3231, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -103,6 +107,8 @@ static struct board_type products[] = {
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 	{ 0x40910E11, "Smart Array 6i", &SA5_access},
 	{ 0x3225103C, "Smart Array P600", &SA5_access},
+	{ 0x3223103C, "Smart Array P800", &SA5_access},
+	{ 0x3231103C, "Smart Array E400", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
diff -burNp lx2611.orig/include/linux/pci_ids.h lx2611-266/include/linux/pci_ids.h
--- lx2611.orig/include/linux/pci_ids.h	2005-03-03 13:49:02.000000000 -0600
+++ lx2611-266/include/linux/pci_ids.h	2005-03-08 14:16:59.050059584 -0600
@@ -696,6 +696,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
 #define PCI_DEVICE_ID_HP_CISSA		0x3220
+#define PCI_DEVICE_ID_HP_CISSB		0x3230
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
