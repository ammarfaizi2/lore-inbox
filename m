Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSJ2Nsk>; Tue, 29 Oct 2002 08:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbSJ2Nsk>; Tue, 29 Oct 2002 08:48:40 -0500
Received: from ospd01.pd.infn.it ([192.84.143.142]:51729 "EHLO
	ospd01.pd.infn.it") by vger.kernel.org with ESMTP
	id <S261861AbSJ2Nsh>; Tue, 29 Oct 2002 08:48:37 -0500
Date: Tue, 29 Oct 2002 14:54:58 +0100 (MET)
From: Alberto Crescente <alberto.crescente@pd.infn.it>
To: linux-kernel@vger.kernel.org
Subject: Serverwork CSB5 & DMA problem
Message-ID: <Pine.OSF.4.40.0210291452390.16236-100000@ospd00.pd.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with 2 IDE disks (SEAGATE) on primary controller.
When I try to enable DMA the kernel return the following message:
/dev/hdb:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

Below there are some information (hdparm, dmesg, lspci):

# hdparm -i /dev/hda

/dev/hda:

 Model=ST340016A, FwRev=3.75, SerialNo=3HS3CP63
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5


# hdparm -i /dev/hdb

/dev/hdb:

 Model=ST340016A, FwRev=3.75, SerialNo=3HS3G692
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5


# dmesg

 Linux version 2.4.18-17.7.xsmp (bhcompile@daffy.perf.redhat.com) (gcc
version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #1 SMP Tue Oct 8
12:37:04 EDT 2002
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 000000000009f800 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Oct 29 12:02:41 bbr-datamove16 nfslock: rpc.statd startup succeeded
 127MB HIGHMEM available.
Oct 29 12:02:41 bbr-datamove16 rpc.statd[601]: Version 0.3.1 Starting
 896MB LOWMEM available.
 found SMP MP-table at 000ff780
 hm, page 000ff000 reserved twice.
 hm, page 00100000 reserved twice.
 hm, page 000f0000 reserved twice.
 hm, page 000f1000 reserved twice.
 On node 0 totalpages: 262128
 zone(0): 4096 pages.
 zone(1): 225280 pages.
 zone(2): 32752 pages.
 Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
 OEM ID: AMI      Product ID: CNB20HE      APIC at: 0xFEE00000
 Processor #0 Pentium(tm) Pro APIC version 17
 Processor #1 Pentium(tm) Pro APIC version 17
 I/O APIC #4 Version 17 at 0xFEC00000.
 I/O APIC #5 Version 17 at 0xFEC01000.
 Processors: 2
 Kernel command line: auto BOOT_IMAGE=xCAT ro root=900
BOOT_FILE=/boot/vmlinuz-2.4.18-17.7.xsmp console=tty1
console=ttyS0,9600
 Initializing CPU#0
 Detected 1266.123 MHz processor.
 Speakup v-1.00 CVS: Tue Jun 11 14:22:53 EDT 2002 : initialized
 Console: colour VGA+ 80x25
 Calibrating delay loop... 2518.66 BogoMIPS
 Memory: 1027044k/1048512k available (1280k kernel code, 17884k reserved,
1051k data, 188k init, 131008k highmem)
 Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
 Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
 Mount cache hash table entries: 16384 (order: 5, 131072 bytes)
 Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
 Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
 CPU: L1 I cache: 16K, L1 D cache: 16K
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
 mtrr: detected mtrr type: Intel
 CPU: L1 I cache: 16K, L1 D cache: 16K
 Intel machine check reporting enabled on CPU#0.
 CPU0: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
 per-CPU timeslice cutoff: 91.40 usecs.
 task migration cache decay timeout: 1 msecs.
 enabled ExtINT on CPU#0
 ESR value before enabling vector: 00000004
 ESR value after enabling vector: 00000000
 Booting processor 1/1 eip 2000
 Initializing CPU#1
 masked ExtINT on CPU#1
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 2526.76 BogoMIPS
 CPU: L1 I cache: 16K, L1 D cache: 16K
 Intel machine check reporting enabled on CPU#1.
 CPU1: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
 Total of 2 processors activated (5044.43 BogoMIPS).
 ENABLING IO-APIC IRQs
 Setting 4 in the phys_id_present_map
 ...changing IO-APIC physical APIC ID to 4 ... ok.
 Setting 5 in the phys_id_present_map
 ...changing IO-APIC physical APIC ID to 5 ... ok.
 ..TIMER: vector=0x31 pin1=2 pin2=0
 ..MP-BIOS bug: 8254 timer not connected to IO-APIC
 ...trying to set up timer (IRQ0) through the 8259A ...
 ..... (found pin 0) ...works.
 testing the IO APIC.......................
 .................................... done.
 Using local APIC timer interrupts.
 calibrating APIC timer ...
 ..... CPU clock speed is 1265.1838 MHz.
 ..... host bus clock speed is 133.0501 MHz.
 cpu: 0, clocks: 260250, slice: 86750
 CPU0<T0:260240,T1:173488,D:2,S:86750,C:260250>
 cpu: 1, clocks: 260250, slice: 86750
 CPU1<T0:260240,T1:86736,D:4,S:86750,C:260250>
 checking TSC synchronization across CPUs: passed.
 migration_task 0 on cpu=0
 migration_task 1 on cpu=1
 PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=2
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
 PCI: Discovered primary peer bus 02 [IRQ]
 PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
 PCI->APIC IRQ transform: (B0,I5,P0) -> 26
 PCI->APIC IRQ transform: (B0,I5,P1) -> 27
 PCI->APIC IRQ transform: (B1,I0,P0) -> 30
 PCI->APIC IRQ transform: (B2,I1,P0) -> 22
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found
 speakup:  initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
 Initializing RT netlink socket
 apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
 apm: disabled - APM is not SMP safe.
 Starting kswapd
 allocated 64 pages and 64 bhs reserved for the highmem bounces
 VFS: Diskquotas version dquot_6.5.0 initialized
 Detected PS/2 Mouse Port.
 pty: 2048 Unix98 ptys configured
 Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
 ttyS0 at 0x03f8 (irq = 4) is a 16550A
 ttyS1 at 0x02f8 (irq = 3) is a 16550A
 Real Time Clock Driver v1.10e
 oprofile: APIC was already enabled
 oprofile 0.2 loaded, major 254
 block: 1024 slots per queue, batch=256
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SvrWks CSB5: IDE controller on PCI bus 00 dev 79
 PCI: Device 00:0f.1 not available because of resource collisions
 SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.
 hda: ST340016A, ATA DISK drive
 hdb: ST340016A, ATA DISK drive
 hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
 hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
 ide-floppy driver 0.99.newide
 Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a National Semiconductor PC87306
 NET4: Frame Diverter 0.46
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 ide-floppy driver 0.99.newide
 hdc: ATAPI 24X CD-ROM drive, 128kB Cache
 Uniform CD-ROM driver Revision: 3.12
 ide0: Speed warnings UDMA 3/4/5 is not functional.
 ide1: Speed warnings UDMA 3/4/5 is not functional.
 ide1: unexpected interrupt, status=0x51, count=1
 hdc: CHECK for good STATUS
 ide0: unexpected interrupt, status=0x58, count=2
 ide0: Speed warnings UDMA 3/4/5 is not functional.
 ide0: Speed warnings UDMA 3/4/5 is not functional.


# lspci -v
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
        Flags: fast devsel
        Memory at <unassigned> (32-bit, prefetchable) [disabled]
        Memory at f7fff000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:00.1 PCI bridge: ServerWorks CNB20LE Host Bridge (rev 01) (prog-if 00
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fc900000-fe9fffff
        Prefetchable memory behind bridge: fc600000-fc6fffff
        Capabilities: [80] AGP version 2.0

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
        Flags: medium devsel

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
        Flags: medium devsel

00:05.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Unknown device 9d15:0001
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 26
        BIST result: 00
        I/O ports at d400 [disabled] [size=256]
        Memory at feafd000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feaa0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:05.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Unknown device 9d15:0001
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 27
        BIST result: 00
        I/O ports at d800 [disabled] [size=256]
        Memory at feaff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Flags: bus master, medium devsel, latency 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if
8a [Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Flags: bus master, medium devsel, latency 64
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at ffa0 [size=16]

00:0f.3 Host bridge: ServerWorks: Unknown device 0225
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 30
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at b800 [size=256]
        Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe9c0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
        Capabilities: [5c] Power Management version 2

02:01.0 Ethernet controller: Intel Corporation: Unknown device 1008 (rev 02)
        Subsystem: Intel Corporation: Unknown device 1107
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 22
        Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
        Memory at febc0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at e800 [size=32]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-



with regards,
Alberto.

