Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWDTWy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWDTWy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWDTWy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:54:27 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:45382 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S932110AbWDTWy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:54:27 -0400
Subject: [PATCH 2.6.16] sata_nv, amd74xx: Add MCP61 support
From: Andrew Chew <achew@nvidia.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-LECv+7413kX0YtIZrsZy"
Date: Thu, 20 Apr 2006 15:54:26 -0700
Message-Id: <1145573666.6869.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 20 Apr 2006 22:54:24.0532 (UTC) FILETIME=[5EA0FD40:01C664CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LECv+7413kX0YtIZrsZy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Added MCP61 device IDs to pci_ids.h.  Added MCP61 IDE support to amd74xx.c.  Added MCP61 SATA support to sata_nv.



diff -uprN -X linux-2.6.16.orig/Documentation/dontdiff linux-2.6.16.orig/drivers/ide/pci/amd74xx.c linux-2.6.16/drivers/ide/pci/amd74xx.c
--- linux-2.6.16.orig/drivers/ide/pci/amd74xx.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/ide/pci/amd74xx.c	2006-04-19 23:18:22.000000000 -0700
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
 	{ 0 }
 };
@@ -492,7 +493,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
-	/* 17 */ DECLARE_AMD_DEV("AMD5536"),
+	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP61"),
+	/* 18 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -529,7 +531,8 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -uprN -X linux-2.6.16.orig/Documentation/dontdiff linux-2.6.16.orig/drivers/scsi/sata_nv.c linux-2.6.16/drivers/scsi/sata_nv.c
--- linux-2.6.16.orig/drivers/scsi/sata_nv.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/scsi/sata_nv.c	2006-04-19 23:15:57.000000000 -0700
@@ -166,6 +166,12 @@ static const struct pci_device_id nv_pci
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
diff -uprN -X linux-2.6.16.orig/Documentation/dontdiff linux-2.6.16.orig/include/linux/pci_ids.h linux-2.6.16/include/linux/pci_ids.h
--- linux-2.6.16.orig/include/linux/pci_ids.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/include/linux/pci_ids.h	2006-04-19 23:16:44.000000000 -0700
@@ -1171,6 +1171,10 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA      0x03E7
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE       0x03EC
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2     0x03F6
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3     0x03F7
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

--=-LECv+7413kX0YtIZrsZy
Content-Disposition: attachment; filename=mcp61.patch
Content-Type: text/x-patch; name=mcp61.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN -X linux-2.6.16.orig/Documentation/dontdiff linux-2.6.16.orig/drivers/ide/pci/amd74xx.c linux-2.6.16/drivers/ide/pci/amd74xx.c
--- linux-2.6.16.orig/drivers/ide/pci/amd74xx.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/ide/pci/amd74xx.c	2006-04-19 23:18:22.000000000 -0700
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
 	{ 0 }
 };
@@ -492,7 +493,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
-	/* 17 */ DECLARE_AMD_DEV("AMD5536"),
+	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP61"),
+	/* 18 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -529,7 +531,8 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -uprN -X linux-2.6.16.orig/Documentation/dontdiff linux-2.6.16.orig/drivers/scsi/sata_nv.c linux-2.6.16/drivers/scsi/sata_nv.c
--- linux-2.6.16.orig/drivers/scsi/sata_nv.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/scsi/sata_nv.c	2006-04-19 23:15:57.000000000 -0700
@@ -166,6 +166,12 @@ static const struct pci_device_id nv_pci
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
diff -uprN -X linux-2.6.16.orig/Documentation/dontdiff linux-2.6.16.orig/include/linux/pci_ids.h linux-2.6.16/include/linux/pci_ids.h
--- linux-2.6.16.orig/include/linux/pci_ids.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/include/linux/pci_ids.h	2006-04-19 23:16:44.000000000 -0700
@@ -1171,6 +1171,10 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA      0x03E7
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE       0x03EC
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2     0x03F6
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3     0x03F7
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128

--=-LECv+7413kX0YtIZrsZy--

