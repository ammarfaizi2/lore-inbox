Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264193AbTCXQav>; Mon, 24 Mar 2003 11:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264273AbTCXQav>; Mon, 24 Mar 2003 11:30:51 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:29162 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264193AbTCXQaq>; Mon, 24 Mar 2003 11:30:46 -0500
Message-Id: <200303241641.h2OGfs35008177@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:42 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: CCISS ID updates.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/Documentation/cciss.txt linux-2.5/Documentation/cciss.txt
--- bk-linus/Documentation/cciss.txt	2003-03-08 09:56:14.000000000 +0000
+++ linux-2.5/Documentation/cciss.txt	2003-03-18 21:49:27.000000000 +0000
@@ -9,6 +9,10 @@ This driver is known to work with the fo
 	* SA 5i 
 	* SA 532
 	* SA 5312
+	* SA 641
+	* SA 642
+	* SA 6400
+	* SA 6400 U320 Expansion Module
 
 If nodes are not already created in the /dev/cciss directory
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/cciss.c linux-2.5/drivers/block/cciss.c
--- bk-linus/drivers/block/cciss.c	2003-03-21 12:53:30.000000000 +0000
+++ linux-2.5/drivers/block/cciss.c	2003-03-21 13:45:20.000000000 +0000
@@ -1,6 +1,6 @@
 /*
- *    Disk Array driver for Compaq SMART2 Controllers
- *    Copyright 2000 Compaq Computer Corporation
+ *    Disk Array driver for HP SA 5xxx and 6xxx Controllers
+ *    Copyright 2000, 2002 Hewlett-Packard Development Company, L.P.
  *
  *    This program is free software; you can redistribute it and/or modify
  *    it under the terms of the GNU General Public License as published by
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to Cciss-discuss@lists.sourceforge.net
  *
  */
 
@@ -69,6 +69,14 @@ const struct pci_device_id cciss_pci_dev
                         0x0E11, 0x4082, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
                         0x0E11, 0x4083, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x0E11, 0x409A, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x0E11, 0x409B, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x0E11, 0x409C, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x0E11, 0x409D, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -80,10 +88,14 @@ MODULE_DEVICE_TABLE(pci, cciss_pci_devic
  *  access = Address of the struct of function pointers 
  */
 static struct board_type products[] = {
-	{ 0x40700E11, "Smart Array 5300",	&SA5_access },
+	{ 0x40700E11, "Smart Array 5300", &SA5_access },
 	{ 0x40800E11, "Smart Array 5i", &SA5B_access},
 	{ 0x40820E11, "Smart Array 532", &SA5B_access},
 	{ 0x40830E11, "Smart Array 5312", &SA5B_access},
+	{ 0x409A0E11, "Smart Array 641", &SA5_access},
+	{ 0x409B0E11, "Smart Array 642", &SA5_access},
+	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
+	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
