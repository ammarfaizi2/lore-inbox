Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTASPEB>; Sun, 19 Jan 2003 10:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbTASPEB>; Sun, 19 Jan 2003 10:04:01 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:682 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267503AbTASPDt>; Sun, 19 Jan 2003 10:03:49 -0500
Date: Sun, 19 Jan 2003 10:12:48 -0500
From: Mace Moneta <mace@monetafamily.org>
Subject: [Problem] PCI resource conflicts in recent 2.4 kernels
To: linux-kernel@vger.kernel.org
Reply-to: mmoneta@optonline.net
Message-id: <1042989167.7294.31.camel@optonline.net>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running Redhat 8.0 on a docked Toshiba Tecra 730CDT (Pentium 150MHz,
80MB RAM), and recently tried to upgrade my kernel to one of their
errata kernels.  When I did, I got PCI resource conflicts, and the SCSI
devices are unable to initialize.  Partitions are not mounted, so the
boot fails.  I confirmed that the problem also occurs with the latest
(2.4.21-pre3) vanilla kernel.  Originally reported to Redhat:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=76159

I was unable to find any similar report via google searches, but there
are a couple of recent similar reports in the Redhat buzilla (bugs 78035
and 76428).

===================
Last Working kernel
===================

2.4.18-14 (Redhat)

===========
Failed boot
===========

Following copied by hand:

PCI: Cannot allocate resource region 0 of device 01:04.0
PCI: Cannot allocate resource region 0 of device 01:08.0
PCI: Cannot allocate resource region 0 of device 01:0c.0
PCI: Cannot allocate resource region 1 of device 01:0c.0
PCI: Failed to allocate resource 0(0-fff) for 01:01.0
PCI: Failed to allocate resource 0(0-fff) for 01:01.1
PCI: Failed to allocate resource 0(0-7f) for 01:04.0
PCI: Failed to allocate resource 0(0-7) for 01:08.0
PCI: Failed to allocate resource 0(0-ff) for 01:0c.0
PCI: Failed to allocate resource 1(0-fff) for 01:0c.0
Loading aic7xxx module
PCI: Device 01:08.0 not available because of resource collisions
PCI: Device 01:0c.0 not available because of resource collisions
/lib/aic7xxx.o init_module
Error: /bin/insmod exited abnormally!
Loading tmscsim module
PCI: Device 01:04.0 not available because of resource collisions
/lib/tmscsim.o init_module
Error: /bin/insmod exited abnormally!

====================
Normal boot messages
====================

PCI: PCI BIOS revision 2.10 entry at 0xfd4ae, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent

===========================================
lspci -vvv on the (good) 2.4.18-14 kernel
===========================================

00:00.0 Host bridge: Toshiba America Info Systems 601 (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0, cache line size 08

00:02.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
        Memory window 0: 00000000-00000000 [disabled]
        Memory window 1: 00000000-00000000 [disabled]
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

00:02.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
        Memory window 0: 00000000-00000000 [disabled]
        Memory window 1: 00000000-00000000 [disabled]
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

00:03.0 ISA bridge: Toshiba America Info Systems: Unknown device 0606 (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:04.0 VGA compatible controller: Chips and Technologies F65550 (rev 05)
(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fe000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:06.0 PCI bridge: Toshiba America Info Systems: Unknown device 0605 (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=13, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

01:01.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to CardBus
Bridge for Notebooks (rev 04)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Region 0: Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=12, subordinate=12, sec-latency=0
        Memory window 0: 00000000-00000000
        Memory window 1: 00000000-00000000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

01:01.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to CardBus
Bridge for Notebooks (rev 04)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Region 0: Memory at 10003000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=13, subordinate=13, sec-latency=0
        Memory window 0: 00000000-00000000
        Memory window 1: 00000000-00000000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

01:04.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi]
(rev 10)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping+ SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ff80 [size=128]

01:08.0 Serial controller: Siig Inc CyberSerial (1-port) 16550 (prog-if 02 [16550])
        Subsystem: Siig Inc CyberSerial (1-port) 16550
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ff78 [size=8]
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at fe00 [disabled] [size=256]
        Region 1: Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fdfe0000 [disabled] [size=64K]

========================================================
lspci -vvv on a bad kernel (first seen on 2.4.18-17.8.0)
========================================================

00:00.0 Class 0600: 1179:0601 (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0, cache line size 08

00:02.0 Class 0607: 1179:060a (rev 07)
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
        Memory window 0: 00000000-00000000 [disabled]
        Memory window 1: 00000000-00000000 [disabled]
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

00:02.1 Class 0607: 1179:060a (rev 07)
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
        Memory window 0: 00000000-00000000 [disabled]
        Memory window 1: 00000000-00000000 [disabled]
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
00:03.0 Class 0601: 1179:0606 (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:04.0 Class 0300: 102c:00e0 (rev 05)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fe000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:06.0 Class 0604: 1179:0605 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=13, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

01:01.0 Class 0607: 1179:0603 (rev 04)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=12, subordinate=12, sec-latency=0
        Memory window 0: 00000000-00000000
        Memory window 1: 00000000-00000000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

01:01.1 Class 0607: 1179:0603 (rev 04)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=13, subordinate=13, sec-latency=0
        Memory window 0: 00000000-00000000
        Memory window 1: 00000000-00000000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-

01:04.0 Class 0100: 1022:2020 (rev 10)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored> [size=128]

01:08.0 Class 0700: 131f:2000 (prog-if 02)
        Subsystem: 131f:2000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored> [size=8]
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 Class 0100: 9004:8178
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored> [size=256]
        Region 1: Memory at <ignored> (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fdfe0000 [disabled] [size=64K]


=====
lsmod
=====

Module                  Size  Used by    Not tainted
smbfs                  39264   1  (autoclean)
ide-cd                 31432   0  (autoclean)
cdrom                  30976   0  (autoclean) [ide-cd]
mousedev                5236   1  (autoclean)
input                   5664   0  (autoclean) [mousedev]
parport_pc             17604   1  (autoclean)
lp                      8612   0  (autoclean)
parport                33984   1  (autoclean) [parport_pc lp]
ne                      7696   1
8390                    7788   0  [ne]
ipt_REJECT              3448   2  (autoclean)
iptable_filter          2316   1  (autoclean)
ip_tables              14456   2  [ipt_REJECT iptable_filter]
cs4232                  5092   0
ad1848                 26124   0  [cs4232]
uart401                 8068   0  [cs4232]
sound                  70196   0  [cs4232 ad1848 uart401]
soundcore               6180   5  [sound]
ext3                   64224   8
jbd                    48180   8  [ext3]
tmscsim                33856   1
aic7xxx               127380   2
sd_mod                 13136   6
scsi_mod              102152   3  [tmscsim aic7xxx sd_mod]


