Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVDBAEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVDBAEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVDBAB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:01:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:29916 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262812AbVDAXsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:13 -0500
Cc: gregkh@suse.de
Subject: [PATCH] PCI: sync up with the latest pci.ids file from sf.net.
In-Reply-To: <1112399269989@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:49 -0800
Message-Id: <11123992692790@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.4, 2005/03/17 00:07:27-08:00, gregkh@suse.de

[PATCH] PCI: sync up with the latest pci.ids file from sf.net.

Thanks to Dave Jones for the automated patch generation: http://www.codemonkey.org.uk/projects/pci/

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/pci.ids |  655 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 491 insertions(+), 164 deletions(-)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	2005-04-01 15:38:21 -08:00
+++ b/drivers/pci/pci.ids	2005-04-01 15:38:21 -08:00
@@ -7,7 +7,7 @@
 #	so if you have anything to contribute, please visit the home page or
 #	send a diff -u against the most recent pci.ids to pci-ids@ucw.cz.
 #
-#	Partial sync-up to daily snapshot on Tue 2005-02-08 11:00:09
+#	Daily snapshot on Tue 2005-03-08 10:11:48
 #
 
 # Vendors, devices and subsystems. Please keep sorted.
@@ -47,6 +47,7 @@
 0357  TTTech AG
 	000a  TTP-Monitoring Card V2.0
 0432  SCM Microsystems, Inc.
+	0001  Pluto2 DVB-T Receiver for PCMCIA [EasyWatch MobilSet]
 05e3  CyberDoor
 	0701  CBD516
 0675  Dynalink
@@ -225,6 +226,7 @@
 		1028 0123  PowerEdge 2600
 		1028 014a  PowerEdge 1750
 		1028 016c  PowerEdge 1850 MPT Fusion SCSI/RAID (Perc 4)
+		1028 0183  PowerEdge 1800
 		1028 1010  LSI U320 SCSI Controller
 	0031  53c1030ZC PCI-X Fusion-MPT Dual Ultra320 SCSI
 	0032  53c1035 PCI-X Fusion-MPT Dual Ultra320 SCSI
@@ -338,6 +340,8 @@
 	4152  RV350 AR [Radeon 9600]
 		1002 0002  Radeon 9600XT
 		1043 c002  Radeon 9600 XT TVD
+		174b 7c29  Sapphire Radeon 9600XT
+		1787 4002  Radeon 9600 XT
 	4153  RV350 AS [Radeon 9600 AS]
 	4154  RV350 AT [Fire GL T2]
 	4155  RV350 AU [Fire GL T2]
@@ -366,6 +370,8 @@
 	4172  RV350 AR [Radeon 9600] (Secondary)
 		1002 0003  Radeon 9600XT (Secondary)
 		1043 c003  A9600XT (Secondary)
+		174b 7c28  Sapphire Radeon 9600XT (Secondary)
+		1787 4003  Radeon 9600 XT (Secondary)
 	4173  RV350 ?? [Radeon 9550] (Secondary)
 	4237  Radeon 7000 IGP
 	4242  R200 BB [Radeon All in Wonder 8500DV]
@@ -380,11 +386,17 @@
 	4345  EHCI USB Controller
 	4347  OHCI USB Controller #1
 	4348  OHCI USB Controller #2
+	4349  ATI Dual Channel Bus Master PCI IDE Controller
 	434d  IXP AC'97 Modem
-# Radeon 9100 IGP integrated
 	4353  ATI SMBus
 	4354  215CT [Mach64 CT]
 	4358  210888CX [Mach64 CX]
+	4363  ATI SMBus
+	436e  ATI 436E Serial ATA Controller
+	4372  ATI SMBus
+	4376  Standard Dual Channel PCI IDE Controller ATI
+	4379  ATI 4379 Serial ATA Controller
+	437a  ATI 437A Serial ATA Controller
 	4437  Radeon Mobility 7000 IGP
 	4554  210888ET [Mach64 ET]
 	4654  Mach64 VT
@@ -505,6 +517,7 @@
 		1002 0084  Xpert 98 AGP 2X (Mobility)
 		1014 0154  ThinkPad A20m
 		1028 00aa  Latitude CPt
+		1028 00bb  Latitude CPx
 	4c4e  Rage Mobility L AGP 2x
 	4c50  3D Rage LT Pro
 		1002 4c50  Rage LT Pro
@@ -526,7 +539,7 @@
 	4c5a  Radeon Mobility M6 LZ
 	4c64  Radeon R250 Ld [Radeon Mobility 9000 M9]
 	4c65  Radeon R250 Le [Radeon Mobility 9000 M9]
-	4c66  Radeon R250 Lf [Radeon Mobility 9000 M9]
+	4c66  Radeon R250 Lf [FireGL 9000]
 	4c67  Radeon R250 Lg [Radeon Mobility 9000 M9]
 # Secondary chip to the Lf
 	4c6e  Radeon R250 Ln [Radeon Mobility 9000 M9] [Secondary]
@@ -548,7 +561,8 @@
 # New PCI ID provided by ATI developer relations
 	4e50  RV350 [Mobility Radeon 9600 M10]
 		1025 005a  TravelMate 290
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1734 1055  Amilo M1420W
 	4e51  M10 NQ [Radeon Mobility 9600]
 	4e52  RV350 [Mobility Radeon 9600 M10]
@@ -567,6 +581,7 @@
 # New PCI ID provided by ATI developer relations
 	4e69  Radeon R350 [Radeon 9800] (Secondary)
 	4e6a  RV350 NJ [Radeon 9800 XT] (Secondary)
+		1002 4e71  ATI Technologies Inc M10 NQ [Radeon Mobility 9600]
 	5041  Rage 128 PA/PRO
 	5042  Rage 128 PB/PRO AGP 2x
 	5043  Rage 128 PC/PRO AGP 4x
@@ -739,6 +754,7 @@
 	5835  RS300M AGP [Radeon Mobility 9100IGP]
 	5838  Radeon 9100 IGP AGP Bridge
 	5941  RV280 [Radeon 9200] (Secondary)
+		1458 4019  Gigabyte Radeon 9200
 		174b 7c12  Sapphire Radeon 9200
 # http://www.hightech.com.hk/html/9200.htm
 		17af 200d  Excalibur Radeon 9200
@@ -747,6 +763,7 @@
 	5960  RV280 [Radeon 9200 PRO]
 	5961  RV280 [Radeon 9200]
 		1002 2f72  All-in-Wonder 9200 Series
+		1019 4c30  Radeon 9200 VIVO
 		12ab 5961  YUAN SMARTVGA Radeon 9200
 		1458 4018  Gigabyte Radeon 9200
 		174b 7c13  Sapphire Radeon 9200
@@ -767,12 +784,13 @@
 # 128MB DDR, DVI/VGA/TV out
 		18bc 0173  GC-R9200L(SE)-C3H [Radeon 9200 Game Buster]
 	5b60  RV370 5B60 [Radeon X300 (PCIE)]
-		1043 002a  EAX300SE
+		1043 002a  Extreme AX300SE-X
+		1043 032e  Extreme AX300/TD
 	5b62  RV370 5B62 [Radeon X600 (PCIE)]
 	5b64  RV370 5B64 [FireGL V3100 (PCIE)]
 	5b65  RV370 5B65 [FireGL D1100 (PCIE)]
-	5c61  RV250 5c61 [Radeon Mobility 9200 M9+]
-	5c63  RV250 5c63 [Radeon Mobility 9200 M9+]
+	5c61  M9+ 5C61 [Radeon Mobility 9200 (AGP)]
+	5c63  M9+ 5C63 [Radeon Mobility 9200 (AGP)]
 	5d44  RV280 [Radeon 9200 SE] (Secondary)
 		1458 4019  Radeon 9200 SE (Secondary)
 		174b 7c12  Sapphire Radeon 9200 SE (Secondary)
@@ -780,6 +798,7 @@
 		17af 2013  Radeon 9200 SE Excalibur (Secondary)
 		18bc 0171  Radeon 9200 SE 128MB Game Buster (Secondary)
 		18bc 0172  GC-R9200L(SE)-C3H [Radeon 9200 Game Buster]
+	5d4d  R480 [Radeon X850XT Platinum]
 	5d57  R423 5F57 [Radeon X800XT (PCIE)]
 	700f  PCI Bridge [IGP 320M]
 	7010  PCI Bridge [IGP 340M]
@@ -845,12 +864,13 @@
 		103c 0024  Pavilion ze4400 builtin Network
 		1385 f311  FA311 / FA312 (FA311 with WoL HW)
 	0022  DP83820 10/100/1000 Ethernet Controller
-	0028  CS5535 Host bridge
+	0028  Geode GX2 Host Bridge
+	002a  CS5535 South Bridge
 	002b  CS5535 ISA bridge
 	002d  CS5535 IDE
 	002e  CS5535 Audio
 	002f  CS5535 USB
-	0030  CS5535 Video
+	0030  Geode GX2 Graphics Processor
 	0035  DP83065 [Saturn] 10/100/1000 Ethernet Controller
 	0500  SCx200 Bridge
 	0501  SCx200 SMI
@@ -997,11 +1017,13 @@
 	1200  GD 7542 [Nordic]
 	1202  GD 7543 [Viking]
 	1204  GD 7541 [Nordic Light]
+	4000  MD 5620 [CLM Data Fax Voice]
 	4400  CD 4400
 	6001  CS 4610/11 [CrystalClear SoundFusion Audio Accelerator]
 		1014 1010  CS4610 SoundFusion Audio Accelerator
 	6003  CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
 		1013 4280  Crystal SoundFusion PCI Audio Accelerator
+		153b 1136  SiXPack 5.1+
 		1681 0050  Game Theater XP
 		1681 a011  Fortissimo III 7.1
 	6004  CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
@@ -1121,7 +1143,7 @@
 	0266  PCI-X Dual Channel SCSI
 	0268  Gigabit Ethernet-SX Adapter (PCI-X)
 	0269  10/100/1000 Base-TX Ethernet Adapter (PCI-X)
-	028C  Citrine chipset SCSI controller
+	028c  Citrine chipset SCSI controller
 		1014 028D  Dual Channel PCI-X DDR SAS RAID Adapter (572E)
 		1014 02BE  Dual Channel PCI-X DDR U320 SCSI RAID Adapter (571B)
 		1014 02C0  Dual Channel PCI-X DDR U320 SCSI Adapter (571A)
@@ -1263,6 +1285,7 @@
 	2001  4DWave NX
 		122d 1400  Trident PCI288-Q3DII (NX)
 	2100  CyberBlade XP4m32
+	2200  XGI Volari XP5
 	8400  CyberBlade/i7
 		1023 8400  CyberBlade i7 AGP
 	8420  CyberBlade/i7d
@@ -1625,6 +1648,7 @@
 		1010 00a0  PowerVR Neon 250 AGP 32Mb
 		1010 00a8  PowerVR Neon 250 32Mb
 		1010 0120  PowerVR Neon 250 AGP 32Mb
+	0072  uPD72874 IEEE1394 OHCI 1.1 3-port PHY-Link Ctrlr
 	0074  56k Voice Modem
 		1033 8014  RCV56ACF 56k Voice Modem
 	009b  Vrc5476
@@ -1719,7 +1743,6 @@
 		1039 5513  SiS5513 EIDE Controller (A,B step)
 		1043 8035  CUSI-FX motherboard
 	5517  5517
-	5518  5518 [IDE]
 	5571  5571
 	5581  5581 Pentium Chipset
 	5582  5582
@@ -1817,6 +1840,8 @@
 	108b  Visualize FXe
 	10c1  NetServer Smart IRQ Router
 	10ed  TopTools Remote Control
+	10f0  rio System Bus Adapter
+	10f1  rio I/O Controller
 	1200  82557B 10/100 NIC
 	1219  NetServer PCI Hot-Plug Controller
 	121a  NetServer SMIC Controller
@@ -1827,6 +1852,7 @@
 	122e  zx1 Local Bus Adapter
 	127c  sx1000 I/O Controller
 	1290  Auxiliary Diva Serial Port
+	12b4  zx1 QuickSilver AGP8x Local Bus Adapter
 	2910  E2910A PCIBus Exerciser
 	2925  E2925A 32 Bit, 33 MHzPCI Exerciser & Analyzer
 103e  Solliday Engineering
@@ -1847,6 +1873,8 @@
 	8043  v8240 PAL 128M [P4T] Motherboard
 	807b  v9280/TD [Geforce4 TI4200 8X With TV-Out and DVI]
 	80bb  v9180 Magic/T [GeForce4 MX440 AGP 8x 64MB TV-out]
+	80c5  nForce3 chipset motherboard [SK8N]
+	80df  v9520 Magic/T
 1044  Adaptec (formerly DPT)
 	1012  Domino RAID Engine
 	a400  SmartCache/Raid I-IV Controller
@@ -1885,7 +1913,7 @@
 		1044 c05a  2400A UDMA Four Channel
 		1044 c05b  2400A UDMA Four Channel DAC
 		1044 c064  3010S Ultra3 Dual Channel
-		1044 c065  3010S Ultra3 Four Channel
+		1044 c065  3410S Ultra160 Four Channel
 		1044 c066  3010S Fibre Channel
 	a511  SmartRAID V Controller
 		1044 c032  ASR-2005S I2O Zero Channel
@@ -1982,11 +2010,13 @@
 		11bd 000e  Studio DV
 		e4bf 1010  CF2-1-CYMBAL
 	8020  TSB12LV26 IEEE-1394 Controller (Link)
+		11bd 000f  Studio DV500-1394
 	8021  TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated)
 		104d 80df  Vaio PCG-FX403
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
 	8022  TSB43AB22 IEEE-1394a-2000 Controller (PHY/Link)
 	8023  TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
+		103c 088c  nc8000 laptop
 	8024  TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
 	8025  TSB82AA2 IEEE-1394b Link Layer Controller
 		55aa 55aa  FireWire 800 PCI Card
@@ -1996,8 +2026,17 @@
 	8029  PCI4510 IEEE-1394 Controller
 		1028 0163  Latitude D505
 		1071 8160  MIM2900
+	802b  PCI7410,7510,7610 OHCI-Lynx Controller
+		1028 014e  PCI7410,7510,7610 OHCI-Lynx Controller (Dell Latitude D800)
 	802e  PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller
+	8031  Texas Instruments PCIxx21/x515 Cardbus Controller
+	8032  Texas Instruments OHCI Compliant IEEE 1394 Host Controller
+	8033  Texas Instruments PCIxx21 Integrated FlashMedia Controller
+	8034  Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
+	8035  Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Smart Card Controller (SMC)
 	8201  PCI1620 Firmware Loading Function
+	8204  PCI7410,7510,7610 PCI Firmware Loading Function
+		1028 014e  Latitude D800
 	8400  ACX 100 22Mbps Wireless Interface
 		00fc 16ec  U.S. Robotics 22 Mbps Wireless PC Card (model 2210)
 		00fd 16ec  U.S. Robotics 22Mbps Wireless PCI Adapter (model 2216)
@@ -2046,6 +2085,10 @@
 		1028 0163  Latitude D505
 		1071 8160  MIM2000
 	ac46  PCI4520 PC card Cardbus Controller
+	ac47  PCI7510 PC card Cardbus Controller
+		1028 014e  Latitude D800
+	ac4a  PCI7510,7610 PC card Cardbus Controller
+		1028 014e  Latitude D800
 	ac50  PCI1410 PC card Cardbus Controller
 	ac51  PCI1420
 		1014 023b  ThinkPad T23 (2647-4MG)
@@ -2067,10 +2110,11 @@
 		175c 6200  ASI62xx Audio Adapter
 	ac8d  PCI 7620
 	ac8e  PCI7420 CardBus Controller
-	ac8f  PCI7420/PCI7620 Dual Socket CardBus and Smart Card Cont.
+	ac8f  PCI7420/PCI7620 Dual Socket CardBus and Smart Card Cont. w/ 1394a-2000 OHCI Two-Port  PHY/Link-Layer Cont. and SD/MS-Pro Sockets
 	fe00  FireWire Host Controller
 	fe03  12C01A FireWire Host Controller
 104d  Sony Corporation
+	8004  DTL-H2500 [Playstation development board]
 	8009  CXD1947Q i.LINK Controller
 	8039  CXD3222 i.LINK Controller
 	8056  Rockwell HCF 56K modem
@@ -2131,9 +2175,32 @@
 		175c 4200  ASI4215 Audio Adapter
 		175c 4300  ASI43xx Audio Adapter
 		175c 4400  ASI4401 Audio Adapter
-		ecc0 0030  Layla
+		ecc0 0010  Darla
+		ecc0 0020  Gina
+		ecc0 0030  Layla rev.0
+		ecc0 0031  Layla rev.1
+		ecc0 0040  Darla24 rev.0
+		ecc0 0041  Darla24 rev.1
+		ecc0 0050  Gina24 rev.0
+		ecc0 0051  Gina24 rev.1
+		ecc0 0070  Mona rev.0
+		ecc0 0071  Mona rev.1
+		ecc0 0072  Mona rev.2
 	18c0  MPC8265A/MPC8266
 	18c1  MPC8271/MPC8272
+	3410  DSP56361 Digital Signal Processor
+		ecc0 0050  Gina24 rev.0
+		ecc0 0051  Gina24 rev.1
+		ecc0 0060  Layla24
+		ecc0 0070  Mona rev.0
+		ecc0 0071  Mona rev.1
+		ecc0 0072  Mona rev.2
+		ecc0 0080  Mia rev.0
+		ecc0 0081  Mia rev.1
+		ecc0 0090  Indigo
+		ecc0 00a0  Indigo IO
+		ecc0 00b0  Indigo DJ
+		ecc0 0100  3G
 	4801  Raven
 	4802  Falcon
 	4803  Hawk
@@ -2174,13 +2241,14 @@
 		8086 3427  S875WP1-E mainboard
 	3371  PDC20371 (FastTrak S150 TX2plus)
 	3373  PDC20378 (FastTrak 378/SATA 378)
-		1043 80f5  PC-DL Deluxe motherboard
+		1043 80f5  K8V Deluxe/PC-DL Deluxe motherboard
 		1462 702e  K8T NEO FIS2R motherboard
 	3375  PDC20375 (SATA150 TX2plus)
 	3376  PDC20376 (FastTrak 376)
 		1043 809e  A7V8X motherboard
 	3574  PDC20579 SATAII 150 IDE Controller
-	3d18  PDC20518 SATAII 150 IDE Controller
+	3d18  PDC20518/PDC40518 (SATAII 150 TX4)
+	3d75  PDC20575 (SATAII150 TX2plus)
 	4d30  PDC20267 (FastTrak100/Ultra100)
 		105a 4d33  Ultra100
 		105a 4d39  FastTrak100
@@ -2301,8 +2369,8 @@
 		1014 0242  iSeries 2872 DASD IOA
 		1014 0266  Dual Channel PCI-X U320 SCSI Adapter
 		1014 0278  Dual Channel PCI-X U320 SCSI RAID Adapter
-		1014 02D3  Dual Channel PCI-X U320 SCSI Adapter
-		1014 02D4  Dual Channel PCI-X U320 SCSI RAID Adapter
+		1014 02d3  Dual Channel PCI-X U320 SCSI Adapter
+		1014 02d4  Dual Channel PCI-X U320 SCSI RAID Adapter
 	ba55  eXtremeRAID 1100 support Device
 	ba56  eXtremeRAID 2000/3000 support Device
 106a  Aten Research Inc
@@ -2312,6 +2380,7 @@
 	0003  Control Video
 	0004  PlanB Video-In
 	0007  O'Hare I/O
+	000c  DOS on Mac
 	000e  Hydra Mac I/O
 	0010  Heathrow Mac I/O
 	0017  Paddington Mac I/O
@@ -2511,11 +2580,13 @@
 	1101  RIO GEM
 	1102  RIO 1394
 	1103  RIO USB
+	1648  [bge] Gigabit Ethernet
 	2bad  GEM
 	5000  Simba Advanced PCI Bridge
 	5043  SunPCI Co-processor
 	8000  Psycho PCI Bus Module
 	8001  Schizo PCI Bus Module
+	8002  Schizo+ PCI Bus Module
 	a000  Ultra IIi
 	a001  Ultra IIe
 	a801  Tomatillo PCI Bus Module
@@ -2559,6 +2630,7 @@
 	1170  PCI-MIO-16XE-10
 	1180  PCI-MIO-16E-1
 	1190  PCI-MIO-16E-4
+	1310  PCI-6602
 	1330  PCI-6031E
 	1350  PCI-6071E
 	14e0  PCI-6110
@@ -2574,6 +2646,7 @@
 	2a80  PCI-6025E
 	2c80  PCI-6035E
 	2ca0  PCI-6034E
+	70b8  PCI-6251 [M Series - High Speed Multifunction DAQ]
 	b001  IMAQ-PCI-1408
 	b011  IMAQ-PXI-1408
 	b021  IMAQ-PCI-1424
@@ -2588,13 +2661,13 @@
 	c831  PCI-GPIB bridge
 1094  First International Computers [FIC]
 1095  Silicon Image, Inc. (formerly CMD Technology Inc)
-	0240  Adaptec AAR-1210SA SATA HostRAID Contr.
+	0240  Adaptec AAR-1210SA SATA HostRAID Controller
 	0640  PCI0640
 	0643  PCI0643
 	0646  PCI0646
 	0647  PCI0647
 	0648  PCI0648
-	0649  SiI 0649 Ultra ATA-100 Host Controller
+	0649  SiI 0649 Ultra ATA/100 PCI to ATA Host Controller
 		0e11 005d  Integrated Ultra ATA-100 Dual Channel Controller
 		0e11 007e  Integrated Ultra ATA-100 IDE RAID Controller
 		101e 0649  AMI MegaRAID IDE 100 Controller
@@ -2646,6 +2719,7 @@
 		127a 0048  Bt878/832 Mediastream Controller
 		144f 3000  MagicTView CPH060 - Video
 		1461 0002  TV98 Series (TV/No FM/Remote)
+		1461 0003  AverMedia UltraTV PCI 350
 		1461 0004  AVerTV WDM Video Capture
 		1461 0761  AverTV DVB-T
 		14f1 0001  Bt878 Mediastream Controller NTSC
@@ -2821,10 +2895,14 @@
 	1146  VScom 010 1 port parallel adaptor
 	1147  VScom 020 2 port parallel adaptor
 	2724  Thales PCSM Security Card
+	8516  PEX 8516  Versatile PCI Express Switch
+	8532  PEX 8532  Versatile PCI Express Switch
 	9030  PCI <-> IOBus Bridge Hot Swap
 		10b5 2862  Alpermann+Velte PCL PCI LV (3V/5V): Timecode Reader Board
 		10b5 2906  Alpermann+Velte PCI TS (3V/5V): Time Synchronisation Board
 		10b5 2940  Alpermann+Velte PCL PCI D (3V/5V): Timecode Reader Board
+		10b5 3025  Alpermann+Velte PCL PCI L (3V/5V): Timecode Reader Board
+		10b5 3068  Alpermann+Velte PCL PCI HD (3V/5V): Timecode Reader Board
 		15ed 1002  MCCS 8-port Serial Hot Swap
 		15ed 1003  MCCS 16-port Serial Hot Swap
 	9036  9036
@@ -2933,7 +3011,7 @@
 	1201  3c982-TXM 10/100baseTX Dual Port A [Hydra]
 	1202  3c982-TXM 10/100baseTX Dual Port B [Hydra]
 	1700  3c940 10/100/1000Base-T [Marvell]
-		1043 80eb  P4P800 Mainboard
+		1043 80eb  P4P800/K8V Deluxe motherboard
 		10b7 0010  3C940 Gigabit LOM Ethernet Adapter
 		10b7 0020  3C941 Gigabit LOM Ethernet Adapter
 		147b 1407  KV8-MAX3 motherboard
@@ -3124,6 +3202,7 @@
 	5217  M5217H
 	5219  M5219
 	5225  M5225
+	5228  M5228 ALi ATA/RAID Controller
 	5229  M5229 IDE
 		1014 050f  ThinkPad R30
 		1014 053d  ThinkPad R40e (2684-HVG) builtin IDE
@@ -3143,6 +3222,8 @@
 	5261  M5261 Ethernet Controller
 	5263  M5263 Ethernet Controller
 	5281  ALi M5281 Serial ATA / RAID Host Controller
+	5287  ULi 5287 SATA
+	5289  ULi 5289 SATA
 	5450  Lucent Technologies Soft Modem AMR
 	5451  M5451 PCI AC-Link Controller Audio Device
 		1014 0506  ThinkPad R30
@@ -3209,7 +3290,7 @@
 		10f7 8312  MagicGraph 128XD
 	0005  NM2200 [MagicGraph 256AV]
 		1014 00dd  ThinkPad 570
-		1028 0088  Latitude CPi A400XT
+		1028 0088  Latitude CPi A
 	0006  NM2360 [MagicMedia 256ZX]
 	0016  NM2380 [MagicMedia 256XL+]
 		10c8 0016  MagicMedia 256XL+
@@ -3257,6 +3338,7 @@
 10d7  BCM Advanced Research
 10d8  Advanced Peripherals Labs
 10d9  Macronix, Inc. [MXIC]
+	0431  MX98715
 	0512  MX98713
 	0531  MX987x5
 		1186 1200  DFE-540TX ProFAST 10/100 Adapter
@@ -3345,6 +3427,7 @@
 		1102 102c  CT6931 RIVA TNT2 Value [Jumper]
 		1462 8808  MSI-8808
 		1554 1041  Pixelview RIVA TNT2 M64
+		1569 002d  Palit Microsystems Daytona TNT2 M64
 	002e  NV6 [Vanta]
 	002f  NV6 [Vanta]
 	0034  MCP04 SMBus
@@ -3357,13 +3440,14 @@
 	003c  MCP04 USB Controller
 	003d  MCP04 PCI Bridge
 	003e  MCP04 Serial ATA Controller
-	0040  NV40 [GeForce 6800 Ultra]
+	0040  nv40 [GeForce 6800 Ultra]
 	0041  NV40 [GeForce 6800]
 	0042  NV40.2
 	0043  NV40.3
 	0045  NV40 [GeForce 6800 GT]
 	0049  NV40GL
 	004e  NV40GL [Quadro FX 4000]
+	0051  CK804 ISA Bridge
 	0052  CK804 SMBus
 	0053  CK804 IDE
 	0054  CK804 Serial ATA Controller
@@ -3387,7 +3471,7 @@
 	0068  nForce2 USB Controller
 		1043 0c11  A7N8X Mainboard
 	006a  nForce2 AC97 Audio Controler (MCP)
-	006b  nForce MultiMedia audio [Via VT82C686B]
+	006b  nForce Audio Processing Unit
 		10de 006b  nForce2 MCP Audio Processing Unit
 	006c  nForce2 External PCI Bridge
 	006d  nForce2 PCI Bridge
@@ -3420,6 +3504,7 @@
 	00da  nForce3 Audio
 	00dd  nForce3 PCI Bridge
 	00df  CK8S Ethernet Controller
+	00e0  nForce3 250Gb LPC Bridge
 	00e1  nForce3 250Gb Host Bridge
 	00e2  nForce3 250Gb AGP Host to PCI Bridge
 	00e3  CK8S Serial ATA Controller (v2.5)
@@ -3427,7 +3512,7 @@
 	00e5  CK8S Parallel ATA Controller (v2.5)
 	00e6  CK8S Ethernet Controller
 	00e7  CK8S USB Controller
-	00e8  CK8S USB Controller
+	00e8  nForce3 EHCI USB 2.0 Controller
 	00ea  nForce3 250Gb AC'97 Audio Controller
 	00ed  nForce3 250Gb PCI-to-PCI Bridge
 	00ee  CK8S Serial ATA Controller (v2.5)
@@ -3435,7 +3520,8 @@
 	00f1  NV43 [GeForce 6600/GeForce 6600 GT]
 	00f2  NV43 [GeForce 6600 GT]
 	00f8  NV45GL [Quadro FX 3400]
-	00f9  NV40 [GeForce 6800 Ultra]
+	00f9  NV40 [GeForce 6800 Ultra/GeForce 6800 GT]
+		1682 2120  GEFORCE 6800 GT PCI-E
 	00fa  NV36 [GeForce PCX 5750]
 	00fb  NV35 [GeForce PCX 5900]
 	00fc  NV37GL [Quadro FX 330/GeForce PCX 5300]
@@ -3467,6 +3553,8 @@
 	0111  NV11DDR [GeForce2 MX 100 DDR/200 DDR]
 	0112  NV11 [GeForce2 Go]
 	0113  NV11GL [Quadro2 MXR/EX]
+	0140  NV43 [MSI NX6600GT-TD128E]
+	014f  NV43 [GeForce 6200]
 	0150  NV15 [GeForce2 GTS/Pro]
 		1043 4016  V7700 AGP Video Card
 		107d 2840  WinFast GeForce2 GTS with TV output
@@ -3544,6 +3632,22 @@
 		1043 405b  V8200 T5
 		1545 002f  Xtasy 6964
 	0203  NV20DCC [Quadro DCC]
+	0240  C51 PCI Express Bridge
+	0241  C51 PCI Express Bridge
+	0242  C51 PCI Express Bridge
+	0243  C51 PCI Express Bridge
+	0244  C51 PCI Express Bridge
+	0245  C51 PCI Express Bridge
+	0246  C51 PCI Express Bridge
+	0247  C51 PCI Express Bridge
+	0248  C51 PCI Express Bridge
+	0249  C51 PCI Express Bridge
+	024a  C51 PCI Express Bridge
+	024b  C51 PCI Express Bridge
+	024c  C51 PCI Express Bridge
+	024d  C51 PCI Express Bridge
+	024e  C51 PCI Express Bridge
+	024f  C51 PCI Express Bridge
 	0250  NV25 [GeForce4 Ti 4600]
 	0251  NV25 [GeForce4 Ti 4400]
 		1043 8023  v8440 GeForce 4 Ti4400
@@ -3554,6 +3658,27 @@
 	0258  NV25GL [Quadro4 900 XGL]
 	0259  NV25GL [Quadro4 750 XGL]
 	025b  NV25GL [Quadro4 700 XGL]
+	0260  MCP51 LPC Bridge
+	0261  MCP51 LPC Bridge
+	0262  MCP51 LPC Bridge
+	0263  MCP51 LPC Bridge
+	0264  MCP51 SMBus
+	0265  MCP51 IDE
+	0266  MCP51 Serial ATA Controller
+	0267  MCP51 Serial ATA Controller
+	0268  MCP51 Ethernet Controller
+	0269  MCP51 Ethernet Controller
+	026a  MCP51 MCI
+	026b  MCP51 AC97 Audio Controller
+	026c  MCP51 High Definition Audio
+	026d  MCP51 USB Controller
+	026e  MCP51 USB Controller
+	026f  MCP51 PCI Bridge
+	0270  MCP51 Host Bridge
+	0271  MCP51 PMU
+	0272  MCP51 Memory Controller 0
+	027e  C51 Memory Controller 2
+	027f  C51 Memory Controller 3
 	0280  NV28 [GeForce4 Ti 4800]
 	0281  NV28 [GeForce4 Ti 4200 AGP 8x]
 	0282  NV28 [GeForce4 Ti 4800 SE]
@@ -3561,6 +3686,22 @@
 	0288  NV28GL [Quadro4 980 XGL]
 	0289  NV28GL [Quadro4 780 XGL]
 	028c  NV28GLM [Quadro4 700 GoGL]
+	02f0  C51 Host Bridge
+	02f1  C51 Host Bridge
+	02f2  C51 Host Bridge
+	02f3  C51 Host Bridge
+	02f4  C51 Host Bridge
+	02f5  C51 Host Bridge
+	02f6  C51 Host Bridge
+	02f7  C51 Host Bridge
+	02f8  C51 Memory Controller 5
+	02f9  C51 Memory Controller 4
+	02fa  C51 Memory Controller 0
+	02fb  C51 PCI Express Bridge
+	02fc  C51 PCI Express Bridge
+	02fd  C51 PCI Express Bridge
+	02fe  C51 Memory Controller 1
+	02ff  C51 Host Bridge
 	0300  NV30 [GeForce FX]
 	0301  NV30 [GeForce FX 5800 Ultra]
 	0302  NV30 [GeForce FX 5800]
@@ -3620,27 +3761,25 @@
 	1ae5  LP6000 Fibre Channel Host Adapter
 	1ae6  LP 8000 Fibre Channel Host Adapter Alternate ID (JX1:2-3, JX2:1-2)
 	1ae7  LP 8000 Fibre Channel Host Adapter Alternate ID (JX1:2-3, JX2:2-3)
-	f015  LP1150e
-	f085  LP850 Fibre Channel Adapter
-	f095  LP952 Fibre Channel Adapter
-	f098  LP982 Fibre Channel Adapter
-	f0a1  LightPulse Fibre Channel Adapter
-	f0a5  LP1050
-	f0d5  LP1150
-	f100  LP11000e
+	f005  LP1150e Fibre Channel Host Adapter
+	f085  LP850 Fibre Channel Host Adapter
+	f095  LP952 Fibre Channel Host Adapter
+	f098  LP982 Fibre Channel Host Adapter
+	f0a5  LP1050 Fibre Channel Host Adapter
+	f0d5  LP1150 Fibre Channel Host Adapter
+	f100  LP11000e Fibre Channel Host Adapter
 	f700  LP7000 Fibre Channel Host Adapter
 	f701  LP 7000EFibre Channel Host Adapter Alternate ID (JX1:2-3, JX2:1-2)
 	f800  LP8000 Fibre Channel Host Adapter
 	f801  LP 8000 Fibre Channel Host Adapter Alternate ID (JX1:2-3, JX2:1-2)
 	f900  LP9000 Fibre Channel Host Adapter
 	f901  LP 9000 Fibre Channel Host Adapter Alternate ID (JX1:2-3, JX2:1-2)
-	f980  LP9802 Fibre Channel Adapter
+	f980  LP9802 Fibre Channel Host Adapter
 	f981  LP 9802 Fibre Channel Host Adapter Alternate ID
 	f982  LP 9802 Fibre Channel Host Adapter Alternate ID
 	fa00  LP10000 Fibre Channel Host Adapter
-	fa01  LP101
-	fb00  LightPulse Fibre Channel Adapter
-	fd00  LP11000
+	fa01  LP101 Fibre Channel Host Adapter
+	fd00  LP11000 Fibre Channel Host Adapter
 10e0  Integrated Micro Solutions Inc.
 	5026  IMS5026/27/28
 	5027  IMS5027
@@ -3822,11 +3961,13 @@
 		1102 0051  SB0090 Audigy Player
 		1102 0053  SB0090 Audigy Player/OEM
 		1102 0058  SB0090 Audigy Player/OEM
+		1102 1007  SB0240 Audigy 2 Platinum 6.1
 		1102 2002  SB Audigy 2 ZS (SB0350)
 	0006  [SB Live! Value] EMU10k1X
 	0007  SB Audigy LS
 		1102 1001  SB0310 Audigy LS
 		1102 1002  SB0312 Audigy LS
+		1102 1006  SB0410 SBLive! 24-bit
 	0008  SB0400 Audigy2 Value
 	4001  SB Audigy FireWire Port
 		1102 0010  SB Audigy FireWire Port
@@ -3840,10 +3981,24 @@
 		1102 1002  SB0312 Audigy LS MIDI/Game port
 	8064  SB0100 [SBLive! 5.1 OEM]
 	8938  Ectiva EV1938
+		1033 80e5  SlimTower-Jim (NEC)
+		1071 7150  Mitac 7150
+		110a 5938  Siemens Scenic Mobile 510PIII
+		13bd 100c  Ceres-C (Sharp, Intel BX)
+		13bd 100d  Sharp, Intel Banister
+		13bd 100e  TwinHead P09S/P09S3 (Sharp)
+		13bd f6f1  Marlin (Sharp)
+		14ff 0e70  P88TE (TWINHEAD INTERNATIONAL Corp)
+		14ff c401  Notebook 9100/9200/2000 (TWINHEAD INTERNATIONAL Corp)
+		156d b400  G400 - Geo (AlphaTop (Taiwan))
+		156d b550  G560  (AlphaTop (Taiwan))
+		156d b560  G560  (AlphaTop (Taiwan))
+		156d b700  G700/U700  (AlphaTop (Taiwan))
+		156d b795  G795  (AlphaTop (Taiwan))
+		156d b797  G797  (AlphaTop (Taiwan))
 1103  Triones Technologies, Inc.
 	0003  HPT343
-# Revisions: 01=HPT366, 03=HPT370, 04=HPT370A, 05=HPT372
-	0004  HPT366/368/370/370A/372
+	0004  HPT366/368/370/370A/372/372N
 		1103 0001  HPT370A
 		1103 0003  HPT343 / HPT345 / HPT363 UDMA33
 		1103 0004  HPT366 UDMA66 (r1) / HPT368 UDMA66 (r2) / HPT370 UDMA100 (r3) / HPT370 UDMA100 RAID (r4)
@@ -3851,9 +4006,9 @@
 		1103 0006  HPT302
 		1103 0007  HPT371 UDMA133
 		1103 0008  HPT374 UDMA/ATA133 RAID Controller
-	0005  HPT372A
+	0005  HPT372A/372N
 	0006  HPT302
-	0007  HPT371
+	0007  HPT371/371N
 	0008  HPT374
 	0009  HPT372N
 1104  RasterOps Corp.
@@ -3944,6 +4099,7 @@
 		1458 5004  GA-7VAX Mainboard
 		1462 7020  K8T NEO 2 motherboard
 		147b 1407  KV8-MAX3 motherboard
+		182d 201d  CN-029 USB2.0 4 port PCI Card
 	3040  VT82C586B ACPI
 	3043  VT86C100A [Rhine]
 		10bd 0000  VT86C100A Fast Ethernet Adapter
@@ -3977,7 +4133,7 @@
 		1019 0a81  L7VTA v1.0 Motherboard (KT400-8235)
 		1043 8095  A7V8X Motherboard (Realtek ALC650 codec)
 		1043 80a1  A7V8X-X Motherboard
-		1043 80b0  A7V600 motherboard (ADI AD1980 codec [SoundMAX])
+		1043 80b0  A7V600/K8V Deluxe motherboard (ADI AD1980 codec [SoundMAX])
 		1106 3059  L7VMM2 Motherboard
 		1106 4161  K7VT2 motherboard
 		1297 c160  FX41 motherboard (Realtek ALC650 codec)
@@ -4013,6 +4169,7 @@
 		1458 5004  GA-7VAX Mainboard
 		1462 7020  K8T NEO 2 motherboard
 		147b 1407  KV8-MAX3 motherboard
+		182d 201d  CN-029 USB 2.0 4 port PCI Card
 	3106  VT6105 [Rhine-III]
 		1186 1403  DFE-530TX rev C
 	3108  S3 Unichrome Pro VGA Adapter
@@ -4031,9 +4188,10 @@
 	3147  VT8233A ISA Bridge
 	3148  P4M266 Host Bridge
 	3149  VIA VT6420 SATA RAID Controller
-		1043 80ed  A7V600 motherboard
+		1043 80ed  A7V600/K8V Deluxe motherboard
 		1458 b003  GA-7VM400AM(F) Motherboard
-		1462 7020  MSI Neo K8T FIS2R mainboard
+		1462 7020  K8T Neo 2 Motherboard
+		147b 1407  KV8-MAX3 motherboard
 	3156  P/KN266 Host Bridge
 # on ASUS P4P800
 	3164  VT6410 ATA133 RAID controller
@@ -4045,7 +4203,9 @@
 		1297 f641  FX41 motherboard
 		1458 5001  GA-7VAX Mainboard
 		1849 3177  K7VT2 motherboard
+	3178  ProSavageDDR P4N333 Host Bridge
 	3188  VT8385 [K8T800 AGP] Host Bridge
+		1043 80a3  K8V Deluxe motherboard
 		147b 1407  KV8-MAX3 motherboard
 	3189  VT8377 [KT400/KT600 AGP] Host Bridge
 		1043 807f  A7V8X motherboard
@@ -4053,11 +4213,13 @@
 	3204  K8M800
 	3205  VT8378 [KM400/A] Chipset Host Bridge
 		1458 5000  GA-7VM400M Motherboard
+	3218  K8T800M Host Bridge
 	3227  VT8237 ISA bridge [KT600/K8T800 South]
 		1043 80ed  A7V600 motherboard
 		1106 3227  DFI KT600-AL Motherboard
 		1458 5001  GA-7VT600 Motherboard
 		147b 1407  KV8-MAX3 motherboard
+	3249  VT6421 IDE RAID Controller
 	4149  VIA VT6420 (ATA133) Controller
 	5030  VT82C596 ACPI [Apollo PRO]
 	6100  VT85C100A [Rhine II]
@@ -4113,7 +4275,7 @@
 	007c  FSC Remote Service Controller, shared memory device
 	007d  FSC Remote Service Controller, SMIC device
 # Superfastcom-PCI (Commtech, Inc.) or DSCC4 WAN Adapter
-	2102  DSCC4 PEB/PEF 20534 DMA Supported Serial Communication Contr.
+	2102  DSCC4 PEB/PEF 20534 DMA Supported Serial Communication Controller with 4 Channels
 	2104  Eicon Diva 2.02 compatible passive ISDN card
 	3142  SIMATIC NET CP 5613A1 (Profibus Adapter)
 	4021  SIMATIC NET CP 5512 (Profibus and MPI Cardbus Adapter)
@@ -4300,13 +4462,16 @@
 	3400  SmartPCI56(UCB1500) 56K Modem
 	5400  TriMedia TM1000/1100
 	5402  TriMedia TM-1300
+		1244 0f00  Fritz!Card DSL
 	7130  SAA7130 Video Broadcast Decoder
 		5168 0138  LiveView FlyVideo 2000
 	7133  SAA713X Audio+video broadcast decoder
 		5168 0138  LifeView FlyVideo 3000
 		5168 0212  LifeView FlyTV Platinum mini
+		5168 0502  LifeView FlyDVB-T Duo CardBus
 # PCI audio and video broadcast decoder (http://www.semiconductors.philips.com/pip/saa7134hl)
 	7134  SAA7134
+		1043 4842  TV-FM Card 7134
 	7135  SAA7135 Audio+video broadcast decoder
 	7145  SAA7145
 	7146  SAA7146
@@ -4317,6 +4482,7 @@
 		114b 2003  DVRaptor Video Edit/Capture Card
 		11bd 0006  DV500 Overlay
 		11bd 000a  DV500 Overlay
+		11bd 000f  DV500 Overlay
 		13c2 0000  Siemens/Technotrend/Hauppauge DVB card rev1.3 or rev1.5
 		13c2 0001  Technotrend/Hauppauge DVB card rev1.3 or rev1.6
 		13c2 0002  Technotrend/Hauppauge DVB card rev2.1
@@ -4367,37 +4533,45 @@
 	e011  Diva Server BRI S/T Rev 2
 	e012  Diva Server 4BRI-8M PCI
 		8001 0014  Diva Server 4BRI-8M PCI Cornet NQ
-	e013  Diva Server 4BRI-8M Rev 2
-		8001 0014  Diva Server 4BRI-8M Cornet NQ 2
+	e013  Diva Server 4BRI Rev 2
+		1133 1300  Diva Server V-4BRI-8
+		1133 e013  Diva Server 4BRI-8M 2.0 PCI
+		8001 0014  Diva Server 4BRI-8M 2.0 PCI Cornet NQ
 	e014  Diva Server PRI-30M PCI
 		0008 0100  Diva Server PRI-30M PCI
 		8001 0014  Diva Server PRI-30M PCI Cornet NQ
-	e015  DIVA Server PRI-30M 2.0
-		8001 0014  Diva Server PRI Cornet NQ 2
+	e015  DIVA Server PRI Rev 2
+		1133 e015  Diva Server PRI 2.0 PCI
+		8001 0014  Diva Server PRI 2.0 PCI Cornet NQ
 	e016  Diva Server Voice 4BRI PCI
 		8001 0014  Diva Server PRI Cornet NQ
-	e017  Diva Server Voice 4BRI PCI Rev 2
-		8001 0014  Diva Server Voice 4BRI PCI Cornet NQ 2
-	e018  Diva Server BRI 2M Revision 2
-		8001 0014  Diva Server BRI 2M Cornet NQ 2
-	e019  Diva Server Voice PRI PCI Rev 2
-		8001 0014  Diva Server Voice PRI PCI Cornet NQ 2
+	e017  Diva Server Voice 4BRI Rev 2
+		1133 e017  Diva Server Voice 4BRI-8M 2.0 PCI
+		8001 0014  Diva Server Voice 4BRI-8M 2.0 PCI Cornet NQ
+	e018  Diva Server BRI-2M 2.0 PCI
+		1133 1800  Diva Server V-BRI-2
+		1133 e018  Diva Server BRI-2M 2.0 PCI
+		8001 0014  Diva Server BRI-2M 2.0 PCI Cornet NQ
+	e019  Diva Server Voice PRI Rev 2
+		1133 e019  Diva Server Voice PRI 2.0 PCI
+		8001 0014  Diva Server Voice PRI 2.0 PCI Cornet NQ
 	e01a  Diva Server 2FX
-	e01b  Diva Server BRI-2M Voice Revision 2
-		8001 0014  Diva Server BRI-2M Voice Cornet NQ 2
-	e01c  Diva Server PRI Rev 3.0
-		1133 1c01  Diva Server PRI/E1/T1-8 Rev 3.0
-		1133 1c02  Diva Server PRI/T1-24 Rev 3.0
-		1133 1c03  Diva Server PRI/E1-30 Rev 3.0
-		1133 1c04  Diva Server V-PRI/E1/T1 Rev 3.0
-		1133 1c05  Diva Server V-PRI/T1-24 Rev 3.0
-		1133 1c06  Diva Server V-PRI/E1-30 Rev 3.0
-		1133 1c07  Diva Server PRI/E1/T1-8 Cornet NQ 3
-		1133 1c08  Diva Server PRI/T1-24 Cornet NQ 3
-		1133 1c09  Diva Server PRI/E1-30 Cornet NQ 3
-		1133 1c0a  Diva Server V-PRI/E1/T1 Cornet NQ 3
-		1133 1c0b  Diva Server V-PRI/T1-24 Cornet NQ 3
-		1133 1c0c  Diva Server V-PRI/E1-30 Cornet NQ 3
+	e01b  Diva Server Voice BRI-2M 2.0 PCI
+		1133 e01b  Diva Server Voice BRI-2M 2.0 PCI
+		8001 0014  Diva Server Voice BRI-2M 2.0 PCI Cornet NQ
+	e01c  Diva Server PRI Rev 3
+		1133 1c01  Diva Server PRI/E1/T1-8
+		1133 1c02  Diva Server PRI/T1-24
+		1133 1c03  Diva Server PRI/E1-30
+		1133 1c04  Diva Server PRI/E1/T1
+		1133 1c05  Diva Server V-PRI/T1-24
+		1133 1c06  Diva Server V-PRI/E1-30
+		1133 1c07  Diva Server PRI/E1/T1-8 Cornet NQ
+		1133 1c08  Diva Server PRI/T1-24 Cornet NQ
+		1133 1c09  Diva Server PRI/E1-30 Cornet NQ
+		1133 1c0a  Diva Server PRI/E1/T1 Cornet NQ
+		1133 1c0b  Diva Server V-PRI/T1-24 Cornet NQ
+		1133 1c0c  Diva Server V-PRI/E1-30 Cornet NQ
 	e01e  Diva Server 2PRI
 		1133 1e00  Diva Server V-2PRI/E1-60
 		1133 1e01  Diva Server V-2PRI/T1-48
@@ -4523,6 +4697,8 @@
 		1148 9521  SK-9521 10/100/1000Base-T Adapter
 	4400  SK-9Dxx Gigabit Ethernet Adapter
 	4500  SK-9Mxx Gigabit Ethernet Adapter
+	9000  SK-9Sxx Gigabit Ethernet Server Adapter PCI-X
+	9843  [Fujitsu] Gigabit Ethernet
 	9e00  SK-9Exx 10/100/1000Base-T Adapter
 		1148 2100  SK-9E21 Server Adapter
 		1148 21d0  SK-9E21D 10/100/1000Base-T Adapter
@@ -4695,6 +4871,8 @@
 	0230  CSB5 LPC bridge
 		4c53 1080  CT8 mainboard
 	0240  K2 SATA
+	0241  K2 SATA
+	0242  K2 SATA
 1167  Mutoh Industries Inc
 1168  Thine Electronics Inc
 1169  Centre for Development of Advanced Computing
@@ -4723,7 +4901,7 @@
 	0404  DVD Decoder card
 	0406  Tecra Video Capture device
 	0407  DVD Decoder card (Version 2)
-	0601  601
+	0601  CPU to PCI bridge
 	0603  ToPIC95 PCI to CardBus Bridge for Notebooks
 	060a  ToPIC95
 	060f  ToPIC97
@@ -4760,6 +4938,8 @@
 		144d c006  vpr Matrix 170B4
 	0552  R5C552 IEEE 1394 Controller
 		1014 0511  ThinkPad A/T/X Series
+	0576  R5C576 SD Bus Host Adapter
+	0592  R5C592 Memory Stick Bus Host Adapter
 1181  Telmatics International
 1183  Fujikura Ltd
 1184  Forks Inc
@@ -4794,6 +4974,7 @@
 	3a63  AirXpert DWL-AG660 Wireless Cardbus Adapter
 	3b05  DWL-G650+ CardBus PC Card
 	4000  DL2000-based Gigabit Ethernet
+	4300  DGE-528T Gigabit Ethernet Adapter
 	4c00  Gigabit Ethernet Adapter
 		1186 4c00  DGE-530T Gigabit Ethernet Adapter
 	8400  D-Link DWL-650+ CardBus PC Card
@@ -4841,6 +5022,10 @@
 	8030  AEC6712S SCSI
 	8040  AEC6712D SCSI
 	8050  AEC6712SUW SCSI
+	8060  AEC6712 SCSI
+	8080  AEC67160 SCSI
+	8081  AEC67160S SCSI
+	808a  AEC67162 2-ch. LVD SCSI
 1192  Densan Company Ltd
 1193  Zeitnet Inc.
 	0001  1221
@@ -4878,7 +5063,7 @@
 	0146  GT-64010/64010A System Controller
 	138f  W8300 802.11 Adapter (rev 07)
 	1fa6  Marvell W8300 802.11 Adapter
-	4146  GT-64011/GT-64111 System Controller
+	1fa7  88W8310 and 88W8000G [Libertas] 802.11g client chipset
 	4320  Gigabit Ethernet Controller
 		1019 0f38  Marvell 88E8001 Gigabit Ethernet Controller (ECS)
 		1019 8001  Marvell 88E8001 Gigabit Ethernet Controller (ECS)
@@ -4991,6 +5176,7 @@
 	4611  GT-64115 System Controller
 	4620  GT-64120/64120A/64121A System Controller
 	4801  GT-48001
+	5005  Belkin F5D5005 Gigabit Desktop Network PCI Card
 	5040  MV88SX5040 4-port SATA I PCI-X Controller
 	5041  MV88SX5041 4-port SATA I PCI-X Controller
 	5080  MV88SX5080 8-port SATA I PCI-X Controller
@@ -5331,25 +5517,29 @@
 1217  O2 Micro, Inc.
 	6729  OZ6729
 	673a  OZ6730
-	6832  OZ6832/6833 Cardbus Controller
-	6836  OZ6836/6860 Cardbus Controller
-	6872  OZ6812 Cardbus Controller
-	6925  OZ6922 Cardbus Controller
-	6933  OZ6933 Cardbus Controller
+	6832  OZ6832/6833 CardBus Controller
+	6836  OZ6836/6860 CardBus Controller
+	6872  OZ6812 CardBus Controller
+	6925  OZ6922 CardBus Controller
+	6933  OZ6933/711E1 CardBus/SmartCardBus Controller
 		1025 1016  Travelmate 612 TX
-	6972  OZ6912 Cardbus Controller
+	6972  OZ601/6912/711E0 CardBus/SmartCardBus Controller
 		1014 020c  ThinkPad R30
 		1179 0001  Magnia Z310
-	7110  OZ711Mx MultiMediaBay Accelerator
-		103c 0890  NC6000 laptop
-	7112  OZ711EC1/M1 SmartCardBus MultiMediaBay Controller
+	7110  OZ711Mx 4-in-1 MemoryCardBus Accelerator
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
+	7112  OZ711EC1/M1 SmartCardBus/MemoryCardBus Controller
 	7113  OZ711EC1 SmartCardBus Controller
-	7114  OZ711M1 SmartCardBus MultiMediaBay Controller
+	7114  OZ711M1/MC1 4-in-1 MemoryCardBus Controller
+	7134  OZ711MP1/MS1 MemoryCardBus Controller
 	71e2  OZ711E2 SmartCardBus Controller
-	7212  OZ711M2 SmartCardBus MultiMediaBay Controller
+	7212  OZ711M2 4-in-1 MemoryCardBus Controller
 	7213  OZ6933E CardBus Controller
-	7223  OZ711M3 SmartCardBus MultiMediaBay Controller
-		103c 0890  NC6000 laptop
+	7223  OZ711M3/MC3 4-in-1 MemoryCardBus Controller
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
+	7233  OZ711MP3/MS3 4-in-1 MemoryCardBus Controller
 1218  Hybricon Corp.
 1219  First Virtual Corporation
 121a  3Dfx Interactive, Inc.
@@ -5458,6 +5648,7 @@
 	8120  E4?
 		11bd 0006  DV500 E4
 		11bd 000a  DV500 E4
+		11bd 000f  DV500 E4
 	8888  Cinemaster C 3.0 DVD Decoder
 		1002 0001  Cinemaster C 3.0 DVD Decoder
 		1002 0002  Cinemaster C 3.0 DVD Decoder
@@ -5536,6 +5727,7 @@
 	1969  ES1969 Solo-1 Audiodrive
 		1014 0166  ES1969 SOLO-1 AudioDrive on IBM Aptiva Mainboard
 		125d 8888  Solo-1 Audio Adapter
+		153b 111b  Terratec 128i PCI
 	1978  ES1978 Maestro 2E
 		0e11 b112  Armada M700/E500
 		1033 803c  ES1978 Maestro-2E Audiodrive
@@ -5585,6 +5777,7 @@
 		10b8 2835  SMC2835W Wireless Cardbus Adapter
 		10b8 a835  SMC2835W V2 Wireless Cardbus Adapter
 		1113 ee03  SMC2802W V2 Wireless PCI Adapter
+		1113 ee08  SMC2835W V3 EU Wireless Cardbus Adapter
 		1186 3202  DWL-G650 A1 Wireless Adapter
 		1259 c104  CG-WLCB54GT Wireless Adapter
 		1385 4800  WG511 Wireless Adapter
@@ -5734,6 +5927,7 @@
 		1048 1500  MicroLink 56k Modem
 		10cf 1059  Fujitsu 229-DFRT
 	1005  HCF 56k Data/Fax/Voice/Spkp (w/Handset) Modem
+		1005 127a  AOpen FM56-P
 		1033 8029  229-DFSV
 		1033 8054  Modem
 		10cf 103c  Fujitsu
@@ -5835,7 +6029,7 @@
 	9132  Ethernet 100/10 MBit
 1283  Integrated Technology Express, Inc.
 	673a  IT8330G
-	8212  IT/ITE8212 Dual channel ATA RAID controller
+	8212  IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems to be ITE8212)
 		1283 0001  IT/ITE8212 Dual channel ATA RAID controller
 	8330  IT8330G
 	8872  IT8874F PCI Dual Serial Port Controller
@@ -5951,6 +6145,34 @@
 	0058  PCI NE2K Ethernet
 	5598  PCI NE2K Ethernet
 12c4  Connect Tech Inc
+	0001  Blue HEAT/PCI 8 (RS232/CL/RJ11)
+	0002  Blue HEAT/PCI 4 (RS232)
+	0003  Blue HEAT/PCI 2 (RS232)
+	0004  Blue HEAT/PCI 8 (UNIV, RS485)
+	0005  Blue HEAT/PCI 4+4/6+2 (UNIV, RS232/485)
+	0006  Blue HEAT/PCI 4 (OPTO, RS485)
+	0007  Blue HEAT/PCI 2+2 (RS232/485)
+	0008  Blue HEAT/PCI 2 (OPTO, Tx, RS485)
+	0009  Blue HEAT/PCI 2+6 (RS232/485)
+	000a  Blue HEAT/PCI 8 (Tx, RS485)
+	000b  Blue HEAT/PCI 4 (Tx, RS485)
+	000c  Blue HEAT/PCI 2 (20 MHz, RS485)
+	000d  Blue HEAT/PCI 2 PTM
+	0100  NT960/PCI
+	0201  cPCI Titan - 2 Port
+	0202  cPCI Titan - 4 Port
+	0300  CTI PCI UART 2 (RS232)
+	0301  CTI PCI UART 4 (RS232)
+	0302  CTI PCI UART 8 (RS232)
+	0310  CTI PCI UART 1+1 (RS232/485)
+	0311  CTI PCI UART 2+2 (RS232/485)
+	0312  CTI PCI UART 4+4 (RS232/485)
+	0320  CTI PCI UART 2
+	0321  CTI PCI UART 4
+	0322  CTI PCI UART 8
+	0330  CTI PCI UART 2 (RS485)
+	0331  CTI PCI UART 4 (RS485)
+	0332  CTI PCI UART 8 (RS485)
 12c5  Picture Elements Incorporated
 	007e  Imaging/Scanning Subsystem Engine
 	007f  Imaging/Scanning Subsystem Engine
@@ -6001,6 +6223,8 @@
 12d4  Ulticom (Formerly DGM&S)
 	0200  T1 Card
 12d5  Equator Technologies Inc
+	0003  BSP16
+	1000  BSP15
 12d6  Analogic Corp
 12d7  Biotronic SRL
 12d8  Pericom Semiconductor
@@ -6351,12 +6575,20 @@
 1381  Brains Co. Ltd
 1382  Marian - Electronic & Software
 	0001  ARC88 audio recording card
-	2088  Marc-8 MIDI 8 channel audio card
+	2008  Prodif 96 Pro sound system
+	2088  Marc 8 Midi sound system
+	20c8  Marc A sound system
+	4008  Marc 2 sound system
+	4010  Marc 2 Pro sound system
+	4048  Marc 4 MIDI sound system
+	4088  Marc 4 Digi sound system
+	4248  Marc X sound system
 1383  Controlnet Inc
 1384  Reality Simulation Systems Inc
 1385  Netgear
 # Note: This lists as Atheros Communications, Inc. AR5212 802.11abg NIC because of Madwifi
 	0013  WG311T
+	311a  GA511 Gigabit Ethernet
 	4100  802.11b Wireless Adapter (MA301)
 	4105  MA311 802.11b wireless adapter
 	4400  WAG511 802.11a/b/g Dual Band Wireless PC Card
@@ -6422,6 +6654,8 @@
 	0016  8065 Security Processor
 	0017  8165 Security Processor
 	0018  8154 Security Processor
+	001d  7956 Security Processor
+	0020  7955 Security Processor
 13a4  Rascom Inc
 13a5  Audio Digital Imaging Inc
 13a6  Videonics Inc
@@ -6549,7 +6783,7 @@
 13fc  Computer Peripherals International
 13fd  Micro Science Inc
 13fe  Advantech Co. Ltd
-	1240  PCI-1240 4-channel stepper motor controller card
+	1240  PCI-1240 4-channel stepper motor controller card w.  Nova Electronics MCX314
 	1600  PCI-1612 4-port RS-232/422/485 PCI Communication Card
 	1752  PCI-1752
 	1754  PCI-1754
@@ -6567,6 +6801,8 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
+	0110  Lava DSerial-PCI Port A
+	0111  Lava DSerial-PCI Port B
 	0120  Quattro-PCI A
 	0121  Quattro-PCI B
 	0180  Lava Octo A
@@ -6597,18 +6833,47 @@
 # formerly IC Ensemble Inc.
 1412  VIA Technologies Inc.
 	1712  ICE1712 [Envy24] PCI Multi-Channel I/O Controller
+		1412 1712  Hoontech ST Audio DSP 24
+		1412 d630  M-Audio Delta 1010
+		1412 d631  M-Audio Delta DiO
+		1412 d632  M-Audio Delta 66
+		1412 d633  M-Audio Delta 44
+		1412 d634  M-Audio Delta Audiophile
+		1412 d635  M-Audio Delta TDIF
+		1412 d637  M-Audio Delta RBUS
 		1412 d638  M-Audio Delta 410
+		1412 d63b  M-Audio Delta 1010LT
+		1412 d63c  Digigram VX442
+		1416 1712  Hoontech ST Audio DSP 24 Media 7.1
+		153b 1115  EWS88 MT
+		153b 1125  EWS88 MT (Master)
+		153b 112b  EWS88 D
+		153b 112c  EWS88 D (Master)
+		153b 1130  EWX 24/96
+		153b 1138  DMX 6fire 24/96
+		153b 1151  PHASE88
+		16ce 1040  Edirol DA-2496
 	1724  VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio Controller
+		1412 1724  AMP Ltd AUDIO2000
+		1412 3630  M-Audio Revolution 7.1
+		153b 1145  Aureon 7.1 Space
+		153b 1147  Aureon 5.1 Sky
+		153b 1153  Aureon 7.1 Universe
+		270f f641  ZNF3-150
+		270f f645  ZNF3-250
 1413  Addonics
 1414  Microsoft Corporation
 1415  Oxford Semiconductor Ltd
 	8403  VScom 011H-EP1 1 port parallel adaptor
 	9501  OX16PCI954 (Quad 16950 UART) function 0
 		131f 2050  CyberPro (4-port)
+# Model IO1085, Part No: JJ-P46012
+		131f 2051  CyberSerial 4S Plus
 		15ed 2000  MCCR Serial p0-3 of 8
 		15ed 2001  MCCR Serial p0-3 of 16
 	950a  EXSYS EX-41092 Dual 16950 Serial adapter
 	950b  OXCB950 Cardbus 16950 UART
+	9510  OX16PCI954 (Quad 16950 UART) function 1 (Disabled)
 	9511  OX16PCI954 (Quad 16950 UART) function 1
 		15ed 2000  MCCR Serial p4-7 of 8
 		15ed 2001  MCCR Serial p4-15 of 16
@@ -6692,6 +6957,7 @@
 1456  Advanced Hardware Architectures
 1457  Nuera Communications Inc
 1458  Giga-byte Technology
+	0c11  K8NS Pro Mainboard
 1459  DOOIN Electronics
 145a  Escalate Networks Inc
 145b  PRAIM SRL
@@ -6703,11 +6969,15 @@
 1460  DYNARC INC
 1461  Avermedia Technologies Inc
 1462  Micro-Star International Co., Ltd.
+# MSI CB54G Wireless PC Card that seems to use the Broadcom 4306 Chipset
+	6819  Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller [MSI CB54G]
 	6825  PCI Card wireless 11g [PC54G]
 	8725  NVIDIA NV25 [GeForce4 Ti 4600] VGA Adapter
 # MSI G4Ti4800, 128MB DDR SDRAM, TV-Out, DVI-I
 	9000  NVIDIA NV28 [GeForce4 Ti 4800] VGA Adapter
+	9110  GeFORCE FX5200
 	9119  NVIDIA NV31 [GeForce FX 5600XT] VGA Adapter
+	9591  nVidia Corporation NV36 [GeForce FX 5700LE]
 1463  Fast Corporation
 1464  Interactive Circuits & Systems Ltd
 1465  GN NETTEST Telecom DIV.
@@ -6814,7 +7084,7 @@
 	0340  PC4800
 	0350  PC4800
 	4500  PC4500
-	4800  Cisco Aironet 340 802.11b WLAN Adapter/Aironet PC4800
+	4800  Cisco Aironet 340 802.11b Wireless LAN Adapter/Aironet PC4800
 	a504  Cisco Aironet Wireless 802.11b
 	a505  Cisco Aironet CB20a 802.11a Wireless LAN Adapter
 	a506  Cisco Aironet Mini PCI b/g
@@ -6974,7 +7244,8 @@
 	1659  NetXtreme BCM5721 Gigabit Ethernet PCI Express
 	165d  NetXtreme BCM5705M Gigabit Ethernet
 	165e  NetXtreme BCM5705M_2 Gigabit Ethernet
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 	166e  570x 10/100 Integrated Controller
 	1677  NetXtreme BCM5751 Gigabit Ethernet PCI Express
 		1028 0179  Optiplex GX280
@@ -7057,9 +7328,9 @@
 	4403  BCM4402 V.90 56k Modem
 	4410  BCM4413 iLine32 HomePNA 2.0
 	4411  BCM4413 V.90 56k modem
-	4412  BCM4413 10/100BaseT
+	4412  BCM4412 10/100BaseT
 	4430  BCM44xx CardBus iLine32 HomePNA 2.0
-	4432  BCM44xx CardBus 10/100BaseT
+	4432  BCM4432 CardBus 10/100BaseT
 	4610  BCM4610 Sentry5 PCI to SB Bridge
 	4611  BCM4610 Sentry5 iLine32 HomePNA 1.0
 	4612  BCM4610 Sentry5 V.90 56k Modem
@@ -7251,7 +7522,10 @@
 	2f02  HSF 56k HSFi Data/Fax
 	2f11  HSF 56k HSFi Modem
 	8234  RS8234 ATM SAR Controller [ServiceSAR Plus]
-	8800  Winfast TV2000 XP
+	8800  CX22702 DVB-T 2k/8k
+		17de 08a1  XPert DVB-T PCI BDA DVBT 23880 Video Capture
+	8802  CX23883 Broadcast Decoder
+		17de 08a1  Xpert DVB-T PCI 2388x Transport Stream Capture
 14f2  MOBILITY Electronics
 	0120  EV1000 bridge
 	0121  EV1000 Parallel port
@@ -7324,6 +7598,8 @@
 	1008  PCI-1008
 151b  COMBOX Ltd
 151c  DIGITAL AUDIO LABS Inc
+	0003  Prodif T 2496
+	4000  Prodif 88
 151d  Fujitsu Computer Products Of America
 151e  MATRIX Corp
 151f  TOPIC SEMICONDUCTOR Corp
@@ -7464,6 +7740,7 @@
 1575  Voltaire Advanced Data Security Ltd
 1576  Viewcast COM
 1578  HITT
+	5615  VPMK3 [Video Processor Mk III]
 1579  Dual Technology Corp
 157a  Japan Elecronics Ind Inc
 157b  Star Multimedia Corp
@@ -7653,7 +7930,7 @@
 1637  Linksys
 	3874  Linksys 802.11b WMP11 PCI Wireless card
 1638  Standard Microsystems Corp [SMC]
-	1100  SMC2602W EZConnect/Addtron AWA-100/Eumitcom PCI WL11000
+	1100  SMC2602W EZConnect / Addtron AWA-100 / Eumitcom PCI WL11000
 163c  Smart Link Ltd.
 	3052  SmartLink SmartPCI562 56K Modem
 	5449  SmartPCI561 Modem
@@ -7674,9 +7951,12 @@
 	104e  5LS172.6 B&R Dual CAN Interface Card
 	12d7  5LS172.61 B&R Dual CAN Interface Card
 167b  ZyDAS Technology Corp.
+	2102  ZyDAS ZD1202
+		187e 3406  ZyAIR B-122 CardBus 11Mbs Wireless LAN Card
 1681  Hercules
 # More specs, more accurate desc.
 	0010  Hercules 3d Prophet II Ultra 64MB [ 350 MHz NV15BR core, 128-bit DDR @ 460 MHz, 1.5v AGP4x  ]
+1682  XFX Pine Group Inc.
 1688  CastleNet Technology Inc.
 	1170  WLAN 802.11b card
 168c  Atheros Communications, Inc.
@@ -7684,6 +7964,7 @@
 	0011  AR5210 802.11a NIC
 	0012  AR5211 802.11ab NIC
 	0013  AR5212 802.11abg NIC
+		1113 d301  Philips CPWNA100 Wireless CardBus adapter
 		1186 3202  D-link DWL-G650 B3 Wireless cardbus adapter
 		1186 3203  DWL-G520 Wireless PCI Adapter
 		1186 3a13  DWL-G520 Wireless PCI Adapter rev. B
@@ -7692,13 +7973,19 @@
 		14b7 0a60  8482-WD ORiNOCO 11a/b/g Wireless PCI Adapter
 		168c 0013  WG511T Wireless CardBus Adapter
 		168c 1025  DWL-G650B2 Wireless CardBus Adapter
+		168c 1027  Netgate NL-3054CB ARIES b/g CardBus Adapter
 		168c 2026  Netgate 5354MP ARIES a(108Mb turbo)/b/g MiniPCI Adapter
+		168c 2041  Netgate 5354MP Plus ARIES2 b/g MiniPCI Adapter
+		168c 2042  Netgate 5354MP Plus ARIES2 a/b/g MiniPCI Adapter
 	1014  AR5212 802.11abg NIC
+169c  Netcell Corporation
+	0044  SyncRAID SR3000/5000 Series SATA RAID Controllers
 16a5  Tekram Technology Co.,Ltd.
 16ab  Global Sun Technology Inc
 	1100  GL24110P
 	1101  PLX9052 PCMCIA-to-PCI Wireless LAN
 	1102  PCMCIA-to-PCI Wireless Network Bridge
+	8501  WL-8305 Wireless LAN PCI Adapter
 16ae  Safenet Inc
 	1141  SafeXcel-1141
 16b4  Aspex Semiconductor Ltd
@@ -7713,6 +8000,7 @@
 	1e0f  LEON2FT Processor
 16ec  U.S. Robotics
 	00ff  USR997900 10/100 Mbps PCI Network Card
+	0116  USR997902 10/100/1000 Mbps PCI Network Card
 	3685  Wireless Access PCI Adapter Model 022415
 16ed  Sycron N. V.
 	1001  UMIO communication card
@@ -7781,13 +8069,24 @@
 17cc  NetChip Technology, Inc
 	2280  USB 2.0
 17d3  Areca Technology Corp.
+	1110  ARC-1110 4-Port PCI-X to SATA RAID Controller
+	1120  ARC-1120 8-Port PCI-X to SATA RAID Controller
+	1130  ARC-1130 12-Port PCI-X to SATA RAID Controller
+	1160  ARC-1160 16-Port PCI-X to SATA RAID Controller
+	1210  ARC-1210 4-Port PCI-Express to SATA RAID Controller
+	1220  ARC-1220 8-Port PCI-Express to SATA RAID Controller
+	1230  ARC-1230 12-Port PCI-Express to SATA RAID Controller
+	1260  ARC-1260 16-Port PCI-Express to SATA RAID Controller
 # S2io ships 10Gb PCI-X Ethernet adapters www.s2io.com
 17d5  S2io Inc.
+	5831  Xframe 10 Gigabit Ethernet PCI-X
+		103c 12d5  HP PCI-X 133MHz 10GbE SR Fiber [AB287A]
 17de  KWorld Computer Co. Ltd.
 # http://www.connect3d.com
 17ee  Connect Components Ltd
 17fe  Linksys, A Division of Cisco Systems
-	2220  [AirConn] INPROCOMM IPN 2220 WLAN Adapter (rev 01)
+	2120  WMP11v4 802.11b PCI card
+	2220  [AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01)
 1813  Ambient Technologies Inc
 	4000  HaM controllerless modem
 		16be 0001  V9x HAM Data Fax Modem
@@ -7795,15 +8094,18 @@
 		16be 0002  V9x HAM 1394
 1814  RaLink
 	0101  Wireless PCI Adpator RT2400 / RT2460
+		3306 1113  Quidway WL100M
 	0201  Ralink RT2500 802.11 Cardbus Reference Card
 		1371 001e  CWC-854 Wireless-G CardBus Adapter
 		1371 001f  CWM-854 Wireless-G Mini PCI Adapter
 		1371 0020  CWP-854 Wireless-G PCI Adapter
+		1458 e381  GN-WMKG 802.11b/g Wireless CardBus Adapter
 1820  InfiniCon Systems Inc.
 1822  Twinhan Technology Co. Ltd
 182d  SiteCom Europe BV
 # HFC-based ISDN card
 	3069  ISDN PCI DC-105V2
+	9790  WL-121 Wireless Network Adapter 100g+ [Ver.3]
 1830  Credence Systems Corporation
 183b  MikroM GmbH
 	08a7  MVC100 DVI
@@ -7832,6 +8134,7 @@
 18ac  DViCO Corporation
 	d810  FusionHDTV 3 Gold
 18b8  Ammasso
+	b001  AMSO 1100 iWARP/RDMA Gigabit Ethernet Coprocessor
 18bc  Info-Tek Corp.
 # assigned to Octigabay System, which has been acquired by Cray
 18c8  Cray Inc
@@ -7849,8 +8152,10 @@
 18fb  Resilience Corporation
 1924  Level 5 Networks Inc.
 1966  Orad Hi-Tec Systems
-1975  Pudlis Co. Ltd.
+	1975  DVG64 family
 1993  Innominate Security Technologies AG
+# http://www.progeny.net
+19ae  Progeny Systems Corporation
 1a08  Sierra semiconductor
 	0000  SC15064
 1b13  Jaton Corp
@@ -7962,15 +8267,19 @@
 	1360  RTL8139 Ethernet
 4143  Digital Equipment Corp
 4144  Alpha Data
+	0044  ADM-XRCIIPro
 416c  Aladdin Knowledge Systems
 	0100  AladdinCARD
 	0200  CPC
 4444  Internext Compression Inc
 	0016  iTVC16 (CX23416) MPEG-2 Encoder
 		0070 4009  WinTV PVR 250
+		0070 8003  WinTV PVR 150
 	0803  iTVC15 MPEG-2 Encoder
 		0070 4000  WinTV PVR-350
 		0070 4001  WinTV PVR-250
+# video capture card
+		1461 a3cf  M179
 4468  Bridgeport machines
 4594  Cogetec Informatique Inc
 45fb  Baldor Electric Company
@@ -8134,6 +8443,7 @@
 	8c11  82C270-294 Savage/MX
 	8c12  86C270-294 Savage/IX-MV
 		1014 017f  ThinkPad T20
+		1179 0001  86C584 SuperSavage/IXC Toshiba
 	8c13  86C270-294 Savage/IX
 		1179 0001  Magnia Z310
 	8c22  SuperSavage MX/128
@@ -8341,6 +8651,7 @@
 		8086 1018  PRO/1000 MT Desktop Adapter
 	1019  82547EI Gigabit Ethernet Controller (LOM)
 		1458 1019  GA-8IPE1000 Pro2 motherboard (865PE)
+		1458 e000  Intel Gigabit Ethernet (Kenai II)
 		8086 1019  PRO/1000 CT Desktop Connection
 		8086 301f  D865PERL mainboard
 		8086 3427  S875WP1-E mainboard
@@ -8397,6 +8708,7 @@
 	1050  82562EZ 10/100 Ethernet Controller
 		1462 728c  865PE Neo2 (MS-6728)
 		1462 758c  MS-6758 (875P Neo)
+		8086 3020  D865PERL mainboard
 		8086 3427  S875WP1-E mainboard
 	1051  82801EB/ER (ICH5/ICH5R) integrated LAN Controller
 	1059  82551QM Ethernet Controller
@@ -8743,10 +9055,10 @@
 		1462 3370  STAC9721 AC
 		147b 0507  TH7II-RAID
 		8086 4557  D815EGEW Mainboard
-	2446  Intel 537 [82801BA/BAM AC'97 Modem]
+	2446  82801BA/BAM AC'97 Modem
 		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
-	2448  82801 PCI Bridge
+	2448  82801 Mobile PCI Bridge
 	2449  82801BA/BAM/CA/CAM Ethernet Controller
 		0e11 0012  EtherExpress PRO/100 VM
 		0e11 0091  EtherExpress PRO/100 VE
@@ -8855,7 +9167,8 @@
 		1025 005a  TravelMate 290
 		1028 0126  Optiplex GX260
 		1028 0163  Latitude D505
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 		1462 5800  845PE Max (MS-6580)
 		1509 2990  Averatec 5110H laptop
@@ -8864,7 +9177,8 @@
 		1014 0267  NetVista A30p
 		1025 005a  TravelMate 290
 		1028 0126  Optiplex GX260
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 		1458 24c2  GA-8PE667 Ultra
 		1462 5800  845PE Max (MS-6580)
@@ -8874,7 +9188,8 @@
 		1025 005a  TravelMate 290
 		1028 0126  Optiplex GX260
 		1028 0163  Latitude D505
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 		1462 5800  845PE Max (MS-6580)
 		1509 2990  Averatec 5110H
@@ -8884,57 +9199,63 @@
 		1014 0267  NetVista A30p
 		1025 005a  TravelMate 290
 		1028 0163  Latitude D505
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 		1458 a002  GA-8PE667 Ultra
 		1462 5800  845PE Max (MS-6580)
 	24c6  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller
 		1025 005a  TravelMate 290
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 	24c7  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
 		1014 0267  NetVista A30p
 		1025 005a  TravelMate 290
 		1028 0126  Optiplex GX260
 		1028 0163  Latitude D505
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 		1462 5800  845PE Max (MS-6580)
 		1509 2990  Averatec 5110H
 		4c53 1090  Cx9 / Vx9 mainboard
-	24ca  82801DBM (ICH4) Ultra ATA Storage Controller
+	24ca  82801DBM (ICH4-M) IDE Controller
 		1025 005a  TravelMate 290
 		1028 0163  Latitude D505
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
-	24cb  82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller
+	24cb  82801DB (ICH4) IDE Controller
 		1014 0267  NetVista A30p
 		1028 0126  Optiplex GX260
 		1458 24c2  GA-8PE667 Ultra
 		1462 5800  845PE Max (MS-6580)
 		4c53 1090  Cx9 / Vx9 mainboard
-	24cc  82801DBM LPC Interface Controller
-	24cd  82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
+	24cc  82801DBM (ICH4-M) LPC Interface Bridge
+	24cd  82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
 		1014 0267  NetVista A30p
 		1025 005a  TravelMate 290
 		1028 0126  Optiplex GX260
 		1028 0163  Latitude D505
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 		1071 8160  MIM2000
 		1462 3981  845PE Max (MS-6580)
 		1509 1968  Averatec 5110H
 		4c53 1090  Cx9 / Vx9 mainboard
 	24d0  82801EB/ER (ICH5/ICH5R) LPC Interface Bridge
-	24d1  82801EB (ICH5) Serial ATA 150 Storage Controller
+	24d1  82801EB (ICH5) SATA Controller
 		103c 12bc  d530 CMT (DG746A)
 		1458 24d1  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
 		8086 3427  S875WP1-E mainboard
 		8086 524c  D865PERL mainboard
 	24d2  82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1
+		1028 0183  PowerEdge 1800
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
-		1458 24d2  GA-8KNXP motherboard (875P)
+		1458 24d2  GA-8IPE1000/8KNXP motherboard
 		1462 7280  865PE Neo2 (MS-6728)
 		8086 3427  S875WP1-E mainboard
 		8086 524c  D865PERL mainboard
@@ -8945,6 +9266,7 @@
 		8086 3427  S875WP1-E mainboard
 		8086 524c  D865PERL mainboard
 	24d4  82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2
+		1028 0183  PowerEdge 1800
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
@@ -8954,27 +9276,32 @@
 	24d5  82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller
 		103c 12bc  Analog Devices codec [SoundMAX Integrated Digital Audio]
 		1043 80f3  P4P800 Mainboard
-		1458 a002  GA-8KNXP motherboard (875P)
+# Again, I suppose they use the same in different subsystems
+		1458 a002  GA-8IPE1000/8KNXP motherboard
 		1462 7280  865PE Neo2 (MS-6728)
 		8086 a000  D865PERL mainboard
+		8086 e000  D865PERL mainboard
 	24d6  82801EB/ER (ICH5/ICH5R) AC'97 Modem Controller
 	24d7  82801EB/ER (ICH5/ICH5R) USB UHCI #3
+		1028 0183  PowerEdge 1800
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
 		8086 3427  S875WP1-E mainboard
 		8086 524c  D865PERL mainboard
-	24db  82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller
+	24db  82801EB/ER (ICH5/ICH5R) IDE Controller
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
 		1462 7580  MSI 875P
+		8086 24db  P4C800 Mainboard
 		8086 3427  S875WP1-E mainboard
 		8086 524c  D865PERL mainboard
 	24dc  82801EB (ICH5) LPC Interface Bridge
 	24dd  82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
+		1028 0183  PowerEdge 1800
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 5006  GA-8IPE1000 Pro2 motherboard (865PE)
@@ -8987,7 +9314,7 @@
 		1462 7280  865PE Neo2 (MS-6728)
 		8086 3427  S875WP1-E mainboard
 		8086 524c  D865PERL mainboard
-	24df  82801EB (ICH5R) SATA (cc=RAID)
+	24df  82801ER (ICH5R) SATA Controller
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1028 0095  Precision Workstation 220 Chipset
 		1043 801c  P3C-2000 system chipset
@@ -9047,8 +9374,8 @@
 	2579  82875P Processor to AGP Controller
 	257b  82875P/E7210 Processor to PCI to CSA Bridge
 	257e  82875P/E7210 Processor to I/O Memory Interface
-	2580  915G/P/GV Processor to I/O Controller
-	2581  915G/P/GV PCI Express Root Port
+	2580  915G/P/GV/GL/PL/910GL Processor to I/O Controller
+	2581  915G/P/GV/GL/PL/910GL PCI Express Root Port
 	2582  82915G/GV/910GL Express Chipset Family Graphics Controller
 		1028 1079  Optiplex GX280
 	2584  925X/XE Memory Controller Hub
@@ -9080,40 +9407,40 @@
 	25ad  6300ESB USB2 Enhanced Host Controller
 	25ae  6300ESB 64-bit PCI-X Bridge
 	25b0  6300ESB SATA RAID Controller
-	2600  Server Hub Interface
-	2601  Server Hub PCI Express x4 Port D
-	2602  Server Hub PCI Express x4 Port C0
-	2603  Server Hub PCI Express x4 Port C1
-	2604  Server Hub PCI Express x4 Port B0
-	2605  Server Hub PCI Express x4 Port B1
-	2606  Server Hub PCI Express x4 Port A0
-	2607  Server Hub PCI Express x4 Port A1
-	2608  Server Hub PCI Express x8 Port C
-	2609  Server Hub PCI Express x8 Port B
-	260a  Server Hub PCI Express x8 Port A
-	260c  Server Hub IMI Registers
-	2610  Server Hub System Bus, Boot, and Interrupt Registers
-	2611  Server Hub Address Mapping Registers
-	2612  Server Hub RAS Registers
-	2613  Server Hub Performance Monitoring Registers
-	2614  Server Hub Performance Monitoring Registers
-	2615  Server Hub Performance Monitoring Registers
-	2617  Server Hub Debug Registers
-	2618  Server Hub Debug Registers
-	2619  Server Hub Debug Registers
-	261a  Server Hub Debug Registers
-	261b  Server Hub Debug Registers
-	261c  Server Hub Debug Registers
-	261d  Server Hub Debug Registers
-	261e  Server Hub Debug Registers
-	2620  External Memory Bridge
-	2621  External Memory Bridge Control Registers
-	2622  External Memory Bridge Memory Interleaving Registers
-	2623  External Memory Bridge DDR Initialization and Calibration
-	2624  External Memory Bridge Reserved Registers
-	2625  External Memory Bridge Reserved Registers
-	2626  External Memory Bridge Reserved Registers
-	2627  External Memory Bridge Reserved Registers
+	2600  E8500 Hub Interface
+	2601  E8500 PCI Express x4 Port D
+	2602  E8500 PCI Express x4 Port C0
+	2603  E8500 PCI Express x4 Port C1
+	2604  E8500 PCI Express x4 Port B0
+	2605  E8500 PCI Express x4 Port B1
+	2606  E8500 PCI Express x4 Port A0
+	2607  E8500 PCI Express x4 Port A1
+	2608  E8500 PCI Express x8 Port C
+	2609  E8500 PCI Express x8 Port B
+	260a  E8500 PCI Express x8 Port A
+	260c  E8500 IMI Registers
+	2610  E8500 System Bus, Boot, and Interrupt Registers
+	2611  E8500 Address Mapping Registers
+	2612  E8500 RAS Registers
+	2613  E8500 Reserved Registers
+	2614  E8500 Reserved Registers
+	2615  E8500 Miscellaneous Registers
+	2617  E8500 Reserved Registers
+	2618  E8500 Reserved Registers
+	2619  E8500 Reserved Registers
+	261a  E8500 Reserved Registers
+	261b  E8500 Reserved Registers
+	261c  E8500 Reserved Registers
+	261d  E8500 Reserved Registers
+	261e  E8500 Reserved Registers
+	2620  E8500 eXternal Memory Bridge
+	2621  E8500 XMB Miscellaneous Registers
+	2622  E8500 XMB Memory Interleaving Registers
+	2623  E8500 XMB DDR Initialization and Calibration
+	2624  E8500 XMB Reserved Registers
+	2625  E8500 XMB Reserved Registers
+	2626  E8500 XMB Reserved Registers
+	2627  E8500 XMB Reserved Registers
 	2640  82801FB/FR (ICH6/ICH6R) LPC Interface Bridge
 	2641  82801FBM (ICH6M) LPC Interface Bridge
 	2642  82801FW/FRW (ICH6W/ICH6RW) LPC Interface Bridge
@@ -9153,11 +9480,10 @@
 	2779  PCI Express Root Port
 	2782  82915G Express Chipset Family Graphics Controller
 	2792  Mobile 915GM/GMS/910GML Express Graphics Controller
-	27b1  Mobile I/O Controller Hub LPC
 	27b8  I/O Controller Hub LPC
+	27b9  Mobile I/O Controller Hub LPC
 	27c0  I/O Controller Hub SATA cc=IDE
 	27c1  I/O Controller Hub SATA cc=AHCI
-	27c2  I/O Controller Hub SATA cc=RAID
 	27c3  I/O Controller Hub SATA cc=RAID
 	27c4  Mobile I/O Controller Hub SATA cc=IDE
 	27c5  Mobile I/O Controller Hub SATA cc=AHCI
@@ -9182,7 +9508,8 @@
 	3200  GD31244 PCI-X SATA HBA
 	3340  82855PM Processor to I/O Controller
 		1025 005a  TravelMate 290
-		103c 0890  NC6000 laptop
+		103c 088c  nc8000 laptop
+		103c 0890  nc6000 laptop
 	3341  82855PM Processor to AGP Controller
 	3575  82830 830 Chipset Host Bridge
 		1014 021d  ThinkPad A/T/X Series
@@ -9306,7 +9633,9 @@
 	84e4  460GX - 84460GX Memory Data Controller (MDC)
 	84e6  460GX - 82466GX Wide and fast PCI eXpander Bridge (WXB)
 	84ea  460GX - 84460GX AGP Bridge (GXB function 1)
-	8500  IXP4XX Network Processor family. IXP420/IXP421/IXP422/IXP425/IXC1100
+	8500  IXP4XX - Intel Network Processor family. IXP420, IXP421, IXP422, IXP425 and IXC1100
+		1993 0dee  mGuard-PCI AV#1
+		1993 0def  mGuard-PCI AV#0
 	9000  IXP2000 Family Network Processor
 	9001  IXP2400 Network Processor
 	9004  IXP2800 Network Processor
@@ -9323,7 +9652,6 @@
 	b154  21154 PCI-to-PCI Bridge
 	b555  21555 Non transparent PCI-to-PCI Bridge
 		12d9 000a  PCI VoIP Gateway
-		1331 0030  ENP-2611
 		4c53 1050  CT7 mainboard
 		4c53 1051  CE7 mainboard
 		e4bf 1000  CC8-1-BLUES
@@ -9512,8 +9840,10 @@
 		9005 0284  Tomcat
 	0285  AAC-RAID
 		0e11 0295  SATA 6Ch (Bearcat)
+		1014 02f2  ServeRAID 8i
 		1028 0287  PowerEdge Expandable RAID Controller 320/DC
 		1028 0291  CERC SATA RAID 2 PCI SATA 6ch (DellCorsair)
+		103c 3227  AAR-2610SA
 		17aa 0286  Legend S220 (Legend Crusader)
 		17aa 0287  Legend S230 (Legend Vulcan)
 		9005 0285  2200S (Vulcan)
@@ -9614,6 +9944,10 @@
 d531  I+ME ACTIA GmbH
 d84d  Exsys
 dead  Indigita Corporation
+deaf  Middle Digital Inc.
+	9050  PC Weasel Virtual VGA
+	9051  PC Weasel Serial Port
+	9052  PC Weasel Watchdog Timer
 e000  Winbond
 	e000  W89C940
 # see also : http://www.schoenfeld.de/inside/Inside_CWMK3.txt maybe a misuse of TJN id or it use the TJN 3XX chip for other applic
@@ -9647,13 +9981,6 @@
 ec80  Belkin Corporation
 	ec00  F5D6000
 ecc0  Echo Digital Audio Corporation
-	0050  Gina24_301
-	0051  Gina24_361
-	0060  Layla24
-	0070  Mona_301_80
-	0071  Mona_301_66
-	0072  Mona_361
-	0080  Mia
 edd8  ARK Logic Inc
 	a091  1000PV [Stingray]
 	a099  2000PV [Stingray]

