Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUG1Nt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUG1Nt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUG1Nt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:49:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266916AbUG1Ntx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:49:53 -0400
Date: Wed, 28 Jul 2004 09:49:10 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: Add support for Innovision DM-8401H
Message-ID: <20040728134910.GA8514@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an SII 680 with strange PCI identifiers it appears

Original patch: Alex Hewson
Verified by: Alan Cox <alan@redhat.com>

OSDL Developer Certificate Of Origin included herein by reference


--- include/linux/pci_ids.h~	2004-07-28 14:24:18.736251384 +0100
+++ include/linux/pci_ids.h	2004-07-28 14:24:18.736251384 +0100
@@ -1634,6 +1634,7 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
+#define PCI_DEVICE_ID_ITE_DM8401	0x8212
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 
--- drivers/ide/pci/siimage.c~	2004-07-28 14:23:17.506559712 +0100
+++ drivers/ide/pci/siimage.c	2004-07-28 14:23:17.507559560 +0100
@@ -19,6 +19,8 @@
  *	If you have strange problems with nVidia chipset systems please
  *	see the SI support documentation and update your system BIOS
  *	if neccessary
+ *
+ *  17/06/2004: Added PCI ID's for Innovision DM-8401H card - mocko@mocko.org.uk
  */
 
 #include <linux/config.h>
@@ -50,6 +52,7 @@
 		case PCI_DEVICE_ID_SII_1210SA:
 			return 1;
 		case PCI_DEVICE_ID_SII_680:
+		case PCI_DEVICE_ID_ITE_DM8401:
 			return 0;
 	}
 	BUG();
@@ -1108,7 +1111,8 @@
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_SII_DEV("SiI680"),
 	/* 1 */ DECLARE_SII_DEV("SiI3112 Serial ATA"),
-	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
+	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA"),
+	/* 3 */ DECLARE_SII_DEV("InnoVISION DM8401H")
 };
 
 /**
@@ -1132,6 +1136,7 @@
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 #endif
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_DM8401,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, siimage_pci_tbl);
