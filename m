Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbTCJGSV>; Mon, 10 Mar 2003 01:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTCJGSV>; Mon, 10 Mar 2003 01:18:21 -0500
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:31104 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S261628AbTCJGR3>;
	Mon, 10 Mar 2003 01:17:29 -0500
Message-ID: <3E6C3075.4040408@tmsusa.com>
Date: Sun, 09 Mar 2003 22:28:05 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: slab error in 2.5.64-mm4
Content-Type: multipart/mixed;
 boundary="------------010101060503080600010105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010101060503080600010105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This may be of interest -

kernel: 2.5.64-mm4

Linux distro: Red Hat 8.0 + updates

Hardware:
Celeron 1.2 Ghz on genuine Intel Motherboard, 512 MB RAM

Just recompiled 2.5.64-mm4 with full debugging
and saw a slab error right after bringing up the
ethernet interfaces -

Full kernel log attached, but the meat of it is here:

Mar  9 21:42:54 jyro kernel: Slab corruption: start=dfc15964, 
expend=dfc159e3, problemat=dfc1599c
Mar  9 21:42:54 jyro kernel: Last user: [<00000000>](0x0)
Mar  9 21:42:54 jyro kernel: Data: 
........................................................62......................................................................A5 

Mar  9 21:42:54 jyro kernel: Next: 71 F0 2C .00 00 00 00 71 F0 2C 
.....................
Mar  9 21:42:54 jyro kernel: slab error in check_poison_obj(): cache 
`size-128':
 object was modified after freeing
Mar  9 21:42:54 jyro kernel: Call Trace:
Mar  9 21:42:54 jyro kernel:  [<c01481bb>] check_poison_obj+0x15b/0x1b0
Mar  9 21:42:54 jyro kernel:  [<c014a1b9>] kmalloc+0x169/0x1c0
Mar  9 21:42:54 jyro kernel:  [<c039e671>] packet_create+0xd1/0x220
Mar  9 21:42:54 jyro kernel:  [<c039e671>] packet_create+0xd1/0x220
Mar  9 21:42:54 jyro kernel:  [<c0330f15>] sock_create+0xd5/0x1c0
Mar  9 21:42:54 jyro kernel:  [<c0388d26>] inet_ioctl+0x106/0x120
Mar  9 21:42:54 jyro kernel:  [<c0331029>] sys_socket+0x29/0x60
Mar  9 21:42:54 jyro kernel:  [<c0331f52>] sys_socketcall+0x72/0x270
Mar  9 21:42:54 jyro kernel:  [<c0180e2e>] sys_ioctl+0x18e/0x3e0
Mar  9 21:42:54 jyro kernel:  [<c010a403>] syscall_call+0x7/0xb






--------------010101060503080600010105
Content-Type: text/plain;
 name="kernel.log.2.5.64-mm4-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel.log.2.5.64-mm4-1"

Mar  9 21:42:54 jyro kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar  9 21:42:54 jyro kernel: Linux version 2.5.64-mm4-1 (root@jyro.mirai.cx) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sun Mar 9 21:24:53 PST 2003
Mar  9 21:42:54 jyro kernel: Video mode to be used for restore is ffff
Mar  9 21:42:54 jyro kernel: BIOS-provided physical RAM map:
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 0000000000100000 - 000000001fec0000 (usable)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 000000001fec0000 - 000000001fef8000 (ACPI data)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 000000001fef8000 - 000000001ff00000 (ACPI NVS)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
Mar  9 21:42:54 jyro kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Mar  9 21:42:54 jyro kernel: 510MB LOWMEM available.
Mar  9 21:42:54 jyro kernel: On node 0 totalpages: 130752
Mar  9 21:42:54 jyro kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar  9 21:42:54 jyro kernel:   Normal zone: 126656 pages, LIFO batch:16
Mar  9 21:42:54 jyro kernel:   HighMem zone: 0 pages, LIFO batch:1
Mar  9 21:42:54 jyro kernel: ACPI: RSDP (v000 AMI                        ) @ 0x000ff980
Mar  9 21:42:54 jyro kernel: ACPI: RSDT (v001 D815EA D815EPE2 08193.02328) @ 0x1fef0000
Mar  9 21:42:54 jyro kernel: ACPI: FADT (v001 D815EA EA81510A 08193.02328) @ 0x1fef1000
Mar  9 21:42:54 jyro kernel: ACPI: MADT (v001 D815EA EA81510A 08193.02328) @ 0x1fee30e4
Mar  9 21:42:54 jyro kernel: ACPI: DSDT (v001 D815E2 EA81520A 00000.00035) @ 0x00000000
Mar  9 21:42:54 jyro kernel: ACPI: BIOS passes blacklist
Mar  9 21:42:54 jyro kernel: Building zonelist for node : 0
Mar  9 21:42:54 jyro kernel: Kernel command line: ro root=/dev/hda3 hdc=ide-scsi
Mar  9 21:42:54 jyro kernel: ide_setup: hdc=ide-scsi
Mar  9 21:42:54 jyro kernel: Initializing CPU#0
Mar  9 21:42:54 jyro kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Mar  9 21:42:54 jyro kernel: Detected 1195.360 MHz processor.
Mar  9 21:42:54 jyro kernel: Console: colour VGA+ 80x25
Mar  9 21:42:54 jyro kernel: Calibrating delay loop... 2359.29 BogoMIPS
Mar  9 21:42:54 jyro kernel: Memory: 513056k/523008k available (2801k kernel code, 9204k reserved, 669k data, 288k init, 0k highmem)
Mar  9 21:42:54 jyro kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar  9 21:42:54 jyro kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar  9 21:42:54 jyro kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mar  9 21:42:54 jyro kernel: -> /dev
Mar  9 21:42:54 jyro kernel: -> /dev/console
Mar  9 21:42:54 jyro kernel: -> /root
Mar  9 21:42:54 jyro kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar  9 21:42:54 jyro kernel: CPU: L2 cache: 256K
Mar  9 21:42:54 jyro kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Mar  9 21:42:54 jyro kernel: Intel machine check architecture supported.
Mar  9 21:42:54 jyro kernel: Intel machine check reporting enabled on CPU#0.
Mar  9 21:42:54 jyro kernel: CPU: Intel(R) Celeron(TM) CPU                1200MHz stepping 01
Mar  9 21:42:54 jyro kernel: Enabling fast FPU save and restore... done.
Mar  9 21:42:54 jyro kernel: Enabling unmasked SIMD FPU exception support... done.
Mar  9 21:42:54 jyro kernel: Checking 'hlt' instruction... OK.
Mar  9 21:42:54 jyro kernel: POSIX conformance testing by UNIFIX
Mar  9 21:42:54 jyro kernel: Linux NET4.0 for Linux 2.4
Mar  9 21:42:54 jyro kernel: Based upon Swansea University Computer Society NET3.039
Mar  9 21:42:54 jyro kernel: Initializing RT netlink socket
Mar  9 21:42:54 jyro kernel: mtrr: v2.0 (20020519)
Mar  9 21:42:54 jyro kernel: PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=1
Mar  9 21:42:54 jyro kernel: PCI: Using configuration type 1
Mar  9 21:42:54 jyro kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Mar  9 21:42:54 jyro kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Mar  9 21:42:54 jyro kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Mar  9 21:42:54 jyro kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Mar  9 21:42:54 jyro kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Mar  9 21:42:54 jyro kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Mar  9 21:42:54 jyro kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Mar  9 21:42:54 jyro kernel: ACPI: Subsystem revision 20030228
Mar  9 21:42:54 jyro kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Mar  9 21:42:54 jyro kernel: Parsing all Control Methods:..........................................................................................................................................................
Mar  9 21:42:54 jyro kernel: Table [DSDT] - 462 Objects with 42 Devices 154 Methods 21 Regions
Mar  9 21:42:54 jyro kernel: ACPI Namespace successfully loaded at root c04bfc7c
Mar  9 21:42:54 jyro kernel: evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
Mar  9 21:42:54 jyro kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000000428
Mar  9 21:42:54 jyro kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Mar  9 21:42:54 jyro kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000042C
Mar  9 21:42:54 jyro kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L03 is not valid
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L04 is not valid
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L05 is not valid
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L07 is not valid
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid
Mar  9 21:42:54 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Mar  9 21:42:54 jyro kernel: Executing all Device _STA and_INI methods:..........................................
Mar  9 21:42:54 jyro kernel: 42 Devices found containing: 42 _STA, 2 _INI methods
Mar  9 21:42:54 jyro kernel: Completing Region/Field/Buffer/Package initialization:...................................................................
Mar  9 21:42:54 jyro kernel: Initialized 13/21 Regions 7/7 Fields 37/37 Buffers 10/10 Packages (462 nodes)
Mar  9 21:42:54 jyro kernel: ACPI: Interpreter enabled
Mar  9 21:42:54 jyro kernel: ACPI: Using PIC for interrupt routing
Mar  9 21:42:54 jyro kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Mar  9 21:42:54 jyro kernel: PCI: Probing PCI hardware (bus 00)
Mar  9 21:42:54 jyro kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Mar  9 21:42:54 jyro kernel: ACPI: Power Resource [FDDP] (off)
Mar  9 21:42:54 jyro kernel: ACPI: Power Resource [URP1] (off)
Mar  9 21:42:54 jyro kernel: ACPI: Power Resource [URP2] (off)
Mar  9 21:42:54 jyro kernel: ACPI: Power Resource [LPTP] (off)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12)
Mar  9 21:42:54 jyro kernel: Linux Plug and Play Support v0.95 (c) Adam Belay
Mar  9 21:42:54 jyro kernel: block request queues:
Mar  9 21:42:54 jyro kernel:  128 requests per read queue
Mar  9 21:42:54 jyro kernel:  128 requests per write queue
Mar  9 21:42:54 jyro kernel:  8 requests per batch
Mar  9 21:42:54 jyro kernel:  enter congestion at 15
Mar  9 21:42:54 jyro kernel:  exit congestion at 17
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
Mar  9 21:42:54 jyro kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
Mar  9 21:42:54 jyro kernel: PCI: Using ACPI for IRQ routing
Mar  9 21:42:54 jyro kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Mar  9 21:42:54 jyro kernel: Enabling SEP on CPU 0
Mar  9 21:42:54 jyro kernel: VFS: Disk quotas dquot_6.5.1
Mar  9 21:42:54 jyro kernel: Journalled Block Device driver loaded
Mar  9 21:42:54 jyro kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Mar  9 21:42:54 jyro kernel: udf: registering filesystem
Mar  9 21:42:54 jyro kernel: Initializing Cryptographic API
Mar  9 21:42:54 jyro kernel: ACPI: Power Button (FF) [PWRF]
Mar  9 21:42:54 jyro kernel: ACPI: Processor [CPU1] (supports C1)
Mar  9 21:42:54 jyro kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Mar  9 21:42:54 jyro kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar  9 21:42:54 jyro kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar  9 21:42:54 jyro kernel: pty: 256 Unix98 ptys configured
Mar  9 21:42:54 jyro kernel: Real Time Clock Driver v1.11
Mar  9 21:42:54 jyro kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar  9 21:42:54 jyro kernel: agpgart: agpgart: Detected an Intel i815 Chipset.
Mar  9 21:42:54 jyro kernel: agpgart: Maximum main memory to use for agp memory: 438M
Mar  9 21:42:54 jyro kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Mar  9 21:42:54 jyro kernel: [drm] Initialized i810 1.2.1 20020211 on minor 0
Mar  9 21:42:54 jyro kernel: anticipatory scheduling elevator
Mar  9 21:42:54 jyro kernel: Floppy drive(s): fd0 is 1.44M
Mar  9 21:42:54 jyro kernel: FDC 0 is a post-1991 82077
Mar  9 21:42:54 jyro kernel: loop: loaded (max 8 devices)
Mar  9 21:42:54 jyro kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar  9 21:42:54 jyro kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar  9 21:42:54 jyro kernel: ICH2: IDE controller at PCI slot 00:1f.1
Mar  9 21:42:54 jyro kernel: ICH2: chipset revision 17
Mar  9 21:42:54 jyro kernel: ICH2: not 100%% native mode: will probe irqs later
Mar  9 21:42:54 jyro kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Mar  9 21:42:54 jyro kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Mar  9 21:42:54 jyro kernel: hda: WDC WD400EB-00CPF0, ATA DISK drive
Mar  9 21:42:54 jyro kernel: anticipatory scheduling elevator
Mar  9 21:42:54 jyro kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  9 21:42:54 jyro kernel: hdc: SONY CD-RW CRX185E1, ATAPI CD/DVD-ROM drive
Mar  9 21:42:54 jyro kernel: anticipatory scheduling elevator
Mar  9 21:42:54 jyro kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar  9 21:42:54 jyro kernel: hda: host protected area => 1
Mar  9 21:42:54 jyro kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
Mar  9 21:42:54 jyro kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Mar  9 21:42:54 jyro kernel: mice: PS/2 mouse device common for all mice
Mar  9 21:42:54 jyro kernel: input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
Mar  9 21:42:54 jyro kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  9 21:42:54 jyro kernel: input: AT Set 2 keyboard on isa0060/serio0
Mar  9 21:42:54 jyro kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  9 21:42:54 jyro kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar  9 21:42:54 jyro kernel: IP: routing cache hash table of 1024 buckets, 32Kbytes
Mar  9 21:42:54 jyro kernel: TCP: Hash tables configured (established 32768 bind 9362)
Mar  9 21:42:54 jyro kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Mar  9 21:42:54 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:42:54 jyro kernel: EXT3-fs: ide0(3,3): orphan cleanup on readonly fs
Mar  9 21:42:54 jyro kernel: ext3_orphan_cleanup: deleting unreferenced inode 210913
Mar  9 21:42:54 jyro kernel: ext3_orphan_cleanup: deleting unreferenced inode 224619
Mar  9 21:42:54 jyro kernel: ext3_orphan_cleanup: deleting unreferenced inode 32078
Mar  9 21:42:54 jyro kernel: ext3_orphan_cleanup: deleting unreferenced inode 32119
Mar  9 21:42:54 jyro kernel: EXT3-fs: ide0(3,3): 4 orphan inodes deleted
Mar  9 21:42:54 jyro kernel: EXT3-fs: recovery complete.
Mar  9 21:42:54 jyro kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  9 21:42:54 jyro kernel: VFS: Mounted root (ext3 filesystem) readonly.
Mar  9 21:42:54 jyro kernel: Freeing unused kernel memory: 288k freed
Mar  9 21:42:54 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Mar  9 21:42:54 jyro kernel: Adding 514072k swap on /dev/hda2.  Priority:42 extents:1
Mar  9 21:42:54 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:42:54 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Mar  9 21:42:54 jyro kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  9 21:42:54 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:42:54 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Mar  9 21:42:54 jyro kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar  9 21:42:54 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:42:54 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Mar  9 21:42:54 jyro kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar  9 21:42:54 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:42:54 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
Mar  9 21:42:54 jyro kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar  9 21:42:54 jyro kernel: found reiserfs format "3.6" with standard journal
Mar  9 21:42:54 jyro kernel: Reiserfs journal params: device ide0(3,8), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Mar  9 21:42:54 jyro kernel: reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
Mar  9 21:42:54 jyro kernel: Using r5 hash to sort names
Mar  9 21:42:54 jyro kernel: blk: queue c04ce37c, I/O limit 4095Mb (mask 0xffffffff)
Mar  9 21:42:54 jyro kernel: IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Mar  9 21:42:54 jyro kernel: microcode: CPU0 already at revision 28 (current=28)
Mar  9 21:42:54 jyro kernel: microcode: freed 2048 bytes
Mar  9 21:42:54 jyro kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
Mar  9 21:42:54 jyro kernel: parport0: cpp_daisy: aa5500ff(38)
Mar  9 21:42:54 jyro kernel: parport0: assign_addrs: aa5500ff(38)
Mar  9 21:42:54 jyro kernel: Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar  9 21:42:54 jyro kernel: Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar  9 21:42:54 jyro kernel: parport0: cpp_daisy: aa5500ff(38)
Mar  9 21:42:54 jyro kernel: parport0: assign_addrs: aa5500ff(38)
Mar  9 21:42:54 jyro kernel: ip_tables: (C) 2000-2002 Netfilter core team
Mar  9 21:42:54 jyro kernel: Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Mar  9 21:42:54 jyro kernel: Copyright (c) 2002 Intel Corporation
Mar  9 21:42:54 jyro kernel: 
Mar  9 21:42:54 jyro kernel: e100: selftest OK.
Mar  9 21:42:54 jyro kernel: Freeing alive device d4372800, eth%%d
Mar  9 21:42:54 jyro kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Mar  9 21:42:54 jyro kernel:   Hardware receive checksums enabled
Mar  9 21:42:54 jyro kernel: 
Mar  9 21:42:54 jyro kernel: e100: selftest OK.
Mar  9 21:42:54 jyro kernel: e100: eth1: Intel(R) PRO/100 S Desktop Adapter
Mar  9 21:42:54 jyro kernel:   Hardware receive checksums enabled
Mar  9 21:42:54 jyro kernel:   cpu cycle saver enabled
Mar  9 21:42:54 jyro kernel: 
Mar  9 21:42:54 jyro kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex
Mar  9 21:42:54 jyro kernel: e100: eth1 NIC Link is Up 10 Mbps Half duplex
Mar  9 21:42:54 jyro kernel: Slab corruption: start=dfc15964, expend=dfc159e3, problemat=dfc1599c
Mar  9 21:42:54 jyro kernel: Last user: [<00000000>](0x0)
Mar  9 21:42:54 jyro kernel: Data: ........................................................62 ......................................................................A5 
Mar  9 21:42:54 jyro kernel: Next: 71 F0 2C .00 00 00 00 71 F0 2C .....................
Mar  9 21:42:54 jyro kernel: slab error in check_poison_obj(): cache `size-128': object was modified after freeing
Mar  9 21:42:54 jyro kernel: Call Trace:
Mar  9 21:42:54 jyro kernel:  [<c01481bb>] check_poison_obj+0x15b/0x1b0
Mar  9 21:42:54 jyro kernel:  [<c014a1b9>] kmalloc+0x169/0x1c0
Mar  9 21:42:54 jyro kernel:  [<c039e671>] packet_create+0xd1/0x220
Mar  9 21:42:54 jyro kernel:  [<c039e671>] packet_create+0xd1/0x220
Mar  9 21:42:54 jyro kernel:  [<c0330f15>] sock_create+0xd5/0x1c0
Mar  9 21:42:54 jyro kernel:  [<c0388d26>] inet_ioctl+0x106/0x120
Mar  9 21:42:54 jyro kernel:  [<c0331029>] sys_socket+0x29/0x60
Mar  9 21:42:54 jyro kernel:  [<c0331f52>] sys_socketcall+0x72/0x270
Mar  9 21:42:54 jyro kernel:  [<c0180e2e>] sys_ioctl+0x18e/0x3e0
Mar  9 21:42:54 jyro kernel:  [<c010a403>] syscall_call+0x7/0xb
Mar  9 21:42:54 jyro kernel: 
Mar  9 21:43:03 jyro kernel: 24.55.66.1 sent an invalid ICMP error to a broadcast.
Mar  9 21:43:03 jyro kernel: Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Mar  9 21:43:04 jyro kernel: Module tun cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar  9 21:43:20 jyro kernel: ip_conntrack version 2.1 (4086 buckets, 32688 max) - 324 bytes per conntrack
Mar  9 21:43:20 jyro kernel: Module iptable_filter cannot be unloaded due to unsafe usage in include/linux/module.h:423
Mar  9 21:43:20 jyro kernel: Module iptable_nat cannot be unloaded due to unsafe usage in include/linux/module.h:423
Mar  9 21:43:20 jyro kernel: Module iptable_mangle cannot be unloaded due to unsafe usage in include/linux/module.h:423
Mar  9 21:43:26 jyro kernel: warning: process `update' used the obsolete bdflush system call
Mar  9 21:43:26 jyro kernel: Fix your initscripts?
Mar  9 21:43:29 jyro kernel: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
Mar  9 21:43:31 jyro kernel: warning: process `update' used the obsolete bdflush system call
Mar  9 21:43:31 jyro kernel: Fix your initscripts?

--------------010101060503080600010105--

