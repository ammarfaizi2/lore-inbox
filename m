Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267664AbRGPSod>; Mon, 16 Jul 2001 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267658AbRGPSoX>; Mon, 16 Jul 2001 14:44:23 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:16133 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267660AbRGPSoP>; Mon, 16 Jul 2001 14:44:15 -0400
Date: Mon, 16 Jul 2001 19:44:43 +0100 (BST)
From: Peter Denison <peterd@pnd-pc.demon.co.uk>
To: <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.4.6] Intel chipset IDE driver display improvements
Message-ID: <Pine.LNX.4.33.0107161937401.1095-100000@pnd-pc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
	Although the code is (and probably the silicon is also!) the same,
for handling the Intel PIIX4 and the I/O Controller Hub architecture found
in the newer chipsets, the chipsets do have different monikers (ICH0, ICH
and ICH2) as far as Intel are concerned. This patch simply identifies the
devices differently, then uses the same code to drive them.


--- drivers/ide/ide-pci.c.old	Sun Jul 15 16:43:55 2001
+++ drivers/ide/ide-pci.c	Sun Jul 15 17:27:19 2001
@@ -29,13 +29,13 @@
 #define DEVID_PIIXb	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371FB_1})
 #define DEVID_PIIX3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371SB_1})
 #define DEVID_PIIX4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371AB})
-#define DEVID_PIIX4E	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AB_1})
+#define DEVID_ICH0	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AB_1})
 #define DEVID_PIIX4E2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82443MX_1})
-#define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
+#define DEVID_ICH	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
 #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1})
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
-#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
-#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_ICH2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
+#define DEVID_ICH2M	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
 #define DEVID_PDC20246	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246})
@@ -341,13 +341,13 @@
 	{DEVID_PIIXb,	"PIIX",		NULL,		NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
 	{DEVID_PIIX3,	"PIIX3",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
 	{DEVID_PIIX4,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
-	{DEVID_PIIX4E,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH0,	"ICH0",		PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4E2,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH,	"ICH",		PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U2,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4NX,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH2,	"ICH2",		PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH2M,	"ICH2-M",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },
--- drivers/ide/piix.c.old	Sun Jul 15 16:43:55 2001
+++ drivers/ide/piix.c	Sun Jul 15 17:04:22 2001
@@ -110,14 +110,18 @@
 	switch(bmide_dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801BA_8:
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
-			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
+			p += sprintf(p, "\n                                Intel ICH2 Ultra 100 Chipset.\n");
 			break;
-		case PCI_DEVICE_ID_INTEL_82372FB_1:
 		case PCI_DEVICE_ID_INTEL_82801AA_1:
+			p += sprintf(p, "\n                                Intel ICH Ultra 66 Chipset.\n");
+			break;
+		case PCI_DEVICE_ID_INTEL_82801AB_1:
+			p += sprintf(p, "\n                                Intel ICH0 Ultra 33 Chipset.\n");
+			break;
+		case PCI_DEVICE_ID_INTEL_82372FB_1:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 66 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82451NX:
-		case PCI_DEVICE_ID_INTEL_82801AB_1:
 		case PCI_DEVICE_ID_INTEL_82443MX_1:
 		case PCI_DEVICE_ID_INTEL_82371AB:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 33 Chipset.\n");

-- 
Peter Denison <peterd@pnd-pc.demon.co.uk>
Linux Driver for Promise DC4030VL cards.
See http://www.pnd-pc.demon.co.uk/promise/promise.html for details

