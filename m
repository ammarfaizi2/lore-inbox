Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUA3BeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUA3BeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:34:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:4316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266498AbUA3Bb5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:31:57 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263101353@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:50 -0800
Message-Id: <1075426310683@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1523, 2004/01/29 17:13:13-08:00, kieran@mgpenguin.net

[PATCH] PCI: pci.ids update

- Replaces pci.ids with a snapshot from pciids.sf.net from 14 Jan 2004


 drivers/pci/pci.ids |  961 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 721 insertions(+), 240 deletions(-)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Thu Jan 29 17:23:48 2004
+++ b/drivers/pci/pci.ids	Thu Jan 29 17:23:48 2004
@@ -7,7 +7,7 @@
 #	so if you have anything to contribute, please visit the home page or
 #	send a diff -u against the most recent pci.ids to pci-ids@ucw.cz.
 #
-#	$Id: pci.ids,v 1.48 2002/12/26 13:03:41 mares Exp $
+#	Daily snapshot on Wed 2004-01-14 11:00:17
 #
 
 # Vendors, devices and subsystems. Please keep sorted.
@@ -118,6 +118,8 @@
 		0e11 7004  Embedded Ultra Wide SCSI Controller
 		1092 8760  FirePort 40 Dual SCSI Controller
 		1de1 3904  DC390F Ultra Wide SCSI Controller
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1050  CT7 mainboard
 	0010  53c895
 		0e11 4040  Integrated Array Controller
 		0e11 4048  Integrated Array Controller
@@ -126,7 +128,10 @@
 	0020  53c1010 Ultra3 SCSI Adapter
 		1de1 1020  DC-390U3W
 	0021  53c1010 66MHz  Ultra3 SCSI Adapter
-	0030  53c1030
+		4c53 1080  CT8 mainboard
+		4c53 1300  P017 mezzanine (32-bit PMC)
+		4c53 1310  P017 mezzanine (64-bit PMC)
+	0030  53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
 		1028 1010  LSI U320 SCSI Controller
 	0040  53c1035
 	008f  53c875J
@@ -161,10 +166,17 @@
 	0017  PROTO-3 PCI Prototyping board
 	9100  INI-9100/9100W SCSI Host
 1002  ATI Technologies Inc
+	4136  Radeon IGP 320 M
+	4144  Radeon R300 AD [Radeon 9500 Pro]
+	4145  Radeon R300 AE [Radeon 9500 Pro]
+	4146  Radeon R300 AF [Radeon 9500 Pro]
+	4147  Radeon R300 AG [FireGL Z1/X1]
 	4158  68800AX [Mach32]
+	4164  Radeon R300 Secondary (DVI) output
 	4242  Radeon R200 BB [Radeon All in Wonder 8500DV]
 		1002 02aa  Radeon 8500 AIW DV Edition
 	4336  Radeon Mobility U1
+	4337  Radeon IGP 340M
 	4354  215CT [Mach64 CT]
 	4358  210888CX [Mach64 CX]
 	4554  210888ET [Mach64 ET]
@@ -214,6 +226,8 @@
 	4752  Rage XL
 		1002 0008  Rage XL
 		1002 4752  Rage XL
+		1002 8008  Rage XL
+		1028 00ce  PowerEdge 1400
 		1028 00d1  PowerEdge 2550
 	4753  Rage XC
 		1002 4753  Rage XC
@@ -238,6 +252,8 @@
 		10f1 0002  R250 If [Tachyon G9000 PRO]
 		148c 2039  R250 If [Radeon 9000 Pro "Evil Commando"]
 		1509 9a00  R250 If [Radeon 9000 "AT009"]
+# New subdevice - 3D Prophet 9000 PCI by Hercules.  AGP version probably would have same ID, so not specified.
+		1681 0040  R250 If [3D prophet 9000]
 		174b 7176  R250 If [Sapphire Radeon 9000 Pro]
 		174b 7192  R250 If [Radeon 9000 "Atlantis"]
 		17af 2005  R250 If [Excalibur Radeon 9000 Pro]
@@ -255,6 +271,7 @@
 	4c44  3D Rage LT Pro AGP-66
 	4c45  Rage Mobility M3 AGP
 	4c46  Rage Mobility M3 AGP 2x
+		1028 00b1  Latitude C600
 	4c47  3D Rage LT-G 215LG
 	4c49  3D Rage LT Pro
 		1002 0004  Rage LT Pro
@@ -262,8 +279,11 @@
 		1002 0044  Rage LT Pro
 		1002 4c49  Rage LT Pro
 	4c4d  Rage Mobility P/M AGP 2x
+		0e11 b111  Armada M700
+		0e11 b160  Armada E500
 		1002 0084  Xpert 98 AGP 2X (Mobility)
 		1014 0154  ThinkPad A20m
+		1028 00aa  Latitude CPt
 	4c4e  Rage Mobility L AGP 2x
 	4c50  3D Rage LT Pro
 		1002 4c50  Rage LT Pro
@@ -274,23 +294,33 @@
 	4c57  Radeon Mobility M7 LW [Radeon Mobility 7500]
 		1014 0517  ThinkPad T30
 		1028 00e6  Radeon Mobility M7 LW (Dell Inspiron 8100)
-	4c58  Radeon Mobility M7 LX [Radeon Mobility FireGL 7800]
+		144d c006  Radeon Mobility M7 LW in vpr Matrix 170B4
+	4c58  Radeon RV200 LX [Mobility FireGL 7800 M7]
 	4c59  Radeon Mobility M6 LY
 		1014 0235  ThinkPad A30p (2653-64G)
 		1014 0239  ThinkPad X22/X23/X24
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
 	4c5a  Radeon Mobility M6 LZ
-	4c64  Radeon R250 Ld [Radeon Mobility 9000]
-	4c65  Radeon R250 Le [Radeon Mobility 9000]
-	4c66  Radeon R250 Lf [Radeon Mobility 9000]
-	4c67  Radeon R250 Lg [Radeon Mobility 9000]
+	4c64  Radeon R250 Ld [Radeon Mobility 9000 M9]
+	4c65  Radeon R250 Le [Radeon Mobility 9000 M9]
+	4c66  Radeon R250 Lf [Radeon Mobility 9000 M9]
+	4c67  Radeon R250 Lg [Radeon Mobility 9000 M9]
+# Secondary chip to the Lf
+	4c6e  Radeon R250 Ln [Radeon Mobility 9000 M9] [Secondary]
 	4d46  Rage Mobility M4 AGP
 	4d4c  Rage Mobility M4 AGP
-	4e44  Radeon R300 ND [Radeon 9700]
-	4e45  Radeon R300 NE [Radeon 9700]
+	4e44  Radeon R300 ND [Radeon 9700 Pro]
+	4e45  Radeon R300 NE [Radeon 9500 Pro]
+		1002 0002  Radeon R300 NE [Radeon 9500 Pro]
 	4e46  Radeon R300 NF [Radeon 9700]
-	4e47  Radeon R300 NG [Radeon 9700]
-	4e64  Radeon R300 [Radeon 9700] (Secondary)
+	4e47  Radeon R300 NG [FireGL X1]
+	4e48  Radeon R350 [Radeon 9800]
+	4e64  Radeon R300 [Radeon 9700 Pro] (Secondary)
+	4e65  Radeon R300 [Radeon 9500 Pro] (Secondary)
+		1002 0003  Radeon R300 NE [Radeon 9500 Pro]
+	4e66  Radeon R300 [Radeon 9700] (Secondary)
+	4e67  Radeon R300 [FireGL X1] (Secondary)
+	4e68  Radeon R350 [Radeon 9800] (Secondary)
 	5041  Rage 128 PA/PRO
 	5042  Rage 128 PB/PRO AGP 2x
 	5043  Rage 128 PC/PRO AGP 4x
@@ -327,7 +357,7 @@
 	5056  Rage 128 PV/PRO TMDS
 	5057  Rage 128 PW/PRO AGP 2x TMDS
 	5058  Rage 128 PX/PRO AGP 4x TMDS
-	5144  Radeon R100 QD [Radeon 64 DDR]
+	5144  Radeon R100 QD [Radeon 7200]
 		1002 0008  Radeon 7000/Radeon VE
 		1002 0009  Radeon 7000/Radeon
 		1002 000a  Radeon 7000/Radeon
@@ -345,8 +375,10 @@
 	5146  Radeon R100 QF
 	5147  Radeon R100 QG
 	5148  Radeon R200 QH [Radeon 8500]
-		1002 0152  FireGL 8800
-		1002 0172  FireGL 8700
+		1002 010a  FireGL 8800 64Mb
+		1002 0152  FireGL 8800 128Mb
+		1002 0162  FireGL 8700 32Mb
+		1002 0172  FireGL 8700 64Mb
 	5149  Radeon R200 QI
 	514a  Radeon R200 QJ
 	514b  Radeon R200 QK
@@ -355,6 +387,9 @@
 		1002 013a  Radeon 8500
 		148c 2026  R200 QL [Radeon 8500 Evil Master II Multi Display Edition]
 		174b 7149  Radeon R200 QL [Sapphire Radeon 8500 LE]
+	514d  Radeon R200 QM [Radeon 9100]
+	514e  Radeon R200 QN [Radeon 8500LE]
+	514f  Radeon R200 QO [Radeon 8500LE]
 	5157  Radeon RV200 QW [Radeon 7500]
 		1002 013a  Radeon 7500
 		1458 4000  RV200 QW [RADEON 7500 PRO MAYA AR]
@@ -365,7 +400,7 @@
 		174b 7161  Radeon RV200 QW [Radeon 7500 LE]
 		17af 0202  RV200 QW [Excalibur Radeon 7500LE]
 	5158  Radeon RV200 QX [Radeon 7500]
-	5159  Radeon VE QY
+	5159  Radeon RV100 QY [Radeon 7000/VE]
 		1002 000a  Radeon 7000/Radeon VE
 		1002 000b  Radeon 7000
 		1002 0038  Radeon 7000/Radeon VE
@@ -377,11 +412,13 @@
 		148c 2023  RV100 QY [Radeon 7000 Evil Master Multi-Display]
 		174b 7112  RV100 QY [Sapphire Radeon VE 7000]
 		1787 0202  RV100 QY [Excalibur Radeon 7000]
-	515a  Radeon VE QZ
+	515a  Radeon RV100 QZ [Radeon 7000/VE]
 	5168  Radeon R200 Qh
 	5169  Radeon R200 Qi
 	516a  Radeon R200 Qj
 	516b  Radeon R200 Qk
+# This one is not in ATI documentation, but is in XFree86 source code
+	516c  Radeon R200 Ql
 	5245  Rage 128 RE/SG
 		1002 0008  Xpert 128
 		1002 0028  Rage 128 AIW
@@ -401,6 +438,7 @@
 		1002 0088  Xpert 99
 	5345  Rage 128 SE/4x
 	5346  Rage 128 SF/4x AGP 2x
+		1002 0048  RAGE 128 16MB VGA TVOUT AMC PAL
 	5347  Rage 128 SG/4x AGP 4x
 	5348  Rage 128 SH
 	534b  Rage 128 SK/4x
@@ -431,7 +469,11 @@
 		1002 5654  Mach64VT Reference
 	5655  264VT3 [Mach64 VT3]
 	5656  264VT4 [Mach64 VT4]
-	700f  U1/A3 AGP Bridge [IGP 320M]
+	5961  Radeon RV280 [Radeon 9200]
+	700f  PCI Bridge [IGP 320M]
+	7010  PCI Bridge [IGP 340M]
+	cab0  AGP Bridge [IGP 320M]
+	cab2  RS200/RS200M AGP Bridge [IGP 340M]
 1003  ULSI Systems
 	0201  US201
 1004  VLSI Technology Inc
@@ -485,7 +527,14 @@
 	0011  NS87560 National PCI System I/O
 	0012  USB Controller
 	0020  DP83815 (MacPhyter) Ethernet Controller
+		1385 f311  FA311 / FA312 (FA311 with WoL HW)
 	0022  DP83820 10/100/1000 Ethernet Controller
+	0028  CS5535 Host bridge
+	002b  CS5535 ISA bridge
+	002d  CS5535 IDE
+	002e  CS5535 Audio
+	002f  CS5535 USB
+	0030  CS5535 Video
 	0500  SCx200 Bridge
 	0501  SCx200 SMI
 	0502  SCx200 IDE
@@ -537,6 +586,7 @@
 	0014  DECchip 21041 [Tulip Pass 3]
 		1186 0100  DE-530+
 	0016  DGLPB [OPPO]
+	0017  PV-PCI Graphics Controller (ZLXp-L)
 	0019  DECchip 21142/43
 		1011 500a  DE500A Fast Ethernet
 		1011 500b  DE500B Fast Ethernet
@@ -567,6 +617,7 @@
 		1374 0002  Cardbus Ethernet Card 10/100
 		1374 0007  Cardbus Ethernet Card 10/100
 		1374 0008  Cardbus Ethernet Card 10/100
+		1385 2100  FA510
 		1395 0001  10/100 Ethernet CardBus PC Card
 		13d1 ab01  EtherFast 10/100 Cardbus (PCMPC200)
 		8086 0001  EtherExpress PRO/100 Mobile CardBus 32
@@ -585,7 +636,9 @@
 		0e11 4051  Integrated Smart Array
 		0e11 4058  Integrated Smart Array
 		103c 10c2  Hewlett-Packard NetRAID-4M
-		12d9 000a  VoIP PCI Gateway
+		12d9 000a  IP Telephony card
+		4c53 1050  CT7 mainboard
+		4c53 1051  CE7 mainboard
 		9005 0365  Adaptec 5400S
 		9005 1364  Dell PowerEdge RAID Controller 2
 		9005 1365  Dell PowerEdge RAID Controller 2
@@ -650,14 +703,17 @@
 	001b  GXT-150P
 	001c  Carrera
 	001d  82G2675
-	0020  MCA
+	0020  GXT1000 Graphics Adapter
 	0022  IBM27-82351
 	002d  Python
-	002e  ServeRAID Controller
+# [official name in AIX 5]
+	002e  SCSI RAID Adapter [ServeRAID]
 		1014 002e  ServeRAID-3x
 		1014 022e  ServeRAID-4H
+	0031  2 Port Serial Adapter
 	0036  Miami
 	003a  CPU to PCI Bridge
+	003c  GXT250P/GXT255P Graphics Adapter
 	003e  16/4 Token ring UTP/STP controller
 		1014 003e  Token-Ring Adapter
 		1014 00cd  Token-Ring Adapter + Wake-On-LAN
@@ -675,23 +731,30 @@
 	004f  ATM Controller (14104f00)
 	0050  ATM Controller (14105000)
 	0053  25 MBit ATM Controller
+	0054  GXT500P/GXT550P Graphics Adapter
 	0057  MPEG PCI Bridge
 	005c  i82557B 10/100
+	005e  GXT800P Graphics Adapter
 	007c  ATM Controller (14107c00)
 	007d  3780IDSP [MWave]
+	008e  GXT3000P Graphics Adapter
 	0090  GXT 3000P
 		1014 008e  GXT-3000P
+	0091  SSA Adapter
 	0095  20H2999 PCI Docking Bridge
 	0096  Chukar chipset SCSI controller
 		1014 0097  iSeries 2778 DASD IOA
 		1014 0098  iSeries 2763 DASD IOA
 		1014 0099  iSeries 2748 DASD IOA
+	009f  PCI 4758 Cryptographic Accelerator
 	00a5  ATM Controller (1410a500)
 	00a6  ATM 155MBPS MM Controller (1410a600)
 	00b7  256-bit Graphics Rasterizer [Fire GL1]
+	00b8  GXT2000P Graphics Adapter
 	00be  ATM 622MBPS Controller (1410be00)
 	00dc  Advanced Systems Management Adapter (ASMA)
 	00fc  CPC710 Dual Bridge and Memory Controller (PCI-64)
+	0104  Gigabit Ethernet-SX Adapter
 	0105  CPC710 Dual Bridge and Memory Controller (PCI-32)
 	010f  Remote Supervisor Adapter (RSA)
 	0142  Yotta Video Compositor Input
@@ -699,6 +762,14 @@
 	0144  Yotta Video Compositor Output
 		1014 0145  Yotta Output Controller (ytout)
 	0156  405GP PLB to PCI Bridge
+	015e  622Mbps ATM PCI Adapter
+	0160  64bit/66MHz PCI ATM 155 MMF
+	016e  GXT4000P Graphics Adapter
+	0170  GXT6000P Graphics Adapter
+	017d  GXT300P Graphics Adapter
+	0180  Snipe chipset SCSI controller
+		1014 0241  iSeries 2757 DASD IOA
+		1014 0264  Quad Channel PCI-X U320 SCSI RAID Adapter (2780)
 	01a7  PCI-X to PCI-X Bridge
 	01bd  ServeRAID Controller
 		1014 01be  ServeRAID-4M
@@ -708,6 +779,19 @@
 		1014 022e  ServeRAID-4H
 		1014 0258  ServeRAID-5i
 		1014 0259  ServeRAID-5i
+	01c1  64bit/66MHz PCI ATM 155 UTP
+	01e6  Cryptographic Accelerator
+	01ff  10/100 Mbps Ethernet
+	0219  Multiport Serial Adapter
+		1014 021a  Dual RVX
+		1014 0251  Internal Modem/RVX
+		1014 0252  Quad Internal Modem
+	021b  GXT6500P Graphics Adapter
+	021c  GXT4500P Graphics Adapter
+	0233  GXT135P Graphics Adapter
+	0266  PCI-X Dual Channel SCSI
+	0268  Gigabit Ethernet-SX Adapter (PCI-X)
+	0269  10/100/1000 Base-TX Ethernet Adapter (PCI-X)
 	0302  XA-32 chipset [Summit]
 	ffff  MPIC-2 interrupt controller
 1015  LSI Logic Corp of Canada
@@ -770,9 +854,16 @@
 		1259 2454  AT-2450v4 10Mb Ethernet Adapter
 		1259 2700  AT-2700TX 10/100 Fast Ethernet
 		1259 2701  AT-2700FX 100Mb Ethernet
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1010  CP5/CR6 mainboard
+		4c53 1020  VR6 mainboard
+		4c53 1030  PC5 mainboard
+		4c53 1040  CL7 mainboard
+		4c53 1060  PC7 mainboard
 	2001  79c978 [HomePNA]
 		1092 0a78  Multimedia Home Network Adapter
 		1668 0299  ActionLink Home Network Adapter
+	2003  Am 1771 MBW [Alchemy]
 	2020  53c974 [PCscsi]
 	2040  79c974
 	3000  ELanSC520 Microcontroller
@@ -817,6 +908,7 @@
 	746b  AMD-8111 ACPI
 	746d  AMD-8111 AC97 Audio
 	746e  AMD-8111 MC97 Modem
+	756b  AMD-8111 ACPI
 1023  Trident Microsystems
 	0194  82C194
 	2000  4DWave DX
@@ -939,13 +1031,15 @@
 		1028 00d0  PowerEdge Expandable RAID Controller 3/Si
 	0005  PowerEdge Expandable RAID Controller 3/Di
 	0006  PowerEdge Expandable RAID Controller 3/Di
-	0007  Remote Assistant Card 3
-	0008  PowerEdge Expandable RAID Controller 3/Di
+	0007  Remote Access Controller:DRAC III
+	0008  Remote Access Controller
+	0009  BMC/SMIC device not present
 	000a  PowerEdge Expandable RAID Controller 3
 		1028 0106  PowerEdge Expandable RAID Controller 3/Di
 		1028 011b  PowerEdge Expandable RAID Controller 3/Di
 		1028 0121  PowerEdge Expandable RAID Controller 3/Di
-	000c  Embedded Systems Management Device 4
+	000c  Remote Access Controller:ERA or ERA/O
+	000d  BMC/SMIC device
 	000e  PowerEdge Expandable RAID Controller
 	000f  PowerEdge Expandable RAID Controller 4/Di
 1029  Siemens Nixdorf IS
@@ -955,9 +1049,11 @@
 102b  Matrox Graphics, Inc.
 # DJ: I've a suspicion that 0010 is a duplicate of 0d10.
 	0010  MGA-I [Impression?]
+	0100  MGA 1064SG [Mystique]
 	0518  MGA-II [Athena]
 	0519  MGA 2064W [Millennium]
 	051a  MGA 1064SG [Mystique]
+		102b 0100  MGA-1064SG Mystique
 		102b 1100  MGA-1084SG Mystique
 		102b 1200  MGA-1084SG Mystique
 		1100 102b  MGA-1084SG Mystique
@@ -1081,6 +1177,12 @@
 	00b8  F64310
 	00c0  F69000 HiQVideo
 		102c 00c0  F69000 HiQVideo
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1010  CP5/CR6 mainboard
+		4c53 1020  VR6 mainboard
+		4c53 1030  PC5 mainboard
+		4c53 1050  CT7 mainboard
+		4c53 1051  CE7 mainboard
 	00d0  F65545
 	00d8  F65545
 	00dc  F65548
@@ -1092,6 +1194,11 @@
 	00f4  F68554 HiQVision
 	00f5  F68555
 	0c30  F69030
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1050  CT7 mainboard
+		4c53 1051  CE7 mainboard
+# C5C project cancelled
+		4c53 1080  CT8 mainboard
 102d  Wyse Technology Inc.
 	50dc  3328 Audio
 102e  Olivetti Advanced Technology
@@ -1107,6 +1214,7 @@
 	6057  MiroVideo DC10/DC30+
 1032  Compaq
 1033  NEC Corporation
+	0000  Vr4181A USB Host or Function Control Unit
 	0001  PCI to 486-like bus Bridge
 	0002  PCI to VL98 Bridge
 	0003  ATM Controller
@@ -1147,9 +1255,11 @@
 	00a6  VRC5477 AC97
 	00cd  IEEE 1394 [OrangeLink] Host Controller
 		12ee 8011  Root hub
+	00df  Vr4131
 	00e0  USB 2.0
 		12ee 7001  Root hub
 		1799 0002  Root Hub
+	00f3  uPD6113x Multimedia Decoder/Processor [EMMA2]
 1034  Framatome Connectors USA Inc.
 1035  Comp. & Comm. Research Lab
 1036  Future Domain Corp.
@@ -1157,7 +1267,8 @@
 1037  Hitachi Micro Systems
 1038  AMP, Inc
 1039  Silicon Integrated Systems [SiS]
-	0001  5591/5592 AGP
+# This is what all my tests report. I don't know if this is equivalent to "5591/5592 AGP".
+	0001  SiS 530 Virtual PCI-to-PCI bridge (AGP)
 	0002  SG86C202
 	0006  85C501/2/3
 	0008  85C503/5513
@@ -1167,8 +1278,12 @@
 		1039 0000  SiS5597 SVGA (Shared RAM)
 	0204  82C204
 	0205  SG86C205
-	0300  300/200
+	0300  SiS300/305 PCI/AGP VGA Display Adapter
 		107d 2720  Leadtek WinFast VR300
+	0310  SiS315H PCI/AGP VGA Display Adapter
+	0315  SiS315 PCI/AGP VGA Display Adapter
+	0325  SiS315PRO PCI/AGP VGA Display Adapter
+	0330  SiS330 [Xabre] PCI/AGP VGA Display Adapter
 	0406  85C501/2
 	0496  85C496
 	0530  530 Host
@@ -1181,6 +1296,7 @@
 	0635  635 Host
 	0645  SiS645 Host & Memory & AGP Controller
 	0646  SiS645DX Host & Memory & AGP Controller
+	0648  SiS 645xx
 	0650  650 Host
 	0651  SiS651 Host
 	0730  730 Host
@@ -1188,18 +1304,23 @@
 	0735  735 Host
 	0740  740 Host
 	0745  745 Host
+	0746  746 Host
+	0755  SiS 755 Host Bridge
 	0900  SiS900 10/100 Ethernet
 		1039 0900  SiS900 10/100 Ethernet Adapter
+		1043 8035  CUSI-FX motherboard
 	0961  SiS961 [MuTIOL Media IO]
 	0962  SiS962 [MuTIOL Media IO]
 	3602  83C602
 	5107  5107
 	5300  SiS540 PCI Display Adapter
+	5315  SiS550 AGP/VGA VGA Display Adapter
 	5401  486 PCI Chipset
 	5511  5511/5512
 	5513  5513 [IDE]
 		1019 0970  P6STP-FL motherboard
 		1039 5513  SiS5513 EIDE Controller (A,B step)
+		1043 8035  CUSI-FX motherboard
 	5517  5517
 	5571  5571
 	5581  5581 Pentium Chipset
@@ -1213,8 +1334,10 @@
 	6236  6236 3D-AGP
 	6300  SiS630 GUI Accelerator+3D
 		1019 0970  P6STP-FL motherboard
+		1043 8035  CUSI-FX motherboard
 	6306  SiS530 3D PCI/AGP
 		1039 6306  SiS530,620 GUI Accelerator+3D
+	6325  SiS650/651/M650/740 PCI/AGP VGA Display Adapter
 	6326  86C326 5598/6326
 		1039 6326  SiS6326 GUI Accelerator
 		1092 0a50  SpeedStar A50
@@ -1222,14 +1345,14 @@
 		1092 4910  SpeedStar A70
 		1092 4920  SpeedStar A70
 		1569 6326  SiS6326 GUI Accelerator
-	7001  7001
+	7001  USB 1.0 Controller
 		1039 7000  Onboard USB Controller
-	7002  SiS7002 USB 2.0
+	7002  USB 2.0 Controller
 		1509 7002  Onboard USB Controller
 	7007  FireWire Controller
-	7012  SiS7012 PCI Audio Accelerator
-	7013  56k Winmodem (Smart Link HAMR5600 compatible)
-	7016  SiS7016 10/100 Ethernet Adapter
+	7012  Sound Controller
+	7013  Intel 537 [56k Winmodem]
+	7016  10/100 Ethernet Adapter
 		1039 7016  SiS7016 10/100 Ethernet Adapter
 	7018  SiS PCI Audio Accelerator
 		1014 01b6  SiS PCI Audio Accelerator
@@ -1254,6 +1377,7 @@
 		15c5 0111  SiS PCI Audio Accelerator
 		270f a171  SiS PCI Audio Accelerator
 		a0a0 0022  SiS PCI Audio Accelerator
+	7019  SiS7019 Audio Accelerator
 103a  Seiko Epson Corporation
 103b  Tatung Co. of America
 103c  Hewlett-Packard Company
@@ -1286,7 +1410,6 @@
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
-	1054  PCI Local Bus Adapter
 	1064  79C970 PCnet Ethernet Controller
 	108b  Visualize FXe
 	10c1  NetServer Smart IRQ Router
@@ -1298,7 +1421,7 @@
 	121c  NetServer PCI COM Port Decoder
 	1229  zx1 System Bus Adapter
 	122a  zx1 I/O Controller
-	122e  PCI-X/AGP Local Bus Adapter
+	122e  zx1 Local Bus Adapter
 	1290  Auxiliary Diva Serial Port
 	2910  E2910A PCIBus Exerciser
 	2925  E2925A 32 Bit, 33 MHzPCI Exerciser & Analyzer
@@ -1307,13 +1430,15 @@
 1040  Accelgraphics Inc.
 1041  Computrend
 1042  Micron
-	1000  FDC 37C665
-	1001  37C922
+	1000  PC Tech RZ1000
+	1001  PC Tech RZ1001
 	3000  Samurai_0
 	3010  Samurai_1
 	3020  Samurai_IDE
 1043  Asustek Computer, Inc.
 	0675  ISDNLink P-IN100-ST-D
+	4021  v7100 Combo Deluxe [GeForce2 MX + TV tuner]
+	4057  v8200 GeForce 3
 1044  Distributed Processing Technology
 	1012  Domino RAID Engine
 	a400  SmartCache/Raid I-IV Controller
@@ -1375,7 +1500,7 @@
 	c832  82C832
 	c861  82C861
 	c895  82C895
-	c935  EV1935 ECTIVA MachOne PCI Audio
+	c935  EV1935 ECTIVA MachOne PCIAudio
 	d568  82C825 [Firebridge 2]
 	d721  IDE [FireStar]
 1046  IPC Corporation, Ltd.
@@ -1385,14 +1510,24 @@
 	1000  QuickStep 1000
 	3000  QuickStep 3000
 1049  Fountain Technologies, Inc.
-104a  SGS Thomson Microelectronics
+# # nee SGS Thomson Microelectronics
+104a  STMicroelectronics
 	0008  STG 2000X
 	0009  STG 1764X
 	0010  STG4000 [3D Prophet Kyro Series]
+	0209  STPC Consumer/Industrial North- and Southbridge
+	020a  STPC Atlas/ConsumerS/Consumer IIA Northbridge
+# From <http://gatekeeper.dec.com/pub/BSD/FreeBSD/FreeBSD-stable/src/share/misc/pci_vendors>
+	0210  STPC Atlas ISA Bridge
+	021a  STPC Consumer S Southbridge
+	021b  STPC Consumer IIA Southbridge
+	0500  ST70137 [Unicorn] ADSL DMT Transceiver
+	0564  STPC Client Northbridge
 	0981  DEC-Tulip compatible 10/100 Ethernet
 	1746  STG 1764X
 	2774  DEC-Tulip compatible 10/100 Ethernet
 	3520  MPEG-II decoder card
+	55cc  STPC Client Southbridge
 104b  BusLogic
 	0140  BT-946C (old) [multimaster  01]
 	1040  BT-946C (BA80C30) [MultiMaster 10]
@@ -1401,6 +1536,7 @@
 	0500  100 MBit LAN Controller
 	0508  TMS380C2X Compressor Interface
 	1000  Eagle i/f AS
+	104c  PCI1510 PC card Cardbus Controller
 	3d04  TVP4010 [Permedia]
 	3d07  TVP4020 [Permedia 2]
 		1011 4d10  Comet
@@ -1444,7 +1580,11 @@
 	8026  TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
 	8027  PCI4451 IEEE-1394 Controller
 		1028 00e6  PCI4451 IEEE-1394 Controller (Dell Inspiron 8100)
-	8400  USR2210 22Mbps Wireless PC Card
+	8029  PCI4510 IEEE-1394 Controller
+	8400  ACX 100 22Mbps Wireless Interface
+	8401  ACX 100 22Mbps Wireless Interface
+# OK, this info is almost useless as is, but at least it's known that it's a wireless card. More info requested from reporter (whi
+	9000  Wireless Interface (of unknown type)
 	a001  TDC1570
 	a100  TDC1561
 	a102  TNETA1575 HyperSAR Plus w/PCI Host i/f & UTOPIA i/f
@@ -1460,7 +1600,9 @@
 	ac19  PCI1221
 	ac1a  PCI1210
 	ac1b  PCI1450
+		0e11 b113  Armada M700
 	ac1c  PCI1225
+		0e11 b121  Armada E500
 	ac1d  PCI1251A
 	ac1e  PCI1211
 	ac1f  PCI1251B
@@ -1474,15 +1616,18 @@
 	ac41  PCI4410 PC card Cardbus Controller
 	ac42  PCI4451 PC card Cardbus Controller
 		1028 00e6  PCI4451 PC card CardBus Controller (Dell Inspiron 8100)
+	ac44  PCI4510 PC card Cardbus Controller
 	ac50  PCI1410 PC card Cardbus Controller
 	ac51  PCI1420
 		1014 023b  ThinkPad T23 (2647-4MG)
+		1028 00b1  Latitude C600
 		10cf 1095  Lifebook C6155
 		e4bf 1000  CP2-2-HIPHOP
 	ac52  PCI1451 PC card Cardbus Controller
 	ac53  PCI1421 PC card Cardbus Controller
 	ac55  PCI1250 PC card Cardbus Controller
 		1014 0512  ThinkPad T30
+	ac56  PCI1510 PC card Cardbus Controller
 	ac60  PCI2040 PCI to DSP Bridge Controller
 	fe00  FireWire Host Controller
 	fe03  12C01A FireWire Host Controller
@@ -1564,7 +1709,9 @@
 	0d38  20263
 		105a 4d39  Fasttrak66
 	1275  20275
+	3318  PDC20318 (SATA150 TX4)
 	3376  PDC20376
+		1043 809e  A7V8X motherboard
 	4d30  20267
 		105a 4d33  Ultra100
 		105a 4d39  Fasttrak100
@@ -1577,6 +1724,7 @@
 	4d68  20268
 		105a 4d68  Ultra100TX2
 	4d69  20269
+		105a 4d68  Ultra133TX2
 	5275  PDC20276 IDE
 		105a 0275  SuperTrak SX6000 IDE
 	5300  DC5300
@@ -1584,6 +1732,7 @@
 	6269  PDC20271
 		105a 6269  FastTrak TX2/TX2000
 	6621  PDC20621 [SX4000] 4 Channel IDE RAID Controller
+	6629  PDC20619 FastTrak TX4000 RAID
 	7275  PDC20277
 105b  Foxconn International, Inc.
 105c  Wipro Infotech Limited
@@ -1621,6 +1770,7 @@
 		13cc 0009  Barco Metheus 5 Megapixel, Dual Head
 		13cc 000a  Barco Metheus 5 Megapixel, Dual Head
 	5348  Revolution 4
+		105d 0037  Revolution IV-FP AGP (For SGI 1600SW)
 105e  Vtech Computers Ltd
 105f  Infotronic America Inc
 1060  United Microelectronics [UMC]
@@ -1669,6 +1819,7 @@
 	0002  DAC960PD
 	0010  DAC960PX
 	0050  AcceleRAID 352/170/160 support Device
+	b166  Gemstone chipset SCSI controller
 	ba55  eXtremeRAID 1100 support Device
 	ba56  eXtremeRAID 2000/3000 support Device
 106a  Aten Research Inc
@@ -1759,6 +1910,7 @@
 	2100  QLA2100 64-bit Fibre Channel Adapter
 		1077 0001  QLA2100 64-bit Fibre Channel Adapter
 	2200  QLA2200
+		1077 0002  QLA2200
 	2300  QLA2300 64-bit FC-AL Adapter
 	2312  QLA2312 Fibre Channel Adapter
 1078  Cyrix Corporation
@@ -1856,7 +2008,6 @@
 	8001  Schizo PCI Bus Module
 	a000  Ultra IIi
 	a001  Ultra IIe
-	a801  Tomatillo PCI Bus Module
 108f  Systemsoft
 1090  Encore Computer Corporation
 1091  Intergraph Corporation
@@ -1896,6 +2047,8 @@
 	1190  PCI-MIO-16E-4
 	1330  PCI-6031E
 	1350  PCI-6071E
+	17d0  PCI-6503
+	2410  PCI-6733
 	2a60  PCI-6023E
 	b001  IMAQ-PCI-1408
 	b011  IMAQ-PXI-1408
@@ -1911,6 +2064,7 @@
 	c831  PCI-GPIB bridge
 1094  First International Computers [FIC]
 1095  CMD Technology Inc
+	0240  Adaptec AAR-1210SA SATA HostRAID Controller
 	0640  PCI0640
 	0643  PCI0643
 	0646  PCI0646
@@ -1925,6 +2079,7 @@
 		1095 0670  USB0670
 	0673  USB0673
 	0680  PCI0680
+	3112  Silicon Image SiI 3112 SATARaid Controller
 1096  Alacron
 1097  Appian Technology
 1098  Quantum Designs (H.K.) Ltd
@@ -1944,8 +2099,10 @@
 	036c  Bt879(??) Video Capture
 		13e9 0070  Win/TV (Video Section)
 	036e  Bt878 Video Capture
-		0070 13eb  WinTV/GO
+		0070 13eb  WinTV Series
 		0070 ff01  Viewcast Osprey 200
+		107d 6606  WinFast TV 2000
+		11bd 0012  PCTV pro (TV + FM stereo receiver)
 		11bd 001c  PCTV Sat (DBC receiver)
 		127a 0001  Bt878 Mediastream Controller NTSC
 		127a 0002  Bt878 Mediastream Controller PAL BG
@@ -1996,10 +2153,11 @@
 		1851 1851  FlyVideo'98 EZ - video
 		1852 1852  FlyVideo'98 (with FM Tuner)
 	0878  Bt878 Audio Capture
-		0070 13eb  WinTV/GO
+		0070 13eb  WinTV Series
 		0070 ff01  Viewcast Osprey 200
 		1002 0001  TV-Wonder
 		1002 0003  TV-Wonder/VE
+		11bd 0012  PCTV pro (TV + FM stereo receiver, audio section)
 		11bd 001c  PCTV Sat (DBC receiver)
 		127a 0001  Bt878 Video Capture (Audio Section)
 		127a 0002  Bt878 Video Capture (Audio Section)
@@ -2055,6 +2213,7 @@
 10a3  Everex Systems Inc
 10a4  Globe Manufacturing Sales
 10a5  Smart Link Ltd.
+	3052  SmartPCI562 56K Modem
 	5449  SmartPCI561 modem
 10a6  Informtech Industrial Ltd.
 10a7  Benchmarq Microelectronics
@@ -2070,6 +2229,7 @@
 	0007  RPCEX
 	0008  DiVO VIP
 	0009  Alteon Gigabit Ethernet
+		10a9 8002  Acenic Gigabit Ethernet
 	0010  AMP Video I/O
 	0011  GRIP
 	0012  SGH PSHAC GSN
@@ -2081,6 +2241,7 @@
 	1006  Dual JPEG 4
 	1007  Dual JPEG 5
 	1008  Cesium
+	100a  IOC4 I/O controller
 	2001  Fibre Channel
 	2002  ASDE
 	8001  O2 1394
@@ -2134,6 +2295,7 @@
 		15ed 1001  Macrolink MCCS 16-port Serial
 		15ed 1002  Macrolink MCCS 8-port Serial Hot Swap
 		15ed 1003  Macrolink MCCS 16-port Serial Hot Swap
+		5654 5634  OpenLine4 Telephony Card
 		d531 c002  PCIntelliCAN 2xSJA1000 CAN bus
 		d84d 4006  EX-4006 1P
 		d84d 4008  EX-4008 1P EPP/ECP
@@ -2154,6 +2316,8 @@
 		d84d 4078  EX-4078 2S(16C552) RS-232+1P
 	9054  PCI <-> IOBus Bridge
 		10b5 2455  Wessex Techology PHIL-PCI
+		10b5 2696  Innes Corp AM Radcap card
+		12d9 0002  PCI Prosody Card rev 1.5
 	9060  9060
 	906d  9060SD
 		125c 0640  Aries 16000P
@@ -2161,6 +2325,8 @@
 	9080  9080
 		10b5 9080  9080 [real subsystem ID not set]
 		129d 0002  Aculab PCI Prosidy card
+		12d9 0002  PCI Prosody Card
+	bb04  B&B 3PCIOSD1A Isolated PCI Serial
 10b6  Madge Networks
 	0001  Smart 16/4 PCI Ringnode
 	0002  Smart 16/4 PCI Ringnode Mk2
@@ -2188,12 +2354,11 @@
 	1001  Collage 155 ATM Server Adapter
 10b7  3Com Corporation
 	0001  3c985 1000BaseSX (SX/TX)
+	0910  3C910-A01
 	1006  MINI PCI type 3B Data Fax Modem
 	1007  Mini PCI 56k Winmodem
 		10b7 615c  Mini PCI 56K Modem
-	1700  Gigabit Ethernet Adapter
-		10b7 0010  3Com 3C940 Gigabit LOM Ethernet Adapter
-		10b7 0020  3Com 3C941 Gigabit LOM Ethernet Adapter
+	1700  3c940 1000Base?
 	3390  3c339 TokenLink Velocity
 	3590  3c359 TokenLink Velocity XL
 		10b7 3590  TokenLink Velocity XL Adapter (3C359/359B)
@@ -2226,6 +2391,7 @@
 		10b7 656b  3CCFEM656 10/100 LAN+56K Modem CardBus
 	6564  3CCFEM656 [id 6564] Cyclone CardBus
 	7646  3cSOHO100-TX Hurricane
+	7770  3CRWE777 PCI(PLX) Wireless Adaptor [Airconnect]
 	7940  3c803 FDDILink UTP Controller
 	7980  3c804 FDDILink SAS Controller
 	7990  3c805 FDDILink DAS Controller
@@ -2266,10 +2432,11 @@
 	9058  3c905B-Combo [Deluxe Etherlink XL 10/100]
 	905a  3c905B-FX [Fast Etherlink XL FX 10/100]
 	9200  3c905C-TX/TX-M [Tornado]
-		1028 0095  Integrated 3C905C-TX Fast Etherlink for PC Management NIC
+		1028 0095  3C920 Integrated Fast Ethernet Controller
+		1028 0097  3C920 Integrated Fast Ethernet Controller
 		10b7 1000  3C905C-TX Fast Etherlink for PC Management NIC
 		10b7 7000  10/100 Mini PCI Ethernet Adapter
-	9210  3C920B-EMB-WNM Integrated Fast Ethernet Controller
+	9201  3C920B-EMB Integrated Fast Ethernet Controller
 	9300  3CSOHO100B-TX  [910-A01]
 	9800  3c980-TX [Fast Etherlink XL Server Adapter]
 		10b7 9800  3c980-TX Fast Etherlink XL Server Adapter
@@ -2277,6 +2444,7 @@
 		10b7 1201  3c982-TXM 10/100baseTX Dual Port A [Hydra]
 		10b7 1202  3c982-TXM 10/100baseTX Dual Port B [Hydra]
 		10b7 9805  3c980 10/100baseTX NIC [Python-T]
+		10f1 2462  Thunder K7 S2462
 	9900  3C990-TX [Typhoon]
 	9902  3CR990-TX-95 [Typhoon 56-bit]
 	9903  3CR990-TX-97 [Typhoon 168-bit]
@@ -2370,12 +2538,16 @@
 	5251  M5251 P1394 OHCI 1.0 Controller
 	5253  M5253 P1394 OHCI 1.1 Controller
 	5261  M5261 Ethernet Controller
+	5450  Lucent Technologies Soft Modem AMR
 	5451  M5451 PCI AC-Link Controller Audio Device
 		1014 0506  ThinkPad R30
 	5453  M5453 PCI AC-Link Controller Modem Device
 	5455  M5455 PCI AC-Link Controller Audio Device
-	5457  M5457 AC-Link Modem Interface Controller
-	5459  SmartPCI561 56K Modem
+	5457  Intel 537 [M5457 AC-Link Modem]
+# Same but more usefull for driver's lookup
+	5459  SmartLink SmartPCI561 56K Modem
+# SmartLink PCI SoftModem
+	545a  SmartLink SmartPCI563 56K Modem
 	5471  M5471 Memory Stick Controller
 	5473  M5473 SD-MMC Controller
 	7101  M7101 PMU
@@ -2444,7 +2616,10 @@
 10c9  Dataexpert Corporation
 10ca  Fujitsu Microelectr., Inc.
 10cb  Omron Corporation
-10cc  Mentor ARC Inc
+# nee Mentor ARC Inc
+10cc  Mai Logic Incorporated
+	0660  Articia S Host Bridge
+	0661  Articia S PCI Bridge
 10cd  Advanced System Products, Inc
 	1100  ASC1100
 	1200  ASC1200 [(abp940) Fast SCSI-II]
@@ -2453,9 +2628,9 @@
 	2300  ABP940-UW
 	2500  ABP940-U2W
 10ce  Radius
-10cf  Citicorp TTI
+# nee Citicorp TTI
+10cf  Fujitsu Limited.
 	2001  mb86605
-10d0  Fujitsu Limited
 10d1  FuturePlus Systems Corp.
 10d2  Molex Incorporated
 10d3  Jabil Circuit Inc
@@ -2485,7 +2660,7 @@
 	0008  NV1 [EDGE 3D]
 	0009  NV1 [EDGE 3D]
 	0010  NV2 [Mutara V08]
-	0020  NV4 [Riva TnT]
+	0020  NV4 [RIVA TNT]
 		1043 0200  V3400 TNT
 		1048 0c18  Erazor II SGRAM
 		1048 0c1b  Erazor II
@@ -2507,11 +2682,12 @@
 		10de 0020  Riva TNT
 		1102 1015  Graphics Blaster CT6710
 		1102 1016  Graphics Blaster RIVA TNT
-	0028  NV5 [Riva TnT2]
+	0028  NV5 [RIVA TNT2/TNT2 Pro]
 		1043 0200  AGP-V3800 SGRAM
 		1043 0201  AGP-V3800 SDRAM
 		1043 0205  PCI-V3800
 		1043 4000  AGP-V3800PRO
+		1048 0c21  Synergy II
 		1092 4804  Viper V770
 		1092 4a00  Viper V770
 		1092 4a02  Viper V770 Ultra
@@ -2523,7 +2699,7 @@
 		1102 1020  3D Blaster RIVA TNT2
 		1102 1026  3D Blaster RIVA TNT2 Digital
 		14af 5810  Maxi Gamer Xentor
-	0029  NV5 [Riva TnT2 Ultra]
+	0029  NV5 [RIVA TNT2 Ultra]
 		1043 0200  AGP-V3800 Deluxe
 		1043 0201  AGP-V3800 Ultra SDRAM
 		1043 0205  PCI-V3800 Ultra
@@ -2533,17 +2709,18 @@
 		14af 5820  Maxi Gamer Xentor 32
 	002a  NV5 [Riva TnT2]
 	002b  NV5 [Riva TnT2]
-	002c  NV6 [Vanta]
+	002c  NV6 [Vanta/Vanta LT]
 		1043 0200  AGP-V3800 Combat SDRAM
 		1043 0201  AGP-V3800 Combat
 		1092 6820  Viper V730
 		1102 1031  CT6938 VANTA 8MB
 		1102 1034  CT6894 VANTA 16MB
 		14af 5008  Maxi Gamer Phoenix 2
-	002d  RIVA TNT2 Model 64
+	002d  NV5M64 [RIVA TNT2 Model 64/Model 64 Pro]
 		1043 0200  AGP-V3800M
 		1043 0201  AGP-V3800M
 		1048 0c3a  Erazor III LT
+		10de 001e  M64 AGP4x
 		1102 1023  CT6892 RIVA TNT2 Value
 		1102 1024  CT6932 RIVA TNT2 Value 32Mb
 		1102 102c  CT6931 RIVA TNT2 Value [Jumper]
@@ -2551,8 +2728,32 @@
 		1554 1041  PixelView RIVA TNT2 M64 32MB
 	002e  NV6 [Vanta]
 	002f  NV6 [Vanta]
-	00a0  NV5 [Riva TNT2]
+	0060  nForce2 ISA Bridge
+		1043 80ad  A7N8X Mainboard
+	0064  nForce2 SMBus (MCP)
+	0065  nForce2 IDE
+	0066  nForce2 Ethernet Controller
+	0067  nForce2 USB Controller
+		1043 0c11  A7N8X Mainboard
+	0068  nForce2 USB Controller
+		1043 0c11  A7N8X Mainboard
+	006a  nForce2 AC97 Audio Controler (MCP)
+	006b  nForce MultiMedia audio [Via VT82C686B]
+	006c  nForce2 External PCI Bridge
+	006d  nForce2 PCI Bridge
+	006e  nForce2 FireWire (IEEE 1394) Controller
+	00a0  NV5 [Aladdin TNT2]
 		14af 5810  Maxi Gamer Xentor
+	00d0  nForce3 LPC Bridge
+	00d1  nForce3 Host Bridge
+	00d2  nForce3 AGP Bridge
+	00d4  nForce3 SMBus
+	00d5  nForce3 IDE
+	00d6  nForce3 Ethernet
+	00d7  nForce3 USB 1.1
+	00d8  nForce3 USB 2.0
+	00da  nForce3 Audio
+	00dd  nForce3 PCI Bridge
 	0100  NV10 [GeForce 256 SDR]
 		1043 0200  AGP-V6600 SGRAM
 		1043 0201  AGP-V6600 SDRAM
@@ -2560,45 +2761,57 @@
 		1043 4009  AGP-V6600 SDRAM
 		1102 102d  CT6941 GeForce 256
 		14af 5022  3D Prophet SE
-	0101  NV10 [GeForce 256 DDR]
+	0101  NV10DDR [GeForce 256 DDR]
 		1043 0202  AGP-V6800 DDR
 		1043 400a  AGP-V6800 DDR SGRAM
 		1043 400b  AGP-V6800 DDR SDRAM
+		107d 2822  WinFast GeForce 256
 		1102 102e  CT6971 GeForce 256 DDR
 		14af 5021  3D Prophet DDR-DVI
-	0103  NV10 [Quadro]
-	0110  NV11 [GeForce2 MX]
+	0103  NV10GL [Quadro]
+	0110  NV11 [GeForce2 MX/MX 400]
 		1043 4015  AGP-V7100 Pro
 		1043 4031  V7100 Pro with TV output
+		1462 8817  MSI GeForce2 MX400 Pro32S [MS-8817]
 		14af 7102  3D Prophet II MX
 		14af 7103  3D Prophet II MX Dual-Display
-	0111  NV11 [GeForce2 MX DDR]
+	0111  NV11DDR [GeForce2 MX 100 DDR/200 DDR]
 	0112  NV11 [GeForce2 Go]
-	0113  NV11 [GeForce2 MXR]
-	0150  NV15 [GeForce2 GTS]
+	0113  NV11GL [Quadro2 MXR/EX]
+	0150  NV15 [GeForce2 GTS/Pro]
 		1043 4016  V7700 AGP Video Card
 		107d 2840  WinFast GeForce2 GTS with TV output
 		1462 8831  Creative GeForce2 Pro
-	0151  NV15 [GeForce2 Ti]
+	0151  NV15DDR [GeForce2 Ti]
 		1043 405f  V7700Ti
-	0152  NV15 [GeForce2 Ultra, Bladerunner]
+	0152  NV15BR [GeForce2 Ultra, Bladerunner]
 		1048 0c56  GLADIAC Ultra
-	0153  NV15 [Quadro2 Pro]
-	0170  NV17 [GeForce4 MX460]
-	0171  NV17 [GeForce4 MX440]
+	0153  NV15GL [Quadro2 Pro]
+	0170  NV17 [GeForce4 MX 460]
+	0171  NV17 [GeForce4 MX 440]
+		10b0 0002  Gainward Pro/600 TV
 		1462 8661  G4MX440-VTP
-	0172  NV17 [GeForce4 MX420]
-	0173  NV1x
+		1462 8730  MX440SES-T (MS-8873)
+		147b 8f00  Abit Siluro GeForce4MX440
+	0172  NV17 [GeForce4 MX 420]
+	0173  NV17 [GeForce4 MX 440-SE]
 	0174  NV17 [GeForce4 440 Go]
 	0175  NV17 [GeForce4 420 Go]
 	0176  NV17 [GeForce4 420 Go 32M]
-	0178  Quadro4 500XGL
+	0178  NV17GL [Quadro4 550 XGL]
 	0179  NV17 [GeForce4 440 Go 64M]
-	017a  Quadro4 200/400NVS
-	017b  Quadro4 550XGL
-	017c  Quadro4 550 GoGL
-	0181  NV18 [GeForce4 MX440 AGP 8x]
-	01a0  NV15 [GeForce2 - nForce GPU]
+	017a  NV17GL [Quadro4 200/400 NVS]
+	017b  NV17GL [Quadro4 550 XGL]
+	017c  NV17GL [Quadro4 550 GoGL]
+	0181  NV18 [GeForce4 MX 440 AGP 8x]
+		1043 806f  V9180 Magic
+		1462 8880  MS-StarForce GeForce4 MX 440 with AGP8X
+	0182  NV18 [GeForce4 MX 440SE AGP 8x]
+	0183  NV18 [GeForce4 MX 420 AGP 8x]
+	0188  NV18GL [Quadro4 580 XGL]
+	018a  NV18GL [Quadro4 NVS AGP 8x]
+	018b  NV18GL [Quadro4 380 XGL]
+	01a0  NVCrush11 [GeForce2 MX Integrated Graphics]
 	01a4  nForce CPU bridge
 	01ab  nForce 420 Memory Controller (DDR)
 	01ac  nForce 220/420 Memory Controller
@@ -2609,24 +2822,53 @@
 	01b7  nForce AGP to PCI Bridge
 	01b8  nForce PCI-to-PCI bridge
 	01bc  nForce IDE
-	01c1  nForce MC97 Modem (Smart Link HAMR5600 compatible)
+	01c1  Intel 537 [nForce MC97 Modem]
 	01c2  nForce USB Controller
 	01c3  nForce Ethernet Controller
+	01e0  nForce2 AGP (different version?)
+	01e8  nForce2 AGP
+	01ea  nForce2 Memory Controller 0
+	01eb  nForce2 Memory Controller 1
+	01ec  nForce2 Memory Controller 2
+	01ed  nForce2 Memory Controller 3
+	01ee  nForce2 Memory Controller 4
+	01ef  nForce2 Memory Controller 5
+	01f0  NV18 [GeForce4 MX - nForce GPU]
 	0200  NV20 [GeForce3]
 		1043 402f  AGP-V8200 DDR
-	0201  NV20 [GeForce3 Ti200]
-	0202  NV20 [GeForce3 Ti500]
+	0201  NV20 [GeForce3 Ti 200]
+	0202  NV20 [GeForce3 Ti 500]
 		1043 405b  V8200 T5
 		1545 002f  Xtasy 6964
-	0203  NV20 [Quadro DCC]
-	0250  NV25 [GeForce4 Ti4600]
-	0251  NV25 [GeForce4 Ti4400]
-	0253  NV25 [GeForce4 Ti4200]
+	0203  NV20DCC [Quadro DCC]
+	0250  NV25 [GeForce4 Ti 4600]
+	0251  NV25 [GeForce4 Ti 4400]
+	0252  NV25 [GeForce4 Ti]
+	0253  NV25 [GeForce4 Ti 4200]
 		107d 2896  WinFast A250 LE TD (Dual VGA/TV-out/DVI)
 		147b 8f09  Siluro (Dual VGA/TV-out/DVI)
-	0258  Quadro4 900XGL
-	0259  Quadro4 750XGL
-	025b  Quadro4 700XGL
+	0258  NV25GL [Quadro4 900 XGL]
+	0259  NV25GL [Quadro4 750 XGL]
+	025b  NV25GL [Quadro4 700 XGL]
+	0280  NV28 [GeForce4 Ti 4800]
+	0281  NV28 [GeForce4 Ti 4200 AGP 8x]
+	0282  NV28 [GeForce4 Ti 4800 SE]
+	0286  NV28 [GeForce4 Ti 4200 Go AGP 8x]
+	0288  NV28GL [Quadro4 980 XGL]
+	0289  NV28GL [Quadro4 780 XGL]
+	0300  NV30 [GeForce FX]
+	0301  NV30 [GeForce FX 5800 Ultra]
+	0302  NV30 [GeForce FX 5800]
+	0308  NV30GL [Quadro FX 2000]
+	0309  NV30GL [Quadro FX 1000]
+	0311  NV31 [GeForce FX 5600 Ultra]
+	0312  NV31 [GeForce FX 5600]
+	0321  NV34 [GeForce FX 5200 Ultra]
+	0322  NV34 [GeForce FX 5200]
+	032b  NV34GL [Quadro FX 500]
+	0330  NV35 [GeForce FX 5900 Ultra]
+	0331  NV35 [GeForce FX 5900]
+	0338  NV35GL [Quadro FX 3000]
 10df  Emulex Corporation
 	1ae5  LP6000 Fibre Channel Host Adapter
 	f085  LP850 Fibre Channel Adapter
@@ -2652,6 +2894,7 @@
 10e3  Tundra Semiconductor Corp.
 	0000  CA91C042 [Universe]
 	0860  CA91C860 [QSpan]
+	0862  CA91C862A [QSpan-II]
 10e4  Tandem Computers
 10e5  Micro Industries Corporation
 10e6  Gainbery Computer Products Inc.
@@ -2672,6 +2915,7 @@
 	811a  PCI-IEEE1355-DS-DE Interface
 	8170  S5933 [Matchmaker] (Chipset Development Tool)
 	82db  AJA HDNTV HD SDI Framestore
+	8851  S5933 on Innes Corp FM Radio Capture card
 10e9  Alps Electric Co., Ltd.
 10ea  Intergraphics Systems
 	1680  IGA-1680
@@ -2681,6 +2925,7 @@
 	2010  CyberPro 2000A
 	5000  CyberPro 5000
 	5050  CyberPro 5050
+	5202  CyberPro 5202
 10eb  Artists Graphics
 	0101  3GA
 	8111  Twist3 Frame Grabber
@@ -2719,6 +2964,7 @@
 		8e2e 7100  KF-230TX/2
 		a0a0 0007  ALN-325C
 	8169  RTL-8169
+		1371 434e  ProG-2000L
 	8197  SmartLAN56 56K Modem
 10ed  Ascii Corporation
 	7310  V7310
@@ -2729,6 +2975,7 @@
 	3fc3  RME Digi96/8 Pad
 	3fc4  RME Digi9652 (Hammerfall)
 	3fc5  RME Hammerfall DSP
+	8381  Ellips Santos Frame Grabber
 10ef  Racore Computer Products, Inc.
 	8154  M815x Token Ring Adapter
 10f0  Peritek Corporation
@@ -2777,6 +3024,8 @@
 		1102 8040  CT4760 SBLive!
 		1102 8051  CT4850 SBLive! Value
 		1102 8061  SBLive! Player 5.1
+		1102 8064  SB Live! 5.1 Model SB0100
+		1102 8065  SBLive! 5.1 Digital Model SB0220
 	0004  SB Audigy
 		1102 0051  SB0090 Audigy Player
 		1102 0053  SB0090 Audigy Player/OEM
@@ -2788,7 +3037,8 @@
 	7003  SB Audigy MIDI/Game port
 		1102 0040  SB Audigy MIDI/Game Port
 	7004  [SB Live! Value] Input device controller
-	8938  ES1371
+	8064  SB0100 [SBLive! 5.1 OEM]
+	8938  Ectiva EV1938
 1103  Triones Technologies, Inc.
 	0003  HPT343
 # Revisions: 01=HPT366, 03=HPT370, 04=HPT370A, 05=HPT372
@@ -2799,6 +3049,7 @@
 	0006  HPT302
 	0007  HPT371
 	0008  HPT374
+	0009  HPT372N
 1104  RasterOps Corp.
 1105  Sigma Designs, Inc.
 	1105  REALmagic Xcard MPEG 1/2/3/4 DVD Decoder
@@ -2809,15 +3060,21 @@
 	0130  VT6305 1394.A Controller
 	0305  VT8363/8365 [KT133/KM133]
 		1043 8033  A7V Mainboard
+		1043 803e  A7V-E Mainboard
 		1043 8042  A7V133/A7V133-C Mainboard
 		147b a401  KT7/KT7-RAID/KT7A/KT7A-RAID Mainboard
 	0391  VT8371 [KX133]
 	0501  VT8501 [Apollo MVP4]
 	0505  VT82C505
-	0561  VT82C561
-	0571  VT82C586/B/686A/B PIPC Bus Master IDE
+# Shares chip with :0576. The VT82C576M has :1571 instead of :0561.
+	0561  VT82C576MV
+	0571  VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
+		1019 0985  P6VXA Motherboard
 		1043 8052  VT8233A Bus Master ATA100/66/33 IDE
-		1106 0571  VT8235 Bus Master ATA133/100/66/33 IDE
+		1043 808c  A7V8X motherboard
+		1106 0571  VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
+		1179 0001  Magnia Z310
+		1297 f641  FX41 motherboard
 		1458 5002  GA-7VAX Mainboard
 	0576  VT82C576 3V [Apollo Master]
 	0585  VT82C585VP [Apollo VP1/VPX]
@@ -2831,24 +3088,36 @@
 	0598  VT82C598 [Apollo MVP3]
 	0601  VT8601 [Apollo ProMedia]
 	0605  VT8605 [ProSavage PM133]
+		1043 802c  CUV4X mainboard
 	0680  VT82C680 [Apollo P6]
 	0686  VT82C686 [Apollo Super South]
+		1019 0985  P6VXA Motherboard
+		1043 802c  CUV4X mainboard
 		1043 8033  A7V Mainboard
+		1043 803e  A7V-E Mainboard
 		1043 8040  A7M266 Mainboard
 		1043 8042  A7V133/A7V133-C Mainboard
 		1106 0000  VT82C686/A PCI to ISA Bridge
 		1106 0686  VT82C686/A PCI to ISA Bridge
+		1179 0001  Magnia Z310
+		147b a702  KG7-Lite Mainboard
 	0691  VT82C693A/694x [Apollo PRO133x]
+		1019 0985  P6VXA Motherboard
+		1179 0001  Magnia Z310
 		1458 0691  VT82C691 Apollo Pro System Controller
 	0693  VT82C693 [Apollo Pro Plus]
 	0698  VT82C693A [Apollo Pro133 AGP]
 	0926  VT82C926 [Amazon]
 	1000  VT82C570MV
 	1106  VT82C570MV
-	1571  VT82C416MV
+	1571  VT82C576M/VT82C586
 	1595  VT82C595/97 [Apollo VP2/97]
 	3038  USB
-		0925 1234  MVP3 USB Controller
+		0925 1234  USB Controller
+		1019 0985  P6VXA Motherboard
+		1043 808c  A7V8X motherboard
+		1179 0001  Magnia Z310
+		1458 5004  GA-7VAX Mainboard
 	3040  VT82C586B ACPI
 	3043  VT86C100A [Rhine]
 		10bd 0000  VT86C100A Fast Ethernet Adapter
@@ -2858,22 +3127,29 @@
 	3050  VT82C596 Power Management
 	3051  VT82C596 Power Management
 	3057  VT82C686 [Apollo Super ACPI]
+		1019 0985  P6VXA Motherboard
 		1043 8033  A7V Mainboard
+		1043 803e  A7V-E Mainboard
 		1043 8040  A7M266 Mainboard
 		1043 8042  A7V133/A7V133-C Mainboard
+		1179 0001  Magnia Z310
 	3058  VT82C686 AC97 Audio Controller
 		0e11 b194  Soundmax integrated digital audio
+		1019 0985  P6VXA Motherboard
 		1106 4511  Onboard Audio on EP7KXA
 		1458 7600  Onboard Audio
 		1462 3091  MS-6309 Onboard Audio
 		15dd 7609  Onboard Audio
-	3059  VT8233 AC97 Audio Controller
+	3059  VT8233/A/8235 AC97 Audio Controller
+		1043 8095  A7V8X Motherboard (Realtek ALC650 codec)
+		1297 c160  FX41 motherboard (Realtek ALC650 codec)
 		1458 a002  GA-7VAX Onboard Audio (Realtek ALC650)
 	3065  VT6102 [Rhine-II]
 		1106 0102  VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
 		1186 1400  DFE-530TX rev A
 		1186 1401  DFE-530TX rev B
-	3068  AC97 Modem Controller
+		13b9 1421  LD-10/100AL PCI Fast Ethernet Adapter (rev.B)
+	3068  Intel 537 [AC97 Modem]
 	3074  VT8233 PCI to ISA Bridge
 		1043 8052  VT8233A
 	3091  VT8633 [Apollo Pro266]
@@ -2884,11 +3160,18 @@
 	3102  VT8662 Host Bridge
 	3103  VT8615 Host Bridge
 	3104  USB 2.0
+		1043 808c  A7V8X motherboard
+		1297 f641  FX41 motherboard
 		1458 5004  GA-7VAX Mainboard
 	3106  VT6105 [Rhine-III]
 	3109  VT8233C PCI to ISA Bridge
 	3112  VT8361 [KLE133] Host Bridge
-	3116  VT8375 [KM266] Host Bridge
+	3116  VT8375 [KM266/KL266] Host Bridge
+		1297 f641  FX41 motherboard
+# found on EPIA M6000/9000 mainboard
+	3122  VT8623 [Apollo CLE266] integrated CastleRock graphics
+# found on EPIA M6000/9000 mainboard
+	3123  VT8623 [Apollo CLE266]
 	3128  VT8753 [P4X266 AGP]
 	3133  VT3133 Host Bridge
 	3147  VT8233A ISA Bridge
@@ -2896,8 +3179,11 @@
 	3156  P/KN266 Host Bridge
 	3168  VT8374 P4X400 Host Controller/AGP Bridge
 	3177  VT8235 ISA Bridge
+		1043 808c  A7V8X motherboard
+		1297 f641  FX41 motherboard
 		1458 5001  GA-7VAX Mainboard
 	3189  VT8377 [KT400 AGP] Host Bridge
+		1043 807f  A7V8X motherboard
 		1458 5000  GA-7VAX Mainboard
 	5030  VT82C596 ACPI [Apollo PRO]
 	6100  VT85C100A [Rhine II]
@@ -2909,6 +3195,7 @@
 	8596  VT82C596 [Apollo PRO AGP]
 	8597  VT82C597 [Apollo VP3 AGP]
 	8598  VT82C598/694x [Apollo MVP3/Pro133x AGP]
+		1019 0985  P6VXA Motherboard
 	8601  VT8601 [Apollo ProMedia AGP]
 	8605  VT8605 [PM133 AGP]
 	8691  VT82C691 [Apollo Pro]
@@ -2920,6 +3207,7 @@
 	b103  VT8615 AGP Bridge
 	b112  VT8361 [KLE133] AGP Bridge
 	b168  VT8235 PCI Bridge
+	b198  VT8237 PCI Bridge
 1107  Stratus Computers
 	0576  VIA VT82C570MV [Apollo] (Wrong vendor ID!)
 1108  Proteon, Inc.
@@ -2936,7 +3224,14 @@
 110a  Siemens Nixdorf AG
 	0002  Pirahna 2-port
 	0005  Tulip controller, power management, switch extender
+	0006  FSC PINC (I/O-APIC)
+	0015  FSC Multiprocessor Interrupt Controller
+	001d  FSC Copernicus Management Controller
+	007b  FSC Remote Service Controller, mailbox device
+	007c  FSC Remote Service Controller, shared memory device
+	007d  FSC Remote Service Controller, SMIC device
 	2102  DSCC4 WAN adapter
+	4021  SIMATIC NET CP 5512 (Profibus and MPI Cardbus Adapter)
 	4942  FPGA I-Bus Tracer for MBD
 	6120  SZB6120
 110b  Chromatic Research Inc.
@@ -3102,10 +3397,16 @@
 	0001  MVC IM-PCI Video frame grabber/processor
 1130  Computervision
 1131  Philips Semiconductors
+	1561  USB 1.1 Host Controller
+	1562  USB 2.0 Host Controller
 	3400  SmartPCI56(UCB1500) 56K Modem
 	7130  SAA7130 Video Broadcast Decoder
+		5168 0138  LiveView FlyVideo 2000
+	7133  SAA7133 Audio+video broadcast decoder
+		5168 0138  LifeView FlyVideo 3000
 # PCI audio and video broadcast decoder (http://www.semiconductors.philips.com/pip/saa7134hl)
 	7134  SAA7134
+	7135  SAA7135 Audio+video broadcast decoder
 	7145  SAA7145
 	7146  SAA7146
 		114b 2003  DVRaptor Video Edit/Capture Card
@@ -3124,24 +3425,59 @@
 	b921  EiconCard P92
 	b922  EiconCard P92
 	b923  EiconCard P92
-	e001  DIVA 20PRO
-		1133 e001  DIVA Pro 2.0 S/T
-	e002  DIVA 20
-		1133 e002  DIVA 2.0 S/T
-	e003  DIVA 20PRO_U
-		1133 e003  DIVA Pro 2.0 U
-	e004  DIVA 20_U
-		1133 e004  DIVA 2.0 U
-	e005  DIVA LOW
-		1133 e005  DIVA 2.01 S/T
-	e00b  Eicon Diva 2.02
-	e010  DIVA Server BRI-2M
-		1133 e010  DIVA Server BRI-2M
-	e012  DIVA Server BRI-8M
-		1133 e012  DIVA Server BRI-8M
-	e014  DIVA Server PRI-30M
-		1133 e014  DIVA Server PRI-30M
-	e018  DIVA Server BRI-2M/-2F
+	e001  Diva Pro 2.0 S/T
+	e002  Diva 2.0 S/T PCI
+	e003  Diva Pro 2.0 U
+	e004  Diva 2.0 U PCI
+	e005  Diva 2.01 S/T PCI
+	e006  Diva CT S/T PCI
+	e007  Diva CT U PCI
+	e008  Diva CT Lite S/T PCI
+	e009  Diva CT Lite U PCI
+	e00a  Diva ISDN+V.90 PCI
+	e00b  Diva 2.02 PCI S/T
+	e00c  Diva 2.02 PCI U
+	e00d  Diva ISDN Pro 3.0 PCI
+	e00e  Diva ISDN+CT S/T PCI Rev 2
+	e010  Diva Server BRI-2M PCI
+		110a 0021  Fujitsu Siemens ISDN S0
+		8001 0014  Diva Server BRI-2M PCI Cornet NQ
+	e011  Diva Server BRI S/T Rev 2
+	e012  Diva Server 4BRI-8M PCI
+		8001 0014  Diva Server 4BRI-8M PCI Cornet NQ
+	e013  Diva Server 4BRI-8M Rev 2
+		8001 0014  Diva Server 4BRI-8M Cornet NQ 2
+	e014  Diva Server PRI-30M PCI
+		0008 0100  Diva Server PRI-30M PCI
+		8001 0014  Diva Server PRI-30M PCI Cornet NQ
+	e015  DIVA Server PRI-30M 2.0
+		8001 0014  Diva Server PRI Cornet NQ 2
+	e016  Diva Server Voice 4BRI PCI
+		8001 0014  Diva Server PRI Cornet NQ
+	e017  Diva Server Voice 4BRI PCI Rev 2
+		8001 0014  Diva Server Voice 4BRI PCI Cornet NQ 2
+	e018  Diva Server BRI 2M Revision 2
+		8001 0014  Diva Server BRI 2M Cornet NQ 2
+	e019  Diva Server Voice PRI PCI Rev 2
+		8001 0014  Diva Server Voice PRI PCI Cornet NQ 2
+	e01a  Diva Server 2FX
+	e01b  Diva Server BRI-2M Voice Revision 2
+		8001 0014  Diva Server BRI-2M Voice Cornet NQ 2
+	e01c  Diva Server PRI Rev 3.0
+		1133 1c01  Diva Server PRI/E1/T1-8 Rev 3.0
+		1133 1c02  Diva Server PRI/T1-24 Rev 3.0
+		1133 1c03  Diva Server PRI/E1-30 Rev 3.0
+		1133 1c04  Diva Server V-PRI/E1/T1 Rev 3.0
+		1133 1c05  Diva Server V-PRI/T1-24 Rev 3.0
+		1133 1c06  Diva Server V-PRI/E1-30 Rev 3.0
+		1133 1c07  Diva Server PRI/E1/T1-8 Cornet NQ 3
+		1133 1c08  Diva Server PRI/T1-24 Cornet NQ 3
+		1133 1c09  Diva Server PRI/E1-30 Cornet NQ 3
+		1133 1c0a  Diva Server V-PRI/E1/T1 Cornet NQ 3
+		1133 1c0b  Diva Server V-PRI/T1-24 Cornet NQ 3
+		1133 1c0c  Diva Server V-PRI/E1-30 Cornet NQ 3
+	e01e  Diva Server 2PRI
+	e020  Diva Server 4PRI
 1134  Mercury Computer Systems
 	0001  Raceway Bridge
 1135  Fuji Xerox Co Ltd
@@ -3209,37 +3545,24 @@
 		1148 5843  FDDI SK-5843 (SK-NET FDDI-LP64)
 		1148 5844  FDDI SK-5844 (SK-NET FDDI-LP64 DAS)
 	4200  Token Ring adapter
-	4300  SK-98xx Gigabit Ethernet Server Adapter
-		1148 9821  SK-9821 Gigabit Ethernet Server Adapter (SK-NET GE-T)
-		1148 9822  SK-9822 Gigabit Ethernet Server Adapter (SK-NET GE-T dual link)
-		1148 9841  SK-9841 Gigabit Ethernet Server Adapter (SK-NET GE-LX)
-		1148 9842  SK-9842 Gigabit Ethernet Server Adapter (SK-NET GE-LX dual link)
-		1148 9843  SK-9843 Gigabit Ethernet Server Adapter (SK-NET GE-SX)
-		1148 9844  SK-9844 Gigabit Ethernet Server Adapter (SK-NET GE-SX dual link)
-		1148 9861  SK-9861 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition)
-		1148 9862  SK-9862 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition dual link)
-		1148 9871  SK-9871 Gigabit Ethernet Server Adapter (SK-NET GE-ZX)
-		1148 9872  SK-9872 Gigabit Ethernet Server Adapter (SK-NET GE-ZX dual link)
-		1259 2970  Allied Telesyn AT-2970SX Gigabit Ethernet Adapter
-		1259 2971  Allied Telesyn AT-2970LX Gigabit Ethernet Adapter
-		1259 2972  Allied Telesyn AT-2970TX Gigabit Ethernet Adapter
-		1259 2973  Allied Telesyn AT-2971SX Gigabit Ethernet Adapter
-		1259 2974  Allied Telesyn AT-2971T Gigabit Ethernet Adapter
-		1259 2975  Allied Telesyn AT-2970SX/2SC Gigabit Ethernet Adapter
-		1259 2976  Allied Telesyn AT-2970LX/2SC Gigabit Ethernet Adapter
-		1259 2977  Allied Telesyn AT-2970TX/2TX Gigabit Ethernet Adapter
-	4320  SK-98xx V2.0 Gigabit Ethernet Adapter
-		1148 0121  Marvell RDK-8001 Adapter
-		1148 0221  Marvell RDK-8002 Adapter
-		1148 0321  Marvell RDK-8003 Adapter
-		1148 0421  Marvell RDK-8004 Adapter
-		1148 0621  Marvell RDK-8006 Adapter
-		1148 0721  Marvell RDK-8007 Adapter
-		1148 0821  Marvell RDK-8008 Adapter
-		1148 0921  Marvell RDK-8009 Adapter
-		1148 1121  Marvell RDK-8011 Adapter
-		1148 1221  Marvell RDK-8012 Adapter
-		1148 3221  SK-9521 V2.0 10/100/1000Base-T Adapter
+	4300  Gigabit Ethernet
+		1148 9821  SK-9821 (1000Base-T single link)
+		1148 9822  SK-9822 (1000Base-T dual link)
+		1148 9841  SK-9841 (1000Base-LX single link)
+		1148 9842  SK-9842 (1000Base-LX dual link)
+		1148 9843  SK-9843 (1000Base-SX single link)
+		1148 9844  SK-9844 (1000Base-SX dual link)
+		1148 9861  SK-9861 (1000Base-SX VF45 single link)
+		1148 9862  SK-9862 (1000Base-SX VF45 dual link)
+# Information got from SysKonnekt
+		1148 9871  SK-9871 (1000Base-ZX single link)
+# Information got from SysKonnekt
+		1148 9872  SK-9872 (1000Base-ZX dual link)
+		1259 2970  AT-2970SX [Allied Telesyn]
+		1259 2972  AT-2970T [Allied Telesyn]
+		1259 2975  AT-2970SX [Allied Telesyn]
+		1259 2977  AT-2970T [Allied Telesyn]
+	4320  SK-98xx Gigabit Ethernet Server Adapter
 		1148 5021  SK-9821 V2.0 Gigabit Ethernet 10/100/1000Base-T Adapter
 		1148 5041  SK-9841 V2.0 Gigabit Ethernet 1000Base-LX Adapter
 		1148 5043  SK-9843 V2.0 Gigabit Ethernet 1000Base-SX Adapter
@@ -3247,8 +3570,7 @@
 		1148 5061  SK-9861 V2.0 Gigabit Ethernet 1000Base-SX Adapter
 		1148 5071  SK-9871 V2.0 Gigabit Ethernet 1000Base-ZX Adapter
 		1148 9521  SK-9521 10/100/1000Base-T Adapter
-	4400 SK-9Dxx Gigabit Ethernet Adapter
-	4500 SK-9Mxx Gigabit Ethernet Adapter
+	4400  Gigabit Ethernet
 1149  Win System Corporation
 114a  VMIC
 	5579  VMIPCI-5579 (Reflective Memory Card)
@@ -3364,6 +3686,7 @@
 	0001  Motion TPEG Recorder/Player with audio
 1166  ServerWorks
 	0005  CNB20-LE Host Bridge
+	0006  CNB20HE Host Bridge
 	0007  CNB20-LE Host Bridge
 	0008  CNB20HE Host Bridge
 	0009  CNB20LE Host Bridge
@@ -3377,14 +3700,20 @@
 	0017  GCNB-LE Host Bridge
 	0200  OSB4 South Bridge
 	0201  CSB5 South Bridge
+		4c53 1080  CT8 mainboard
 	0203  CSB6 South Bridge
 	0211  OSB4 IDE Controller
 	0212  CSB5 IDE Controller
+		4c53 1080  CT8 mainboard
 	0213  CSB6 RAID/IDE Controller
 	0220  OSB4/CSB5 OHCI USB Controller
+		4c53 1080  CT8 mainboard
 	0221  CSB6 OHCI USB Controller
 	0225  GCLE Host Bridge
+# cancelled
+		4c53 1080  CT8 mainboard
 	0227  GCLE-2 Host Bridge
+		4c53 1080  CT8 mainboard
 1167  Mutoh Industries Inc
 1168  Thine Electronics Inc
 1169  Centre for Development of Advanced Computing
@@ -3435,7 +3764,9 @@
 	0465  RL5c465
 	0466  RL5c466
 	0475  RL5c475
+		144d c006  vpr Matrix 170B4 CardBus bridge
 	0476  RL5c476 II
+		1014 0185  ThinkPad A/T/X Series
 		104d 80df  Vaio PCG-FX403
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
 	0477  RL5c477
@@ -3444,7 +3775,9 @@
 	0522  R5C522 IEEE 1394 Controller
 		1014 01cf  ThinkPad A30p (2653-64G)
 	0551  R5C551 IEEE 1394 Controller
+		144d c006  vpr Matrix 170B4
 	0552  R5C552 IEEE 1394 Controller
+		1014 0511  ThinkPad A/T/X Series
 1181  Telmatics International
 1183  Fujikura Ltd
 1184  Forks Inc
@@ -3460,8 +3793,6 @@
 	1340  DFE-690TXD CardBus PC Card
 	1561  DRP-32TXD Cardbus PC Card
 	4000  DL2K Ethernet
-	4c00  Gigabit Ethernet Adapter
-		1186 4c00  DGE-530T Gigabit Ethernet Adapter
 1187  Advanced Technology Laboratories, Inc.
 1188  Shima Seiki Manufacturing Ltd.
 1189  Matsushita Electronics Co Ltd
@@ -3539,9 +3870,6 @@
 11aa  Actel
 11ab  Galileo Technology Ltd.
 	0146  GT-64010/64010A System Controller
-	4146  GT-64111 System Controller
-	4320  Gigabit Ethernet Adapter
-		11ab 9521  Marvell Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
 	4611  GT-64115 System Controller
 	4620  GT-64120/64120A/64121A System Controller
 	4801  GT-48001
@@ -3637,6 +3965,7 @@
 	0443  LT WinModem
 	0444  LT WinModem
 	0445  LT WinModem
+		8086 2203  PRO/100+ MiniPCI (probably an Ambit U98.003.C.00 combo card)
 	0446  LT WinModem
 	0447  LT WinModem
 	0448  WinModem 56k
@@ -3666,6 +3995,7 @@
 	044e  LT WinModem
 	044f  V90 WildWire Modem
 	0450  LT WinModem
+		1033 80a8  Versa Note Vxi
 		144f 4005  Magnia SG20
 	0451  LT WinModem
 	0452  LT WinModem
@@ -3683,6 +4013,8 @@
 	0480  Venus Modem (V90, 56KFlex)
 	5801  USB
 	5802  USS-312 USB Controller
+# 4 port PCI USB Controller made by Agere (formely Lucent)
+	5803  USS-344S USB Controller
 	5811  FW323
 		dead 0800  FireWire Host Bus Adapter
 11c2  Sand Microelectronics
@@ -3726,7 +4058,6 @@
 11d9  TEC Corporation
 11da  Novell
 11db  Sega Enterprises Ltd
-	1234  Broadband Adapter
 11dc  Questra Corporation
 11dd  Crosfield Electronics Limited
 11de  Zoran Corporation
@@ -3786,32 +4117,28 @@
 11fc  Silicon Magic
 11fd  High Street Consultants
 11fe  Comtrol Corporation
-	0001  Rocketport 32 port w/external I/F
-	0002  Rocketport 8 port w/external I/F
-	0003  Rocketport 16 port w/external I/F
-	0004  Rocketport 4 port w/quad cable
-	0005  Rocketport 8 port w/octa cable
-	0006  Rocketport 8 port w/RJ11 connectors
-	0007  Rocketport 4 port w/RJ11 connectors
-	0008  Rocketport 8 port w/ DB78 SNI (Siemens) connector
-	0009  Rocketport 16 port w/ DB78 SNI (Siemens) connector
-	000a  Rocketport Plus 4 port
-	000b  Rocketport Plus 8 port
-	000c  RocketModem 6 port
-	000d  RocketModem 4-port
-	000e  Rocketport Plus 2 port RS232
-	000f  Rocketport Plus 2 port RS422
-	0801  Rocketport UPCI 32 port w/external I/F
-	0802  Rocketport UPCI 8 port w/external I/F
-	0803  Rocketport UPCI 16 port w/external I/F
-	0805  Rocketport UPCI 8 port w/octa cable
-	080C  RocketModem III 8 port
-	080D  RocketModem III 4 port
-	0903  Rocketport Compact PCI 16 port w/external I/F
+	0001  RocketPort 8 Oct
+	0002  RocketPort 8 Intf
+	0003  RocketPort 16 Intf
+	0004  RocketPort 32 Intf
+	0005  RocketPort Octacable
+	0006  RocketPort 8J
+	0007  RocketPort 4-port
+	0008  RocketPort 8-port
+	0009  RocketPort 16-port
+	000a  RocketPort Plus Quadcable
+	000b  RocketPort Plus Octacable
+	000c  RocketPort 8-port Modem
+	8015  RocketPort 4-port UART 16954
 11ff  Scion Corporation
 1200  CSS Corporation
 1201  Vista Controls Corp
 1202  Network General Corp.
+	4300  Gigabit Ethernet Adapter
+		1202 9841  SK-9841 LX
+		1202 9842  SK-9841 LX dual link
+		1202 9843  SK-9843 SX
+		1202 9844  SK-9843 SX dual link
 1203  Bayer Corporation, Agfa Division
 1204  Lattice Semiconductor Corporation
 1205  Array Corporation
@@ -3858,6 +4185,7 @@
 	6933  OZ6933 Cardbus Controller
 		1025 1016  Travelmate 612 TX
 	6972  OZ6912 Cardbus Controller
+		1179 0001  Magnia Z310
 1218  Hybricon Corp.
 1219  First Virtual Corporation
 121a  3Dfx Interactive, Inc.
@@ -3975,6 +4303,8 @@
 		1242 6562  FCX2-6562 Dual Channel PCI-X Fibre Channel Adapter
 		1242 656a  FCX-6562 PCI-X Fibre Channel Adapter
 	4643  FCI-1063 Fibre Channel Adapter
+	6562  FCX2-6562 Dual Channel PCI-X Fibre Channel Adapter
+	656a  FCX-6562 PCI-X Fibre Channel Adapter
 1243  Delphax
 1244  AVM Audiovisuelles MKTG & Computer System GmbH
 	0700  B1 ISDN
@@ -4035,6 +4365,7 @@
 		1014 0166  ES1969 SOLO-1 AudioDrive on IBM Aptiva Mainboard
 		125d 8888  Solo-1 Audio Adapter
 	1978  ES1978 Maestro 2E
+		0e11 b112  Armada M700/E500
 		1033 803c  ES1978 Maestro-2E Audiodrive
 		1033 8058  ES1978 Maestro-2E Audiodrive
 		1092 4000  Monster Sound MX400
@@ -4045,6 +4376,7 @@
 	1989  ESS Modem
 		125d 1989  ESS Modem
 	1998  ES1983S Maestro-3i PCI Audio Accelerator
+		1028 00b1  Latitude C600
 		1028 00e6  ES1983S Maestro-3i (Dell Inspiron 8100)
 	1999  ES1983S Maestro-3i PCI Modem Accelerator
 	199a  ES1983S Maestro-3i PCI Audio Accelerator
@@ -4067,8 +4399,9 @@
 	3873  Prism 2.5 Wavelan chipset
 		1186 3501  DWL-520 Wireless PCI Adapter
 		1668 0414  HWP01170-01 802.11b PCI Wireless Adapter
-		1737 3874  WMP11 Wireless 802.11b PCI Adaptor
+		1737 3874  WMP11 Wireless 802.11b PCI Adapter
 		8086 2513  Wireless 802.11b MiniPCI Adapter
+	3890  D-Links DWL-g650 A1
 	8130  HMP8130 NTSC/PAL Video Decoder
 	8131  HMP8131 NTSC/PAL Video Decoder
 1261  Matsushita-Kotobuki Electronics Industries, Ltd.
@@ -4094,6 +4427,7 @@
 	0710  SM710 LynxEM
 	0712  SM712 LynxEM+
 	0720  SM720 Lynx3DM
+	0730  SM731 Cougar3DR
 	0810  SM810 LynxE
 	0811  SM811 LynxE
 	0820  SM820 Lynx3D
@@ -4104,6 +4438,7 @@
 1273  Hughes Network Systems
 	0002  DirecPC
 1274  Ensoniq
+	1171  ES1373 [AudioPCI] (also Creative Labs CT5803)
 	1371  ES1371 [AudioPCI-97]
 		0e11 0024  AudioPCI on Motherboard Compaq Deskpro
 		0e11 b1a7  ES1371, ES1373 AudioPCI
@@ -4173,6 +4508,7 @@
 1277  Comstream
 1278  Transtech Parallel Systems Ltd.
 	0701  TPE3/TM3 PowerPC Node
+	0710  TPE5 PowerPC PCI board
 1279  Transmeta Corporation
 	0295  Northbridge
 	0395  LongRun Northbridge
@@ -4368,6 +4704,7 @@
 		12ae 0001  Gigabit Ethernet-SX (Universal)
 		1410 0104  Gigabit Ethernet-SX PCI Adapter
 	0002  AceNIC Gigabit Ethernet (Copper)
+		10a9 8002  Acenic Gigabit Ethernet
 		12ae 0002  Gigabit Ethernet-T (3C986-T)
 12af  TDK USA Corp
 12b0  Jorge Scientific Corp
@@ -4379,7 +4716,7 @@
 12b6  Natural Microsystems
 12b7  Cognex Modular Vision Systems Div. - Acumen Inc.
 12b8  Korg
-12b9  US Robotics/3Com
+12b9  5610 56K FaxModem
 	1006  WinModem
 		12b9 005c  USR 56k Internal Voice WinModem (Model 3472)
 		12b9 005e  USR 56k Internal WinModem (Models 662975)
@@ -4462,16 +4799,20 @@
 	00a0  ITNT2
 12d3  Vingmed Sound A/S
 12d4  Ulticom (Formerly DGM&S)
+	0200  T1 Card
 12d5  Equator Technologies
 12d6  Analogic Corp
 12d7  Biotronic SRL
 12d8  Pericom Semiconductor
 12d9  Aculab PLC
+	0002  PCI Prosody
+	0004  cPCI Prosody
 12da  True Time Inc.
 12db  Annapolis Micro Systems, Inc
 12dc  Symicron Computer Communication Ltd.
 12dd  Management Graphics
 12de  Rainbow Technologies
+	0200  CryptoSwift CS200
 12df  SBS Technologies Inc
 12e0  Chase Research
 	0010  ST16C654 Quad UART
@@ -4584,6 +4925,7 @@
 	0036  PCI-DAS64/M2/16
 	0037  PCI-DAS64/M3/16
 	004c  PCI-DAS1000
+	004d  PCI-QUAD04
 1308  Jato Technologies Inc.
 	0001  NetCelerator Adapter
 		1308 0001  NetCelerator Adapter
@@ -4669,8 +5011,13 @@
 132d  Integrated Silicon Solution, Inc.
 1330  MMC Networks
 1331  Radisys Corp.
+	8200  82600 Host Bridge
+	8201  82600 IDE
+	8202  82600 USB
+	8210  82600 PCI Bridge
 1332  Micro Memory
 	5415  MM-5415CN PCI Memory Module with Battery Backup
+	5425  MM-5425CN PCI 64/66 Memory Module with Battery Backup
 1334  Redcreek Communications, Inc
 1335  Videomail, Inc
 1337  Third Planet Publishing
@@ -4696,6 +5043,7 @@
 134c  Chori Joho System Co. Ltd
 134d  PCTel Inc
 	7890  HSP MicroModem 56
+		134d 0001  PCT789 adapter
 	7891  HSP MicroModem 56
 		134d 0001  HSP MicroModem 56
 	7892  HSP MicroModem 56
@@ -4755,13 +5103,12 @@
 1369  Digigram
 136a  High Soft Tech
 136b  Kawasaki Steel Corporation
+	ff01  KL5A72002 Motion JPEG
 136c  Adtek System Science Co Ltd
 136d  Gigalabs Inc
 136f  Applied Magic Inc
 1370  ATL Products
 1371  CNet Technology Inc
-	434e  GigaCard Network Adapter
-		1371 434e  N-Way PCI-Bus Giga-Card 1000/100/10Mbps(L)
 1373  Silicon Vision Inc
 1374  Silicom Ltd
 1375  Argosystems Inc
@@ -4782,6 +5129,7 @@
 1384  Reality Simulation Systems Inc
 1385  Netgear
 	4100  802.11b Wireless Adapter (MA301)
+	4105  MA311 802.11b wireless adapter
 	620a  GA620
 	622a  GA622
 	630a  GA630
@@ -4891,6 +5239,8 @@
 13ce  Cocom A/S
 13cf  Studio Audio & Video Ltd
 13d0  Techsan Electronics Co Ltd
+# http://www.b2c2inc.com/products/pc-specs.html
+	2103  B2C2 Sky2PC PCI [SkyStar2]
 13d1  Abocom Systems Inc
 	ab02  ADMtek Centaur-C rev 17 [D-Link DFE-680TX] CardBus Fast Ethernet Adapter
 	ab06  RTL8139 [FE2000VX] CardBus Fast Ethernet Attached Port Adapter
@@ -4919,7 +5269,7 @@
 13e6  Argosy research Inc
 13e7  NAC Incorporated
 13e8  Chip Express Corporation
-13e9  Chip Express Corporation
+13e9  Intraserver Technology Inc
 13ea  Dallas Semiconductor
 13eb  Hauppauge Computer Works Inc
 13ec  Zydacron Inc
@@ -4941,9 +5291,11 @@
 		13f6 0101  CMI8338-031 PCI Audio Device
 	0111  CM8738
 		1019 0970  P6STP-FL motherboard
+		1043 8035  CUSI-FX motherboard
 		1043 8077  CMI8738 6-channel audio controller
 		1043 80e2  CMI8738 6ch-MX
 		13f6 0111  CMI8738/C3DX PCI Audio Device
+		1681 a000  Gamesurround MUSE XL
 	0211  CM8738
 13f7  Wildfire Communications
 13f8  Ad Lib Multimedia Inc
@@ -4967,8 +5319,6 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
-	0180  Lava Octo A
-	0181  Lava Octo B
 	0200  Lava Port Plus
 	0201  Lava Quad A
 	0202  Lava Quad B
@@ -5016,6 +5366,8 @@
 141e  Fanuc Ltd
 141f  Visiontech Ltd
 1420  Psion Dacom plc
+	8002  Gold Card NetGlobal 56k+10/100Mb CardBus (Ethernet part)
+	8003  Gold Card NetGlobal 56k+10/100Mb CardBus (Modem part)
 1421  Ads Technologies Inc
 1422  Ygrec Systems Co Ltd
 1423  Custom Technology Corp.
@@ -5090,7 +5442,7 @@
 	0001  NextMove PCI
 1460  DYNARC INC
 1461  Avermedia Technologies Inc
-1462  Micro-star International Co Ltd
+1462  Micro-Star International Co., Ltd.
 1463  Fast Corporation
 1464  Interactive Circuits & Systems Ltd
 1465  GN NETTEST Telecom DIV.
@@ -5101,6 +5453,7 @@
 146a  IFR
 146b  Parascan Technologies Ltd
 146c  Ruby Tech Corp.
+	1430  FE-1430TX Fast Ethernet PCI Adapter
 146d  Tachyon, INC.
 146e  Williams Electronics Games, Inc.
 146f  Multi Dimensional Consulting Inc
@@ -5151,6 +5504,7 @@
 149b  SEIKO Instruments Inc
 149c  OVISLINK Corp.
 149d  NEWTEK Inc
+	0001  Video Toaster for PC
 149e  Mapletree Networks Inc.
 149f  LECTRON Co Ltd
 14a0  SOFTING GmBH
@@ -5177,6 +5531,14 @@
 	0000  DSL NIC
 14b4  PHILIPS Business Electronics B.V.
 14b5  Creamware GmBH
+	0200  Scope
+	0300  Pulsar
+	0400  Pulsar2
+	0600  Pulsar2
+	0800  DSP-Board
+	0900  DSP-Board
+	0a00  DSP-Board
+	0b00  DSP-Board
 14b6  Quantum Data Corp.
 14b7  PROXIM Inc
 	0001  Symphony 4110
@@ -5285,6 +5647,9 @@
 		0e11 009a  NC7770 Gigabit Server Adapter (PCI-X, 10/100/1000-T)
 		0e11 00c1  NC6770 Gigabit Server Adapter (PCI-X, 1000-SX)
 		1028 0121  Broadcom BCM5701 1000Base-T
+		10a9 8010  SGI IO9 Gigabit Ethernet (Copper)
+		10a9 8011  SGI Gigabit Ethernet (Copper)
+		10a9 8012  SGI Gigabit Ethernet (Fiber)
 		10b7 1004  3C996-SX 1000Base-SX
 		10b7 1006  3C996B-T 1000Base-T
 		10b7 1007  3C1000-T 1000Base-T
@@ -5302,6 +5667,7 @@
 	1647  NetXtreme BCM5703 Gigabit Ethernet
 		0e11 0099  NC7780 1000BaseTX
 		0e11 009a  NC7770 1000BaseTX
+		10a9 8010  SGI IO9 Gigabit Ethernet (Copper)
 		14e4 0009  BCM5703 1000BaseTX
 		14e4 000a  BCM5703 1000BaseSX
 		14e4 000b  BCM5703 1000BaseTX
@@ -5314,13 +5680,9 @@
 		10b7 2000  3C998-T Dual Port 10/100/1000 PCI-X
 		10b7 3000  3C999-T Quad Port 10/100/1000 PCI-X
 		1166 1648  NetXtreme CIOB-E 1000Base-T
-	1649  NetXtreme BCM5704S Gigabit Ethernet
 	164d  NetXtreme BCM5702FE Gigabit Ethernet
 	1653  NetXtreme BCM5705 Gigabit Ethernet
-	1654  NetXtreme BCM5705 Gigabit Ethernet
 	165d  NetXtreme BCM5705M Gigabit Ethernet
-	165e  NetXtreme BCM5705M Gigabit Ethernet
-	166e  NetXtreme BCM5705F Gigabit Ethernet
 	1696  NetXtreme BCM5782 Gigabit Ethernet
 		14e4 000d  NetXtreme BCM5782 1000Base-T
 	169c  NetXtreme BCM5788 Gigabit Ethernet
@@ -5345,13 +5707,14 @@
 	16c7  NetXtreme BCM5703 Gigabit Ethernet
 		14e4 0009  NetXtreme BCM5703 1000Base-T
 		14e4 000a  NetXtreme BCM5703 1000Base-SX
-	170d  NetXtreme BCM5901 Gigabit Ethernet
-	170e  NetXtreme BCM5901 Gigabit Ethernet
 	4210  BCM4210 iLine10 HomePNA 2.0
 	4211  BCM4211 iLine10 HomePNA 2.0 + V.90 56k modem
 	4212  BCM4212 v.90 56k modem
 	4301  BCM4301 802.11b
+	4320  BCM94306 802.11g
+		1737 4320  WPC54G
 	4401  BCM4401 100Base-T
+		1043 80a8  A7V8X motherboard
 	4402  BCM4402 Integrated 10/100BaseT
 	4410  BCM4413 iLine32 HomePNA 2.0
 	4411  BCM4413 V.90 56k modem
@@ -5440,6 +5803,9 @@
 		122d 4302  Dell MP3930V-W(C) MiniPCI
 	1610  ADSL AccessRunner PCI Arbitration Device
 	1611  AccessRunner PCI ADSL Interface Device
+	1620  ADSL AccessRunner V2 PCI Arbitration Device
+	1621  AccessRunner V2 PCI ADSL Interface Device
+	1622  AccessRunner V2 PCI ADSL Yukon WAN Adapter
 	1803  HCF 56k Modem
 		0e11 0023  623-LAN Grizzly
 		0e11 0043  623-LAN Yogi
@@ -5505,11 +5871,6 @@
 		14f1 2004  Dynalink 56PMi
 	8234  RS8234 ATM SAR Controller [ServiceSAR Plus]
 14f2  MOBILITY Electronics
-	0120  EV1000 bridge
-	0121  EV1000 Parallel port
-	0122  EV1000 Serial port
-	0123  EV1000 Keyboard controller
-	0124  EV1000 Mouse controller
 14f3  BROADLOGIC
 14f4  TOKYO Electronic Industry CO Ltd
 14f5  SOPAC Ltd
@@ -5582,6 +5943,8 @@
 		1522 0400  RockForceDUO+ 2 Port V.92/V.44 Data/Fax/Voice Modem
 		1522 0500  RockForceQUATRO+ 4 Port V.92/V.44 Data/Fax/Voice Modem
 		1522 0600  RockForce+ 2 Port V.90 Data/Fax/Voice Modem
+		1522 0700  RockForce+ 4 Port V.90 Data/Fax/Voice Modem
+		1522 0800  RockForceOCTO+ 8 Port V.92/V.44 Data/Fax/Voice Modem
 1523  MUSIC Semiconductors
 1524  ENE Technology Inc
 	1211  CB1211 Cardbus Controller
@@ -5618,6 +5981,7 @@
 1541  MACHONE Communications
 1542  VIVID Technology Inc
 1543  SILICON Laboratories
+	3052  Intel 537 [Winmodem]
 	4c22  Si3036 MC'97 DAA
 1544  DCM DATA Systems
 1545  VISIONTEK
@@ -5858,6 +6222,7 @@
 1638  Standard Microsystems Corp [SMC]
 	1100  SMC2602W EZConnect / Addtron AWA-100
 163c  Smart Link Ltd.
+	3052  SmartLink SmartPCI562 56K Modem
 	5449  SmartPCI561 Modem
 1657  Brocade Communications Systems, Inc.
 165a  Epix Inc
@@ -5871,6 +6236,8 @@
 16ab  Global Sun Technology Inc
 	1102  PCMCIA-to-PCI Wireless Network Bridge
 16be  Creatix Polymedia GmbH
+16ca  CENATEK Inc
+	0001  Rocket Drive DL
 16ec  U.S. Robotics
 	3685  Wireless Access PCI Adapter Model 022415
 16f6  VideoTele.com, Inc.
@@ -5879,16 +6246,10 @@
 170c  YottaYotta Inc.
 172a  Accelerated Encryption
 1737  Linksys
-	1032  Gigabit Network Adapter
-		1737 0015  EG1032 v2 Instant Gigabit Network Adapter
-	1064  Gigabit Network Adapter
-		1737 0016  EG1064 v2 Instant Gigabit Network Adapter
 173b  Altima (nee Broadcom)
 	03e8  AC1000 Gigabit Ethernet
-	03e9  AC1001 Gigabit Ethernet
 	03ea  AC9100 Gigabit Ethernet
 		173b 0001  AC1002
-	03eb  AC1003 Gigabit Ethernet
 1743  Peppercon AG
 	8139  ROL/F-100 Fast Ethernet Adapter with ROL
 174b  PC Partner Limited
@@ -5904,6 +6265,8 @@
 	0006  AMCC HOTlink
 1799  Belkin
 17af  Hightech Information System Ltd.
+17cc  NetChip Technology, Inc
+	2280  USB 2.0
 1813  Ambient Technologies Inc
 	4000  HaM controllerless modem
 		16be 0001  V9x HAM Data Fax Modem
@@ -5911,6 +6274,11 @@
 		16be 0002  V9x HAM 1394
 1851  Microtune, Inc.
 1852  Anritsu Corp.
+1888  Varisys Ltd
+	0301  VMFX1 FPGA PMC module
+	0601  VSM2 dual PMC carrier
+	0710  VS14x series PowerPC PCI board
+	0720  VS24x series PowerPC PCI board
 1a08  Sierra semiconductor
 	0000  SC15064
 1b13  Jaton Corp
@@ -5923,7 +6291,12 @@
 	2020  DC-390
 	690c  690c
 	dc29  DC290
+1fc0  Tumsan Oy
+	0300  E2200 Dual E1/Rawpipe Card
+2000  Smart Link Ltd.
 2001  Temporal Research Ltd
+2003  Smart Link Ltd.
+2004  Smart Link Ltd.
 21c3  21st Century Computer Corp.
 2348  Racore
 	2010  8142 100VG/AnyLAN
@@ -5935,7 +6308,15 @@
 3000  Hansol Electronics Inc.
 3142  Post Impression Systems.
 3388  Hint Corp
-	0021  HB1-SE33 PCI-PCI Bridge
+	0013  HiNT HC4 PCI to ISDN bridge, Multimedia audio controller
+	0014  HiNT HC4 PCI to ISDN bridge, Network controller
+	0020  HB6 Universal PCI-PCI bridge (transparent mode)
+	0021  HB6 Universal PCI-PCI bridge (non-transparent mode)
+		4c53 1050  CT7 mainboard
+		4c53 1080  CT8 mainboard
+		4c53 3010  PPCI mezzanine (32-bit PMC)
+	101a  E.Band [AudioTrak Inca88]
+	101b  E.Band [AudioTrak Inca88]
 	8011  VXPro II Chipset
 		3388 8011  VXPro II Chipset CPU to PCI Bridge
 	8012  VXPro II Chipset
@@ -5995,6 +6376,7 @@
 	0100  AladdinCARD
 	0200  CPC
 4444  Internext Compression Inc
+	0803  iTVC15 MPEG-2 Encoder
 4468  Bridgeport machines
 4594  Cogetec Informatique Inc
 45fb  Baldor Electric Company
@@ -6040,6 +6422,7 @@
 5143  Qualcomm Inc
 5145  Ensoniq (Old)
 	3031  Concert AudioPCI
+5168  Animation Technologies Inc.
 5301  Alliance Semiconductor Corp.
 	0001  ProMotion aT3D
 5333  S3 Inc.
@@ -6150,6 +6533,7 @@
 	8c12  86C270-294 Savage/IX-MV
 		1014 017f  ThinkPad T20
 	8c13  86C270-294 Savage/IX
+		1179 0001  Magnia Z310
 	8c22  SuperSavage MX/128
 	8c24  SuperSavage MX/64
 	8c26  SuperSavage MX/64C
@@ -6160,10 +6544,10 @@
 	8c2e  SuperSavage IX/C SDR
 		1014 01fc  ThinkPad T23 (2647-4MG)
 	8c2f  SuperSavage IX/C DDR
-# Integrated in VIA ProSavage PN133 North Bridge
-	8d01  VT8603 [ProSavage PN133] AGP4X VGA Controller (Twister)
+	8d01  86C380 [ProSavageDDR K4M266]
 	8d02  VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK)
-	8d04  VT8751 [ProSavageDDR P4M266] VGA Controller
+	8d03  VT8751 [ProSavageDDR P4M266]
+	8d04  VT8375 [ProSavage8 KM266/KL266]
 	9102  86C410 Savage 2000
 		1092 5932  Viper II Z200
 		1092 5934  Viper II Z200
@@ -6175,6 +6559,7 @@
 		1092 5a57  Viper II Z200
 	ca00  SonicVibes
 544c  Teralogic Inc
+	0350  TL880-based HDTV/ATSC tuner
 5455  Technische University Berlin
 	4458  S5933
 5519  Cnet Technologies, Inc.
@@ -6182,6 +6567,7 @@
 	0001  I-30xx Scanner Interface
 5555  Genroco, Inc
 	0003  TURBOstor HFP-832 [HiPPI NIC]
+5654  VoiceTronix Pty Ltd
 5700  Netpower
 6356  UltraStor
 6374  c't Magazin für Computertechnik
@@ -6257,13 +6643,14 @@
 	1029  82559 Ethernet Controller
 	1030  82559 InBusiness 10/100
 	1031  82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller
-		1014 0209  ThinkPad A30p/T30
+		1014 0209  ThinkPad A/T/X Series
 		104d 80e7  Vaio PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
 		107b 5350  EtherExpress PRO/100 VE
 		1179 0001  EtherExpress PRO/100 VE
 		144d c000  EtherExpress PRO/100 VE
 		144d c001  EtherExpress PRO/100 VE
 		144d c003  EtherExpress PRO/100 VE
+		144d c006  vpr Matrix 170B4
 	1032  82801CAM (ICH3) PRO/100 VE Ethernet Controller
 	1033  82801CAM (ICH3) PRO/100 VM (LOM) Ethernet Controller
 	1034  82801CAM (ICH3) PRO/100 VM Ethernet Controller
@@ -6279,18 +6666,20 @@
 	103e  82801BD PRO/100 VM (MOB) Ethernet Controller
 	1040  536EP Data Fax Modem
 		16be 1040  V.9X DSP Data Fax Modem
-	1048  82597EX 10GbE Ethernet Controller
-		8086 a01f  PRO/10GbE LR Server Adapter
-		8086 a11f  PRO/10GbE LR Server Adapter
+	1043  PRO/Wireless LAN 2100 3B Mini PCI Adapter
 	1059  82551QM Ethernet Controller
 	1130  82815 815 Chipset Host Bridge and Memory Controller Hub
 		1025 1016  Travelmate 612 TX
 		1043 8027  TUSL2-C Mainboard
 		104d 80df  Vaio PCG-FX403
+		8086 4532  D815EEA2 mainboard
+		8086 4557  D815EGEW Mainboard
 	1131  82815 815 Chipset AGP Bridge
 	1132  82815 CGC [Chipset Graphics Controller]
 		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
+		8086 4532  D815EEA2 Mainboard
+		8086 4557  D815EGEW Mainboard
 	1161  82806AA PCI64 Hub Advanced Programmable Interrupt Controller
 		8086 1161  82806AA PCI64 Hub APIC
 	1162  Xscale 80200 Big Endian Companion Chip
@@ -6475,6 +6864,7 @@
 		8086 8000  82806AA PCI64 Hub Controller (HRes)
 	1460  82870P2 P64H2 Hub PCI Bridge
 	1461  82870P2 P64H2 I/OxAPIC
+		15d9 3480  P4DP6
 	1462  82870P2 P64H2 Hot Plug Controller
 	1960  80960RP [i960RP Microprocessor]
 		101e 0431  MegaRAID 431 RAID Controller
@@ -6526,23 +6916,33 @@
 	2428  82801AB PCI Bridge
 	2440  82801BA ISA Bridge (LPC)
 	2442  82801BA/BAM USB (Hub #1)
+		1014 01c6  Netvista A40/A40p
+		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
 		147b 0507  TH7II-RAID
+		8086 4532  D815EEA2 mainboard
+		8086 4557  D815EGEW Mainboard
 	2443  82801BA/BAM SMBus
+		1014 01c6  Netvista A40/A40p
 		1025 1016  Travelmate 612 TX
 		1043 8027  TUSL2-C Mainboard
 		104d 80df  Vaio PCG-FX403
 		147b 0507  TH7II-RAID
+		8086 4532  D815EEA2 mainboard
+		8086 4557  D815EGEW Mainboard
 	2444  82801BA/BAM USB (Hub #2)
 		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
 		147b 0507  TH7II-RAID
+		8086 4532  D815EEA2 mainboard
 	2445  82801BA/BAM AC'97 Audio
+		1014 01c6  Netvista A40/A40p
 		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
 		1462 3370  STAC9721 AC
 		147b 0507  TH7II-RAID
-	2446  82801BA/BAM AC'97 Modem
+		8086 4557  D815EGEW Mainboard
+	2446  Intel 537 [82801BA/BAM AC'97 Modem]
 		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
 	2448  82801BAM/CAM PCI Bridge
@@ -6560,8 +6960,12 @@
 		1014 023d  EtherExpress PRO/100 VE
 		1014 0244  EtherExpress PRO/100 VE
 		1014 0245  EtherExpress PRO/100 VE
+		1014 0265  PRO/100 VE Desktop Connection
+		1014 0267  PRO/100 VE Desktop Connection
+		1014 026a  PRO/100 VE Desktop Connection
 		109f 315d  EtherExpress PRO/100 VE
 		109f 3181  EtherExpress PRO/100 VE
+		1179 ff01  PRO/100 VE Network Connection
 		1186 7801  EtherExpress PRO/100 VE
 		144d 2602  HomePNA 1M CNR
 		8086 3010  EtherExpress PRO/100 VE
@@ -6577,10 +6981,13 @@
 		1025 1016  Travelmate 612TX
 		104d 80df  Vaio PCG-FX403
 	244b  82801BA IDE U100
+		1014 01c6  Netvista A40/A40p
 		1043 8027  TUSL2-C Mainboard
 		147b 0507  TH7II-RAID
+		8086 4532  D815EEA2 mainboard
+		8086 4557  D815EGEW Mainboard
 	244c  82801BAM ISA Bridge (LPC)
-	244e  82801BA/CA/DB PCI Bridge
+	244e  82801BA/CA/DB/EB PCI Bridge
 	2450  82801E ISA Bridge (LPC)
 	2452  82801E USB
 	2453  82801E SMBus
@@ -6588,44 +6995,80 @@
 	245b  82801E IDE U100
 	245d  82801E Ethernet Controller 1
 	245e  82801E PCI Bridge
-	2480  82801CA ISA Bridge (LPC)
+	2480  82801CA LPC Interface Controller
 	2482  82801CA/CAM USB (Hub #1)
-		1014 0220  ThinkPad T23/A30p/T30
+		1014 0220  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
-	2483  82801CA/CAM SMBus
-		1014 0220  ThinkPad T23/A30p/T30
+		15d9 3480  P4DP6
+		8086 1958  vpr Matrix 170B4
+	2483  82801CA/CAM SMBus Controller
+		1014 0220  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
+		15d9 3480  P4DP6
+		8086 1958  vpr Matrix 170B4
 	2484  82801CA/CAM USB (Hub #2)
-		1014 0220  ThinkPad T23/A30p/T30
+		1014 0220  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
-	2485  82801CA/CAM AC'97 Audio
+		15d9 3480  P4DP6
+		8086 1958  vpr Matrix 170B4
+	2485  82801CA/CAM AC'97 Audio Controller
 		1014 0222  ThinkPad T23 (2647-4MG) or A30p (2653-64G)
 		1014 0508  ThinkPad T30
+		1014 051c  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
-	2486  82801CA/CAM AC'97 Modem
-		1014 0223  ThinkPad A30p (2653-64G)
+		144d c006  vpr Matrix 170B4
+	2486  82801CA/CAM AC'97 Modem Controller
+		1014 0223  ThinkPad A/T/X Series
 		1014 0503  ThinkPad R31 2656BBG
-		1014 051a  ThinkPad T30
+		1014 051a  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
+		1179 0001  Toshiba Satellite 1110 Z15 internal Modem
 		134d 4c21  Dell Inspiron 2100 internal modem
+		144d 2115  vpr Matrix 170B4 internal modem
 		14f1 5421  MD56ORD V.92 MDC Modem
 	2487  82801CA/CAM USB (Hub #3)
-		1014 0220  ThinkPad T23/A30p/T30
+		1014 0220  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
+		15d9 3480  P4DP6
+		8086 1958  vpr Matrix 170B4
 	248a  82801CAM IDE U100
-		1014 0220  ThinkPad T23/A30p/T30
+		1014 0220  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
-	248b  82801CA IDE U100
+		8086 1958  vpr Matrix 170B4
+	248b  82801CA Ultra ATA Storage Controller
+		15d9 3480  P4DP6
 	248c  82801CAM ISA Bridge (LPC)
-	24c0  82801DB ISA Bridge (LPC)
+	24c0  82801DB LPC Interface Controller
+		1462 5800  845PE Max (MS-6580)
 	24c2  82801DB USB (Hub #1)
-	24c3  82801DB SMBus
+		1462 5800  845PE Max (MS-6580)
+	24c3  82801DB/DBM SMBus Controller
+		1462 5800  845PE Max (MS-6580)
 	24c4  82801DB USB (Hub #2)
-	24c5  82801DB AC'97 Audio
-	24c6  82801DB AC'97 Modem
+		1462 5800  845PE Max (MS-6580)
+	24c5  82801DB AC'97 Audio Controller
+		1462 5800  845PE Max (MS-6580)
+	24c6  82801DB AC'97 Modem Controller
 	24c7  82801DB USB (Hub #3)
-	24cb  82801DB ICH4 IDE
-	24cd  82801DB USB EHCI Controller
+		1462 5800  845PE Max (MS-6580)
+	24ca  82801DBM Ultra ATA Storage Controller
+	24cb  82801DB Ultra ATA Storage Controller
+		1462 5800  845PE Max (MS-6580)
+	24cc  82801DBM LPC Interface Controller
+	24cd  82801DB USB2
+		1462 3981  845PE Max (MS-6580) Onboard USB EHCI Controller
+	24d0  82801EB LPC Interface Controller
+	24d1  82801EB Ultra ATA Storage Controller
+	24d2  82801EB USB
+	24d3  82801EB SMBus Controller
+	24d4  82801EB USB
+	24d5  82801EB AC'97 Audio Controller
+	24d6  82801EB AC'97 Modem Controller
+	24d7  82801EB USB
+	24db  82801EB Ultra ATA Storage Controller
+	24dc  82801EB LPC Interface Controller
+	24dd  82801EB USB2
+	24de  82801EB USB
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1028 0095  Precision Workstation 220 Chipset
 		1043 801c  P3C-2000 system chipset
@@ -6641,24 +7084,48 @@
 	2532  82850 850 (Tehama) Chipset AGP Bridge
 	2533  82860 860 (Wombat) Chipset AGP Bridge
 	2534  82860 860 (Wombat) Chipset PCI Bridge
-	2540  e7500 [Plumas] DRAM Controller
-	2541  e7500 [Plumas] DRAM Controller Error Reporting
-	2543  e7500 [Plumas] HI_B Virtual PCI Bridge (F0)
-	2544  e7500 [Plumas] HI_B Virtual PCI Bridge (F1)
-	2545  e7500 [Plumas] HI_C Virtual PCI Bridge (F0)
-	2546  e7500 [Plumas] HI_C Virtual PCI Bridge (F1)
-	2547  e7500 [Plumas] HI_D Virtual PCI Bridge (F0)
-	2548  e7500 [Plumas] HI_D Virtual PCI Bridge (F1)
+	2540  E7500 Memory Controller Hub
+		15d9 3480  P4DP6
+	2541  E7000 Series Host RASUM Controller
+		15d9 3480  P4DP6
+	2543  E7000 Series Hub Interface B PCI-to-PCI Bridge
+	2544  E7000 Series Hub Interface B RASUM Controller
+	2545  E7000 Series Hub Interface C PCI-to-PCI Bridge
+	2546  E7000 Series Hub Interface C RASUM Controller
+	2547  E7000 Series Hub Interface D PCI-to-PCI Bridge
+	2548  E7000 Series Hub Interface D RASUM Controller
+	254c  E7501 Memory Controller Hub
+	2550  E7505 Memory Controller Hub
+	2551  E7000 Series RAS Controller
+	2552  E7000 Series Processor to AGP Controller
+	2553  E7000 Series Hub Interface B PCI-to-PCI Bridge
+	2554  E7000 Series Hub Interface B PCI-to-PCI Bridge RAS Controller
+	255d  E7205 Memory Controller Hub
 	2560  82845G/GL [Brookdale-G] Chipset Host Bridge
+		1462 5800  845PE Max (MS-6580)
 	2561  82845G/GL [Brookdale-G] Chipset AGP Bridge
 	2562  82845G/GL [Brookdale-G] Chipset Integrated Graphics Device
+	2570  82865G/PE/P Processor to I/O Controller
+	2571  82865G/PE/P Processor to AGP Controller
+	2572  82865G Integrated Graphics Device
+	2573  82865G/PE/P Processor to PCI to CSA Bridge
+	2576  82864G/PE/P Processor to I/O Memory Interface
+	2578  82875P Memory Controller Hub
+	2579  82875P Processor to AGP Controller
+	257b  82875P Processor to PCI to CSA Bridge
+	257e  82875P Processor to I/O Memory Interface
 	3092  Integrated RAID
+	3340  82855PM Processor to I/O Controller
+	3341  82855PM Processor to AGP Controller
 	3575  82830 830 Chipset Host Bridge
-		1014 021d  ThinkPad T23 (2647-4MG) or A30p (2653-64G)
+		1014 021d  ThinkPad A/T/X Series
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
 	3576  82830 830 Chipset AGP Bridge
 	3577  82830 CGC [Chipset Graphics Controller]
+		1014 0513  ThinkPad A/T/X Series
 	3578  82830 830 Chipset Host Bridge
+	3580  82852/855GM Host Bridge
+	3582  82852/855GM Integrated Graphics Device
 	5200  EtherExpress PRO/100 Intelligent Server
 	5201  EtherExpress PRO/100 Intelligent Server
 		8086 0001  EtherExpress PRO/100 Server Ethernet Adapter
@@ -6674,6 +7141,7 @@
 	7113  82371AB/EB/MB PIIX4 ACPI
 	7120  82810 GMCH [Graphics Memory Controller Hub]
 	7121  82810 CGC [Chipset Graphics Controller]
+		8086 4341  Cayman (CA810) Mainboard
 	7122  82810 DC-100 GMCH [Graphics Memory Controller Hub]
 	7123  82810 DC-100 CGC [Chipset Graphics Controller]
 	7124  82810E DC-133 GMCH [Graphics Memory Controller Hub]
@@ -6685,6 +7153,7 @@
 	7181  440LX/EX - 82443LX/EX AGP bridge
 	7190  440BX/ZX/DX - 82443BX/ZX/DX Host bridge
 		0e11 0500  Armada 1750 Laptop System Chipset
+		0e11 b110  Armada M700
 		1179 0001  Toshiba Tecra 8100 Laptop System Chipset
 	7191  440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
 	7192  440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled)
@@ -6761,9 +7230,6 @@
 	5478  AIC-7850
 	5575  AVA-2930
 	5578  AIC-7855
-	5647  ANA-7711 TCP Offload Engine
-		9004 7710  ANA-7711F TCP Offload Engine - Optical
-		9004 7711  ANA-7711LP TCP Offload Engine - Copper
 	5675  AIC-755x
 	5678  AIC-7856
 	5775  AIC-755x
@@ -6805,6 +7271,8 @@
 	7478  AHA-2944/2944W / AIC-7874
 	7578  AHA-3944/3944W / AIC-7875
 	7678  AHA-4944W/UW / AIC-7876
+	7710  ANA-7711F Network Accelerator Card (NAC) - Optical
+	7711  ANA-7711C Network Accelerator Card (NAC) - Copper
 	7778  AIC-787x
 	7810  AIC-7810
 	7815  AIC-7815 RAID+Memory Controller IC
@@ -6881,6 +7349,8 @@
 		9005 62a1  19160 Ultra160 SCSI Controller
 	0083  AIC-7892D U160/m
 	008f  AIC-7892P U160/m
+		1179 0001  Magnia Z310
+		15d9 9005  Onboard SCSI Host Adapter
 	00c0  AHA-3960D / AIC-7899A U160/m
 		0e11 f620  Compaq 64-Bit/66MHz Dual Channel Wide Ultra3 SCSI Adapter
 		9005 f620  AHA-3960D U160/m
@@ -6890,6 +7360,8 @@
 		1028 00c5  PowerEdge 2550
 	00cf  AIC-7899P U160/m
 		1028 00d1  PowerEdge 2550
+		10f1 2462  Thunder K7 S2462
+		15d9 9005  Onboard SCSI Host Adapter
 	0250  ServeRAID Controller
 		1014 0279  ServeRAID-xx
 		1014 028c  ServeRAID-xx
@@ -6906,11 +7378,18 @@
 	8014  ASC-29320LP U320
 	801e  AIC-7901A U320
 	801f  AIC-7902 U320
+	8080  ASC-29320A U320 w/HostRAID
+	808f  AIC-7901 U320 w/HostRAID
 	8090  ASC-39320 U320 w/HostRAID
 	8091  ASC-39320D U320 w/HostRAID
 	8092  ASC-29320 U320 w/HostRAID
 	8093  ASC-29320B U320 w/HostRAID
 	8094  ASC-29320LP U320 w/HostRAID
+	8095  ASC-39320(B) U320 w/HostRAID
+	8096  ASC-39320A U320 w/HostRAID
+	8097  ASC-29320ALP U320 w/HostRAID
+	809c  ASC-39320D(B) U320 w/HostRAID
+	809d  AIC-7902(B) U320 w/HostRAID
 	809e  AIC-7901A U320 w/HostRAID
 	809f  AIC-7902 U320 w/HostRAID
 907f  Atronics
@@ -6953,7 +7432,7 @@
 e000  Winbond
 	e000  W89C940
 e159  Tiger Jet Network Inc.
-	0001  Model 300 128k [Catawba TJ]
+	0001  Intel 537
 		0059 0001  128k ISDN-S/T Adapter
 		0059 0003  128k ISDN-U Adapter
 	0002  Tiger100APC ISDN chipset
@@ -6999,7 +7478,9 @@
 	facd  KONA HD SMPTE 292M I/O
 fa57  Fast Search & Transfer ASA
 febd  Ultraview Corp.
-feda  Epigram Inc
+feda  Broadcom Inc (nee Epigram)
+	a0fa  BCM4210 iLine10 HomePNA 2.0
+	a10e  BCM4230 iLine10 HomePNA 2.0
 fffe  VMWare Inc
 	0710  Virtual SVGA
 ffff  Illegal Vendor ID

