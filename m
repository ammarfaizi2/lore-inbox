Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUHSNd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUHSNd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUHSNd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:33:27 -0400
Received: from math.ut.ee ([193.40.5.125]:52958 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266117AbUHSNdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:33:16 -0400
Date: Thu, 19 Aug 2004 16:33:14 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: PCI problem on PPC PReP (Motorola Powerstack II)
Message-ID: <Pine.GSO.4.44.0408191624240.15736-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I and a couple other users of Motorola Powerstack II are suffering from
PCI NIC hangs (tulip and 3com tested, driver loads fine but hangs on
ifconfig up) with 2.6 kernels. Now that I got the machine to boot 2.6
again, I did have a look at it. The PCI configuration that is discovered
is completely different in 2.4 and 2.6. 2.6 finds also the host bridge
that 2.4 doesn't see. Device numbers and interrupts are different.

Below is the config diff (oldpci is from 2.4, newpci is from 2.6). Any
ideas?

This is a excerpt from 2.4 dmesg:

PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: moved device 00:0b.1 resource 4 (101) to 1480
PCI: moved device 00:0b.1 resource 5 (101) to 1490

And this is correspondign 2.6 dmesg chunk:

PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: Cannot allocate resource region 5 of device 0000:00:01.1


--- oldlspci	2004-08-19 15:43:59.000000000 +0300
+++ newlspci	2004-08-19 16:23:52.000000000 +0300
@@ -1,4 +1,13 @@
-0000:00:0b.0 ISA bridge: Symphony Labs W83C553 (rev 10)
+0000:00:00.0 Host bridge: IBM: Unknown device 0037 (rev 02)
+	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
+	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
+	Latency: 0
+00: 14 10 37 00 06 01 00 02 02 00 00 06 00 00 00 00
+10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+
+0000:00:01.0 ISA bridge: Symphony Labs W83C553 (rev 10)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
@@ -7,7 +16,7 @@
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-0000:00:0b.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
+0000:00:01.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 0
@@ -15,40 +24,39 @@
 	Region 1: I/O ports at 03f4 [disabled] [size=4]
 	Region 2: I/O ports at 0170 [disabled] [size=8]
 	Region 3: I/O ports at 0374 [disabled] [size=4]
-	Region 4: I/O ports at 1480 [disabled] [size=16]
-	Region 5: I/O ports at 1490 [disabled] [size=16]
+	Region 4: I/O ports at <unassigned> [disabled] [size=16]
+	Region 5: I/O ports at 1480 [disabled] [size=16]
 00: ad 10 05 01 00 00 80 02 05 8f 01 01 08 00 80 00
 10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
-20: 81 14 00 00 91 14 00 00 00 00 00 00 00 00 00 00
+20: 01 00 00 00 81 14 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 02 28

-0000:00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
-	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
+0000:00:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
-	Latency: 0 (4250ns min, 16000ns max)
+	Latency: 0 (4250ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin A routed to IRQ 15
 	Region 0: I/O ports at 1000 [size=256]
 	Region 1: Memory at c2008000 (32-bit, non-prefetchable) [size=256]
 	Region 2: Memory at c2009000 (32-bit, non-prefetchable) [size=4K]
-00: 00 10 03 00 47 00 00 02 13 00 00 01 00 00 00 00
+00: 00 10 03 00 17 00 00 02 13 00 00 01 08 00 00 00
 10: 01 10 00 00 00 80 00 02 00 90 00 02 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 11 40

-0000:00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
-	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
+0000:00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
+	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
-	Latency: 0 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
-	Interrupt: pin A routed to IRQ 11
-	Region 0: I/O ports at 1400 [size=128]
-	Region 1: Memory at c200a000 (32-bit, non-prefetchable) [size=128]
+	Interrupt: pin A routed to IRQ 9
+	Region 0: I/O ports at 1400 [disabled] [size=128]
+	Region 1: Memory at c200a000 (32-bit, non-prefetchable) [disabled] [size=128]
 	Expansion ROM at c1040000 [disabled] [size=256K]
-00: 11 10 09 00 17 00 80 02 22 00 00 02 08 00 00 00
+00: 11 10 09 00 00 00 80 02 22 00 00 02 00 00 00 00
 10: 01 14 00 00 00 a0 00 02 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 04 01 00 00 00 00 00 00 00 00 0b 01 14 28

-0000:00:12.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
+0000:00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin ? routed to IRQ 15

=======================================================================

This is old PCI config:
0000:00:0b.0 ISA bridge: Symphony Labs W83C553 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: ad 10 65 05 07 00 00 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0b.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [disabled] [size=8]
	Region 1: I/O ports at 03f4 [disabled] [size=4]
	Region 2: I/O ports at 0170 [disabled] [size=8]
	Region 3: I/O ports at 0374 [disabled] [size=4]
	Region 4: I/O ports at 1480 [disabled] [size=16]
	Region 5: I/O ports at 1490 [disabled] [size=16]
00: ad 10 05 01 00 00 80 02 05 8f 01 01 08 00 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 81 14 00 00 91 14 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 02 28

0000:00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (4250ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at c2008000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at c2009000 (32-bit, non-prefetchable) [size=4K]
00: 00 10 03 00 47 00 00 02 13 00 00 01 00 00 00 00
10: 01 10 00 00 00 80 00 02 00 90 00 02 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 11 40

0000:00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=128]
	Region 1: Memory at c200a000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at c1040000 [disabled] [size=256K]
00: 11 10 09 00 17 00 80 02 22 00 00 02 08 00 00 00
10: 01 14 00 00 00 a0 00 02 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 04 01 00 00 00 00 00 00 00 00 0b 01 14 28

0000:00:12.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 15
	Region 0: Memory at c1000000 (32-bit, prefetchable) [disabled] [size=16M]
	Expansion ROM at c2000000 [disabled] [size=32K]
00: 13 10 b8 00 00 00 00 02 00 00 00 03 00 00 00 00
10: 08 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00

=======================================================================

And this in new:
0000:00:00.0 Host bridge: IBM: Unknown device 0037 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 14 10 37 00 06 01 00 02 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 ISA bridge: Symphony Labs W83C553 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: ad 10 65 05 07 00 00 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [disabled] [size=8]
	Region 1: I/O ports at 03f4 [disabled] [size=4]
	Region 2: I/O ports at 0170 [disabled] [size=8]
	Region 3: I/O ports at 0374 [disabled] [size=4]
	Region 4: I/O ports at <unassigned> [disabled] [size=16]
	Region 5: I/O ports at 1480 [disabled] [size=16]
00: ad 10 05 01 00 00 80 02 05 8f 01 01 08 00 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 00 00 00 81 14 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 02 28

0000:00:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (4250ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at c2008000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at c2009000 (32-bit, non-prefetchable) [size=4K]
00: 00 10 03 00 17 00 00 02 13 00 00 01 08 00 00 00
10: 01 10 00 00 00 80 00 02 00 90 00 02 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 11 40

0000:00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1400 [disabled] [size=128]
	Region 1: Memory at c200a000 (32-bit, non-prefetchable) [disabled] [size=128]
	Expansion ROM at c1040000 [disabled] [size=256K]
00: 11 10 09 00 00 00 80 02 22 00 00 02 00 00 00 00
10: 01 14 00 00 00 a0 00 02 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 04 01 00 00 00 00 00 00 00 00 0b 01 14 28

0000:00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 15
	Region 0: Memory at c1000000 (32-bit, prefetchable) [disabled] [size=16M]
	Expansion ROM at c2000000 [disabled] [size=32K]
00: 13 10 b8 00 00 00 00 02 00 00 00 03 00 00 00 00
10: 08 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00


-- 
Meelis Roos (mroos@linux.ee)


