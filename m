Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278321AbRJSG7j>; Fri, 19 Oct 2001 02:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278322AbRJSG7a>; Fri, 19 Oct 2001 02:59:30 -0400
Received: from [203.117.131.12] ([203.117.131.12]:19072 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S278321AbRJSG7V>; Fri, 19 Oct 2001 02:59:21 -0400
Message-ID: <3BCFCF60.20509@metaparadigm.com>
Date: Fri, 19 Oct 2001 14:59:44 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011016
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [PATCH] detect Intel 82801CA IDE chip (830MP) in PIIX
Content-Type: multipart/mixed;
 boundary="------------040300000906060907090402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040300000906060907090402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have an Intel830MP based laptop (Fujitsu E-6656 lifebook)

This small patch lets PIIX enable UDMA mode 5 on this chipset.

~mc

--------------040300000906060907090402
Content-Type: text/plain;
 name="Intel830MP-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Intel830MP-ide.patch"

--- linux-2.4.12/drivers/ide/ide-pci.c.orig	Fri Oct 19 12:58:00 2001
+++ linux-2.4.12/drivers/ide/ide-pci.c	Fri Oct 19 14:33:44 2001
@@ -38,4 +38,5 @@
 #define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
 #define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
@@ -386,4 +387,5 @@
 	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
--- linux-2.4.12/drivers/ide/piix.c.orig	Wed Sep 26 12:37:11 2001
+++ linux-2.4.12/drivers/ide/piix.c	Fri Oct 19 14:29:35 2001
@@ -92,4 +92,5 @@
 		case PCI_DEVICE_ID_INTEL_82801BA_8:
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
+	        case PCI_DEVICE_ID_INTEL_82801CA_10:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
@@ -365,5 +366,6 @@
 	byte udma_66		= eighty_ninty_three(drive);
 	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9)) ? 1 : 0;
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
--- linux-2.4.12/include/linux/pci_ids.h.orig	Fri Oct 19 12:58:04 2001
+++ linux-2.4.12/include/linux/pci_ids.h	Fri Oct 19 14:54:03 2001
@@ -1595,4 +1595,14 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
 #define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
+#define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
+#define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
+#define PCI_DEVICE_ID_INTEL_82801CA_4	0x2484
+#define PCI_DEVICE_ID_INTEL_82801CA_5	0x2485
+#define PCI_DEVICE_ID_INTEL_82801CA_6	0x2486
+#define PCI_DEVICE_ID_INTEL_82801CA_7	0x2487
+#define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
+#define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
+#define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121

--------------040300000906060907090402--

