Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290779AbSAaAr5>; Wed, 30 Jan 2002 19:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290782AbSAaArs>; Wed, 30 Jan 2002 19:47:48 -0500
Received: from alb-66-24-180-102.nycap.rr.com ([66.24.180.102]:11718 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S290779AbSAaArf>; Wed, 30 Jan 2002 19:47:35 -0500
Date: Wed, 30 Jan 2002 19:47:33 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: tulip woes
Message-ID: <20020131004733.GA25163@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux incandescent 2.4.10-ac12 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

w/ 2.4.18-pre7-ac1, I get the following:


Jan 30 07:43:47 pinky kernel: Linux Tulip driver version 0.9.15-pre9
(Nov 6, 2001)
Jan 30 07:43:47 pinky kernel: PCI: Found IRQ 11 for device 00:08.0
Jan 30 07:43:47 pinky kernel: 00:08.0: PCI cache line size set
incorrectly (32 bytes) by BIOS/FW, correcting to 64 
Jan 30 07:43:47 pinky kernel: eth0: Lite-On PNIC-II rev 37 at
0xe0836000, 00:A0:CC:33:0D:FA, IRQ 11.
Jan 30 07:43:47 pinky kernel: eth0: Autonegotiation failed, using
10baseT, link
beat status 10cc.
Jan 30 07:44:10 pinky kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 30 07:44:10 pinky kernel: eth0: PNIC2 transmit timed out, status
e4260000, CSR6/7 e0402002 / effffbff CSR12 000000c8, resetting...
Jan 30 07:44:18 pinky kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 30 07:44:18 pinky kernel: eth0: PNIC2 transmit timed out, status
e4260000, CSR6/7 e0402002 / effffbff CSR12 000000c8, resetting...


The nic is connected to a 100mbit hub, hence the autonegotion defaulting
to 10baseT makes it pretty useless.  It works fine w/ 2.4.10-ac12's
tulip driver.  I also tried the tulip-1.1.8 driver from the tulip
sourceforge page, as well as compiling 2.4.18-pre7-ac1's tulip driver w/out
CONFIG_TULIP_MWI and CONFIG_TULIP_MMIO; they all had autonegotiation
fail.  

Output from lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at d000 [size=16]
        Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]
        Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
        Subsystem: VIA Technologies, Inc.: Unknown device 7911
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=4]
        Capabilities: <available only to root>

00:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX
[Linksys EtherFast 10/100] (rev 25)
        Subsystem: Lite-On Communications Inc: Unknown device c001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at df000000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon QD
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at dd000000 (32-bit, non-prefetchable)
[size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>



Let me know if you need any more info..

-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>
