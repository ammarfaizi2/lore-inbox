Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSJJNPq>; Thu, 10 Oct 2002 09:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJJNPq>; Thu, 10 Oct 2002 09:15:46 -0400
Received: from smtp0.adl1.internode.on.net ([203.16.214.194]:57616 "EHLO
	smtp0.adl1.internode.on.net") by vger.kernel.org with ESMTP
	id <S261330AbSJJNPn>; Thu, 10 Oct 2002 09:15:43 -0400
Message-ID: <001101c2705f$ef082e50$1a0da8c0@bert>
Reply-To: "Tom Lanyon" <toml@internode.on.net>
From: "Tom Lanyon" <toml@internode.on.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Conntrack/NAT bug
Date: Thu, 10 Oct 2002 22:51:25 +0930
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:   Some sort of coding problem in
conntrack.
[2.] Full description of the problem/report:
The following error pops up quite often in my console:
ASSERT ip_conntrack_core.c:94 &ip_conntrack_lock readlocked
ASSERT: ip_nat_core.c:841 &ip_conntrack_lock not readlocked
[3.]
[4.] Kernel version - 2.4.20-pre8-ac3
[5.]
[6.]
[7.] Environment
[7.1.] Software:
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         e100
[7.2.] Processor information:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 2017.996
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4023.91

[7.3.] Module information:
e100                   51576   1

[7.4.] Loaded driver and hardware information:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fef9fff : System RAM
  00100000-0023c353 : Kernel code
  0023c354-002a0817 : Kernel data
0fefa000-0fefcfff : ACPI Tables
0fefd000-0fefdfff : ACPI Non-volatile Storage
0fefe000-0fefffff : reserved
10000000-100003ff : Intel Corp. 82801DB ICH4 IDE
e6800000-e6800fff : Intel Corp. 82801BD PRO/100 VE (CNR) Ethernet Controller
  e6800000-e6800fff : e100
e7000000-e70003ff : Intel Corp. 82801DB USB EHCI Controller
e7800000-e787ffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated
Graphics Device
e8000000-efffffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated
Graphics Device
f0000000-f7ffffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown device 8093
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [0105]

00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562 (rev 01)
(prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 2562
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e7800000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if
00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if
00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 12
        Region 4: I/O ports at d400 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01) (prog-if
00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if
20)
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 3
        Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 81)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: e6800000-e6ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01) (prog-if 8a
[Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned> [size=8]
        Region 1: I/O ports at <unassigned> [size=4]
        Region 2: I/O ports at <unassigned> [size=8]
        Region 3: I/O ports at <unassigned> [size=4]
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

01:08.0 Ethernet controller: Intel Corp.: Unknown device 103a (rev 81)
        Subsystem: Asustek Computer, Inc.: Unknown device 8071
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b800 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information : None
[7.7.] Other information that might be relevant to the problem
[X.] Other notes, patches, fixes, workarounds:

Thanks for your help
Tom Lanyon
toml@internode.on.net


