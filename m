Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbVJGPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVJGPxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVJGPxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:53:42 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:13840 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S1030467AbVJGPxl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:53:41 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.14-rc3] Fix sata_nv handling of NVIDIA MCP51/55
Date: Fri, 7 Oct 2005 08:53:39 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1F10@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.14-rc3] Fix sata_nv handling of NVIDIA MCP51/55
Thread-Index: AcXLV0uOdc0l5eaYT9CP08JT/N3MHg==
From: "Andy Currid" <ACurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>
X-OriginalArrivalTime: 07 Oct 2005 15:53:40.0441 (UTC) FILETIME=[496D2490:01C5CB57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to fix sata_nv handling of NVIDIA MCP51/55


Signed-off-by: Andy Currid <acurrid@nvidia.com>

--- linux-2.6.14-rc3/drivers/scsi/sata_nv.c	2003-01-01
18:08:23.000000000 -0800
+++ linux-2.6.14-rc3devel/drivers/scsi/sata_nv.c	2003-01-01
18:19:34.000000000 -0800
@@ -29,6 +29,8 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.09
+ *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
  *
  *  0.08
  *     - Added support for MCP51 and MCP55.
@@ -132,9 +134,7 @@ enum nv_host_type
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804,
-	MCP51,
-	MCP55
+	CK804
 };
 
 static struct pci_device_id nv_pci_tbl[] = {
@@ -153,13 +153,13 @@ static struct pci_device_id nv_pci_tbl[]
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
