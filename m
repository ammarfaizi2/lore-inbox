Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVAXTYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVAXTYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVAXTYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:24:10 -0500
Received: from fmr18.intel.com ([134.134.136.17]:36301 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261585AbVAXTWX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:22:23 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: bzolnier@gmail.com
Subject: [PATCH] IDE driver support for Intel ICH4L - 2.6.11-rc1
Date: Mon, 24 Jan 2005 04:28:01 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501240428.01794.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds IDE driver support for ICH4-L to the piix.c, piix.h and pci_ids.h source.  This patch was build against 2.6.11-rc1.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11-rc1/drivers/ide/pci/piix.c.orig	2005-01-24 04:14:45.465148896 -0800
+++ linux-2.6.11-rc1/drivers/ide/pci/piix.c	2005-01-24 04:18:21.724272512 -0800
@@ -129,6 +129,7 @@ static u8 piix_ratemask (ide_drive_t *dr
 		case PCI_DEVICE_ID_INTEL_82801CA_10:
 		case PCI_DEVICE_ID_INTEL_82801CA_11:
 		case PCI_DEVICE_ID_INTEL_82801E_11:
+		case PCI_DEVICE_ID_INTEL_82801DB_1:
 		case PCI_DEVICE_ID_INTEL_82801DB_10:
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
@@ -440,6 +441,7 @@ static unsigned int __devinit init_chips
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
 		case PCI_DEVICE_ID_INTEL_82801CA_10:
 		case PCI_DEVICE_ID_INTEL_82801CA_11:
+		case PCI_DEVICE_ID_INTEL_82801DB_1:
 		case PCI_DEVICE_ID_INTEL_82801DB_10:
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
@@ -607,13 +609,14 @@ static struct pci_device_id piix_pci_tbl
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
 #ifdef CONFIG_BLK_DEV_IDE_SATA
- 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
+ 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 #endif
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
--- linux-2.6.11-rc1/drivers/ide/pci/piix.h.orig	2005-01-24 04:18:33.123539560 -0800
+++ linux-2.6.11-rc1/drivers/ide/pci/piix.h	2005-01-24 04:20:29.329873512 -0800
@@ -54,11 +54,12 @@ static ide_pci_device_t piix_pci_info[] 
 	/* 14 */ DECLARE_PIIX_DEV("ICH4"),
 	/* 15 */ DECLARE_PIIX_DEV("ICH5"),
 	/* 16 */ DECLARE_PIIX_DEV("C-ICH"),
-	/* 17 */ DECLARE_PIIX_DEV("ICH4"),
-	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA"),
-	/* 19 */ DECLARE_PIIX_DEV("ICH5"),
-	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
-	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
+	/* 17 */ DECLARE_PIIX_DEV("ICH4-L"),
+	/* 18 */ DECLARE_PIIX_DEV("ICH4"),
+	/* 19 */ DECLARE_PIIX_DEV("ICH5-SATA"),
+	/* 20 */ DECLARE_PIIX_DEV("ICH5"),
+	/* 21 */ DECLARE_PIIX_DEV("ICH6"),
+	/* 22 */ DECLARE_PIIX_DEV("ICH7"),
 };
 
 #endif /* PIIX_H */
--- linux-2.6.11-rc1/include/linux/pci_ids.h.orig	2005-01-24 04:13:24.147511056 -0800
+++ linux-2.6.11-rc1/include/linux/pci_ids.h	2005-01-24 04:14:20.423955736 -0800
@@ -2178,6 +2178,7 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82801DB_0	0x24c0
+#define PCI_DEVICE_ID_INTEL_82801DB_1	0x24c1
 #define PCI_DEVICE_ID_INTEL_82801DB_2	0x24c2
 #define PCI_DEVICE_ID_INTEL_82801DB_3	0x24c3
 #define PCI_DEVICE_ID_INTEL_82801DB_4	0x24c4
