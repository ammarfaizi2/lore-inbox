Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUCRJVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUCRJVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:21:00 -0500
Received: from ns.suse.de ([195.135.220.2]:45753 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262461AbUCRJUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:20:51 -0500
Message-ID: <405969F1.2050103@suse.de>
Date: Thu, 18 Mar 2004 10:20:49 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Modular IDE drivers
Content-Type: multipart/mixed;
 boundary="------------020203050803030706070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020203050803030706070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

the attached patch is required to have modular IDE drivers announce 
themselves properly in modules.pcimap. Two drivers are missing 
(triflex.c and cmd640.c) since they haven't been converted to new-style 
PCI drivers.

Any reason _not_ to apply this patch?

Please keep me cc'ed as I'm not subscribed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------020203050803030706070401
Content-Type: text/plain;
 name="ide-pci-module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-pci-module.patch"

--- linux-2.6.4/drivers/ide/pci/aec62xx.c.orig	2004-03-17 09:25:22.325445094 +0100
+++ linux-2.6.4/drivers/ide/pci/aec62xx.c	2004-03-17 09:25:44.050689817 +0100
@@ -539,6 +539,7 @@
 	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "AEC62xx IDE",
--- linux-2.6.4/drivers/ide/pci/alim15x3.c.orig	2004-03-17 09:26:25.904602130 +0100
+++ linux-2.6.4/drivers/ide/pci/alim15x3.c	2004-03-17 09:26:52.495557754 +0100
@@ -880,6 +880,7 @@
 	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "ALI15x3 IDE",
--- linux-2.6.4/drivers/ide/pci/amd74xx.c.orig	2004-03-17 09:27:29.516750165 +0100
+++ linux-2.6.4/drivers/ide/pci/amd74xx.c	2004-03-17 09:28:01.410300904 +0100
@@ -467,7 +467,8 @@
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "AMD IDE",
--- linux-2.6.4/drivers/ide/pci/cmd64x.c.orig	2004-03-17 09:31:06.361302309 +0100
+++ linux-2.6.4/drivers/ide/pci/cmd64x.c	2004-03-17 09:31:20.982428681 +0100
@@ -760,6 +760,7 @@
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, cmd64x_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "CMD64x IDE",
--- linux-2.6.4/drivers/ide/pci/cy82c693.c.orig	2004-03-17 09:32:21.241463889 +0100
+++ linux-2.6.4/drivers/ide/pci/cy82c693.c	2004-03-17 09:32:38.557876103 +0100
@@ -441,6 +441,7 @@
 	{ PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, cy82c693_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "Cypress IDE",
--- linux-2.6.4/drivers/ide/pci/generic.c.orig	2004-03-17 09:32:59.786255100 +0100
+++ linux-2.6.4/drivers/ide/pci/generic.c	2004-03-17 09:33:18.742236318 +0100
@@ -134,6 +134,7 @@
 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "PCI IDE",
--- linux-2.6.4/drivers/ide/pci/hpt34x.c.orig	2004-03-17 09:33:51.867466000 +0100
+++ linux-2.6.4/drivers/ide/pci/hpt34x.c	2004-03-17 09:35:55.806650590 +0100
@@ -336,6 +336,7 @@
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT343, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, hpt34x_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "HPT34x IDE",
--- linux-2.6.4/drivers/ide/pci/hpt366.c.orig	2004-03-17 09:34:00.814097248 +0100
+++ linux-2.6.4/drivers/ide/pci/hpt366.c	2004-03-17 09:36:20.194193307 +0100
@@ -1228,6 +1228,7 @@
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, hpt366_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "HPT366 IDE",
--- linux-2.6.4/drivers/ide/pci/it8172.c.orig	2004-03-17 09:34:05.501856093 +0100
+++ linux-2.6.4/drivers/ide/pci/it8172.c	2004-03-17 09:36:40.573797195 +0100
@@ -300,6 +300,7 @@
 	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8172G, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, it8172_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "IT8172IDE",
--- linux-2.6.4/drivers/ide/pci/ns87415.c.orig	2004-03-17 09:34:10.268594024 +0100
+++ linux-2.6.4/drivers/ide/pci/ns87415.c	2004-03-17 09:37:01.972131300 +0100
@@ -230,6 +230,7 @@
 	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, ns87415_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "NS87415IDE",
--- linux-2.6.4/drivers/ide/pci/opti621.c.orig	2004-03-17 09:34:16.804863440 +0100
+++ linux-2.6.4/drivers/ide/pci/opti621.c	2004-03-17 09:37:21.700907436 +0100
@@ -367,6 +367,7 @@
 	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "Opti621 IDE",
--- linux-2.6.4/drivers/ide/pci/pdc202xx_new.c.orig	2004-03-17 09:34:24.165914477 +0100
+++ linux-2.6.4/drivers/ide/pci/pdc202xx_new.c	2004-03-17 09:37:45.877505810 +0100
@@ -534,6 +534,7 @@
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, pdc202new_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "Promise IDE",
--- linux-2.6.4/drivers/ide/pci/pdc202xx_old.c.orig	2004-03-17 09:34:29.469510257 +0100
+++ linux-2.6.4/drivers/ide/pci/pdc202xx_old.c	2004-03-17 09:38:28.962097476 +0100
@@ -902,6 +902,7 @@
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, pdc202xx_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "Promise Old IDE",
--- linux-2.6.4/drivers/ide/pci/piix.c.orig	2004-03-17 09:34:34.596152886 +0100
+++ linux-2.6.4/drivers/ide/pci/piix.c	2004-03-17 09:38:51.992999067 +0100
@@ -807,6 +807,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "PIIX IDE",
--- linux-2.6.4/drivers/ide/pci/rz1000.c.orig	2004-03-17 09:34:39.221928125 +0100
+++ linux-2.6.4/drivers/ide/pci/rz1000.c	2004-03-17 09:39:09.025488960 +0100
@@ -68,6 +68,7 @@
 	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "RZ1000 IDE",
--- linux-2.6.4/drivers/ide/pci/sc1200.c.orig	2004-03-17 09:34:44.678483398 +0100
+++ linux-2.6.4/drivers/ide/pci/sc1200.c	2004-03-17 09:39:25.300179489 +0100
@@ -558,6 +558,7 @@
 	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "SC1200 IDE",
--- linux-2.6.4/drivers/ide/pci/serverworks.c.orig	2004-03-17 09:34:48.410495275 +0100
+++ linux-2.6.4/drivers/ide/pci/serverworks.c	2004-03-17 09:39:43.311410161 +0100
@@ -809,6 +809,8 @@
 	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
+
 
 static struct pci_driver driver = {
 	.name		= "Serverworks IDE",
--- linux-2.6.4/drivers/ide/pci/sgiioc4.c.orig	2004-03-17 09:34:55.619586523 +0100
+++ linux-2.6.4/drivers/ide/pci/sgiioc4.c	2004-03-17 09:40:07.179090015 +0100
@@ -790,6 +790,7 @@
 	 PCI_ANY_ID, 0x0b4000, 0xFFFFFF, 0},
 	{0}
 };
+MODULE_DEVICE_TABLE(pci, sgiioc4_pci_tbl);
 
 static struct pci_driver driver = {
 	.name = "SGI-IOC4 IDE",
--- linux-2.6.4/drivers/ide/pci/siimage.c.orig	2004-03-17 09:35:01.056147081 +0100
+++ linux-2.6.4/drivers/ide/pci/siimage.c	2004-03-17 09:40:21.931183644 +0100
@@ -1196,6 +1196,7 @@
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, siimage_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "SiI IDE",
--- linux-2.6.4/drivers/ide/pci/sis5513.c.orig	2004-03-17 09:35:07.028565757 +0100
+++ linux-2.6.4/drivers/ide/pci/sis5513.c	2004-03-17 09:40:41.998869667 +0100
@@ -957,6 +957,7 @@
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "SIS IDE",
--- linux-2.6.4/drivers/ide/pci/sl82c105.c.orig	2004-03-17 09:35:15.187405525 +0100
+++ linux-2.6.4/drivers/ide/pci/sl82c105.c	2004-03-17 09:41:01.219779885 +0100
@@ -494,6 +494,7 @@
 	{ PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, sl82c105_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "W82C105 IDE",
--- linux-2.6.4/drivers/ide/pci/slc90e66.c.orig	2004-03-17 09:35:20.775925838 +0100
+++ linux-2.6.4/drivers/ide/pci/slc90e66.c	2004-03-17 09:41:22.288200836 +0100
@@ -377,6 +377,7 @@
 	{ PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "SLC90e66 IDE",
--- linux-2.6.4/drivers/ide/pci/trm290.c.orig	2004-03-17 09:35:31.146180071 +0100
+++ linux-2.6.4/drivers/ide/pci/trm290.c	2004-03-17 09:42:44.727370015 +0100
@@ -408,6 +408,7 @@
 	{ PCI_VENDOR_ID_TEKRAM, PCI_DEVICE_ID_TEKRAM_DC290, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, trm290_pci_tbl);
 
 static struct pci_driver driver = {
 	.name		= "TRM290 IDE",
--- linux-2.6.4/drivers/ide/pci/via82cxxx.c.orig	2004-03-17 09:35:36.373795934 +0100
+++ linux-2.6.4/drivers/ide/pci/via82cxxx.c	2004-03-17 09:42:58.040844401 +0100
@@ -621,6 +621,7 @@
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, via_pci_tbl);
 
 static struct pci_driver driver = {
 	.name 		= "VIA IDE",

--------------020203050803030706070401--
