Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUL3VIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUL3VIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 16:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUL3VIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 16:08:12 -0500
Received: from fmr20.intel.com ([134.134.136.19]:10174 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261716AbUL3VHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 16:07:47 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH] PATA support for Intel ICH7 - 2.6.10 - repost
Date: Thu, 30 Dec 2004 06:13:07 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412300613.07427.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting patch with word wrap turned off.  Please let me know if this is still not formated correctly.

This patch adds the Intel ICH7 DID's to the pci_ids.h file and updates the piix driver and related files for PATA support.  
If acceptable, please apply. 

Thanks,

Jason Gaston


--- linux-2.6.10/arch/i386/pci/irq.c.orig	2004-12-24 13:35:40.000000000 -0800
+++ linux-2.6.10/arch/i386/pci/irq.c	2004-12-28 07:07:28.000000000 -0800
@@ -491,6 +491,8 @@
 		case PCI_DEVICE_ID_INTEL_ESB_1:
 		case PCI_DEVICE_ID_INTEL_ICH6_0:
 		case PCI_DEVICE_ID_INTEL_ICH6_1:
+		case PCI_DEVICE_ID_INTEL_ICH7_0:
+		case PCI_DEVICE_ID_INTEL_ICH7_1:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
--- linux-2.6.10/drivers/ide/pci/piix.c.orig	2004-12-24 13:33:51.000000000 -0800
+++ linux-2.6.10/drivers/ide/pci/piix.c	2004-12-28 07:07:28.000000000 -0800
@@ -134,6 +134,7 @@
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
+		case PCI_DEVICE_ID_INTEL_ICH7_21:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -445,6 +446,7 @@
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
+		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		{
 			unsigned int extra = 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -612,6 +614,7 @@
 #endif
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
--- linux-2.6.10/drivers/ide/pci/piix.h.orig	2004-12-24 13:34:26.000000000 -0800
+++ linux-2.6.10/drivers/ide/pci/piix.h	2004-12-28 07:07:28.000000000 -0800
@@ -57,7 +57,8 @@
 	/* 17 */ DECLARE_PIIX_DEV("ICH4"),
 	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA"),
 	/* 19 */ DECLARE_PIIX_DEV("ICH5"),
-	/* 20 */ DECLARE_PIIX_DEV("ICH6")
+	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
+	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
 };
 
 #endif /* PIIX_H */
--- linux-2.6.10/include/linux/pci_ids.h.orig	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/include/linux/pci_ids.h	2004-12-28 07:07:28.000000000 -0800
@@ -2225,6 +2225,30 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
+#define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b0
+#define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
+#define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
+#define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
+#define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c2
+#define PCI_DEVICE_ID_INTEL_ICH7_5	0x27c4
+#define PCI_DEVICE_ID_INTEL_ICH7_6	0x27c5
+#define PCI_DEVICE_ID_INTEL_ICH7_7	0x27c8
+#define PCI_DEVICE_ID_INTEL_ICH7_8	0x27c9
+#define PCI_DEVICE_ID_INTEL_ICH7_9	0x27ca
+#define PCI_DEVICE_ID_INTEL_ICH7_10	0x27cb
+#define PCI_DEVICE_ID_INTEL_ICH7_11	0x27cc
+#define PCI_DEVICE_ID_INTEL_ICH7_12	0x27d0
+#define PCI_DEVICE_ID_INTEL_ICH7_13	0x27d2
+#define PCI_DEVICE_ID_INTEL_ICH7_14	0x27d4
+#define PCI_DEVICE_ID_INTEL_ICH7_15	0x27d6
+#define PCI_DEVICE_ID_INTEL_ICH7_16	0x27d8
+#define PCI_DEVICE_ID_INTEL_ICH7_17	0x27da
+#define PCI_DEVICE_ID_INTEL_ICH7_18	0x27dc
+#define PCI_DEVICE_ID_INTEL_ICH7_19	0x27dd
+#define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
+#define PCI_DEVICE_ID_INTEL_ICH7_21	0x27df
+#define PCI_DEVICE_ID_INTEL_ICH7_22	0x27e0
+#define PCI_DEVICE_ID_INTEL_ICH7_23	0x27e2
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
