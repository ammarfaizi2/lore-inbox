Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261166AbRELD5u>; Fri, 11 May 2001 23:57:50 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261158AbRELD5l>; Fri, 11 May 2001 23:57:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261157AbRELD5Z>;
	Fri, 11 May 2001 23:57:25 -0400
Message-Id: <200105120300.f4C309d18680@mailout2-0.nyroc.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: "T. C. Raymond" <tc.raymond@ieee.org>
Organization: Power Delivery Consultants, Inc.
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI ID Fixups for Intel 82801BA & BAM
Date: Fri, 11 May 2001 22:57:56 -0400
X-Mailer: KMail [version 1.2.1]
Cc: pci-ids@ucw.cz
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a quick patch to fix the PCI ID's for the 82801BA and add ID's for 
the mobile version, the 82801BAM.  The DID's are from Intel developer docs, I 
don't remember the URL.  It's easy to find.  Fixes the unknown IDE controller 
problem for Dell Inspiron 8000 and one of the newer Sony Vaio's.

Tim

diff -u -r linux/drivers/ide/ide-pci.c linux_new/drivers/ide/ide-pci.c
--- linux/drivers/ide/ide-pci.c	Fri May 11 22:31:35 2001
+++ linux_new/drivers/ide/ide-pci.c	Fri May 11 21:18:18 2001
@@ -34,7 +34,8 @@
 #define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82801AA_1})
 #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82372FB_1})
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82451NX})
-#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82820FW_5})
+#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82801BA_9})
+#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82801BA_8})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     
PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     
PCI_DEVICE_ID_VIA_82C586_1})
 #define DEVID_PDC20246	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, 
PCI_DEVICE_ID_PROMISE_20246})
@@ -343,6 +344,7 @@
 	{DEVID_PIIX4U2,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		
{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4NX,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		
{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		
{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		
{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, 
{0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	
DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		
{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },
diff -u -r linux/drivers/ide/piix.c linux_new/drivers/ide/piix.c
--- linux/drivers/ide/piix.c	Tue Mar  6 22:44:34 2001
+++ linux_new/drivers/ide/piix.c	Fri May 11 21:42:04 2001
@@ -108,7 +108,8 @@
 	c1 = inb_p((unsigned short)bibma + 0x0a);

 	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82820FW_5:
+		case PCI_DEVICE_ID_INTEL_82801BA_8:
+		case PCI_DEVICE_ID_INTEL_82801BA_9:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 
Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -358,7 +359,8 @@
 	byte			speed;

 	byte udma_66		= eighty_ninty_three(drive);
-	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82820FW_5)) ? 1 : 0;
+	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
diff -u -r linux/drivers/pci/pci.ids linux_new/drivers/pci/pci.ids
--- linux/drivers/pci/pci.ids	Sun Mar 25 21:14:20 2001
+++ linux_new/drivers/pci/pci.ids	Fri May 11 22:10:32 2001
@@ -4592,13 +4592,18 @@
 		11d4 0048  SoundMAX Integrated Digital Audio
 	2426  82801AB AC'97 Modem
 	2428  82801AB PCI Bridge
-	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
-	2442  82820 820 (Camino 2) Chipset USB (Hub A)
-	2443  82820 820 (Camino 2) Chipset SMBus
-	2444  82820 820 (Camino 2) Chipset USB (Hub B)
-	2449  82820 820 (Camino 2) Chipset Ethernet
-	244b  82820 820 (Camino 2) Chipset IDE U100
-	244e  82820 820 (Camino 2) Chipset PCI
+	2440  82801BA ISA Bridge (ICH2)
+	2442  82801BA(M) USB (Hub A)
+	2443  82801BA(M) SMBus
+	2444  82801BA(M) USB (Hub B)
+	2445  82801BA(M) AC'97 Audio
+	2446  82801BA(M) AC'97 Modem
+	2448  82801BA PCI
+	2449  82801BA(M) Ethernet
+	244a  82801BAM IDE U100
+	244b  82801BA IDE U100
+	244c  82801BAM ISA Bridge (ICH2)
+	244e  82801BAM PCI
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
diff -u -r linux/include/linux/pci_ids.h linux_new/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	Wed Apr 18 17:40:06 2001
+++ linux_new/include/linux/pci_ids.h	Fri May 11 20:48:27 2001
@@ -1472,13 +1472,25 @@
 #define PCI_DEVICE_ID_INTEL_82801AB_5	0x2425
 #define PCI_DEVICE_ID_INTEL_82801AB_6	0x2426
 #define PCI_DEVICE_ID_INTEL_82801AB_8	0x2428
-#define PCI_DEVICE_ID_INTEL_82820FW_0	0x2440
-#define PCI_DEVICE_ID_INTEL_82820FW_1	0x2442
-#define PCI_DEVICE_ID_INTEL_82820FW_2	0x2443
-#define PCI_DEVICE_ID_INTEL_82820FW_3	0x2444
-#define PCI_DEVICE_ID_INTEL_82820FW_4	0x2449
-#define PCI_DEVICE_ID_INTEL_82820FW_5	0x244b
-#define PCI_DEVICE_ID_INTEL_82820FW_6	0x244e
+//#define PCI_DEVICE_ID_INTEL_82820FW_0	0x2440
+#define PCI_DEVICE_ID_INTEL_82801BA_0	0x2440
+//#define PCI_DEVICE_ID_INTEL_82820FW_1	0x2442
+#define PCI_DEVICE_ID_INTEL_82801BA_1	0x2442
+//#define PCI_DEVICE_ID_INTEL_82820FW_2	0x2443
+#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2443
+//#define PCI_DEVICE_ID_INTEL_82820FW_3	0x2444
+#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2444
+#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2445
+#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2446
+#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2448
+//#define PCI_DEVICE_ID_INTEL_82820FW_4	0x2449
+#define PCI_DEVICE_ID_INTEL_82801BA_7	0x2449
+//#define PCI_DEVICE_ID_INTEL_82820FW_5	0x244a
+#define PCI_DEVICE_ID_INTEL_82801BA_8	0x244a
+#define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
+#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
+//#define PCI_DEVICE_ID_INTEL_82820FW_6	0x244e
+#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
