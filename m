Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTFTQlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTFTQlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:41:06 -0400
Received: from ip-66-80-37-197.chi.megapath.net ([66.80.37.197]:55812 "HELO
	srvr1.mousebusiness.com") by vger.kernel.org with SMTP
	id S263349AbTFTQhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:37:08 -0400
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Fri, 20 Jun 2003 11:51:08 -0500
Subject: AMD MP, SMP, Tyan 2466
From: kernel <kernel@mousebusiness.com>
To: <linux-kernel@vger.kernel.org>
Message-ID: <BB18A5AC.17043%kernel@mousebusiness.com>
In-Reply-To: <Pine.LNX.4.44.0306200832120.25872-100000@home.transmeta.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm having trouble running my dual AMD MP box in SMP mode. Runs fine in
single CPU mode, but when I enable either RedHat 9.0's stock SMP kernel or
my own brew, I don't have to wait long for crashes, oopses and other strange
behavior. I've tried 2.4.19, 2.4.20 and 2.4.21 with same results. I can run
SMP-enabled kernel with nosmp boot parameter just fine. Only SMP mode causes
trouble. I've been doing research on the web for days, tried mem=nopentium,
noapic, CONFIG_HIGHMEM4G and CONFIG_NOHIGHMEM.

Hardware:
Tyan S2466 motherboard
Two AMD MP 2000+ processors running at 1666MHz
ATI XPert 2000 Pro 32MB AGP video card
On-board 3Com 3c905C-TX ethernet controller
Promise SX6000 RAID controller, latest firmware, with 6 Maxtor 160GB drives
connected to it. Running Promise's driver compiled from source as module as
I couldn't get the i2o driver to cooperate.
1GB PC2100 Corsair DIMM
hda - 80 GB Maxtor drive
hdb - unused
hdc - Yamaha CDR/RW
hdd - open slot for another 80GB Maxtor

I will also put two Linksys Gigabit adaptors in the 64 bit slots once I
figure out what's going on with SMP.

I am experiencing unstability regardless of whether Promise module is
installed or not, so that's not the source of my problems.

I will need some hand-holding in producing documentation that might be
needed to troubleshoot this. Please be patient with me, I'm not really a
kernel hacker and only a wanna-be programmer :)

The log files attached below are from one of the few boot attempts where the
system booted far enough to save log entries to files.

What can I try next?

Artur

Here's my grub.conf so that you know what parameters I start the kernel
with:

title Red Hat Linux (2.4.20-030613a-smp)
    root (hd0,0)
    kernel /boot/vmlinuz-2.4.20-030613a-smp ro root=/dev/hda1 noapic nousb
hdc=ide-scsi ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe
ide6=noprobe ide7=noprobe mem=nopentium
    initrd /boot/initrd-2.4.20-030613a-smp.img
title Red Hat Linux (2.4.20-8smp)
    root (hd0,0)
    kernel /boot/vmlinuz-2.4.20-8smp ro root=/dev/hda1 hdc=ide-scsi noapic
    initrd /boot/initrd-2.4.20-8smp.img
title Red Hat Linux-up (2.4.20-8)
    root (hd0,0)
    kernel /boot/vmlinuz-2.4.20-8 ro root=/dev/hda1 hdc=ide-scsi
    initrd /boot/initrd-2.4.20-8.img

And here's a sample /var/log/messages file with a nice kernel crash followed
by a lockup after restart:

Jun 13 16:51:29 grail syslogd 1.4.1: restart.
Jun 13 16:51:29 grail syslog: syslogd startup succeeded
Jun 13 16:51:29 grail kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jun 13 16:51:29 grail kernel: Linux version 2.4.20-030613a-smp (root@grail)
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #2 SMP Fri Jun 13
16:36:27 CDT 2003
Jun 13 16:51:29 grail kernel: BIOS-provided physical RAM map:
Jun 13 16:51:29 grail kernel:  BIOS-e820: 0000000000000000 -
000000000009e400 (usable)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 000000000009e400 -
00000000000a0000 (reserved)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 00000000000ce000 -
0000000000100000 (reserved)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 0000000000100000 -
000000003ff80000 (usable)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 000000003ff80000 -
0000000040000000 (reserved)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 00000000fec00000 -
00000000fec04000 (reserved)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Jun 13 16:51:29 grail kernel:  BIOS-e820: 00000000fff80000 -
0000000100000000 (reserved)
Jun 13 16:51:29 grail kernel: 127MB HIGHMEM available.
Jun 13 16:51:29 grail kernel: 896MB LOWMEM available.
Jun 13 16:51:29 grail syslog: klogd startup succeeded
Jun 13 16:51:29 grail kernel: found SMP MP-table at 000f7170
Jun 13 16:51:29 grail kernel: hm, page 000f7000 reserved twice.
Jun 13 16:51:29 grail kernel: hm, page 000f8000 reserved twice.
Jun 13 16:51:29 grail kernel: hm, page 0009f000 reserved twice.
Jun 13 16:51:29 grail kernel: hm, page 000a0000 reserved twice.
Jun 13 16:51:29 grail kernel: On node 0 totalpages: 262016
Jun 13 16:51:29 grail kernel: zone(0): 4096 pages.
Jun 13 16:51:29 grail kernel: zone(1): 225280 pages.
Jun 13 16:51:29 grail kernel: zone(2): 32640 pages.
Jun 13 16:51:29 grail kernel: Intel MultiProcessor Specification v1.4
Jun 13 16:51:29 grail kernel:     Virtual Wire compatibility mode.
Jun 13 16:51:29 grail kernel: OEM ID: TYAN     Product ID: PAULANER     APIC
at: 0xFEE00000
Jun 13 16:51:29 grail kernel: Processor #1 Pentium(tm) Pro APIC version 16
Jun 13 16:51:29 grail kernel: Processor #0 Pentium(tm) Pro APIC version 16
Jun 13 16:51:29 grail kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jun 13 16:51:29 grail kernel: Processors: 2
Jun 13 16:51:29 grail kernel: Kernel command line: ro root=/dev/hda1
hdc=ide-scsi
Jun 13 16:51:29 grail kernel: ide_setup: hdc=ide-scsi
Jun 13 16:51:29 grail kernel: Initializing CPU#0
Jun 13 16:51:29 grail kernel: Detected 1666.731 MHz processor.
Jun 13 16:51:29 grail kernel: Console: colour VGA+ 80x25
Jun 13 16:51:29 grail kernel: Calibrating delay loop... 3329.22 BogoMIPS
Jun 13 16:51:29 grail kernel: Memory: 1032756k/1048064k available (1293k
kernel code, 14916k reserved, 329k data, 308k init, 130560k highmem)
Jun 13 16:51:29 grail kernel: Dentry cache hash table entries: 131072
(order: 8, 1048576 bytes)
Jun 13 16:51:29 grail kernel: Inode cache hash table entries: 65536 (order:
7, 524288 bytes)
Jun 13 16:51:29 grail kernel: Mount-cache hash table entries: 16384 (order:
5, 131072 bytes)
Jun 13 16:51:29 grail kernel: Buffer-cache hash table entries: 65536 (order:
6, 262144 bytes)
Jun 13 16:51:29 grail kernel: Page-cache hash table entries: 262144 (order:
8, 1048576 bytes)
Jun 13 16:51:29 grail kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Jun 13 16:51:29 grail kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 13 16:51:29 grail kernel: Intel machine check architecture supported.
Jun 13 16:51:29 grail kernel: Intel machine check reporting enabled on
CPU#0.
Jun 13 16:51:29 grail kernel: Enabling fast FPU save and restore... done.
Jun 13 16:51:29 grail kernel: Enabling unmasked SIMD FPU exception
support... done.
Jun 13 16:51:29 grail kernel: Checking 'hlt' instruction... OK.
Jun 13 16:51:29 grail kernel: POSIX conformance testing by UNIFIX
Jun 13 16:51:29 grail kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Jun 13 16:51:29 grail kernel: mtrr: detected mtrr type: Intel
Jun 13 16:51:29 grail kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Jun 13 16:51:29 grail kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 13 16:51:29 grail kernel: Intel machine check reporting enabled on
CPU#0.
Jun 13 16:51:29 grail kernel: CPU0: AMD Athlon(tm) MP 2000+ stepping 02
Jun 13 16:51:29 grail kernel: per-CPU timeslice cutoff: 731.44 usecs.
Jun 13 16:51:29 grail kernel: masked ExtINT on CPU#0
Jun 13 16:51:29 grail portmap: portmap startup succeeded
Jun 13 16:51:29 grail kernel: ESR value before enabling vector: 00000000
Jun 13 16:51:29 grail kernel: ESR value after enabling vector: 00000000
Jun 13 16:51:29 grail kernel: Booting processor 1/0 eip 2000
Jun 13 16:51:29 grail kernel: Initializing CPU#1
Jun 13 16:51:29 grail kernel: masked ExtINT on CPU#1
Jun 13 16:51:29 grail kernel: ESR value before enabling vector: 00000000
Jun 13 16:51:29 grail kernel: ESR value after enabling vector: 00000000
Jun 13 16:51:29 grail kernel: Calibrating delay loop... 3329.22 BogoMIPS
Jun 13 16:51:29 grail kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Jun 13 16:51:29 grail kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 13 16:51:29 grail kernel: Intel machine check reporting enabled on
CPU#1.
Jun 13 16:51:29 grail kernel: CPU1: AMD Athlon(tm) Processor stepping 02
Jun 13 16:51:29 grail kernel: Total of 2 processors activated (6658.45
BogoMIPS).
Jun 13 16:51:29 grail kernel: ENABLING IO-APIC IRQs
Jun 13 16:51:29 grail kernel: Setting 2 in the phys_id_present_map
Jun 13 16:51:29 grail kernel: ...changing IO-APIC physical APIC ID to 2 ...
ok.
Jun 13 16:51:29 grail kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jun 13 16:51:30 grail kernel: testing the IO APIC.......................
Jun 13 16:51:30 grail kernel:
Jun 13 16:51:30 grail kernel: .................................... done.
Jun 13 16:51:30 grail kernel: Using local APIC timer interrupts.
Jun 13 16:51:30 grail kernel: calibrating APIC timer ...
Jun 13 16:51:30 grail kernel: ..... CPU clock speed is 1666.8222 MHz.
Jun 13 16:51:30 grail kernel: ..... host bus clock speed is 266.6915 MHz.
Jun 13 16:51:30 grail kernel: cpu: 0, clocks: 2666915, slice: 888971
Jun 13 16:51:30 grail kernel:
CPU0<T0:2666912,T1:1777936,D:5,S:888971,C:2666915>
Jun 13 16:51:30 grail kernel: cpu: 1, clocks: 2666915, slice: 888971
Jun 13 16:51:30 grail kernel:
CPU1<T0:2666912,T1:888960,D:10,S:888971,C:2666915>
Jun 13 16:51:30 grail kernel: checking TSC synchronization across CPUs:
passed.
Jun 13 16:51:30 grail kernel: Waiting on wait_init_idle (map = 0x2)
Jun 13 16:51:30 grail kernel: All processors have done init_idle
Jun 13 16:51:30 grail rpc.statd[412]: Version 1.0.1 Starting
Jun 13 16:51:30 grail kernel: mtrr: your CPUs had inconsistent fixed MTRR
settings
Jun 13 16:51:30 grail nfslock: rpc.statd startup succeeded
Jun 13 16:51:30 grail kernel: mtrr: probably your BIOS does not setup all
CPUs
Jun 13 16:51:30 grail kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7d0,
last bus=3
Jun 13 16:51:30 grail kernel: PCI: Using configuration type 1
Jun 13 16:51:30 grail kernel: PCI: Probing PCI hardware
Jun 13 16:51:30 grail kernel: PCI->APIC IRQ transform: (B1,I5,P0) -> 18
Jun 13 16:51:30 grail kernel: PCI->APIC IRQ transform: (B2,I0,P3) -> 19
Jun 13 16:51:30 grail kernel: PCI->APIC IRQ transform: (B2,I5,P0) -> 17
Jun 13 16:51:30 grail kernel: PCI->APIC IRQ transform: (B2,I8,P0) -> 19
Jun 13 16:51:30 grail kernel: BIOS failed to enable PCI standards
compliance, fixing this error.
Jun 13 16:51:30 grail kernel: isapnp: Scanning for PnP cards...
Jun 13 16:51:30 grail kernel: isapnp: No Plug & Play device found
Jun 13 16:51:30 grail kernel: Linux NET4.0 for Linux 2.4
Jun 13 16:51:30 grail kernel: Based upon Swansea University Computer Society
NET3.039
Jun 13 16:51:30 grail kernel: Initializing RT netlink socket
Jun 13 16:51:30 grail kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16)
Jun 13 16:51:30 grail kernel: apm: disabled - APM is not SMP safe.
Jun 13 16:51:30 grail keytable: Loading keymap:
Jun 13 16:51:30 grail kernel: Starting kswapd
Jun 13 16:51:30 grail kernel: allocated 32 pages and 32 bhs reserved for the
highmem bounces
Jun 13 16:51:30 grail kernel: VFS: Diskquotas version dquot_6.4.0
initialized
Jun 13 16:51:30 grail kernel: Journalled Block Device driver loaded
Jun 13 16:51:30 grail kernel: pty: 2048 Unix98 ptys configured
Jun 13 16:51:30 grail kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jun 13 16:51:30 grail kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jun 13 16:51:30 grail kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jun 13 16:51:30 grail kernel: Real Time Clock Driver v1.10e
Jun 13 16:51:30 grail kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Jun 13 16:51:30 grail kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jun 13 16:51:30 grail kernel: AMD7441: IDE controller on PCI bus 00 dev 39
Jun 13 16:51:30 grail keytable:
Jun 13 16:51:30 grail kernel: AMD7441: chipset revision 4
Jun 13 16:51:30 grail keytable: Loading system font:
Jun 13 16:51:30 grail kernel: AMD7441: not 100%% native mode: will probe
irqs later
Jun 13 16:51:30 grail kernel: AMD7441: disabling single-word DMA support
(revision < C4)
Jun 13 16:51:30 grail kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Jun 13 16:51:30 grail kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:DMA
Jun 13 16:51:30 grail kernel: hda: MAXTOR 6L080J4, ATA DISK drive
Jun 13 16:51:30 grail kernel: hdc: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
Jun 13 16:51:30 grail kernel: hdd: MAXTOR 6L080J4, ATA DISK drive
Jun 13 16:51:30 grail kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 13 16:51:30 grail kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 13 16:51:30 grail keytable:
Jun 13 16:51:30 grail kernel: blk: queue c034cd64, I/O limit 4095Mb (mask
0xffffffff)
Jun 13 16:51:30 grail kernel: hda: 156355584 sectors (80054 MB) w/1819KiB
Cache, CHS=155114/16/63, UDMA(100)
Jun 13 16:51:30 grail rc: Starting keytable:  succeeded
Jun 13 16:51:30 grail kernel: blk: queue c034d214, I/O limit 4095Mb (mask
0xffffffff)
Jun 13 16:51:30 grail kernel: hdd: 156355584 sectors (80054 MB) w/1819KiB
Cache, CHS=155114/16/63, UDMA(100)
Jun 13 16:51:30 grail kernel: Partition check:
Jun 13 16:51:30 grail kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Jun 13 16:51:30 grail kernel:  hdd: hdd1 hdd2 hdd3 hdd4 < hdd5 hdd6 >
Jun 13 16:51:30 grail kernel: Floppy drive(s): fd0 is 1.44M
Jun 13 16:51:30 grail kernel: FDC 0 is a post-1991 82077
Jun 13 16:51:30 grail kernel: RAMDISK driver initialized: 16 RAM disks of
4096K size 1024 blocksize
Jun 13 16:51:30 grail kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Jun 13 16:51:30 grail kernel: md: Autodetecting RAID arrays.
Jun 13 16:51:30 grail kernel: md: autorun ...
Jun 13 16:51:30 grail kernel: md: ... autorun DONE.
Jun 13 16:51:30 grail kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun 13 16:51:30 grail kernel: IP Protocols: ICMP, UDP, TCP
Jun 13 16:51:30 grail kernel: IP: routing cache hash table of 8192 buckets,
64Kbytes
Jun 13 16:51:30 grail kernel: TCP: Hash tables configured (established
262144 bind 65536)
Jun 13 16:51:30 grail kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jun 13 16:51:30 grail kernel: RAMDISK: Compressed image found at block 0
Jun 13 16:51:30 grail kernel: Freeing initrd memory: 83k freed
Jun 13 16:51:30 grail kernel: VFS: Mounted root (ext2 filesystem).
Jun 13 16:51:30 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 16:51:30 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 16:51:30 grail kernel: Freeing unused kernel memory: 308k freed
Jun 13 16:51:30 grail kernel: usb.c: registered new driver usbdevfs
Jun 13 16:51:30 grail kernel: usb.c: registered new driver hub
Jun 13 16:51:30 grail kernel: usb-ohci.c: USB OHCI at membase 0xf8829000,
IRQ 19
Jun 13 16:51:30 grail kernel: usb-ohci.c: usb-02:00.0, Advanced Micro
Devices [AMD] AMD-768 [Opus] USB
Jun 13 16:51:30 grail kernel: usb.c: new USB bus registered, assigned bus
number 1
Jun 13 16:51:30 grail kernel: hub.c: USB hub found
Jun 13 16:51:30 grail kernel: hub.c: 4 ports detected
Jun 13 16:51:30 grail kernel: mice: PS/2 mouse device common for all mice
Jun 13 16:51:30 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,1), internal journal
Jun 13 16:51:30 grail random: Initializing random number generator:
succeeded
Jun 13 16:51:30 grail kernel: Adding Swap: 1048816k swap-space (priority -1)
Jun 13 16:51:30 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 16:51:30 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,6), internal journal
Jun 13 16:51:30 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 16:51:30 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 16:51:30 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,5), internal journal
Jun 13 16:51:30 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 16:51:30 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 16:51:30 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,2), internal journal
Jun 13 16:51:30 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 16:51:30 grail kernel: SCSI subsystem driver Revision: 1.00
Jun 13 16:51:30 grail kernel: scsi0 : SCSI host adapter emulation for IDE
ATAPI devices
Jun 13 16:51:30 grail kernel:   Vendor: YAMAHA    Model: CRW2200E
Rev: 1.0B
Jun 13 16:51:30 grail kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
Jun 13 16:51:30 grail kernel: kernel BUG at page_alloc.c:100!
Jun 13 16:51:30 grail kernel: invalid operand: 0000
Jun 13 16:51:30 grail kernel: CPU:    0
Jun 13 16:51:30 grail kernel: EIP:    0010:[<c013b0c2>]    Not tainted
Jun 13 16:51:30 grail kernel: EFLAGS: 00010282
Jun 13 16:51:30 grail kernel: eax: c1a847ac   ebx: c1a84760   ecx: f7fe6270
edx: c1a842cc
Jun 13 16:51:30 grail kernel: esi: 000000b2   edi: 00000000   ebp: 000000b2
esp: f7861e3c
Jun 13 16:51:30 grail kernel: ds: 0018   es: 0018   ss: 0018
Jun 13 16:51:30 grail rc: Starting pcmcia:  succeeded
Jun 13 16:51:30 grail kernel: Process initlog (pid: 13, stackpage=f7861000)
Jun 13 16:51:30 grail kernel: Stack: c0281038 c1000020 c1a84820 c0280fa8
c1a80020 00000217 fffffffc 00000030
Jun 13 16:51:30 grail kernel:        00000003 000000b2 08105000 000000b2
c012eb6f c1a84760 f7862080 08051000
Jun 13 16:51:30 grail kernel:        000b4000 08451000 c02f6800 000000b2
08105000 f7862084 f78d0ac0 f78d2e00
Jun 13 16:51:30 grail kernel: Call Trace:    [<c012eb6f>] [<c0131b04>]
[<c011ce2b>] [<c012240c>] [<c0128fb3>]
Jun 13 16:51:30 grail kernel:   [<c01291b5>] [<c0108ee2>] [<c01554df>]
[<c0154b7a>] [<c0155823>] [<c0109238>]
Jun 13 16:51:30 grail kernel:
Jun 13 16:51:30 grail kernel: Code: 0f 0b 64 00 74 29 25 c0 8b 53 08 85 d2
74 08 0f 0b 66 00 74
Jun 13 16:51:30 grail kernel:  <6>parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
Jun 13 16:51:30 grail kernel: parport0: irq 7 detected
Jun 13 16:51:30 grail netfs: Mounting other filesystems:  succeeded
Jun 13 16:51:30 grail autofs: automount startup succeeded
Jun 13 16:51:30 grail sshd:  succeeded
Jun 13 16:51:29 grail sysctl: net.ipv4.ip_forward = 0
Jun 13 16:51:29 grail sysctl: net.ipv4.conf.default.rp_filter = 1
Jun 13 16:51:29 grail sysctl: kernel.sysrq = 0
Jun 13 16:51:29 grail sysctl: kernel.core_uses_pid = 1
Jun 13 16:51:29 grail network: Setting network parameters:  succeeded
Jun 13 16:51:29 grail ifup: grep: relocation error: grep: symbol , version
GLIBC_2.0 not defined in file libc.so.6 with link time reference
Jun 13 16:51:29 grail ifup: grep: relocation error: grep: symbol , version
GLIBC_2.0 not defined in file libc.so.6 with link time reference
Jun 13 16:51:29 grail network: Bringing up loopback interface:  succeeded
Jun 13 16:51:29 grail ifup: grep: relocation error: grep: symbol , version
GLIBC_2.0 not defined in file libc.so.6 with link time reference
Jun 13 16:51:29 grail network: Bringing up interface eth0:  succeeded
Jun 13 16:51:32 grail xinetd[522]: xinetd Version 2.3.10 started with
libwrap options compiled in.
Jun 13 16:51:32 grail xinetd[522]: Started working: 1 available service
Jun 13 16:51:34 grail xinetd: xinetd startup succeeded
Jun 13 16:51:34 grail sendmail: sendmail startup succeeded
Jun 13 16:51:34 grail sendmail: sm-client startup succeeded
Jun 13 16:51:34 grail gpm: gpm startup succeeded
Jun 13 16:51:35 grail crond: crond startup succeeded
Jun 13 16:51:36 grail kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
Jun 13 16:51:36 grail kernel: parport0: irq 7 detected
Jun 13 16:51:36 grail kernel: lp0: using parport0 (polling).
Jun 13 16:51:36 grail kernel: lp0: console ready
Jun 13 16:51:36 grail modprobe: modprobe: Can't locate module char-major-188
Jun 13 16:51:36 grail last message repeated 15 times
Jun 13 16:51:37 grail cups: cupsd startup succeeded
Jun 13 16:51:37 grail xfs: xfs startup succeeded
Jun 13 16:51:37 grail anacron: anacron startup succeeded
Jun 13 16:51:37 grail atd: atd startup succeeded
Jun 13 16:51:37 grail xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Jun 13 16:51:43 grail login(pam_unix)[668]: session opened for user root by
LOGIN(uid=0)
Jun 13 16:51:43 grail  -- root[668]: ROOT LOGIN ON tty1
Jun 13 16:54:47 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 16:54:47 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide1(22,65), internal journal
Jun 13 16:54:47 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 16:56:29 grail shutdown: shutting down for system reboot
Jun 13 16:56:29 grail init: Switching to runlevel: 6
Jun 13 16:56:29 grail login(pam_unix)[668]: session closed for user root
Jun 13 16:56:30 grail atd: atd shutdown succeeded
Jun 13 16:56:30 grail init: no more processes left in this runlevel
Jun 13 16:56:40 grail shutdown: shutting down for system reboot
Jun 13 17:00:09 grail syslogd 1.4.1: restart.
Jun 13 17:00:09 grail syslog: syslogd startup succeeded
Jun 13 17:00:09 grail kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jun 13 17:00:09 grail kernel: Linux version 2.4.20-030613a-smp (root@grail)
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #2 SMP Fri Jun 13
16:36:27 CDT 2003
Jun 13 17:00:09 grail kernel: BIOS-provided physical RAM map:
Jun 13 17:00:09 grail kernel:  BIOS-e820: 0000000000000000 -
000000000009e400 (usable)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 000000000009e400 -
00000000000a0000 (reserved)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 00000000000ce000 -
0000000000100000 (reserved)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 0000000000100000 -
000000003ff80000 (usable)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 000000003ff80000 -
0000000040000000 (reserved)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 00000000fec00000 -
00000000fec04000 (reserved)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Jun 13 17:00:09 grail kernel:  BIOS-e820: 00000000fff80000 -
0000000100000000 (reserved)
Jun 13 17:00:09 grail kernel: 127MB HIGHMEM available.
Jun 13 17:00:09 grail kernel: 896MB LOWMEM available.
Jun 13 17:00:09 grail kernel: found SMP MP-table at 000f7170
Jun 13 17:00:09 grail kernel: hm, page 000f7000 reserved twice.
Jun 13 17:00:09 grail kernel: hm, page 000f8000 reserved twice.
Jun 13 17:00:09 grail syslog: klogd startup succeeded
Jun 13 17:00:09 grail kernel: hm, page 0009f000 reserved twice.
Jun 13 17:00:09 grail kernel: hm, page 000a0000 reserved twice.
Jun 13 17:00:09 grail kernel: On node 0 totalpages: 262016
Jun 13 17:00:09 grail kernel: zone(0): 4096 pages.
Jun 13 17:00:09 grail kernel: zone(1): 225280 pages.
Jun 13 17:00:09 grail kernel: zone(2): 32640 pages.
Jun 13 17:00:09 grail kernel: Intel MultiProcessor Specification v1.4
Jun 13 17:00:09 grail kernel:     Virtual Wire compatibility mode.
Jun 13 17:00:09 grail kernel: OEM ID: TYAN     Product ID: PAULANER     APIC
at: 0xFEE00000
Jun 13 17:00:09 grail kernel: Processor #1 Pentium(tm) Pro APIC version 16
Jun 13 17:00:09 grail kernel: Processor #0 Pentium(tm) Pro APIC version 16
Jun 13 17:00:09 grail kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jun 13 17:00:09 grail kernel: Processors: 2
Jun 13 17:00:09 grail kernel: Kernel command line: ro root=/dev/hda1
mem=nopentium noapic nousb hdc=ide-scsi ide2=noprobe ide3=noprobe
ide4=noprobe ide5=noprobe ide6=noprobe ide7=noprobe
Jun 13 17:00:09 grail kernel: ide_setup: hdc=ide-scsi
Jun 13 17:00:09 grail kernel: ide_setup: ide2=noprobe
Jun 13 17:00:09 grail kernel: ide_setup: ide3=noprobe
Jun 13 17:00:09 grail kernel: ide_setup: ide4=noprobe
Jun 13 17:00:09 grail kernel: ide_setup: ide5=noprobe
Jun 13 17:00:09 grail kernel: ide_setup: ide6=noprobe
Jun 13 17:00:09 grail kernel: ide_setup: ide7=noprobe
Jun 13 17:00:09 grail kernel: Initializing CPU#0
Jun 13 17:00:09 grail kernel: Detected 1666.763 MHz processor.
Jun 13 17:00:09 grail kernel: Console: colour VGA+ 80x25
Jun 13 17:00:09 grail kernel: Calibrating delay loop... 3322.67 BogoMIPS
Jun 13 17:00:09 grail kernel: Memory: 1031860k/1048064k available (1293k
kernel code, 15812k reserved, 329k data, 308k init, 130560k highmem)
Jun 13 17:00:09 grail kernel: Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Jun 13 17:00:09 grail kernel: Dentry cache hash table entries: 131072
(order: 8, 1048576 bytes)
Jun 13 17:00:09 grail kernel: Inode cache hash table entries: 65536 (order:
7, 524288 bytes)
Jun 13 17:00:09 grail kernel: Mount-cache hash table entries: 16384 (order:
5, 131072 bytes)
Jun 13 17:00:09 grail kernel: Buffer-cache hash table entries: 65536 (order:
6, 262144 bytes)
Jun 13 17:00:09 grail kernel: Page-cache hash table entries: 262144 (order:
8, 1048576 bytes)
Jun 13 17:00:09 grail kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Jun 13 17:00:09 grail kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 13 17:00:09 grail kernel: Intel machine check architecture supported.
Jun 13 17:00:09 grail kernel: Intel machine check reporting enabled on
CPU#0.
Jun 13 17:00:09 grail kernel: Enabling fast FPU save and restore... done.
Jun 13 17:00:09 grail kernel: Enabling unmasked SIMD FPU exception
support... done.
Jun 13 17:00:09 grail kernel: Checking 'hlt' instruction... OK.
Jun 13 17:00:09 grail kernel: POSIX conformance testing by UNIFIX
Jun 13 17:00:09 grail kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Jun 13 17:00:09 grail kernel: mtrr: detected mtrr type: Intel
Jun 13 17:00:09 grail kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Jun 13 17:00:09 grail portmap: portmap startup succeeded
Jun 13 17:00:09 grail kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 13 17:00:09 grail kernel: Intel machine check reporting enabled on
CPU#0.
Jun 13 17:00:09 grail kernel: CPU0: AMD Athlon(tm) MP 2000+ stepping 02
Jun 13 17:00:09 grail kernel: per-CPU timeslice cutoff: 731.44 usecs.
Jun 13 17:00:09 grail kernel: masked ExtINT on CPU#0
Jun 13 17:00:09 grail kernel: ESR value before enabling vector: 00000000
Jun 13 17:00:09 grail kernel: ESR value after enabling vector: 00000000
Jun 13 17:00:09 grail kernel: Booting processor 1/0 eip 2000
Jun 13 17:00:09 grail kernel: Initializing CPU#1
Jun 13 17:00:09 grail kernel: masked ExtINT on CPU#1
Jun 13 17:00:09 grail kernel: ESR value before enabling vector: 00000000
Jun 13 17:00:09 grail kernel: ESR value after enabling vector: 00000000
Jun 13 17:00:09 grail kernel: Calibrating delay loop... 3329.22 BogoMIPS
Jun 13 17:00:09 grail kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Jun 13 17:00:09 grail kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 13 17:00:09 grail kernel: Intel machine check reporting enabled on
CPU#1.
Jun 13 17:00:09 grail kernel: CPU1: AMD Athlon(tm) Processor stepping 02
Jun 13 17:00:09 grail kernel: Total of 2 processors activated (6651.90
BogoMIPS).
Jun 13 17:00:09 grail kernel: Using local APIC timer interrupts.
Jun 13 17:00:09 grail kernel: calibrating APIC timer ...
Jun 13 17:00:09 grail kernel: ..... CPU clock speed is 1666.8537 MHz.
Jun 13 17:00:09 grail kernel: ..... host bus clock speed is 266.6966 MHz.
Jun 13 17:00:09 grail kernel: cpu: 0, clocks: 2666966, slice: 888988
Jun 13 17:00:09 grail kernel:
CPU0<T0:2666960,T1:1777968,D:4,S:888988,C:2666966>
Jun 13 17:00:09 grail kernel: cpu: 1, clocks: 2666966, slice: 888988
Jun 13 17:00:09 grail kernel:
CPU1<T0:2666960,T1:888976,D:8,S:888988,C:2666966>
Jun 13 17:00:09 grail kernel: checking TSC synchronization across CPUs:
passed.
Jun 13 17:00:09 grail kernel: Waiting on wait_init_idle (map = 0x2)
Jun 13 17:00:09 grail kernel: All processors have done init_idle
Jun 13 17:00:09 grail kernel: mtrr: your CPUs had inconsistent fixed MTRR
settings
Jun 13 17:00:09 grail kernel: mtrr: probably your BIOS does not setup all
CPUs
Jun 13 17:00:09 grail kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7d0,
last bus=3
Jun 13 17:00:09 grail kernel: PCI: Using configuration type 1
Jun 13 17:00:09 grail kernel: PCI: Probing PCI hardware
Jun 13 17:00:09 grail kernel: BIOS failed to enable PCI standards
compliance, fixing this error.
Jun 13 17:00:09 grail kernel: isapnp: Scanning for PnP cards...
Jun 13 17:00:09 grail rpc.statd[459]: Version 1.0.1 Starting
Jun 13 17:00:09 grail kernel: isapnp: No Plug & Play device found
Jun 13 17:00:09 grail nfslock: rpc.statd startup succeeded
Jun 13 17:00:09 grail kernel: Linux NET4.0 for Linux 2.4
Jun 13 17:00:09 grail kernel: Based upon Swansea University Computer Society
NET3.039
Jun 13 17:00:09 grail kernel: Initializing RT netlink socket
Jun 13 17:00:09 grail kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16)
Jun 13 17:00:09 grail kernel: apm: disabled - APM is not SMP safe.
Jun 13 17:00:09 grail kernel: Starting kswapd
Jun 13 17:00:09 grail kernel: allocated 32 pages and 32 bhs reserved for the
highmem bounces
Jun 13 17:00:09 grail kernel: VFS: Diskquotas version dquot_6.4.0
initialized
Jun 13 17:00:09 grail kernel: Journalled Block Device driver loaded
Jun 13 17:00:09 grail kernel: pty: 2048 Unix98 ptys configured
Jun 13 17:00:09 grail kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jun 13 17:00:09 grail kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jun 13 17:00:09 grail kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jun 13 17:00:09 grail kernel: Real Time Clock Driver v1.10e
Jun 13 17:00:09 grail kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Jun 13 17:00:09 grail kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jun 13 17:00:09 grail kernel: AMD7441: IDE controller on PCI bus 00 dev 39
Jun 13 17:00:09 grail kernel: AMD7441: chipset revision 4
Jun 13 17:00:09 grail keytable: Loading keymap:
Jun 13 17:00:09 grail kernel: AMD7441: not 100%% native mode: will probe
irqs later
Jun 13 17:00:09 grail kernel: AMD7441: disabling single-word DMA support
(revision < C4)
Jun 13 17:00:09 grail kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Jun 13 17:00:09 grail kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:pio
Jun 13 17:00:09 grail kernel: hda: MAXTOR 6L080J4, ATA DISK drive
Jun 13 17:00:09 grail kernel: hdc: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
Jun 13 17:00:09 grail kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 13 17:00:09 grail kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 13 17:00:09 grail kernel: blk: queue c034cd64, I/O limit 4095Mb (mask
0xffffffff)
Jun 13 17:00:09 grail kernel: hda: 156355584 sectors (80054 MB) w/1819KiB
Cache, CHS=155114/16/63, UDMA(100)
Jun 13 17:00:09 grail kernel: Partition check:
Jun 13 17:00:09 grail kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Jun 13 17:00:09 grail keytable:
Jun 13 17:00:09 grail kernel: Floppy drive(s): fd0 is 1.44M
Jun 13 17:00:09 grail keytable: Loading system font:
Jun 13 17:00:09 grail kernel: FDC 0 is a post-1991 82077
Jun 13 17:00:09 grail kernel: RAMDISK driver initialized: 16 RAM disks of
4096K size 1024 blocksize
Jun 13 17:00:09 grail kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Jun 13 17:00:09 grail kernel: md: Autodetecting RAID arrays.
Jun 13 17:00:09 grail kernel: md: autorun ...
Jun 13 17:00:09 grail kernel: md: ... autorun DONE.
Jun 13 17:00:09 grail kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun 13 17:00:09 grail kernel: IP Protocols: ICMP, UDP, TCP
Jun 13 17:00:09 grail kernel: IP: routing cache hash table of 8192 buckets,
64Kbytes
Jun 13 17:00:09 grail kernel: TCP: Hash tables configured (established
262144 bind 65536)
Jun 13 17:00:09 grail keytable:
Jun 13 17:00:09 grail kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jun 13 17:00:09 grail rc: Starting keytable:  succeeded
Jun 13 17:00:09 grail kernel: RAMDISK: Compressed image found at block 0
Jun 13 17:00:09 grail kernel: Freeing initrd memory: 83k freed
Jun 13 17:00:09 grail kernel: VFS: Mounted root (ext2 filesystem).
Jun 13 17:00:09 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 17:00:09 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 17:00:09 grail kernel: Freeing unused kernel memory: 308k freed
Jun 13 17:00:09 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,1), internal journal
Jun 13 17:00:09 grail kernel: Adding Swap: 1048816k swap-space (priority -1)
Jun 13 17:00:09 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 17:00:09 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,6), internal journal
Jun 13 17:00:09 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 17:00:09 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 17:00:09 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,5), internal journal
Jun 13 17:00:09 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 17:00:09 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 17:00:10 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,2), internal journal
Jun 13 17:00:10 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 17:00:10 grail kernel: SCSI subsystem driver Revision: 1.00
Jun 13 17:00:10 grail kernel: scsi0 : SCSI host adapter emulation for IDE
ATAPI devices
Jun 13 17:00:10 grail kernel:   Vendor: YAMAHA    Model: CRW2200E
Rev: 1.0B
Jun 13 17:00:10 grail kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
Jun 13 17:00:10 grail kernel: usb.c: registered new driver usbdevfs
Jun 13 17:00:10 grail kernel: usb.c: registered new driver hub
Jun 13 17:00:10 grail kernel: usb-ohci.c: USB OHCI at membase 0xf88df000,
IRQ 10
Jun 13 17:00:10 grail kernel: usb-ohci.c: usb-02:00.0, Advanced Micro
Devices [AMD] AMD-768 [Opus] USB
Jun 13 17:00:10 grail kernel: usb.c: new USB bus registered, assigned bus
number 1
Jun 13 17:00:10 grail kernel: hub.c: USB hub found
Jun 13 17:00:10 grail kernel: hub.c: 4 ports detected
Jun 13 17:00:10 grail kernel: usb.c: USB disconnect on device 02:00.0-0
address 1
Jun 13 17:00:10 grail random: Initializing random number generator:
succeeded
Jun 13 17:00:10 grail kernel: usb.c: USB bus 1 deregistered
Jun 13 17:00:10 grail kernel: usb.c: deregistering driver usbdevfs
Jun 13 17:00:10 grail kernel: usb.c: deregistering driver hub
Jun 13 17:00:10 grail kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
Jun 13 17:00:10 grail kernel: parport0: irq 7 detected
Jun 13 17:00:10 grail kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0,
id 0, lun 0
Jun 13 17:00:10 grail kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw
xa/form2 cdda tray
Jun 13 17:00:10 grail kernel: Uniform CD-ROM driver Revision: 3.12
Jun 13 17:00:10 grail kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Jun 13 17:00:10 grail kernel: 02:08.0: 3Com PCI 3c905C Tornado at 0x3000.
Vers LK1.1.16
Jun 13 17:00:10 grail rc: Starting pcmcia:  succeeded
Jun 13 17:00:10 grail netfs: Mounting other filesystems:  succeeded
Jun 13 17:00:10 grail autofs: automount startup succeeded
Jun 13 17:00:10 grail sshd:  succeeded
Jun 13 17:00:07 grail network: Setting network parameters:  succeeded
Jun 13 17:00:07 grail network: Bringing up loopback interface:  succeeded
Jun 13 17:00:12 grail xinetd[569]: xinetd Version 2.3.10 started with
libwrap options compiled in.
Jun 13 17:00:12 grail xinetd[569]: Started working: 1 available service
Jun 13 17:00:13 grail xinetd: xinetd startup succeeded
Jun 13 17:00:14 grail sendmail: sendmail startup succeeded
Jun 13 17:00:14 grail sendmail: sm-client startup succeeded
Jun 13 17:00:14 grail gpm: gpm startup succeeded
Jun 13 17:00:15 grail crond: crond startup succeeded
Jun 13 17:00:16 grail kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
Jun 13 17:00:16 grail kernel: parport0: irq 7 detected
Jun 13 17:00:16 grail kernel: lp0: using parport0 (polling).
Jun 13 17:00:16 grail kernel: lp0: console ready
Jun 13 17:00:16 grail kernel: spurious 8259A interrupt: IRQ7.
Jun 13 17:00:16 grail modprobe: modprobe: Can't locate module char-major-188
Jun 13 17:00:16 grail last message repeated 15 times
Jun 13 17:00:16 grail modprobe: modprobe: Can't locate module char-major-180
Jun 13 17:00:16 grail last message repeated 15 times
Jun 13 17:00:16 grail cups: cupsd startup succeeded
Jun 13 17:00:17 grail xfs: xfs startup succeeded
Jun 13 17:00:17 grail anacron: anacron startup succeeded
Jun 13 17:00:17 grail atd: atd startup succeeded
Jun 13 17:00:17 grail xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Jun 13 17:00:27 grail login(pam_unix)[731]: session opened for user root by
LOGIN(uid=0)
Jun 13 17:00:27 grail  -- root[731]: ROOT LOGIN ON tty1
Jun 13 17:00:36 grail kernel: Found PTI SuperTrak at mbase: 0xf0800000, irq
5.
Jun 13 17:00:36 grail kernel:  Timeout wait for IOP Status Get Ready!
Jun 13 17:00:36 grail last message repeated 2 times
Jun 13 17:00:36 grail kernel: scsi1 : PROMISE SuperTrak SX6000 Driver
Jun 13 17:00:36 grail kernel:   Vendor: PTI       Model: SuperTrak
Rev:     
Jun 13 17:00:36 grail kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Jun 13 17:11:20 grail kernel: Attached scsi disk sda at scsi1, channel 0, id
0, lun 0
Jun 13 17:11:20 grail kernel: SCSI device sda: 1273437184 512-byte hdwr
sectors (-447511 MB)
Jun 13 17:11:20 grail kernel:  sda: sda1
Jun 13 17:11:21 grail kernel: kjournald starting.  Commit interval 5 seconds
Jun 13 17:11:21 grail kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1),
internal journal
Jun 13 17:11:21 grail kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jun 13 17:13:51 grail kernel: invalidate: busy buffer
Jun 13 17:19:42 grail syslogd 1.4.1: restart.
Jun 13 17:19:42 grail syslog: syslogd startup succeeded
Jun 13 17:19:42 grail syslog: ^[[60G[
Jun 13 17:19:42 grail rc: Starting syslog:  failed
Jun 13 17:19:42 grail portmap: Starting portmapper:

[SYSTEM HANGS HERE]


