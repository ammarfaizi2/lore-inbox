Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSELLHB>; Sun, 12 May 2002 07:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSELLHA>; Sun, 12 May 2002 07:07:00 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:17162 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S312529AbSELLG7>;
	Sun, 12 May 2002 07:06:59 -0400
Date: Sun, 12 May 2002 13:06:57 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 6)
Message-ID: <20020512130657.A26363@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am sending the following patch to Marcelo for inclusion in the kernel.
It adds support for the IDE controller of the 82801E I/O Controller Hub.
  
Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.410   -> 1.411  
#	  drivers/ide/piix.c	1.11    -> 1.12   
#	drivers/ide/ide-pci.c	1.17    -> 1.18   
#	arch/i386/kernel/pci-irq.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/12	wim@iguana.be	1.411
# [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 6)
# 
# Add IDE support for 82801E I/O Controller Hub.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/pci-irq.c b/arch/i386/kernel/pci-irq.c
--- a/arch/i386/kernel/pci-irq.c	Sun May 12 12:59:55 2002
+++ b/arch/i386/kernel/pci-irq.c	Sun May 12 12:59:55 2002
@@ -467,6 +467,7 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
 
diff -Nru a/drivers/ide/ide-pci.c b/drivers/ide/ide-pci.c
--- a/drivers/ide/ide-pci.c	Sun May 12 12:59:55 2002
+++ b/drivers/ide/ide-pci.c	Sun May 12 12:59:55 2002
@@ -46,6 +46,7 @@
 #define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_10})
 #define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
 #define DEVID_PIIX4U6	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_11})
+#define DEVID_PIIX4U7	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801E_11})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
@@ -402,6 +403,7 @@
 	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U6, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U7, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Sun May 12 12:59:55 2002
+++ b/drivers/ide/piix.c	Sun May 12 12:59:55 2002
@@ -93,6 +93,7 @@
 		case PCI_DEVICE_ID_INTEL_82801BA_11:
 	        case PCI_DEVICE_ID_INTEL_82801CA_10:
 	        case PCI_DEVICE_ID_INTEL_82801CA_11:
+	        case PCI_DEVICE_ID_INTEL_82801E_11:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -368,7 +369,8 @@
 	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_10) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_11) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11)) ? 1 : 0;
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801E_11)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
