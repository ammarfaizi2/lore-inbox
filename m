Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSHGXcd>; Wed, 7 Aug 2002 19:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSHGXcd>; Wed, 7 Aug 2002 19:32:33 -0400
Received: from telus-2.cdlsystems.com ([142.179.183.92]:2291 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S316437AbSHGXca>;
	Wed, 7 Aug 2002 19:32:30 -0400
Message-ID: <048001c23e6b$20e1ffe0$2c0e10ac@frinkiac7>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208080050300.7410-100000@localhost.localdomain> <1028762508.1992.309.camel@ldb>
Subject: DMA Problems with Intel 845 Chipset and Northwood CPU
Date: Wed, 7 Aug 2002 17:35:35 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Please accept my apologies if this question has already been answered....

I have a new Pentium 4 computer and I can't get the DMA working for hard
disk transfers.  Specifically, its a Dell Dimension 4500 with a Pentium 4
2.26 GHz processor (Northwood) and an 845 (Brookdale) chipset.  RedHat
7.3....

I noticed that the hard disk transfers were very slow.  I tried to set up
DMA with hdparm - see below:

[root@yoda ide]# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4866/255/63, sectors = 78177792, start = 0
 busstate     =  1 (on)
[root@yoda ide]# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)
[root@yoda ide]#

I thought that perhaps the chipset had changed between this Northwood
machine an the older core - I have a P4 1.8 GHz machine that DMA works fine
on.  I upgraded to kernel 2.4.19 with no change.

The IDE controller (according to Windows XP....) is an Intel 82801DB Ultra
ATA Storage Controller - 24CB.  I've included the lspci --vvx listing from
the problem machine below - my aplogies for the long list.  If anyone has
any suggestions I'd really appreciate them...

Thanks....

Mark

lspci listing:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
(rev 11)
 Subsystem: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
 Latency: 0
 Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
 Capabilities: [e4] #09 [a104]
 Capabilities: [a0] AGP version 2.0
  Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
  Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>
00: 86 80 30 1a 06 01 90 20 11 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 30 1a
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 11) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
 Memory behind bridge: fc700000-fe7fffff
 Prefetchable memory behind bridge: dc300000-ec4fffff
 BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 86 80 31 1a 07 01 a0 00 11 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 f0 00 a0 22
20: 70 fc 70 fe 30 dc 40 ec 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if
00 [UHCI])
 Subsystem: Dell Computer Corporation: Unknown device 0132
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin A routed to IRQ 11
 Region 4: I/O ports at e800 [size=32]
00: 86 80 c2 24 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 28 10 32 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if
00 [UHCI])
 Subsystem: Dell Computer Corporation: Unknown device 0132
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin B routed to IRQ 5
 Region 4: I/O ports at e880 [size=32]
00: 86 80 c4 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 e8 00 00 00 00 00 00 00 00 00 00 28 10 32 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01) (prog-if
00 [UHCI])
 Subsystem: Dell Computer Corporation: Unknown device 0132
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin C routed to IRQ 9
 Region 4: I/O ports at ec00 [size=32]
00: 86 80 c7 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ec 00 00 00 00 00 00 00 00 00 00 28 10 32 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 03 00 00

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if
20 [EHCI])
 Subsystem: Dell Computer Corporation: Unknown device 0132
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin D routed to IRQ 10
 Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 Capabilities: [58] #0a [2080]
00: 86 80 cd 24 06 01 90 02 01 20 03 0c 00 00 00 00
10: 00 fc bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 32 01
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81) (prog-if 00
[Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
 Latency: 0
 Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
 I/O behind bridge: 0000d000-0000dfff
 Memory behind bridge: fe800000-feafffff
 Prefetchable memory behind bridge: ec500000-ec5fffff
 BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 4e 24 07 01 80 80 81 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 d0 d0 80 22
20: 80 fe a0 fe 50 ec 50 ec 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
00: 86 80 c0 24 0f 01 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01) (prog-if 8a
[Master SecP PriP])
 Subsystem: Dell Computer Corporation: Unknown device 0132
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin A routed to IRQ 9
 Region 0: I/O ports at <unassigned> [size=8]
 Region 1: I/O ports at <unassigned> [size=4]
 Region 2: I/O ports at <unassigned> [size=8]
 Region 3: I/O ports at <unassigned> [size=4]
 Region 4: I/O ports at ffa0 [size=16]
 Region 5: Memory at 20000000 (32-bit, non-prefetchable) [disabled]
[size=1K]
00: 86 80 cb 24 05 00 80 02 01 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 ff 00 00 00 00 00 20 00 00 00 00 28 10 32 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
 Subsystem: Dell Computer Corporation: Unknown device 0132
 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Interrupt: pin B routed to IRQ 3
 Region 4: I/O ports at e480 [size=32]
00: 86 80 c3 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 e4 00 00 00 00 00 00 00 00 00 00 28 10 32 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 00

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200]
(rev a3) (prog-if 00 [VGA])
 Subsystem: nVidia Corporation: Unknown device 0132
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 248 (1250ns min, 250ns max)
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
 Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
 Region 2: Memory at ec480000 (32-bit, prefetchable) [size=512K]
 Expansion ROM at fe7e0000 [disabled] [size=128K]
 Capabilities: [60] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 Capabilities: [44] AGP version 2.0
  Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
  Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>
00: de 10 53 02 07 00 b0 02 a3 00 00 03 00 f8 00 00
10: 00 00 00 fd 08 00 00 e0 08 00 48 ec 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 32 01
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 05 01

02:00.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
10)
 Subsystem: Intel Corp.: Unknown device 0071
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64 (2000ns min, 14000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
 Region 1: I/O ports at dc00 [size=64]
 Region 2: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
 Expansion ROM at feae0000 [disabled] [size=64K]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 01 90 02 10 00 00 02 08 40 00 00
10: 00 f0 af fe 01 dc 00 00 00 00 ac fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 71 00
30: 00 00 ae fe dc 00 00 00 00 00 00 00 0b 01 08 38

02:02.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
 Subsystem: Voyetra Technologies: Unknown device 3357
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64 (1000ns min, 6000ns max)
 Interrupt: pin A routed to IRQ 9
 Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
 Region 1: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
 Capabilities: [40] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 13 10 03 60 06 01 10 04 01 00 01 04 00 40 00 00
10: 00 d0 af fe 00 00 90 fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 53 50 57 33
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 04 18


