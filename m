Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTFPMEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFPMEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:04:37 -0400
Received: from mail.ithnet.com ([217.64.64.8]:51978 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263818AbTFPMEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:04:30 -0400
Date: Mon, 16 Jun 2003 14:18:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: BUG REPORT: Massive performance drop in routing throughput with
 2.4.21
Message-Id: <20030616141806.6a92f839.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

there seems to be a real serious problem with 2.4.21, routing through two
ethernet-devices. After 24 hours of a routing-only box the throughput from
ethernet a to ethernet b decreased to something around 4-100 kByte/sec (100
Mbit network 2 cards ns83820). I had to drop using 2.4.21 on this box because
of this. 2.4.20 is flawless on the machine and ran for around 100 days before
without any troubles. Going back to 2.4.20 cured it.

The box itself:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
(rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 8038
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f9800000-fbdfffff
	Prefetchable memory behind bridge: fbf00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8038
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
(rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Region 4: I/O ports at b800 [disabled] [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 20, cache line size 08
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 20, cache line size 08
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: National Semiconductor Corporation DP83820
10/100/1000 Ethernet Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 20 (2750ns min, 13000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at f9000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Ethernet controller: National Semiconductor Corporation DP83820
10/100/1000 Ethernet Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 20 (2750ns min, 13000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at f8800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 22)
	Subsystem: D-Link System Inc DFE-500TX Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 20 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at f8000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI
Adapter (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 9800 [size=256]
	Region 1: Memory at f7800000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at f7000000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI
Adapter (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at f6800000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at f6000000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X (rev 27)
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Xpert 98 RXL AGP 2X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at f9800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fbfe0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


meminfo during problem:


        total:    used:    free:  shared: buffers:  cached:
Mem:  4075950080 1629593600 2446356480        0 103702528 1415892992
Swap: 2147467264        0 2147467264
MemTotal:      3980420 kB
MemFree:       2389020 kB
MemShared:           0 kB
Buffers:        101272 kB
Cached:        1382708 kB
SwapCached:          0 kB
Active:        1131004 kB
Inactive:       359432 kB
HighTotal:     3112944 kB
HighFree:      1720812 kB
LowTotal:       867476 kB
LowFree:        668208 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB

cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 1004.528
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 2005.40

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 1004.528
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 2005.40


lsmod:

Module                  Size  Used by    Not tainted
nfs                    75768   1  (autoclean)
lockd                  51440   1  (autoclean) [nfs]
sunrpc                 70044   1  (autoclean) [nfs lockd]
ipt_LOG                 3480   1  (autoclean)
iptable_filter          1740   1  (autoclean)
iptable_nat            17176   1  (autoclean)
ip_conntrack           20992   1  (autoclean) [iptable_nat]
ip_tables              12568   5  [ipt_LOG iptable_filter iptable_nat]
cls_u32                 5788   1 
sch_prio                3296   0  (unused)
sch_sfq                 3520   0  (unused)
sch_tbf                 2944   0  (unused)
sch_cbq                13792   1 
tulip                  42848   1 
ns83820                14288   2 


Regards,
Stephan

