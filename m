Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbRBMAAR>; Mon, 12 Feb 2001 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129626AbRBMAAI>; Mon, 12 Feb 2001 19:00:08 -0500
Received: from mpoli.fi ([62.236.132.1]:32785 "EHLO mpoli.fi")
	by vger.kernel.org with ESMTP id <S129280AbRBLX77>;
	Mon, 12 Feb 2001 18:59:59 -0500
Date: Tue, 13 Feb 2001 01:55:01 +0200
From: Olli Lounela <olli@mpoli.fi>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fwd: Mylex dac960 not SMP-safe?
Message-ID: <20010213015501.J17002@mpoli.fi>
Reply-To: olli@mpoli.fi
In-Reply-To: <20010212134757.A18423@mpoli.fi> <200102121702.f1CH20U03841@dandelion.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <200102121702.f1CH20U03841@dandelion.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii

On Mon, Feb 12, 2001 at 09:02:00AM -0800, Leonard N. Zubkoff wrote:
> 
> I seem to recall that the Intel Providence motherboard has been
> problematic in many configurations.  Have you contacted Mylex Technical
> Support to inquire about compatibility issues between the AcceleRAID 250
> and the PR440FX motherboard?  They are far more expert than I when
> hardware compatibility is in question.

I have done that now, but don't really expect response before tomorrow at
earliest.

Just to mention what I earlier forgot, I've made darn sure the cooling is
good enough. The raid pack is in external box, so power quality should not
affect the issue.

> Busmastering jumper?  The only jumper on the AcceleRAID 250 I recall is the one
> that controls whether the SISL support for onboard Symbios SCSI chips is
> activated.  Having this jumper in the wrong position could lead to interrupt
> problems, I expect.

OK. The documentation about the meaning of SISL was not exactly the best in
the World, so to say. The onboard controller is aic7880, I didn't think it
uses Symbios chips... ohwell.

> If it hangs right after the driver banner is printed, but before the
> configuration of the controller is reported, this almost certainly means that
> the driver is not receiving interrupts from the DAC960.  This generally

This is the case. With nosmp, it gets recognized and initialized all right,
the filesystems in the disk set pass e2fsck without problems, but the boot
still eventually hangs hard at eepro100 initialization once init changes to
runlevel 3 (this is RedHat, alright).

There is a difference here, from Mylex init hang I can do soft reboot, eepro
init hangs hard. And yes, I've waited half an hour to see if it recovers.
No such luck.

With 2.2-UP (stock RH 2.2.16-3) I seem to be able to run the machine with no
problems, though SMP variant of the same still hangs hard, apparently at
network traffic.

> indicates compatibility problems between the motherboard, its BIOS, and the
> DAC960 hardware/firmware, a buggy motherboard, or it can indicate that the

I've now also upgraded the flsh ROMs to the latest I found from Mylex' web
site (Firmware 4.08-0-35, BIOS 4.10-41).

> Linux kernel is not dealing properly with the motherboard APIC configuration.
> I thought that the latter type of issue is no longer likely.

This is what it sounds like, to me, if the driver works fine. Especially
since 2.2 is different from 2.4, and also since the motherboard has worked
before. Perhaps the kernel mis-initializes APIC, and interrupts go awry.

I have now tested several kernels, going all the way back to 2.4.0-test10 
(I thought there might be something in common with Jan-Benedict Glaw's
report about PCI problems with DAC1164). No difference at all with any of
the kernels.

However, I still have no real idea how to start debugging the case. I sure
hope it isn't undebuggable.

> eepro100, so I am initially much more suspicious of the PR440FX motherboard
> combination.

My feelings exactly. I suspect SMP PPro is no longer all that common, and
Mylex there might be much less so. eepro100/B with 82557 should not be
uncommon, however. Strange, however, that it's the dac960 that exposes the
problem.

> I notice that the AcceleRAID 250 and eepro100 are sharing IRQ 10.  WHile in
> theory this should work fine, and does in other systems, is it possible to
> place the AcceleRAID 250 in a different slot or assign it another IRQ?

Forcing these to different IRQ's made no difference, nor did shuffling
around the PCI-cards (just two, S3 Virge and Mylex).

Finally got 2.4.2pre3 nosmp boot dmesg, attached. Also current lspci -vvvxx

-- 
    Olli               ...and he thought I'm serious! Hahahaha...

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.2-pre3 (root@huikka.bogus.local) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 SMP Tue Feb 13 03:23:46 EET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 000000000bf00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000180000 @ 00000000ffe80000 (reserved)
 BIOS-e820: 0000000000009000 @ 00000000fec00000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f7ef0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: PR440FX      APIC at: 0xFEC08000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Processor #12 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #18 is ISA   
I/O APIC #13 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 18, IRQ 00, APIC ID d, APIC INT 00
Int: type 0, pol 1, trig 1, bus 18, IRQ 01, APIC ID d, APIC INT 01
Int: type 0, pol 1, trig 1, bus 18, IRQ 03, APIC ID d, APIC INT 03
Int: type 0, pol 1, trig 1, bus 18, IRQ 04, APIC ID d, APIC INT 04
Int: type 0, pol 1, trig 1, bus 18, IRQ 05, APIC ID d, APIC INT 05
Int: type 0, pol 1, trig 1, bus 18, IRQ 06, APIC ID d, APIC INT 06
Int: type 0, pol 1, trig 1, bus 18, IRQ 07, APIC ID d, APIC INT 07
Int: type 0, pol 1, trig 1, bus 18, IRQ 08, APIC ID d, APIC INT 08
Int: type 0, pol 1, trig 1, bus 18, IRQ 09, APIC ID d, APIC INT 09
Int: type 0, pol 1, trig 1, bus 18, IRQ 0c, APIC ID d, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 18, IRQ 0e, APIC ID d, APIC INT 0e
Int: type 0, pol 1, trig 1, bus 18, IRQ 0f, APIC ID d, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 4c, APIC ID d, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID d, APIC INT 11
Int: type 0, pol 3, trig 3, bus 0, IRQ 18, APIC ID d, APIC INT 12
Processors: 2
mapped APIC to ffffe000 (fec08000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=linux ro root=3005 nosmp
Initializing CPU#0
Detected 198.667 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 396.49 BogoMIPS
Memory: 191152k/196608k available (971k kernel code, 5068k reserved, 332k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
CPU0: Intel Pentium Pro stepping 09
per-CPU timeslice cutoff: 733.84 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
SMP mode deactivated, forcing use of dummy APIC emulation.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfda11, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
disabling PIRQ2
PCI->APIC IRQ transform: (B0,I6,P0) -> 18
disabling PIRQ1
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
disabling PIRQ3
PCI->APIC IRQ transform: (B0,I19,P0) -> 19
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
39 structures occupying 1244 bytes.
DMI table at 0x000F99B3.
BIOS Vendor: Intel Corp.
BIOS Version: 1.00.09.DI0 
BIOS Release: 08/28/98
Board Vendor: Intel Corporation.
Board Name: PR440FX.
Board Version: AA657173-503.
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 126853kB/42284kB, 384 slots per queue
DAC960: ***** DAC960 RAID Driver Version 2.4.9 of 7 September 2000 *****
DAC960: Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Configuring Mylex DAC960PTL1 PCI RAID Controller
DAC960#0:   Firmware Version: 4.08-0-35, Channels: 1, Memory Size: 8MB
DAC960#0:   PCI Bus: 0, Device: 11, Function: 1, I/O Address: Unassigned
DAC960#0:   PCI Address: 0xFE000000 mapped at 0xCC800000, IRQ Channel: 10
DAC960#0:   Controller Queue Depth: 124, Maximum Blocks per Command: 128
DAC960#0:   Driver Queue Depth: 123, Scatter/Gather Limit: 33 of 33 Segments
DAC960#0:   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
DAC960#0:   Physical Devices:
DAC960#0:     0:0  Vendor: IBM       Model: DNES-309170W      Revision: SA30
DAC960#0:          Serial Number:         AJG12775
DAC960#0:          Disk Status: Online, 17915904 blocks
DAC960#0:     0:1  Vendor: IBM       Model: DNES-309170W      Revision: SA30
DAC960#0:          Serial Number:         AJG17464
DAC960#0:          Disk Status: Online, 17915904 blocks
DAC960#0:     0:2  Vendor: IBM       Model: DNES-309170W      Revision: SA30
DAC960#0:          Serial Number:         AJG37391
DAC960#0:          Disk Status: Online, 17915904 blocks
DAC960#0:   Logical Drives:
DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 35831808 blocks, Write Thru
Partition check:
 rd/c0d0: rd/c0d0p1 rd/c0d0p2 < rd/c0d0p5 rd/c0d0p6 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
Software Watchdog Timer: 0.05, timer margin: 60 sec
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 265032k swap-space (priority -1)

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set
00: 86 80 37 12 06 01 80 22 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 72 set
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffbe6000 (32-bit, prefetchable)
	Region 1: I/O ports at ff40
	Region 2: Memory at fef00000 (32-bit, non-prefetchable)
00: 86 80 29 12 07 01 80 02 01 00 00 02 00 48 00 00
10: 08 60 be ff 41 ff 00 00 00 00 f0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 08 38

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
00: 86 80 00 70 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 4: I/O ports at ffa0 [disabled]
00: 86 80 10 70 00 00 80 02 00 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 SCSI storage controller: Adaptec AIC-7880U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 72 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at fc00
	Region 1: Memory at ffbe7000 (32-bit, non-prefetchable)
00: 04 90 78 80 07 00 80 02 00 00 00 01 08 48 00 00
10: 01 fc 00 00 00 70 be ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 08 08

00:0b.0 PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 05) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ff900000-ff9fffff
	Prefetchable memory behind bridge: ff800000-ff8fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: 86 80 60 09 06 00 80 02 05 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 f0 00 80 22
20: 90 ff 90 ff 80 ff 80 ff 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 03 00

00:0b.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
	Subsystem: Mylex Corporation: Unknown device 0010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe000000 (32-bit, prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 69 10 10 00 16 00 90 22 05 00 04 01 08 20 80 00
10: 08 00 00 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 69 10 10 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00

00:13.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ff000000 (32-bit, non-prefetchable)
00: 33 53 11 88 03 00 00 02 00 00 00 03 00 00 00 00
10: 00 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00


--6TrnltStXW4iwmi0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
