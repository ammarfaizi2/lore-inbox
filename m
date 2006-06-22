Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWFVEqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWFVEqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWFVEqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:46:49 -0400
Received: from z06.nvidia.com ([209.213.198.25]:45762 "EHLO daphne.nvidia.com")
	by vger.kernel.org with ESMTP id S932789AbWFVEqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:46:48 -0400
Subject: [PATCH] Add MCP65 support for amd74xx driver
From: Andrew Chew <achew@nvidia.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 22 Jun 2006 00:37:03 -0700
Message-Id: <1150961823.5109.3.camel@achew-linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting up patch and resending.

This patch adds MCP65 support to the amd74xx driver.

Signed-off-by: Andrew Chew <achew@nvidia.com>




diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/drivers/ide/pci/amd74xx.c linux-2.6.16.19/drivers/ide/pci/amd74xx.c
--- linux-2.6.16.19.original/drivers/ide/pci/amd74xx.c	2006-05-30 17:31:44.000000000 -0700
+++ linux-2.6.16.19/drivers/ide/pci/amd74xx.c	2006-06-05 17:20:15.000000000 -0700
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
 	{ 0 }
 };
@@ -492,7 +493,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
-	/* 17 */ DECLARE_AMD_DEV("AMD5536"),
+	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP65"),
+	/* 18 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -529,7 +531,8 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/include/linux/pci_ids.h linux-2.6.16.19/include/linux/pci_ids.h
--- linux-2.6.16.19.original/include/linux/pci_ids.h	2006-05-30 17:31:44.000000000 -0700
+++ linux-2.6.16.19/include/linux/pci_ids.h	2006-06-05 17:14:47.000000000 -0700
@@ -1171,6 +1171,15 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE       0x0448
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128


