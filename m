Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUFAWct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUFAWct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUFAWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:32:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265266AbUFAWaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [5/10]
Date: Wed, 2 Jun 2004 00:19:15 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020019.15349.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: add new nForce IDE/SATA device IDs to amd74xx.c

From: "Brian Lazara" <blazara@nvidia.com>

Add device IDs for new nForce IDE and SATA controllers.  Rename some of
the existing controller names to correctly match released product names.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.c |   33 +++++++++++++----
 linux-2.6.7-rc2-bk2-bzolnier/include/linux/pci_ids.h   |    6 +++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff -puN drivers/ide/pci/amd74xx.c~ide_nv_update drivers/ide/pci/amd74xx.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/amd74xx.c~ide_nv_update	2004-06-01 19:48:31.859475304 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.c	2004-06-01 19:55:04.121842360 +0200
@@ -1,7 +1,8 @@
 /*
  * Version 2.13
  *
- * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s IDE driver for Linux.
+ * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
+ * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -69,6 +70,12 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -473,12 +480,18 @@ static ide_pci_device_t amd74xx_chipsets
 
 	/*  5 */ DECLARE_NV_DEV("NFORCE"),
 	/*  6 */ DECLARE_NV_DEV("NFORCE2"),
-	/*  7 */ DECLARE_NV_DEV("NFORCE2S"),
-	/*  8 */ DECLARE_NV_DEV("NFORCE2S-SATA"),
-	/*  9 */ DECLARE_NV_DEV("NFORCE3"),
-	/* 10 */ DECLARE_NV_DEV("NFORCE3S"),
-	/* 11 */ DECLARE_NV_DEV("NFORCE3S-SATA"),
-	/* 12 */ DECLARE_NV_DEV("NFORCE3S-SATA2")
+	/*  7 */ DECLARE_NV_DEV("NFORCE2-U400R"),
+	/*  8 */ DECLARE_NV_DEV("NFORCE2-U400R-SATA"),
+	/*  9 */ DECLARE_NV_DEV("NFORCE3-150"),
+	/* 10 */ DECLARE_NV_DEV("NFORCE3-250"),
+	/* 11 */ DECLARE_NV_DEV("NFORCE3-250-SATA"),
+	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2"),
+	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
+	/* 14 */ DECLARE_NV_DEV("NFORCE-CK804-SATA"),
+	/* 15 */ DECLARE_NV_DEV("NFORCE-CK804-SATA2"),
+	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP04"),
+	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP04-SATA"),
+	/* 18 */ DECLARE_NV_DEV("NFORCE-MCP04-SATA2")
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -504,6 +517,12 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -puN -L drivers/ide/pci/amd74xx.h /dev/null /dev/null
diff -puN include/linux/pci_ids.h~ide_nv_update include/linux/pci_ids.h
--- linux-2.6.7-rc2-bk2/include/linux/pci_ids.h~ide_nv_update	2004-06-01 19:48:31.864474544 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/linux/pci_ids.h	2004-06-01 19:48:33.507224808 +0200
@@ -1057,6 +1057,12 @@
 #define PCI_DEVICE_ID_NVIDIA_UTNT2		0x0029
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085

_

