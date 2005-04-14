Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVDNNr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVDNNr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDNNr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:47:59 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:42502 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261503AbVDNNrn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:47:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] [2.6.11] New NVIDIA device IDs
Date: Thu, 14 Apr 2005 06:47:39 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A04A47E49@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.6.11] New NVIDIA device IDs
Thread-Index: AcVA+O/37Qilz5aeRFGZQFiI6ne3gA==
From: "Andy Currid" <ACurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Apr 2005 13:47:39.0225 (UTC) FILETIME=[85E32490:01C540F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch against kernel 2.6.11 adds PCI device IDs for future NVIDIA
silicon, and patches the amd74xx IDE and sata_nv SATA drivers to support
them.

Andy
--
Andy Currid, NVIDIA Corporation
acurrid@nvidia.com   408 566 6743 

--

diff -pur linux-2.6.11/drivers/ide/pci/amd74xx.c
patch-2.6.11/drivers/ide/pci/amd74xx.c
--- linux-2.6.11/drivers/ide/pci/amd74xx.c	2005-03-01
23:38:33.000000000 -0800
+++ patch-2.6.11/drivers/ide/pci/amd74xx.c	2005-04-14
01:11:52.000000000 -0700
@@ -72,6 +72,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50,
AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50,
AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -487,6 +488,7 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2"),
 	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
+	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct
pci_device_id *id)
@@ -521,6 +523,7 @@ static struct pci_device_id amd74xx_pci_
 #endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -pur linux-2.6.11/drivers/scsi/sata_nv.c
patch-2.6.11/drivers/scsi/sata_nv.c
--- linux-2.6.11/drivers/scsi/sata_nv.c	2005-04-14 05:34:42.968498768
-0700
+++ patch-2.6.11/drivers/scsi/sata_nv.c	2005-04-14 05:36:12.445896136
-0700
@@ -20,6 +20,9 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.07
+ *     - Added support for RAID class code.
+ *
  *  0.06
  *     - Added generic SATA support by using a pci_device_id that
filters on
  *       the IDE storage class code.
@@ -48,7 +51,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.6"
+#define DRV_VERSION			"0.7"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -136,6 +139,9 @@ static struct pci_device_id nv_pci_tbl[]
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
diff -pur linux-2.6.11/include/linux/pci_ids.h
patch-2.6.11/include/linux/pci_ids.h
--- linux-2.6.11/include/linux/pci_ids.h	2005-03-01
23:38:37.000000000 -0800
+++ patch-2.6.11/include/linux/pci_ids.h	2005-04-14
05:41:07.762001264 -0700
@@ -1166,6 +1166,12 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE   0x0265
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA  0x0266
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2 0x0267
+#define PCI_DEVICE_ID_NVIDIA_NVENET_12          0x0268
+#define PCI_DEVICE_ID_NVIDIA_NVENET_13          0x0269
+#define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO        0x026B
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
 
 #define PCI_VENDOR_ID_IMS		0x10e0

