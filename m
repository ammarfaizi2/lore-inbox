Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131504AbRCNSVs>; Wed, 14 Mar 2001 13:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbRCNSVj>; Wed, 14 Mar 2001 13:21:39 -0500
Received: from ns.caldera.de ([212.34.180.1]:34053 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131504AbRCNSVa>;
	Wed, 14 Mar 2001 13:21:30 -0500
Date: Wed, 14 Mar 2001 19:20:27 +0100
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Vincent Sweeney <v.sweeney@dexterus.com>, linux-kernel@vger.kernel.org
Subject: Re: cpqarray & 2.4.1+ hang
Message-ID: <20010314192027.A11047@caldera.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
X-Mailer: Mutt 1.0i
In-Reply-To: <3AAFB0CE.D1FBD52E@dexterus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii

> I have a problem with the 2.4 series kernel running on a number of
> Compaq ProLiant DL360 servers. The 2.2.x kernels and 2.4.0 work fine,
> however from 2.4.1 onwards the boxes just hang at the following position
> on bootup:

> Partition check: 
>   ida/c0d0:

> I have also tested with 2.4.2-ac20 and the same problem occurs. Doing a
> search on the web some people recommend changing the OS setting in the
> Compaq BIOS to Linux fixes this problem, however my servers are already
> running with this BIOS setting and I've also tested with numerous other
> OS's in the BIOS but the same problem occurs.

Workaround: run the kernel with the 'noapic' option on its commandline.

The ServerWorks chipset used in this Compaq Server somehow does not pass
the the relevant information to Linux mapping routines. :/

I have attached lspci -xxx and dmesg output of our DL360 below.

Ciao, Marcus

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.xx"

00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08
00: 66 11 09 00 07 01 00 22 05 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
00: 66 11 09 00 07 01 00 02 05 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 RAID bus controller: Symbios Logic Inc. (formerly NCR): Unknown device 0010 (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 4040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 192 (7500ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 2000 [size=256]
	Region 1: Memory at c5000000 (32-bit, non-prefetchable) [size=16M]
	Region 2: Memory at c4000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 00 10 10 00 57 01 10 02 02 00 04 01 08 c0 00 00
10: 01 20 00 00 00 00 00 c5 00 00 00 c4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 40 40
30: 00 00 00 00 40 00 00 00 00 00 00 00 03 01 1e 08

00:03.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at c2000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at 2400 [size=256]
	Region 2: Memory at c3fff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 56 47 87 00 90 02 7a 00 00 03 08 40 00 00
10: 08 00 00 c2 01 24 00 00 00 f0 ff c3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 56 47
30: 00 00 00 00 5c 00 00 00 00 00 00 00 ff 00 08 00

00:04.0 System peripheral: Compaq Computer Corporation Advanced System Management Controller
	Subsystem: Compaq Computer Corporation: Unknown device b0f3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at c3ffef00 (32-bit, non-prefetchable) [size=256]
00: 11 0e f0 a0 43 01 00 02 00 00 80 08 00 00 00 00
10: 01 18 00 00 00 ef ff c3 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f3 b0
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
	Subsystem: Relience Computer: Unknown device 0200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 66 11 00 02 07 00 00 02 4f 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 00 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 2800 [size=16]
00: 66 11 11 02 45 01 00 02 00 8a 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Compaq Computer Corporation: Unknown device b134
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at c6fff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3000 [size=64]
	Region 2: Memory at c6e00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 57 01 90 02 08 00 00 02 08 40 00 00
10: 00 f0 ff c6 01 30 00 00 00 00 e0 c6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 34 b1
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 08 38

03:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Compaq Computer Corporation: Unknown device b134
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at c6dff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3040 [size=64]
	Region 2: Memory at c6c00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 57 01 90 02 08 00 00 02 08 40 00 00
10: 00 f0 df c6 41 30 00 00 00 00 c0 c6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 34 b1
30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 08 38


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dl360.dmesg"

Linux version 2.4.2 (root@) (gcc version 2.95.2 19991024 (release)) #4S SMP Fri Mar 9 23:05:30 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000fefc000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000004000 @ 000000000fffc000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f4ff0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 16
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 16
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #3 is PCI   
Bus #9 is ISA   
I/O APIC #8 Version 17 at 0xFEC00000.
Int: type 0, pol 3, trig 3, bus 0, IRQ 14, APIC ID 8, APIC INT 15
Int: type 0, pol 3, trig 3, bus 0, IRQ 15, APIC ID 8, APIC INT 14
Int: type 0, pol 3, trig 3, bus 0, IRQ 16, APIC ID 8, APIC INT 15
Int: type 0, pol 3, trig 3, bus 0, IRQ 17, APIC ID 8, APIC INT 14
Int: type 0, pol 3, trig 3, bus 3, IRQ 18, APIC ID 8, APIC INT 17
Int: type 0, pol 3, trig 3, bus 3, IRQ 19, APIC ID 8, APIC INT 16
Int: type 0, pol 3, trig 3, bus 3, IRQ 1a, APIC ID 8, APIC INT 17
Int: type 0, pol 3, trig 3, bus 3, IRQ 1b, APIC ID 8, APIC INT 16
Int: type 0, pol 3, trig 3, bus 0, IRQ 04, APIC ID 8, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 05, APIC ID 8, APIC INT 12
Int: type 0, pol 3, trig 3, bus 3, IRQ 10, APIC ID 8, APIC INT 11
Int: type 0, pol 3, trig 3, bus 3, IRQ 14, APIC ID 8, APIC INT 18
Int: type 0, pol 1, trig 1, bus 9, IRQ 01, APIC ID 8, APIC INT 01
Int: type 0, pol 1, trig 1, bus 9, IRQ 00, APIC ID 8, APIC INT 02
Int: type 0, pol 1, trig 1, bus 9, IRQ 04, APIC ID 8, APIC INT 04
Int: type 0, pol 1, trig 1, bus 9, IRQ 06, APIC ID 8, APIC INT 06
Int: type 0, pol 1, trig 1, bus 9, IRQ 08, APIC ID 8, APIC INT 08
Int: type 0, pol 1, trig 1, bus 9, IRQ 09, APIC ID 8, APIC INT 09
Int: type 0, pol 1, trig 1, bus 9, IRQ 0a, APIC ID 8, APIC INT 0a
Int: type 0, pol 1, trig 1, bus 9, IRQ 0b, APIC ID 8, APIC INT 0b
Int: type 0, pol 1, trig 1, bus 9, IRQ 0c, APIC ID 8, APIC INT 0c
Int: type 0, pol 3, trig 3, bus 9, IRQ 0d, APIC ID 8, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 9, IRQ 0e, APIC ID 8, APIC INT 0e
Int: type 0, pol 1, trig 1, bus 9, IRQ 0f, APIC ID 8, APIC INT 0f
Lint: type 3, pol 0, trig 0, bus 9, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 9, IRQ 00, APIC ID ff, APIC LINT 01
Int: type 3, pol 0, trig 0, bus 9, IRQ 00, APIC ID 8, APIC INT 00
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: vga=274 noapic quiet root=/dev/ida/c0d0p1
Initializing CPU#0
Detected 930.465 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1854.66 BogoMIPS
Memory: 254640k/262128k available (1031k kernel code, 7100k reserved, 281k data, 264k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU speed 933Mhz, Bus Speed 133MHz (c6740040)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU speed 933Mhz, Bus Speed 133MHz (c6740040)
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.26 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 9
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1854.66 BogoMIPS
Stack at about cfff5fbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU speed 933Mhz, Bus Speed 133MHz (c6440040)
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (3709.33 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
calibrating APIC timer ...
..... CPU clock speed is 930.4502 MHz.
..... host bus clock speed is 132.9214 MHz.
cpu: 0, clocks: 1329214, slice: 443071
CPU0<T0:1329200,T1:886128,D:1,S:443071,C:1329214>
cpu: 1, clocks: 1329214, slice: 443071
CPU1<T0:1329200,T1:443056,D:2,S:443071,C:1329214>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 03
PCI: Device 00:00 not found by BIOS
PCI: Device 00:01 not found by BIOS
PCI: Device 00:78 not found by BIOS
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
vesafb: framebuffer at 0xa0000, mapped to 0xc00a0000, size 128k
vesafb: mode is 640x480x4, linelength=80, pages=17862
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 80x30
fb0: VESA VGA frame buffer device
pty: 1024 Unix98 ptys configured
block: queued sectors max/low 168936kB/56312kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2800-0x2807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2808-0x280f, BIOS settings: hdc:pio, hdd:pio
hdc: Compaq CRN-8241B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 565k freed
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
loop: loaded (max 8 devices)
cpqarray: Device 1000 has been found at 0 8
Compaq SMART2 Driver (v 2.4.2)
Found 1 controller(s)
cpqarray: Finding drives on ida0 (Integrated Array)
cpqarray ida/c0d0: blksz=512 nr_blks=17756160
cpqarray: Starting firmware's background processing
Partition check:
 ida/c0d0: p1 p2 p3
NTFS version 010116
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=3
Freeing unused kernel memory: 264k freed
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.4.21
Copyright (c) 2001 Intel Corporation

eth0: Compaq Fast Ethernet Server Adapter
  Mem:0xc6fff000  IRQ:5  Speed:100 Mbps  Dx:Half
  Hardware receive checksums enabled

eth1: Compaq Fast Ethernet Server Adapter
  Mem:0xc6dff000  IRQ:7  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link.
  Speed and duplex will be determined at time of connection.
  Hardware receive checksums enabled
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
NET4: Linux IPX 0.46 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
Adding Swap: 310072k swap-space (priority -1)
NET4: AppleTalk 0.18a for Linux NET4.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
lp: driver loaded but no devices found
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A

--X1bOJ3K7DJ5YkBrT--
