Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291173AbSAaRbF>; Thu, 31 Jan 2002 12:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291171AbSAaRau>; Thu, 31 Jan 2002 12:30:50 -0500
Received: from mbr.sphere.ne.jp ([203.138.71.91]:47516 "EHLO mbr.sphere.ne.jp")
	by vger.kernel.org with ESMTP id <S291172AbSAaRaa>;
	Thu, 31 Jan 2002 12:30:30 -0500
Date: Fri, 1 Feb 2002 02:29:58 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Misc ICH ID changes - revised
Message-Id: <20020201022958.7b58493f.harada@mbr.sphere.ne.jp>
In-Reply-To: <E16WIFn-0002Iy-00@the-village.bc.nu>
In-Reply-To: <20020131224122.59d1de9e.bruce@ask.ne.jp>
	<E16WIFn-0002Iy-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 14:31:55 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > assigned to the 820 chipset, instead of the more general ICH2. The IDE
> > changes are in there because the ICHs' IDE is not quite the same as a
> > PIIX4.
> 
> Im confused. All you seem to be doing is renaming existing defines. I don't
> see any other change

Sorry, I could have put that better... all I was talking about there was
renaming the #defines to more closely reflect Intel docs, which don't refer
to the ICH IDE stuff as PIIX4s. Let me know if I should drop that bit.

Anyway, I've added a little more - some of the ICH3 IDs, and a few user messages.


diff -urN -X dontdiff linux-2.4.18-pre7/drivers/ide/ide-pci.c linux-2.4.18-pre7-bjh/drivers/ide/ide-pci.c
--- linux-2.4.18-pre7/drivers/ide/ide-pci.c	Fri Oct 26 05:53:47 2001
+++ linux-2.4.18-pre7-bjh/drivers/ide/ide-pci.c	Fri Feb  1 00:31:32 2002
@@ -30,14 +30,15 @@
 #define DEVID_MPIIX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371MX})
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
-#define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
+#define DEVID_ICH2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
+#define DEVID_ICH2M	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_ICH3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_11})
+#define DEVID_ICH3M	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
@@ -379,14 +380,15 @@
 	{DEVID_MPIIX,	"MPIIX",	NULL,		NULL,		INIT_PIIX,	NULL,		{{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX3,	"PIIX3",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
 	{DEVID_PIIX4,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
-	{DEVID_PIIX4E,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH0,	"ICH0",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4E2,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH,	"ICH",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U2,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4NX,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
-	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH2,	"ICH2",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH2M,	"ICH2M",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH3,	"ICH3",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_ICH3M,	"ICH3M",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
diff -urN -X dontdiff linux-2.4.18-pre7/drivers/ide/piix.c linux-2.4.18-pre7-bjh/drivers/ide/piix.c
--- linux-2.4.18-pre7/drivers/ide/piix.c	Fri Oct 26 05:53:47 2001
+++ linux-2.4.18-pre7-bjh/drivers/ide/piix.c	Fri Feb  1 00:13:10 2002
@@ -89,17 +89,24 @@
 	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
 
 	switch(bmide_dev->device) {
+	        case PCI_DEVICE_ID_INTEL_82801CA_10:
+	        case PCI_DEVICE_ID_INTEL_82801CA_11:
+			p += sprintf(p, "\n                                Intel ICH3 Ultra 100 Chipset.\n");
+			break;
 		case PCI_DEVICE_ID_INTEL_82801BA_8:
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
-	        case PCI_DEVICE_ID_INTEL_82801CA_10:
-			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
+			p += sprintf(p, "\n                                Intel ICH2 Ultra 100 Chipset.\n");
 			break;
-		case PCI_DEVICE_ID_INTEL_82372FB_1:
 		case PCI_DEVICE_ID_INTEL_82801AA_1:
+			p += sprintf(p, "\n                                Intel ICH Ultra 66 Chipset.\n");
+			break;
+		case PCI_DEVICE_ID_INTEL_82372FB_1:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 66 Chipset.\n");
 			break;
-		case PCI_DEVICE_ID_INTEL_82451NX:
 		case PCI_DEVICE_ID_INTEL_82801AB_1:
+			p += sprintf(p, "\n                                Intel ICH0 Ultra 33 Chipset.\n");
+			break;
+		case PCI_DEVICE_ID_INTEL_82451NX:
 		case PCI_DEVICE_ID_INTEL_82443MX_1:
 		case PCI_DEVICE_ID_INTEL_82371AB:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 33 Chipset.\n");
diff -urN -X dontdiff linux-2.4.18-pre7/drivers/pci/pci.ids linux-2.4.18-pre7-bjh/drivers/pci/pci.ids
--- linux-2.4.18-pre7/drivers/pci/pci.ids	Thu Jan 31 20:29:13 2002
+++ linux-2.4.18-pre7-bjh/drivers/pci/pci.ids	Fri Feb  1 00:35:02 2002
@@ -5015,38 +5015,42 @@
 	1a24  82840 840 (Carmel) Chipset PCI Bridge (Hub B)
 	1a30  82845 845 (Brookdale) Chipset Host Bridge
 	1a31  82845 845 (Brookdale) Chipset AGP Bridge
-	2410  82801AA ISA Bridge (LPC)
-	2411  82801AA IDE
-	2412  82801AA USB
-	2413  82801AA SMBus
-	2415  82801AA AC'97 Audio
+	2410  82801AA ICH ISA Bridge (LPC)
+	2411  82801AA ICH IDE
+	2412  82801AA ICH USB
+	2413  82801AA ICH SMBus
+	2415  82801AA ICH AC'97 Audio
 		11d4 0040  SoundMAX Integrated Digital Audio
 		11d4 0048  SoundMAX Integrated Digital Audio
 		11d4 5340  SoundMAX Integrated Digital Audio
-	2416  82801AA AC'97 Modem
-	2418  82801AA PCI Bridge
-	2420  82801AB ISA Bridge (LPC)
-	2421  82801AB IDE
-	2422  82801AB USB
-	2423  82801AB SMBus
-	2425  82801AB AC'97 Audio
+	2416  82801AA ICH AC'97 Modem
+	2418  82801AA ICH PCI Bridge
+	2420  82801AB ICH0 ISA Bridge (LPC)
+	2421  82801AB ICH0 IDE
+	2422  82801AB ICH0 USB
+	2423  82801AB ICH0 SMBus
+	2425  82801AB ICH0 AC'97 Audio
 		11d4 0040  SoundMAX Integrated Digital Audio
 		11d4 0048  SoundMAX Integrated Digital Audio
-	2426  82801AB AC'97 Modem
-	2428  82801AB PCI Bridge
-	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
-	2442  82820 820 (Camino 2) Chipset USB (Hub A)
-	2443  82820 820 (Camino 2) Chipset SMBus
-	2444  82820 820 (Camino 2) Chipset USB (Hub B)
-	2445  82820 820 (Camino 2) Chipset AC'97 Audio Controller
-	2446  82820 820 (Camino 2) Chipset AC'97 Modem Controller
-	2448  82820 820 (Camino 2) Chipset PCI (-M)
-	2449  82820 (ICH2) Chipset Ethernet Controller
-	244a  82820 820 (Camino 2) Chipset IDE U100 (-M)
-	244b  82820 820 (Camino 2) Chipset IDE U100
-	244c  82820 820 (Camino 2) Chipset ISA Bridge (ICH2-M)
-	244e  82820 820 (Camino 2) Chipset PCI
+	2426  82801AB ICH0 AC'97 Modem
+	2428  82801AB ICH0 PCI Bridge
+	2440  82801BA ICH2 ISA Bridge (LPC)
+	2441  82801BA ICH2-LE IDE U66
+	2442  82801BA ICH2 USB (Hub A)
+	2443  82801BA ICH2 SMBus
+	2444  82801BA ICH2 USB (Hub B)
+	2445  82801BA ICH2 AC'97 Audio Controller
+	2446  82801BA ICH2 AC'97 Modem Controller
+	2448  82801BA ICH2-M PCI Bridge
+	2449  82801BA ICH2 Ethernet Controller
+	244a  82801BA ICH2-M IDE U100
+	244b  82801BA ICH2 IDE U100
+	244c  82801BA ICH2-M ISA Bridge
+	244e  82801BA ICH2 PCI Bridge
+	2481  82801CA ICH3-LE UDE U66
 	2485  AC'97 Audio Controller
+	248a  82801CA ICH3-M IDE U100
+	248b  82801CA ICH3 IDE U100
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
