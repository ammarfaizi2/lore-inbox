Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291068AbSAaNlw>; Thu, 31 Jan 2002 08:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291070AbSAaNlm>; Thu, 31 Jan 2002 08:41:42 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:65084 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S291068AbSAaNl1>;
	Thu, 31 Jan 2002 08:41:27 -0500
Date: Thu, 31 Jan 2002 22:41:22 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Misc ICH ID changes
Message-Id: <20020131224122.59d1de9e.bruce@ask.ne.jp>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just got my hands on an i815EG B-step board, and several of the PCI
device IDs, etc., don't give the expected results, as they are mistakenly
assigned to the 820 chipset, instead of the more general ICH2. The IDE changes
are in there because the ICHs' IDE is not quite the same as a PII4X.
Various patches have been floating around to change these since early 2.4
days, but they don't seem to have made it in.

Anyway, here's the patch against 2.4.18-pre7:

diff -urN -X dontdiff linux-2.4.18-pre7/drivers/ide/ide-pci.c linux-2.4.18-pre7-bjh/drivers/ide/ide-pci.c
--- linux-2.4.18-pre7/drivers/ide/ide-pci.c	Fri Oct 26 05:53:47 2001
+++ linux-2.4.18-pre7-bjh/drivers/ide/ide-pci.c	Thu Jan 31 20:18:14 2002
@@ -30,12 +30,12 @@
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
+#define DEVID_ICH2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
 #define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
 #define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
@@ -379,12 +379,12 @@
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
+	{DEVID_ICH2,	"ICH2",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
diff -urN -X dontdiff linux-2.4.18-pre7/drivers/pci/pci.ids linux-2.4.18-pre7-bjh/drivers/pci/pci.ids
--- linux-2.4.18-pre7/drivers/pci/pci.ids	Thu Jan 31 20:29:13 2002
+++ linux-2.4.18-pre7-bjh/drivers/pci/pci.ids	Thu Jan 31 20:47:49 2002
@@ -5015,37 +5015,37 @@
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
 	2485  AC'97 Audio Controller
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
