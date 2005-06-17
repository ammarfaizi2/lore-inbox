Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVFQTe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVFQTe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVFQTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:34:49 -0400
Received: from palrel10.hp.com ([156.153.255.245]:46514 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262074AbVFQTeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:34:21 -0400
Date: Fri, 17 Jun 2005 13:34:51 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] cciss 2.6: pci id fix
Message-ID: <20050617183451.GB9913@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a PCI ID I got wrong before. It also adds support for another
new SAS controller due out this summer. I didn't have a marketing name prior
to my last submission.
Also modifies the copyright date range.

Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 Documentation/cciss.txt |    1 +
 drivers/block/cciss.c   |    9 ++++++---
 include/linux/pci_ids.h |    3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2612-rc6-p001/Documentation/cciss.txt lx2612-rc6/Documentation/cciss.txt
--- lx2612-rc6-p001/Documentation/cciss.txt	2005-06-14 12:04:32.000000000 -0500
+++ lx2612-rc6/Documentation/cciss.txt	2005-06-17 13:17:23.259424816 -0500
@@ -17,6 +17,7 @@ This driver is known to work with the fo
 	* SA P600
 	* SA P800
 	* SA E400
+	* SA E300
 
 If nodes are not already created in the /dev/cciss directory, run as root:
 
diff -burNp lx2612-rc6-p001/drivers/block/cciss.c lx2612-rc6/drivers/block/cciss.c
--- lx2612-rc6-p001/drivers/block/cciss.c	2005-06-17 13:04:52.384575144 -0500
+++ lx2612-rc6/drivers/block/cciss.c	2005-06-17 13:17:23.262424360 -0500
@@ -1,6 +1,6 @@
 /*
  *    Disk Array driver for HP SA 5xxx and 6xxx Controllers
- *    Copyright 2000, 2002 Hewlett-Packard Development Company, L.P.
+ *    Copyright 2000, 2005 Hewlett-Packard Development Company, L.P.
  *
  *    This program is free software; you can redistribute it and/or modify
  *    it under the terms of the GNU General Public License as published by
@@ -53,7 +53,7 @@
 MODULE_AUTHOR("Hewlett-Packard Company");
 MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.6");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-			" SA6i P600 P800 E400");
+			" SA6i P600 P800 E400 E300");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -84,8 +84,10 @@ static const struct pci_device_id cciss_
 		0x103C, 0x3225, 0, 0, 0},
 	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSB,
 		0x103c, 0x3223, 0, 0, 0},
-	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSB,
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
 		0x103c, 0x3231, 0, 0, 0},
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
+		0x103c, 0x3233, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -109,6 +111,7 @@ static struct board_type products[] = {
 	{ 0x3225103C, "Smart Array P600", &SA5_access},
 	{ 0x3223103C, "Smart Array P800", &SA5_access},
 	{ 0x3231103C, "Smart Array E400", &SA5_access},
+	{ 0x3233103C, "Smart Array E300", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
diff -burNp lx2612-rc6-p001/include/linux/pci_ids.h lx2612-rc6/include/linux/pci_ids.h
--- lx2612-rc6-p001/include/linux/pci_ids.h	2005-06-14 12:04:37.000000000 -0500
+++ lx2612-rc6/include/linux/pci_ids.h	2005-06-17 13:17:23.265423904 -0500
@@ -711,8 +711,9 @@
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
 #define PCI_DEVICE_ID_HP_DIVA_RMP3	0x1301
 #define PCI_DEVICE_ID_HP_CISSA		0x3220
-#define PCI_DEVICE_ID_HP_CISSB		0x3230
+#define PCI_DEVICE_ID_HP_CISSB		0x3222
 #define PCI_DEVICE_ID_HP_ZX2_IOC	0x4031
+#define PCI_DEVICE_ID_HP_CISSC		0x3230
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
