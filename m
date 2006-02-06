Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWBFUkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWBFUkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWBFUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:40:35 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:61071 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S964804AbWBFUke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:40:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <17383.46125.907045.269882@fisica.ufpr.br>
Date: Mon, 6 Feb 2006 18:40:13 -0200
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
In-Reply-To: <43E7700F.6080702@t-online.de>
References: <43E70BE3.1080805@t-online.de>
	<17383.24476.747110.629245@fisica.ufpr.br>
	<43E7700F.6080702@t-online.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen (Knut_Petersen@t-online.de) wrote on 6 February 2006 16:49:
 >>Yes, this works fine. The kernel gets it from pxelinux directly via
 >>option IPAPPEND.
 >>
 >>Here's what I copied manually from the screen after the IP-Config:
 >>line:
 >>
 >>  
 >>
 >That was not what I asked. Please test without ipappend
 >and use ip=dhcp as a kernel parameter instead. Don´t forget
 >to enable dhcp autoconfiguration in the kernel config ...

Ops, sorry.

 >I bet that you will see that the same dhcp server that proved to
 >work correctly by providing your server ip etc to the
 >pxe bootrom and via ipappend to the kernel is unable to
 >give that same information to the linux ipconfig code
 >directly. Please try and report.

Exactly. In fact it tried several times and ended up getting the
config. The dhcp log shows many trials. Apparently the server gets the
request but the client doesn't get the answer.

 >I assume that you do not have any problem to pxeboot good
 >old DOS and memtest. Right?

I only used linux with these machines but never had this problem
before. It even happens with 2.4

 >Please give board name, bios version, pxe rom version, and
 >lspci -vv.

Tyan 2466, phoenix bios 4.0 release 6.0, Intel boot agent version 1.0.15.
Here's the output of lspci -vv

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Region 1: Memory at fea00000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1030 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet Controller (Co
pper) (rev 02)
        Subsystem: Intel Corp. PRO/1000 XT Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fe620000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at fe600000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 1000 [size=32]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] #07 [0002]
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable
-
                Address: 0000000000000000  Data: 0000

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (pr
og-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fe700000-fe7fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at fe700000 (32-bit, non-prefetchable) [size=4K]

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: Tyan Computer Tiger MPX S2466 (3C920 Integrated Fast Ethernet Controller)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 2000 [size=128]
        Region 1: Memory at fe701000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

>If I am right with my bet the problem is unrelated to the tcp / udp
 >choice and unrelated to ipconfig, portmap lookup and nfsroot code.

Exactly, that's why I talked about the driver directly in my first
post.
