Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVJCRra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVJCRra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJCRr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:47:29 -0400
Received: from amdext4.amd.com ([163.181.251.6]:16058 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1750810AbVJCRr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:47:28 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Mon, 3 Oct 2005 12:04:23 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com, linux-ide@vger.kernel.org
Subject: [PATCH 7/7] AMD Geode GX/LX support
Message-ID: <20051003180423.GI29264@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5FB12C2RW1376778-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The core IDE engine on the CS5536 is the same as the other AMD southbridges,
so unlike the CS5535, we can simply add the appropriate PCI headers to
the existing amd74xx code.  Please apply against linux-2.6.14-rc2-mm2.

Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

Index: linux-2.6.14-rc2-mm2/drivers/ide/pci/amd74xx.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/drivers/ide/pci/amd74xx.c
+++ linux-2.6.14-rc2-mm2/drivers/ide/pci/amd74xx.c
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_AMD_CS5536_IDE,             0x40, AMD_UDMA_100 },
 	{ 0 }
 };
 
@@ -491,6 +492,7 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
+	/* 17 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -527,6 +529,7 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+	{ PCI_VENDOR_ID_AMD,    PCI_DEVICE_ID_AMD_CS5536_IDE, 	        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
Index: linux-2.6.14-rc2-mm2/include/linux/pci_ids.h
===================================================================
--- linux-2.6.14-rc2-mm2.orig/include/linux/pci_ids.h
+++ linux-2.6.14-rc2-mm2/include/linux/pci_ids.h
@@ -549,6 +549,15 @@
 #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
 
+#define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
+#define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
+#define PCI_DEVICE_ID_AMD_CS5536_AUDIO  0x2093
+#define PCI_DEVICE_ID_AMD_CS5536_OHC    0x2094
+#define PCI_DEVICE_ID_AMD_CS5536_EHC    0x2095
+#define PCI_DEVICE_ID_AMD_CS5536_UDC    0x2096
+#define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
+#define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
+
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001

