Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSHTNVE>; Tue, 20 Aug 2002 09:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSHTNVE>; Tue, 20 Aug 2002 09:21:04 -0400
Received: from ns1.ionium.org ([62.27.22.2]:47116 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S317096AbSHTNVC> convert rfc822-to-8bit;
	Tue, 20 Aug 2002 09:21:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: shared graphic ram hangs kernel since 2.4.3-ac1
Date: Tue, 20 Aug 2002 15:27:51 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208201527.51649.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.. 
i finally got some more info about my problem with kernel booting:
after some tests i found all kernels prior (and including) 2.4.3 to boot 
properly, whereas every later one (2.4.3-ac1 was the first i tested) failed 
right after "Ok, booting the kernel."

since i have 512 mb ram and the onboard gfx chip uses 8MB (can switch to 1MB 
in the bios) i decided to try to set the mem to 504 (512 - 8 = 504)

when i use mem=504M as boot parameter, 2.4.3-ac1 boots and all the other 
kernels i tested up to 2.4.18 boot with mem=504M.

2.4.19 however doesnt and 2.4.20-pre4 doesnt as well.. no mem=xxxM line helps, 
they always hang at "Ok, booting the kernel."


Kernels prior to 2.4.3 didn't need a mem=xxxM line at all.


Here is some info about the system:
Epox 4G4A+, i845G, onboard HPT372, onboard Realteak RTL 8100B, onboard 
Integrated Graphics Controller, ... 512 MB Double Sided DDR Ram 2.5 V, P4 2.0 
GHz Northwood

 
/proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping	: 4
cpu MHz		: 2019.980
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4023.91


/proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  526389248 13664256 512724992        0   598016  6148096
Swap: 509956096        0 509956096
MemTotal:       514052 kB
MemFree:        500708 kB
MemShared:           0 kB
Buffers:           584 kB
Cached:           6004 kB
SwapCached:          0 kB
Active:           3640 kB
Inactive:         4524 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514052 kB
LowFree:        500708 kB
SwapTotal:      498004 kB
SwapFree:       498004 kB


lspci -vvv

00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
	Subsystem: Unknown device 1695:4002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [0105]

00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562 (rev 01) 
(prog-if 00 [VGA])
	Subsystem: Unknown device 1695:9002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 81) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01) (prog-if 8a 
[Master SecP PriP])
	Subsystem: Unknown device 1695:4002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
	Subsystem: Unknown device 1695:4002
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 0500 [size=32]

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Unknown device 1695:9001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Vital Product Data


--
Best Regards,
Justin Heesemann
