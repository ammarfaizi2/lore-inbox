Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268041AbTBYTKj>; Tue, 25 Feb 2003 14:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268048AbTBYTKj>; Tue, 25 Feb 2003 14:10:39 -0500
Received: from ztxmail01.ztx.compaq.com ([161.114.1.205]:24846 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S268041AbTBYTKg>; Tue, 25 Feb 2003 14:10:36 -0500
Date: Tue, 25 Feb 2003 13:22:47 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.63, add new board support to cciss driver
Message-ID: <20030225072247.GA18990@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* Patch to add support for new boards to cciss driver.
  Smart Array 641, Smart Array 642, Smart Array 6400, Smart Array 6400 EM.
* Change copyright notice, contact info.

Applies to 2.5.63

-- steve

--- linux-2.5.63/include/linux/pci_ids.h~new_devs	2003-02-25 11:34:25.000000000 +0600
+++ linux-2.5.63-root/include/linux/pci_ids.h	2003-02-25 11:34:49.000000000 +0600
@@ -144,6 +144,7 @@
 #define PCI_DEVICE_ID_COMPAQ_NETEL100I	0xb011
 #define PCI_DEVICE_ID_COMPAQ_CISS	0xb060
 #define PCI_DEVICE_ID_COMPAQ_CISSB	0xb178
+#define PCI_DEVICE_ID_COMPAQ_CISSC	0x46
 #define PCI_DEVICE_ID_COMPAQ_THUNDER	0xf130
 #define PCI_DEVICE_ID_COMPAQ_NETFLEX3B	0xf150
 
--- linux-2.5.63/drivers/block/cciss.c~new_devs	2003-02-25 12:47:20.000000000 +0600
+++ linux-2.5.63-root/drivers/block/cciss.c	2003-02-25 13:18:19.000000000 +0600
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
--- linux-2.5.63/Documentation/cciss.txt~new_devs	2003-02-25 12:50:01.000000000 +0600
+++ linux-2.5.63-root/Documentation/cciss.txt	2003-02-25 12:50:21.000000000 +0600
@@ -9,6 +9,10 @@ This driver is known to work with the fo
 	* SA 5i 
 	* SA 532
 	* SA 5312
+	* SA 641
+	* SA 642
+	* SA 6400
+	* SA 6400 U320 Expansion Module
 
 If nodes are not already created in the /dev/cciss directory
 

_
