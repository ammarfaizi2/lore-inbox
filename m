Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbULRAWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbULRAWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbULRAWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:22:23 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:39306 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262246AbULRAQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:16:55 -0500
Date: Sat, 18 Dec 2004 01:16:43 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: strange problems with IRQ and coldplug under Acer Aspire 1524WLMi
Message-ID: <Pine.LNX.4.60.0412180055250.3536@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry if this is 100000 post about this, but I found nothing similar 
enought while googling.

Also sorry if you are not the right person to ask. Please forward this 
message to someone who should read it. Thanks.

[ I am using 2.6.10-rc3-mm1 currently. ]

I have Acer Aspire 1524WLMi and have the following problems with it (fresh 
Gentoo amd64 2004.3.1 install):

1. kernel started without noapic is sending my Realtek gigabit network 
card to >100 IRQ (something like 168 IIRC)

2. there seems to be 3 things on IRQ11 (with noapic): yenta, usb2.0, 
realtek. Untill removing yenta and usb2.0 module from /lib/modules I was 
getting IRQ disabled message while coldplug run (and /proc/interrupts 
showed 10000 or so of IRQ11). After removing of those files everyting (but 
yenta and usb2.0) is working fine. And I suspect usb2.0 here - since after 
removing only yenta module nothing changed.


Here is my configuration:

krzys ~ # lspci -vvvv
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0204
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8
         Region 0: Memory at d0000000 (32-bit, prefetchable)
         Capabilities: [80] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [60] #08 [0060]
         Capabilities: [58] #08 [8001]

0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1204
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2204
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:00.3 Host bridge: VIA Technologies, Inc. K8M800
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4204
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:00.7 Host bridge: VIA Technologies, Inc. K8M800
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 
South] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: c1000000-c1ffffff
         Prefetchable memory behind bridge: e0000000-efffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 Ethernet controller: Linksys, A Division of Cisco Systems 
[AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01)
         Subsystem: AMBIT Microsystem Corp.: Unknown device 0305
         Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 1c00
         Region 1: Memory at c0006000 (32-bit, non-prefetchable) [size=32]
         Region 2: Memory at c0005000 (32-bit, non-prefetchable) [size=2K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at 20000000 (32-bit, non-prefetchable)
         Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
         Memory window 0: 00000000-00000000 (prefetchable)
         Memory window 1: 00000000-00000000 (prefetchable)
         I/O window 0: 00000000-00000003
         I/O window 1: 00000000-00000003
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite-
         16-bit legacy interface ports at 0001

0000:00:0b.1 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled]
         Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
         Memory window 0: 00000000-00000000 [disabled] (prefetchable)
         Memory window 1: 00000000-00000000 [disabled] (prefetchable)
         I/O window 0: 00000000-00000003 [disabled]
         I/O window 1: 00000000-00000003 [disabled]
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite-
         16-bit legacy interface ports at 0001

0000:00:0b.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 
OHCI Two-Port PHY/Link-Layer Controller (prog-if 10 [OHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 1000ns max), cache line size 10
         Interrupt: pin C routed to IRQ 10
         Region 0: Memory at c0005800 (32-bit, non-prefetchable)
         Region 1: Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns min, 16000ns max), cache line size 10
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 1000
         Region 1: Memory at c0006400 (32-bit, non-prefetchable) [size=256]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at 1c20 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin B routed to IRQ 0
         Region 4: I/O ports at 1c40 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin C routed to IRQ 0
         Region 4: I/O ports at 1c60 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) 
(prog-if 20 [EHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin D routed to IRQ 0
         Region 0: Memory at c0006800 (32-bit, non-prefetchable)
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
         Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 11
         Region 4: I/O ports at 1c80 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
         Subsystem: Acer Incorporated [ALI]: Unknown device 0046
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 9
         Region 0: I/O ports at 1400
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem 
Controller (rev 80)
         Subsystem: Acer Incorporated [ALI]: Unknown device 0046
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 11
         Region 0: I/O ports at 1800
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 
[Athlon64/Opteron] HyperTransport Technology Configuration
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 
[Athlon64/Opteron] Address Map
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 
[Athlon64/Opteron] DRAM Controller
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 
[Athlon64/Opteron] Miscellaneous Control
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV36 [GeForce 
FX Go5700] (rev a1) (prog-if 00 [VGA])
         Subsystem: Acer Incorporated [ALI]: Unknown device 006e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at c1000000 (32-bit, non-prefetchable)
         Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>


krzys ~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3400+
stepping        : 10
cpu MHz         : 2201.309
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm 3dnowext 
3dnow
bogomips        : 4341.76
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


krzys ~ # cat /proc/meminfo
MemTotal:       509960 kB
MemFree:        269964 kB
Buffers:         23556 kB
Cached:         126492 kB
SwapCached:          0 kB
Active:         103608 kB
Inactive:        77492 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       509960 kB
LowFree:        269964 kB
SwapTotal:     3927852 kB
SwapFree:      3927852 kB
Dirty:            4064 kB
Writeback:           0 kB
Mapped:          38908 kB
Slab:            51736 kB
CommitLimit:   4182832 kB
Committed_AS:    48992 kB
PageTables:        928 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      3532 kB
VmallocChunk: 34359734835 kB


krzys ~ # uname -a
Linux krzys 2.6.10-rc3-mm1 #2 Sat Dec 18 00:02:53 CET 2004 x86_64 AMD 
Athlon(tm) 64 Processor 3400+ AuthenticAMD GNU/Linux


krzys ~ # cat /proc/version
Linux version 2.6.10-rc3-mm1 (root@krzys) (gcc version 3.4.3 (Gentoo Linux 
3.4.3, ssp-3.4.3-0, pie-8.7.6.6)) #2 Sat Dec 18 00:02:53 CET 2004


krzys ~ # emerge info
Portage 2.0.51-r8 (default-linux/amd64/2004.3, gcc-3.4.3, 
glibc-2.3.4.20040808-r1, 2.6.10-rc3-mm1 x86_64)
=================================================================
System uname: 2.6.10-rc3-mm1 x86_64 AMD Athlon(tm) 64 Processor 3400+
Gentoo Base System version 1.4.16
Python:              dev-lang/python-2.3.4 [2.3.4 (#1, Dec 17 2004, 
18:19:04)]
dev-lang/python:     2.3.4
sys-devel/autoconf:  2.59-r5
sys-devel/automake:  1.8.5-r1
sys-devel/binutils:  2.15.90.0.1.1-r3
sys-devel/libtool:   1.5.2-r7
virtual/os-headers:  2.6.8.1-r1
ACCEPT_KEYWORDS="amd64 ~amd64"
AUTOCLEAN="yes"
CFLAGS="-O2 -O3 -Os -march=athlon64 -mtune=athlon64 -fomit-frame-pointer 
-fweb -frename-registers -freorder-blocks -ftracer -funit-at-a-time 
-fforce-addr -pipe"
CHOST="x86_64-pc-linux-gnu"
CONFIG_PROTECT="/etc /usr/kde/2/share/config /usr/kde/3/share/config 
/usr/share/config /var/qmail/control"
CONFIG_PROTECT_MASK="/etc/gconf /etc/terminfo /etc/env.d"
CXXFLAGS="-O2 -O3 -Os -march=athlon64 -mtune=athlon64 -fomit-frame-pointer 
-fweb -frename-registers -freorder-blocks -ftracer -funit-at-a-time 
-fforce-addr -pipe"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoaddcvs autoconfig ccache distlocks nostrip sandbox sfperms"
GENTOO_MIRRORS="ftp://sunsite.informatik.rwth-aachen.de/pub/Linux/gentoo 
http://trumpetti.atm.tut.fi/gentoo/ http://www.gigaload.org/gentoo.org/ 
http://gentoo.mirror.sdv.fr http://gentoo.tiscali.nl/gentoo/"
MAKEOPTS="-j1"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY="/usr/local/portage"
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="amd64 X aalib accessibility acl acpi activefilter alsa artworkextra 
atm audiofile bcmath berkdb bitmap-fonts bluetooth bmp bzlib calendar 
cdparanoia cdr crypt cscope ctype curl curlwrappers dba dga dhcp dio 
directfb doc dvd dvdr dvdread edl erandom f77 fbcon flac fortran freetts 
ftp gcj gd gdbm ggi gif gimpprint gmp gnokii gnutls gphoto2 gpm gstreamer 
gtk guile hal howl imap inifile innodb irda jack jack-tmpfs java 
javascript jbig jce jms joystick jp2 jpeg jpeg2k justify jython kadu-voice 
lcms libcaca live lzo lzw lzw-tiff matroska md5sum mhash mime ming mmap 
mng mozcalendar mozdevelop mozilla mozsvg mozxmlterm multilib mysql mythtv 
nas ncurses network nls no-old-linux nptl nvidia objc opengl oss pam pcntl 
pcre perl php pic png posix postgres povray python qt quicktime readline 
real rhino rtc ruby samba scanner session shared sharedmem simplexml sms 
sndfile soap sockets socks5 softmmu speex sqlite ssl svg sysvipc tcltk 
tcpd tetex tga theora tiff tokenizer truetype unicode usb v4l2 wmf xanim 
xinerama xml xml2 xmlrpc xpm xprint xrandr xscreensaver xsl xv xvid xvmc 
zlib"


krzys ~ # cat /usr/src/linux/.config | grep -v "is not set"
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc3-mm1
# Sat Dec 18 00:02:23 2004
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y

#
# Power management options
#
CONFIG_PM=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BLACKLIST_YEAR=2001
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=m

#
# shared options
#

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_UNORDERED_IO=y
CONFIG_PCI_MSI=y

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Performance-monitoring counters support
#
CONFIG_PERFCTR=y
CONFIG_PERFCTR_VIRTUAL=y
CONFIG_PERFCTR_INTERRUPT_SUPPORT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=32

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=m
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

#
# SCSI device support
#

#
# Multi-device support (RAID and LVM)
#

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C
#
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_TCPDIAG=y

#
# IP: Virtual Server Configuration
#
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_IPTABLES=m

#
# Bridge: Netfilter Configuration
#

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_BRIDGE=m

#
# QoS and/or fair queueing
#

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m

#
# IrDA options
#

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#

#
# Ethernet (10 or 100Mbit)
#
CONFIG_MII=m

#
# Ethernet (1000 Mbit)
#
CONFIG_R8169=m
CONFIG_R8169_NAPI=y

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#

#
# Wireless LAN (non-hamradio)
#

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m

#
# Wan interfaces
#

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=y

#
# ISDN subsystem
#

#
# Telephony Support
#

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=800
CONFIG_INPUT_EVDEV=m

#
# Input I/O drivers
#
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m

#
# IPMI
#

#
# Watchdog Cards
#
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y

#
# PCMCIA character devices
#
CONFIG_MWAVE=m
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#

#
# Dallas's 1-wire bus
#

#
# Misc devices
#

#
# Multimedia devices
#

#
# Digital Video Broadcasting Devices
#

#
# Graphics support
#
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_BIT32_EMUL=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_VIRMIDI=m

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_VIA82XX=m

#
# USB devices
#

#
# PCMCIA devices
#

#
# Open Sound System
#

#
# USB support
#
CONFIG_USB=m

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y

#
# USB Device Class drivers
#

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be 
needed; see USB_STORAGE Help for more information
#

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#

#
# USB Imaging devices
#

#
# USB Multimedia devices
#

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#

#
# USB port drivers
#

#
# USB Serial Converter support
#

#
# USB Miscellaneous drivers
#

#
# USB ATM/DSL drivers
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m

#
# USB Gadget Support
#

#
# Firmware Drivers
#
CONFIG_EDD=m

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=y
CONFIG_REISER4_LARGE_KEY=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_QUOTA=y
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_CACHEFS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=852
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-2"
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_EXPERIMENTAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_LDM_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_SECLVL=m
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m



Can you say anything about it?


Thanks,

Grzegorz Kulewski

