Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSCTBC6>; Tue, 19 Mar 2002 20:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310681AbSCTBCq>; Tue, 19 Mar 2002 20:02:46 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:61637 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S310435AbSCTBCQ> convert rfc822-to-8bit; Tue, 19 Mar 2002 20:02:16 -0500
Date: Tue, 19 Mar 2002 19:02:11 -0600
From: Ken Brownfield <ken@irridia.com>
To: m.knoblauch@TeraPort.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP (RH7.2)
Message-ID: <20020319190211.B15811@asooo.flowerfire.com>
In-Reply-To: <3C97867C.701970C8@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll take a leap and guess that this is DMA.

Disable DMA, or go to MDMA2 would be my suggestion.  I don't think I've
used a Tyan board yet that doesn't get something horribly wrong.  Make
sure DMA is currently active with 'hdparm -d /dev/hda' though -- the
dmesg output can be misleading.

We're seeing this with Tyan 2410s and Seagate drives.  I think Tyan just
can't get DMA right.  Luckily we mainly lost docs or man pages before we
disabled DMA, although losing the rpm database sucked.  MDMA2 seems okay
but we haven't tested it long enough to form a lasting impression.

Side notes:

There are issues with CONFIG_IDEDMA{,_PCI}_AUTO in 2.4 that Martin fixed
(AFAIK), so I would suggest using hdparm at boot ('hdparm -d0 /dev/hda'
or 'hdparm -X34 /dev/hda') until those CONFIG options work when false.

I'm actually patching the ServerWorks driver to honor the CONFIG flag,
since even with hdparm there is a narrow risk to the fs during the boot
process before DMA is disabled.

Unless you want to compile DMA out of your kernels... but I actually
have some non-Tyan hardware that doesn't need to be crippled, and I
don't want to separate DMA vs non-DMA kernels.

Hope it helps, 
-- 
Ken.
ken@irridia.com

On Tue, Mar 19, 2002 at 07:42:04PM +0100, Martin Knoblauch wrote:
| Hi,
| 
|  what could be the cause of filesystem corruption on a Tyan Thunder 2462
| dual Athlon 1900MP? The system has 2GB "registered" ECC memory and is
| running a 2.4.17SMP kernel.
| 
|  A customer of us has 8 of these beasts and one has started "acting up".
| Basically destroying the root partition withing minutes after booting a
| fresh installation. The other 7 (identical) systems are OK. Is there
| anything that one should look for (like the noapic thing).
| 
|  Included is the messages file with three boot sequences. Interestingly
| the first sequence seems to misdetect the system completetly .... At the
| end of the file the number of junk characters seems to increase quite a
| bit :-(
| 
|  Unfortunatelly I am just in remote debugging mode right now. Guess I
| will see the system on thursday.
| 
| TIA
| Martin
| -- 
| ------------------------------------------------------------------
| Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
| TeraPort GmbH            |    Phone:  +49-89-510857-309
| C+ITS                    |    Fax:    +49-89-510857-111
| http://www.teraport.de   |    Mobile: +49-170-4904759
| Mar 19 09:11:14 fems146 syslogd 1.4.1: restart.
| Mar 19 09:11:14 fems146 syslog: syslogd startup succeeded
| Mar 19 09:11:14 fems146 syslog: klogd startup succeeded
| Mar 19 09:11:14 fems146 kernel: klogd 1.4.1, log source = /proc/kmsg started.
| Mar 19 09:11:14 fems146 kernel: Inspecting /boot/System.map-2.4.17smp
| Mar 19 09:11:14 fems146 portmap: portmap startup succeeded
| Mar 19 09:11:14 fems146 kernel: Loaded 16042 symbols from /boot/System.map-2.4.17smp.
| Mar 19 09:11:14 fems146 kernel: Symbols match kernel version 2.4.17.
| Mar 19 09:11:14 fems146 kernel: Loaded 10 symbols from 2 modules.
| Mar 19 09:11:14 fems146 kernel: Linux version 2.4.17smp (root@dino) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #4 SMP Die Feb 5 14:00:50 CET 2002
| Mar 19 09:11:14 fems146 kernel: BIOS-provided physical RAM map:
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 000000000ffd0000 - 000000000fff0000 (ACPI NVS)
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 000000000fff0000 - 0000000010000000 (usable)
| Mar 19 09:11:14 fems146 kernel:  BIOS-e820: 00000000feea0000 - 0000000100000000 (reserved)
| Mar 19 09:11:14 fems146 nfslock: rpc.statd startup succeeded
| Mar 19 09:11:14 fems146 kernel: found SMP MP-table at 000fbfe0
| Mar 19 09:11:14 fems146 kernel: hm, page 000fb000 reserved twice.
| Mar 19 09:11:14 fems146 kernel: hm, page 000fc000 reserved twice.
| Mar 19 09:11:14 fems146 rpc.statd[591]: Version 0.3.1 Starting
| Mar 19 09:11:14 fems146 kernel: hm, page 000e9000 reserved twice.
| Mar 19 09:11:14 fems146 kernel: hm, page 000ea000 reserved twice.
| Mar 19 09:11:14 fems146 kernel: On node 0 totalpages: 65536
| Mar 19 09:11:14 fems146 kernel: zone(0): 4096 pages.
| Mar 19 09:11:14 fems146 kernel: zone(1): 61440 pages.
| Mar 19 09:11:14 fems146 kernel: zone(2): 0 pages.
| Mar 19 09:11:14 fems146 kernel: Intel MultiProcessor Specification v1.4
| Mar 19 09:11:14 fems146 kernel:     Virtual Wire compatibility mode.
| Mar 19 09:11:14 fems146 kernel: OEM ID: COMPAQ   Product ID: Deskpro      APIC at: 0xFEE00000
| Mar 19 09:11:14 fems146 kernel: Processor #0 Pentium(tm) Pro APIC version 16
| Mar 19 09:11:14 fems146 kernel: I/O APIC #8 Version 17 at 0xFEC00000.
| Mar 19 09:11:14 fems146 kernel: Processors: 1
| Mar 19 09:11:14 fems146 kernel: Kernel command line: BOOT_IMAGE=2.4.17smp ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.17smp
| Mar 19 09:11:14 fems146 kernel: Initializing CPU#0
| Mar 19 09:11:14 fems146 kernel: Detected 730.907 MHz processor.
| Mar 19 09:11:14 fems146 kernel: Console: colour VGA+ 80x25
| Mar 19 09:11:14 fems146 kernel: Calibrating delay loop... 1458.17 BogoMIPS
| Mar 19 09:11:14 fems146 kernel: Memory: 254928k/262144k available (1279k kernel code, 6700k reserved, 386k data, 236k init, 0k highmem)
| Mar 19 09:11:14 fems146 kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
| Mar 19 09:11:14 fems146 kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
| Mar 19 09:11:14 fems146 kernel: Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
| Mar 19 09:11:14 fems146 kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
| Mar 19 09:11:14 fems146 kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
| Mar 19 09:11:14 fems146 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
| Mar 19 09:11:14 fems146 kernel: CPU: L2 cache: 256K
| Mar 19 09:11:14 fems146 kernel: Intel machine check architecture supported.
| Mar 19 09:11:14 fems146 kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 09:11:14 fems146 kernel: Enabling fast FPU save and restore... done.
| Mar 19 09:11:14 fems146 kernel: Enabling unmasked SIMD FPU exception support... done.
| Mar 19 09:11:14 fems146 kernel: Checking 'hlt' instruction... OK.
| Mar 19 09:11:14 fems146 kernel: POSIX conformance testing by UNIFIX
| Mar 19 09:11:14 fems146 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
| Mar 19 09:11:14 fems146 kernel: mtrr: detected mtrr type: Intel
| Mar 19 09:11:14 fems146 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
| Mar 19 09:11:14 fems146 kernel: CPU: L2 cache: 256K
| Mar 19 09:11:14 fems146 kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 09:11:14 fems146 kernel: CPU0: Intel Pentium III (Coppermine) stepping 06
| Mar 19 09:11:14 fems146 kernel: per-CPU timeslice cutoff: 731.53 usecs.
| Mar 19 09:11:14 fems146 kernel: enabled ExtINT on CPU#0
| Mar 19 09:11:14 fems146 kernel: ESR value before enabling vector: 00000000
| Mar 19 09:11:14 fems146 kernel: ESR value after enabling vector: 00000000
| Mar 19 09:11:14 fems146 kernel: Error: only one processor found.
| Mar 19 09:11:14 fems146 kernel: ENABLING IO-APIC IRQs
| Mar 19 09:11:14 fems146 kernel: Setting 8 in the phys_id_present_map
| Mar 19 09:11:14 fems146 kernel: ...changing IO-APIC physical APIC ID to 8 ... ok.
| Mar 19 09:11:14 fems146 kernel: ..TIMER: vector=0x31 pin1=-1 pin2=-1
| Mar 19 09:11:14 fems146 kernel: ...trying to set up timer (IRQ0) through the 8259A ...  failed.
| Mar 19 09:11:14 fems146 kernel: ...trying to set up timer as Virtual Wire IRQ... works.
| Mar 19 09:11:14 fems146 kernel: testing the IO APIC.......................
| Mar 19 09:11:14 fems146 kernel: 
| Mar 19 09:11:14 fems146 kernel: .................................... done.
| Mar 19 09:11:14 fems146 kernel: Using local APIC timer interrupts.
| Mar 19 09:11:14 fems146 kernel: calibrating APIC timer ...
| Mar 19 09:11:14 fems146 kernel: ..... CPU clock speed is 730.9247 MHz.
| Mar 19 09:11:14 fems146 kernel: ..... host bus clock speed is 132.8952 MHz.
| Mar 19 09:11:14 fems146 kernel: cpu: 0, clocks: 1328952, slice: 664476
| Mar 19 09:11:14 fems146 kernel: CPU0<T0:1328944,T1:664464,D:4,S:664476,C:1328952>
| Mar 19 09:11:14 fems146 kernel: Waiting on wait_init_idle (map = 0x0)
| Mar 19 09:11:14 fems146 kernel: All processors have done init_idle
| Mar 19 09:11:14 fems146 kernel: PCI: PCI BIOS revision 2.10 entry at 0xe838d, last bus=2
| Mar 19 09:11:14 fems146 kernel: PCI: Using configuration type 1
| Mar 19 09:11:14 fems146 kernel: PCI: Probing PCI hardware
| Mar 19 09:11:14 fems146 ypbind: Setting NIS domain name fd.de:  succeeded
| Mar 19 09:11:14 fems146 kernel: Unknown bridge resource 0: assuming transparent
| Mar 19 09:11:14 fems146 kernel: Unknown bridge resource 2: assuming transparent
| Mar 19 09:11:14 fems146 kernel: PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
| Mar 19 09:11:14 fems146 kernel: PCI->APIC IRQ transform: (B0,I31,P2) -> 23
| Mar 19 09:11:14 fems146 kernel: PCI->APIC IRQ transform: (B0,I31,P1) -> 17
| Mar 19 09:11:14 fems146 kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 18
| Mar 19 09:11:14 fems146 kernel: PCI->APIC IRQ transform: (B2,I8,P0) -> 20
| Mar 19 09:11:14 fems146 kernel: PCI->APIC IRQ transform: (B2,I10,P0) -> 21
| Mar 19 09:11:14 fems146 kernel: Linux NET4.0 for Linux 2.4
| Mar 19 09:11:14 fems146 kernel: Based upon Swansea University Computer Society NET3.039
| Mar 19 09:11:14 fems146 kernel: Initializing RT netlink socket
| Mar 19 09:11:14 fems146 kernel: Starting kswapd
| Mar 19 09:11:14 fems146 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
| Mar 19 09:11:14 fems146 kernel: pty: 256 Unix98 ptys configured
| Mar 19 09:11:14 fems146 kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
| Mar 19 09:11:14 fems146 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
| Mar 19 09:11:14 fems146 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
| Mar 19 09:11:14 fems146 kernel: block: 128 slots per queue, batch=32
| Mar 19 09:11:14 fems146 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
| Mar 19 09:11:14 fems146 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
| Mar 19 09:11:14 fems146 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
| Mar 19 09:11:14 fems146 kernel: PIIX4: IDE controller on PCI bus 00 dev f9
| Mar 19 09:11:14 fems146 kernel: PIIX4: chipset revision 1
| Mar 19 09:11:14 fems146 kernel: PIIX4: not 100%% native mode: will probe irqs later
| Mar 19 09:11:14 fems146 kernel:     ide0: BM-DMA at 0x2460-0x2467, BIOS settings: hda:DMA, hdb:pio
| Mar 19 09:11:14 fems146 kernel:     ide1: BM-DMA at 0x2468-0x246f, BIOS settings: hdc:DMA, hdd:pio
| Mar 19 09:11:14 fems146 kernel: hda: ST340016A, ATA DISK drive
| Mar 19 09:11:14 fems146 kernel: hdc: LTN485, ATAPI CD/DVD-ROM drive
| Mar 19 09:11:14 fems146 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
| Mar 19 09:11:14 fems146 kernel: ide1 at 0x170-0x177,0x376 on irq 15
| Mar 19 09:11:14 fems146 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=5169/240/63
| Mar 19 09:11:14 fems146 kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache, DMA
| Mar 19 09:11:14 fems146 kernel: Uniform CD-ROM driver Revision: 3.12
| Mar 19 09:11:14 fems146 kernel: Partition check:
| Mar 19 09:11:14 fems146 kernel:  hda: [PTBL] [4865/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 >
| Mar 19 09:11:14 fems146 kernel: Floppy drive(s): fd0 is 1.44M
| Mar 19 09:11:14 fems146 kernel: FDC 0 is a post-1991 82077
| Mar 19 09:11:14 fems146 kernel: SCSI subsystem driver Revision: 1.00
| Mar 19 09:11:14 fems146 kernel: request_module[scsi_hostadapter]: Root fs not mounted
| Mar 19 09:11:14 fems146 kernel: usb.c: registered new driver hub
| Mar 19 09:11:14 fems146 kernel: Initializing USB Mass Storage driver...
| Mar 19 09:11:14 fems146 kernel: usb.c: registered new driver usb-storage
| Mar 19 09:11:14 fems146 kernel: USB Mass Storage support registered.
| Mar 19 09:11:14 fems146 kernel: md: linear personality registered as nr 1
| Mar 19 09:11:14 fems146 kernel: md: raid0 personality registered as nr 2
| Mar 19 09:11:14 fems146 kernel: md: raid1 personality registered as nr 3
| Mar 19 09:11:14 fems146 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
| Mar 19 09:11:14 fems146 kernel: md: Autodetecting RAID arrays.
| Mar 19 09:11:14 fems146 kernel: md: autorun ...
| Mar 19 09:11:14 fems146 kernel: md: ... autorun DONE.
| Mar 19 09:11:14 fems146 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
| Mar 19 09:11:14 fems146 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
| Mar 19 09:11:14 fems146 kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
| Mar 19 09:11:14 fems146 kernel: TCP: Hash tables configured (established 16384 bind 16384)
| Mar 19 09:11:14 fems146 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
| Mar 19 09:11:15 fems146 kernel: RAMDISK: Compressed image found at block 0
| Mar 19 09:11:15 fems146 kernel: Freeing initrd memory: 258k freed
| Mar 19 09:11:15 fems146 kernel: VFS: Mounted root (ext2 filesystem).
| Mar 19 09:11:15 fems146 kernel: Freeing unused kernel memory: 236k freed
| Mar 19 09:11:15 fems146 kernel: Real Time Clock Driver v1.10e
| Mar 19 09:11:15 fems146 kernel: Adding Swap: 2048248k swap-space (priority -1)
| Mar 19 09:11:15 fems146 kernel: Adding Swap: 1020088k swap-space (priority -2)
| Mar 19 09:11:15 fems146 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
| Mar 19 09:11:15 fems146 kernel: 02:0a.0: 3Com PCI 3c905 Boomerang 100baseTx at 0x1040. Vers LK1.1.16
| Mar 19 09:11:15 fems146 ypbind: ypbind startup succeeded
| Mar 19 09:07:59 fems146 rc.sysinit: Mounting proc filesystem:  succeeded 
| Mar 19 09:07:59 fems146 rc.sysinit: Unmounting initrd:  succeeded 
| Mar 19 09:07:59 fems146 sysctl: net.ipv4.ip_forward = 0 
| Mar 19 09:07:59 fems146 sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 09:07:59 fems146 sysctl: kernel.sysrq = 0 
| Mar 19 09:07:59 fems146 rc.sysinit: Configuring kernel parameters:  succeeded 
| Mar 19 09:07:59 fems146 date: Tue Mar 19 09:06:14 MET 2002 
| Mar 19 09:07:59 fems146 rc.sysinit: Setting clock  (localtime): Tue Mar 19 09:06:14 MET 2002 succeeded 
| Mar 19 09:07:59 fems146 rc.sysinit: Loading default keymap succeeded 
| Mar 19 09:07:59 fems146 rc.sysinit: Setting default font (lat0-sun16):  succeeded 
| Mar 19 09:07:59 fems146 rc.sysinit: Activating swap partitions:  succeeded 
| Mar 19 09:07:59 fems146 rc.sysinit: Setting hostname localhost.localdomain:  succeeded 
| Mar 19 09:07:59 fems146 fsck: /dev/hda2 
| Mar 19 09:07:59 fems146 fsck:  was not cleanly unmounted, check forced. 
| Mar 19 09:07:59 fems146 fsck: /dev/hda2: 137066/768544 files (0.1% non-contiguous), 620777/1536215 blocks 
| Mar 19 09:07:59 fems146 rc.sysinit: Checking root filesystem succeeded 
| Mar 19 09:07:59 fems146 rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
| Mar 19 09:08:00 fems146 rc.sysinit: Finding module dependencies:  succeeded 
| Mar 19 09:08:00 fems146 fsck: /dev/hda1 was not cleanly unmounted, check forced. 
| Mar 19 09:08:02 fems146 fsck: /dev/hda1: 47/26104 files (2.1% non-contiguous), 11455/104391 blocks 
| Mar 19 09:08:02 fems146 fsck: /1 
| Mar 19 09:08:02 fems146 fsck:  was not cleanly unmounted, check forced. 
| Mar 19 09:08:02 fems146 fsck: /1: |                                                                 
| Mar 19 09:08:03 fems146 fsck: /1: |                                                                 
| Mar 19 09:09:53 fems146 fsck: /1:  
| Mar 19 09:09:53 fems146 fsck: Inode 2932939, i_blocks is 64, should be 8.  FIXED. 
| Mar 19 09:09:53 fems146 fsck: /1: Inode 2932940, i_blocks is 64, should be 8.  FIXED. 
| Mar 19 09:11:02 fems146 fsck: /1: 68669/3719168 files (0.9% non-contiguous), 552811/7438095 blocks 
| Mar 19 09:11:07 fems146 rc.sysinit: Checking filesystems succeeded 
| Mar 19 09:11:07 fems146 rc.sysinit: Mounting local filesystems:  succeeded 
| Mar 19 09:11:07 fems146 rc.sysinit: Enabling local filesystem quotas:  succeeded 
| Mar 19 09:11:08 fems146 rc.sysinit: Enabling swap space:  succeeded 
| Mar 19 09:11:10 fems146 init: Entering runlevel: 3 
| Mar 19 09:11:11 fems146 sysctl: net.ipv4.ip_forward = 0 
| Mar 19 09:11:11 fems146 sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 09:11:11 fems146 sysctl: kernel.sysrq = 0 
| Mar 19 09:11:11 fems146 network: Setting network parameters:  succeeded 
| Mar 19 09:11:11 fems146 network: Bringing up interface lo:  succeeded 
| Mar 19 09:11:13 fems146 network: Bringing up interface eth0:  succeeded 
| Mar 19 09:11:19 fems146 ypbind: attempting to contact yp server failed
| Mar 19 09:11:19 fems146 keytable: Loading keymap:  succeeded
| Mar 19 09:11:19 fems146 keytable: Loading system font:  succeeded
| Mar 19 09:11:19 fems146 gmond: gmond startup succeeded
| Mar 19 09:11:19 fems146 random: Initializing random number generator:  succeeded
| Mar 19 09:11:25 fems146 mount: mount: backgrounding "fems14adm:/net/fems14adm/fs1"
| Mar 19 09:11:25 fems146 mount: mount: RPC: Unable to receive; errno = No route to host
| Mar 19 09:11:31 fems146 mount: mount: RPC: Unable to receive; errno = No route to host
| Mar 19 09:11:31 fems146 mount: mount: backgrounding "fems14:/net/fems14/fs2"
| Mar 19 09:11:31 fems146 netfs: Mounting NFS filesystems:  succeeded
| Mar 19 09:11:31 fems146 netfs: Mounting other filesystems:  succeeded
| Mar 19 09:11:32 fems146 automount[825]: starting automounter version 3.1.7, path = /G, maptype = file, mapname = /etc/auto.work
| Mar 19 09:11:32 fems146 automount[843]: starting automounter version 3.1.7, path = /users, maptype = yp, mapname = auto.users
| Mar 19 09:11:32 fems146 autofs: automount startup succeeded
| Mar 19 09:11:32 fems146 automount[843]: using kernel protocol version 3
| Mar 19 09:11:32 fems146 automount[825]: using kernel protocol version 3
| Mar 19 09:11:32 fems146 snmpd: snmpd startup succeeded
| Mar 19 09:11:32 fems146 sshd: Starting sshd:
| Mar 19 09:11:33 fems146 sshd:  succeeded
| Mar 19 09:11:33 fems146 sshd: 
| Mar 19 09:11:33 fems146 rc: Starting sshd:  succeeded
| Mar 19 09:11:33 fems146 ucd-snmp[868]: UCD-SNMP version 4.2.1 
| Mar 19 09:11:34 fems146 xinetd[921]: chargen disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: chargen disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: daytime disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: daytime disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: echo disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: echo disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: finger disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: linuxconf disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: ntalk disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: exec disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: rsync disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: talk disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: time disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: time disabled, removing
| Mar 19 09:11:34 fems146 xinetd[921]: ftp disabled, removing
| Mar 19 09:11:35 fems146 xinetd[921]: xinetd Version 2.3.3 started with libwrap options compiled in.
| Mar 19 09:11:35 fems146 xinetd[921]: Started working: 4 available services
| Mar 19 09:11:36 fems146 xinetd: xinetd startup succeeded
| Mar 19 09:11:37 fems146 nfs: Starting NFS services:  succeeded
| Mar 19 09:11:37 fems146 nfs: rpc.rquotad startup succeeded
| Mar 19 09:11:37 fems146 nfs: rpc.mountd startup succeeded
| Mar 19 09:11:37 fems146 nfs: rpc.nfsd startup succeeded
| Mar 19 09:11:38 fems146 crond: crond startup succeeded
| Mar 19 09:12:09 fems146 ypbind[623]: broadcast: RPC: Timed out.
| Mar 19 09:12:42 fems146 xfs: xfs startup succeeded
| Mar 19 09:12:42 fems146 xfs: listening on port 7100 
| Mar 19 09:12:42 fems146 anacron: anacron startup succeeded
| Mar 19 09:12:42 fems146 atd: atd startup succeeded
| Mar 19 09:12:43 fems146 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
| Mar 19 09:12:43 fems146 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
| Mar 19 09:12:43 fems146 rc: Starting dont_blank:  succeeded
| Mar 19 09:12:43 fems146 hdaset: 
| Mar 19 09:12:43 fems146 hdaset: /dev/hda:
| Mar 19 09:12:43 fems146 hdaset:  setting using_dma to 1 (on)
| Mar 19 09:12:43 fems146 hdaset:  using_dma    =  1 (on)
| Mar 19 09:12:43 fems146 rc: Starting hdaset:  succeeded
| Mar 19 09:12:43 fems146 linuxconf: Running Linuxconf hooks:  succeeded
| Mar 19 09:12:48 fems146 login(pam_unix)[1476]: check pass; user unknown
| Mar 19 09:12:48 fems146 login(pam_unix)[1476]: authentication failure; logname=LOGIN uid=0 euid=0 tty=tty1 ruser= rhost= 
| Mar 19 09:12:51 fems146 login[1476]: FAILED LOGIN 1 FROM (null) FOR rot, Authentication failure
| Mar 19 09:12:54 fems146 login(pam_unix)[1476]: session opened for user root by LOGIN(uid=0)
| Mar 19 09:12:54 fems146  -- root[1476]: ROOT LOGIN ON tty1
| Mar 19 09:13:23 fems146 ypbind[623]: broadcast: RPC: Timed out.
| Mar 19 09:14:05 fems146 anacron: anacron shutdown succeeded
| Mar 19 09:14:06 fems146 atd: atd shutdown succeeded
| Mar 19 09:14:06 fems146 Font Server[1407]: terminating 
| Mar 19 09:14:06 fems146 xfs: xfs shutdown succeeded
| Mar 19 09:14:06 fems146 rpc.mountd: Caught signal 15, un-registering and exiting. 
| Mar 19 09:14:06 fems146 nfs: rpc.mountd shutdown succeeded
| Mar 19 09:14:10 fems146 kernel: nfsd: last server has exited
| Mar 19 09:14:10 fems146 kernel: nfsd: unexporting all filesystems
| Mar 19 09:14:10 fems146 nfs: nfsd shutdown succeeded
| Mar 19 09:14:10 fems146 nfs: Shutting down NFS services:  succeeded
| Mar 19 09:14:10 fems146 nfs: rpc.rquotad shutdown succeeded
| Mar 19 09:14:10 fems146 sshd: sshd -TERM succeeded
| Mar 19 09:14:11 fems146 ucd-snmp[868]: Received TERM or STOP signal...  shutting down... 
| Mar 19 09:14:11 fems146 snmpd: snmpd shutdown succeeded
| Mar 19 09:14:11 fems146 xinetd[921]: Exiting...
| Mar 19 09:14:11 fems146 xinetd: xinetd shutdown succeeded
| Mar 19 09:14:11 fems146 crond: crond shutdown succeeded
| Mar 19 09:14:11 fems146 autofs: automount -USR2 succeeded
| Mar 19 09:14:11 fems146 automount[825]: shutting down, path = /G
| Mar 19 09:14:11 fems146 automount[843]: shutting down, path = /users
| Mar 19 09:14:11 fems146 autofs: automount shutdown failed
| Mar 19 09:14:13 fems146 gmond: gmond shutdown succeeded
| Mar 19 09:14:13 fems146 dd: 1+0 records in
| Mar 19 09:14:13 fems146 dd: 1+0 records out
| Mar 19 09:14:13 fems146 random: Saving random seed:  succeeded
| Mar 19 09:14:13 fems146 rpc.statd[591]: Caught signal 15, un-registering and exiting.
| Mar 19 09:14:13 fems146 nfslock: rpc.statd shutdown succeeded
| Mar 19 09:14:13 fems146 portmap: portmap shutdown succeeded
| Mar 19 09:14:13 fems146 kernel: Kernel logging (proc) stopped.
| Mar 19 09:14:13 fems146 kernel: Kernel log daemon terminating.
| Mar 19 09:14:14 fems146 syslog: klogd shutdown succeeded
| Mar 19 09:14:14 fems146 exiting on signal 15
| Mar 19 00:23:40 fems146 syslogd 1.4.1: restart.
| Mar 19 00:23:40 fems146 syslog: syslogd startup succeeded
| Mar 19 00:23:40 fems146 kernel: klogd 1.4.1, log source = /proc/kmsg started.
| Mar 19 00:23:40 fems146 kernel: Inspecting /boot/System.map-2.4.17smp
| Mar 19 00:23:40 fems146 syslog: klogd startup succeeded
| Mar 19 00:23:40 fems146 portmap: portmap startup succeeded
| Mar 19 00:23:40 fems146 kernel: Loaded 16042 symbols from /boot/System.map-2.4.17smp.
| Mar 19 00:23:40 fems146 kernel: Symbols match kernel version 2.4.17.
| Mar 19 00:23:40 fems146 kernel: Loaded 10 symbols from 2 modules.
| Mar 19 00:23:40 fems146 kernel: Linux version 2.4.17smp (root@dino) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #4 SMP Die Feb 5 14:00:50 CET 2002
| Mar 19 00:23:40 fems146 kernel: BIOS-provided physical RAM map:
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 000000007fff0000 - 000000007fff6c00 (ACPI data)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 000000007fff6c00 - 0000000080000000 (ACPI NVS)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
| Mar 19 00:23:40 fems146 kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
| Mar 19 00:23:40 fems146 kernel: 1151MB HIGHMEM available.
| Mar 19 00:23:40 fems146 kernel: found SMP MP-table at 000f74d0
| Mar 19 00:23:40 fems146 kernel: hm, page 000f7000 reserved twice.
| Mar 19 00:23:40 fems146 kernel: hm, page 000f8000 reserved twice.
| Mar 19 00:23:40 fems146 kernel: hm, page 0009f000 reserved twice.
| Mar 19 00:23:40 fems146 kernel: hm, page 000a0000 reserved twice.
| Mar 19 00:23:40 fems146 kernel: On node 0 totalpages: 524272
| Mar 19 00:23:40 fems146 rpc.statd[577]: Version 0.3.1 Starting
| Mar 19 00:23:40 fems146 kernel: zone(0): 4096 pages.
| Mar 19 00:23:40 fems146 nfslock: rpc.statd startup succeeded
| Mar 19 00:23:40 fems146 kernel: zone(1): 225280 pages.
| Mar 19 00:23:40 fems146 kernel: zone(2): 294896 pages.
| Mar 19 00:23:40 fems146 kernel: Intel MultiProcessor Specification v1.4
| Mar 19 00:23:40 fems146 kernel:     Virtual Wire compatibility mode.
| Mar 19 00:23:40 fems146 kernel: OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
| Mar 19 00:23:40 fems146 kernel: Processor #1 Pentium(tm) Pro APIC version 16
| Mar 19 00:23:40 fems146 kernel: Processor #0 Pentium(tm) Pro APIC version 16
| Mar 19 00:23:40 fems146 kernel: I/O APIC #2 Version 17 at 0xFEC00000.
| Mar 19 00:23:40 fems146 kernel: Processors: 2
| Mar 19 00:23:40 fems146 kernel: Kernel command line: BOOT_IMAGE=2.4.17smp ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.17smp
| Mar 19 00:23:40 fems146 kernel: Initializing CPU#0
| Mar 19 00:23:40 fems146 kernel: Detected 1592.923 MHz processor.
| Mar 19 00:23:40 fems146 ypbind: Setting NIS domain name fd.de:  succeeded
| Mar 19 00:23:40 fems146 kernel: Console: colour VGA+ 80x25
| Mar 19 00:23:40 fems146 kernel: Calibrating delay loop... 3178.49 BogoMIPS
| Mar 19 00:23:40 fems146 kernel: Memory: 2061276k/2097088k available (1279k kernel code, 35424k reserved, 386k data, 236k init, 1179584k highmem)
| Mar 19 00:23:40 fems146 kernel: Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
| Mar 19 00:23:40 fems146 kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
| Mar 19 00:23:40 fems146 kernel: Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
| Mar 19 00:23:40 fems146 kernel: Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
| Mar 19 00:23:40 fems146 kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
| Mar 19 00:23:40 fems146 ypbind: ypbind startup succeeded
| Mar 19 00:23:40 fems146 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:23:40 fems146 kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:23:40 fems146 kernel: Intel machine check architecture supported.
| Mar 19 00:23:40 fems146 kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 00:23:40 fems146 kernel: Enabling fast FPU save and restore... done.
| Mar 19 00:23:40 fems146 kernel: Enabling unmasked SIMD FPU exception support... done.
| Mar 19 00:23:40 fems146 kernel: Checking 'hlt' instruction... OK.
| Mar 19 00:23:40 fems146 kernel: POSIX conformance testing by UNIFIX
| Mar 19 00:23:40 fems146 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
| Mar 19 00:23:40 fems146 ypbind: bound to NIS server ed0601
| Mar 19 00:23:40 fems146 kernel: mtrr: detected mtrr type: Intel
| Mar 19 00:23:40 fems146 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:23:40 fems146 kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:23:40 fems146 kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 00:23:40 fems146 kernel: CPU0: AMD Athlon(tm) MP 1900+ stepping 02
| Mar 19 00:23:40 fems146 kernel: per-CPU timeslice cutoff: 731.57 usecs.
| Mar 19 00:23:40 fems146 kernel: enabled ExtINT on CPU#0
| Mar 19 00:23:40 fems146 kernel: ESR value before enabling vector: 00000000
| Mar 19 00:23:40 fems146 kernel: ESR value after enabling vector: 00000000
| Mar 19 00:23:40 fems146 kernel: Booting processor 1/0 eip 2000
| Mar 19 00:23:40 fems146 kernel: Initializing CPU#1
| Mar 19 00:23:40 fems146 kernel: masked ExtINT on CPU#1
| Mar 19 00:23:40 fems146 kernel: ESR value before enabling vector: 00000000
| Mar 19 00:23:40 fems146 kernel: ESR value after enabling vector: 00000000
| Mar 19 00:23:40 fems146 kernel: Calibrating delay loop... 3185.04 BogoMIPS
| Mar 19 00:23:40 fems146 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:23:40 fems146 kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:23:40 fems146 kernel: Intel machine check reporting enabled on CPU#1.
| Mar 19 00:23:40 fems146 kernel: CPU1: AMD Athlon(tm) Processor stepping 02
| Mar 19 00:23:40 fems146 kernel: Total of 2 processors activated (6363.54 BogoMIPS).
| Mar 19 00:23:40 fems146 kernel: ENABLING IO-APIC IRQs
| Mar 19 00:23:40 fems146 kernel: Setting 2 in the phys_id_present_map
| Mar 19 00:23:40 fems146 kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
| Mar 19 00:23:40 fems146 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
| Mar 19 00:23:40 fems146 kernel: testing the IO APIC.......................
| Mar 19 00:23:40 fems146 kernel: 
| Mar 19 00:23:40 fems146 kernel: .................................... done.
| Mar 19 00:23:40 fems146 kernel: Using local APIC timer interrupts.
| Mar 19 00:23:40 fems146 kernel: calibrating APIC timer ...
| Mar 19 00:23:40 fems146 kernel: ..... CPU clock speed is 1592.9759 MHz.
| Mar 19 00:23:40 fems146 kernel: ..... host bus clock speed is 265.4960 MHz.
| Mar 19 00:23:40 fems146 kernel: cpu: 0, clocks: 2654960, slice: 884986
| Mar 19 00:23:40 fems146 kernel: CPU0<T0:2654960,T1:1769968,D:6,S:884986,C:2654960>
| Mar 19 00:23:40 fems146 kernel: cpu: 1, clocks: 2654960, slice: 884986
| Mar 19 00:23:40 fems146 kernel: CPU1<T0:2654960,T1:884976,D:12,S:884986,C:2654960>
| Mar 19 00:23:40 fems146 kernel: checking TSC synchronization across CPUs: passed.
| Mar 19 00:23:40 fems146 kernel: Waiting on wait_init_idle (map = 0x2)
| Mar 19 00:23:40 fems146 kernel: All processors have done init_idle
| Mar 19 00:23:40 fems146 kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
| Mar 19 00:23:40 fems146 kernel: mtrr: probably your BIOS does not setup all CPUs
| Mar 19 00:23:40 fems146 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
| Mar 19 00:23:40 fems146 kernel: PCI: Using configuration type 1
| Mar 19 00:23:40 fems146 kernel: PCI: Probing PCI hardware
| Mar 19 00:23:40 fems146 kernel: Unknown bridge resource 0: assuming transparent
| Mar 19 00:23:40 fems146 kernel: Unknown bridge resource 1: assuming transparent
| Mar 19 00:23:40 fems146 kernel: Unknown bridge resource 2: assuming transparent
| Mar 19 00:23:40 fems146 kernel: I/O APIC: AMD Errata #22 may be present. In the event of instability try
| Mar 19 00:23:40 fems146 kernel:         : booting with the "noapic" option.
| Mar 19 00:23:40 fems146 kernel: Linux NET4.0 for Linux 2.4
| Mar 19 00:23:40 fems146 kernel: Based upon Swansea University Computer Society NET3.039
| Mar 19 00:23:40 fems146 kernel: Initializing RT netlink socket
| Mar 19 00:23:40 fems146 kernel: Starting kswapd
| Mar 19 00:23:40 fems146 kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
| Mar 19 00:23:40 fems146 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
| Mar 19 00:23:40 fems146 kernel: pty: 256 Unix98 ptys configured
| Mar 19 00:23:40 fems146 kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
| Mar 19 00:23:40 fems146 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
| Mar 19 00:23:40 fems146 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
| Mar 19 00:23:40 fems146 kernel: block: 128 slots per queue, batch=32
| Mar 19 00:23:40 fems146 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
| Mar 19 00:23:40 fems146 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
| Mar 19 00:23:40 fems146 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
| Mar 19 00:23:40 fems146 kernel: AMD7411: IDE controller on PCI bus 00 dev 39
| Mar 19 00:23:40 fems146 kernel: AMD7411: chipset revision 1
| Mar 19 00:23:40 fems146 kernel: AMD7411: not 100%% native mode: will probe irqs later
| Mar 19 00:23:40 fems146 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
| Mar 19 00:23:40 fems146 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
| Mar 19 00:23:40 fems146 kernel: hda: ST340016A, ATA DISK drive
| Mar 19 00:23:40 fems146 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
| Mar 19 00:23:40 fems146 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
| Mar 19 00:23:40 fems146 kernel: Partition check:
| Mar 19 00:23:40 fems146 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
| Mar 19 00:23:40 fems146 kernel: Floppy drive(s): fd0 is 1.44M
| Mar 19 00:23:40 fems146 kernel: FDC 0 is a post-1991 82077
| Mar 19 00:23:40 fems146 kernel: SCSI subsystem driver Revision: 1.00
| Mar 19 00:23:40 fems146 kernel: request_module[scsi_hostadapter]: Root fs not mounted
| Mar 19 00:23:40 fems146 kernel: usb.c: registered new driver hub
| Mar 19 00:23:40 fems146 kernel: Initializing USB Mass Storage driver...
| Mar 19 00:23:40 fems146 kernel: usb.c: registered new driver usb-storage
| Mar 19 00:23:40 fems146 kernel: USB Mass Storage support registered.
| Mar 19 00:23:40 fems146 kernel: md: linear personality registered as nr 1
| Mar 19 00:23:40 fems146 kernel: md: raid0 personality registered as nr 2
| Mar 19 00:23:40 fems146 kernel: md: raid1 personality registered as nr 3
| Mar 19 00:23:40 fems146 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
| Mar 19 00:23:40 fems146 kernel: md: Autodetecting RAID arrays.
| Mar 19 00:23:40 fems146 kernel: md: autorun ...
| Mar 19 00:23:40 fems146 keytable: Loading keymap:  succeeded
| Mar 19 00:23:40 fems146 kernel: md: ... autorun DONE.
| Mar 19 00:23:40 fems146 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
| Mar 19 00:23:40 fems146 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
| Mar 19 00:23:40 fems146 kernel: IP: routing cache hash table of 16384 buckets, 128Kbytes
| Mar 19 00:23:40 fems146 kernel: TCP: Hash tables configured (established 262144 bind 65536)
| Mar 19 00:23:40 fems146 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
| Mar 19 00:23:40 fems146 kernel: RAMDISK: Compressed image found at block 0
| Mar 19 00:23:40 fems146 kernel: Freeing initrd memory: 258k freed
| Mar 19 00:23:40 fems146 kernel: VFS: Mounted root (ext2 filesystem).
| Mar 19 00:23:40 fems146 keytable: Loading system font:  succeeded
| Mar 19 00:23:40 fems146 kernel: Freeing unused kernel memory: 236k freed
| Mar 19 00:23:40 fems146 kernel: Real Time Clock Driver v1.10e
| Mar 19 00:23:41 fems146 kernel: Adding Swap: 2048248k swap-space (priority -1)
| Mar 19 00:23:41 fems146 kernel: Adding Swap: 1020088k swap-space (priority -2)
| Mar 19 00:23:41 fems146 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
| Mar 19 00:23:41 fems146 kernel: 00:0f.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x1400. Vers LK1.1.16
| Mar 19 00:23:41 fems146 kernel: 00:10.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x1480. Vers LK1.1.16
| Mar 19 00:23:41 fems146 gmond: gmond startup succeeded
| Mar 19 00:23:41 fems146 random: Initializing random number generator:  succeeded
| Mar 19 00:23:41 fems146 netfs: Mounting NFS filesystems:  succeeded
| Mar 19 00:23:41 fems146 netfs: Mounting other filesystems:  succeeded
| Mar 19 00:23:41 fems146 automount[815]: starting automounter version 3.1.7, path = /G, maptype = file, mapname = /etc/auto.work
| Mar 19 00:23:41 fems146 automount[823]: starting automounter version 3.1.7, path = /users, maptype = yp, mapname = auto.users
| Mar 19 00:23:41 fems146 autofs: automount startup succeeded
| Mar 19 00:23:41 fems146 automount[815]: using kernel protocol version 3
| Mar 19 00:23:41 fems146 automount[823]: using kernel protocol version 3
| Mar 19 00:23:42 fems146 snmpd: snmpd startup succeeded
| Mar 19 00:23:42 fems146 sshd: Starting sshd:
| Mar 19 00:23:33 fems146 rc.sysinit: Mounting proc filesystem:  succeeded 
| Mar 19 00:23:33 fems146 rc.sysinit: Unmounting initrd:  succeeded 
| Mar 19 00:23:33 fems146 sysctl: net.ipv4.ip_forward = 0 
| Mar 19 00:23:33 fems146 sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 00:23:33 fems146 sysctl: kernel.sysrq = 0 
| Mar 19 00:23:33 fems146 rc.sysinit: Configuring kernel parameters:  succeeded 
| Mar 19 00:23:33 fems146 date: Tue Mar 19 00:23:27 MET 2002 
| Mar 19 00:23:33 fems146 rc.sysinit: Setting clock  (localtime): Tue Mar 19 00:23:27 MET 2002 succeeded 
| Mar 19 00:23:33 fems146 rc.sysinit: Loading default keymap succeeded 
| Mar 19 00:23:33 fems146 rc.sysinit: Setting default font (lat0-sun16):  succeeded 
| Mar 19 00:23:33 fems146 rc.sysinit: Activating swap partitions:  succeeded 
| Mar 19 00:23:33 fems146 rc.sysinit: Setting hostname localhost.localdomain:  succeeded 
| Mar 19 00:23:33 fems146 fsck: /dev/hda2: clean, 137039/768544 files, 620790/1536215 blocks 
| Mar 19 00:23:33 fems146 rc.sysinit: Checking root filesystem succeeded 
| Mar 19 00:23:42 fems146 sshd:  succeeded
| Mar 19 00:23:33 fems146 rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
| Mar 19 00:23:42 fems146 sshd: ^[[60G[  
| Mar 19 00:23:33 fems146 rc.sysinit: Finding module dependencies:  succeeded 
| Mar 19 00:23:42 fems146 sshd: 
| Mar 19 00:23:33 fems146 fsck: /dev/hda1: clean, 47/26104 files, 11455/104391 blocks 
| Mar 19 00:23:42 fems146 rc: Starting sshd:  succeeded
| Mar 19 00:23:34 fems146 fsck: /1: clean, 68669/3719168 files, 552811/7438095 blocks 
| Mar 19 00:23:34 fems146 rc.sysinit: Checking filesystems succeeded 
| Mar 19 00:23:34 fems146 rc.sysinit: Mounting local filesystems:  succeeded 
| Mar 19 00:23:34 fems146 rc.sysinit: Enabling local filesystem quotas:  succeeded 
| Mar 19 00:23:34 fems146 rc.sysinit: Enabling swap space:  succeeded 
| Mar 19 00:23:37 fems146 init: Entering runlevel: 3 
| Mar 19 00:23:37 fems146 sysctl: net.ipv4.ip_forward = 0 
| Mar 19 00:23:37 fems146 sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 00:23:37 fems146 sysctl: kernel.sysrq = 0 
| Mar 19 00:23:43 fems146 ucd-snmp[849]: UCD-SNMP version 4.2.1 
| Mar 19 00:23:37 fems146 network: Setting network parameters:  succeeded 
| Mar 19 00:23:37 fems146 network: Bringing up interface lo:  succeeded 
| Mar 19 00:23:40 fems146 network: Bringing up interface eth0:  succeeded 
| Mar 19 00:23:43 fems146 xinetd[902]: chargen disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: chargen disabled, removing
| Mar 19 00:23:43 fems146 xiNetd[902]: daytime disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: daytime disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: echo disabled, removing
| Mar 19 00:23:43 fems146 xinetD[902]: echo disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: finger disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: linuxconf disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: ntalk disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: exec disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: rsync disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: talk disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: time disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: time disabled, removing
| Mar 19 00:23:43 fems146 xinetd[902]: ftp disabled, removing
| Mar 19 00:23:44 fems146 xinetd[902]: xinetd Version 2.3.3 started with libwrap optiOns compiled in.
| Mar 19 00:23:44 fems146 xinetd[902]: Started working: 4 available services
| Mar 19 00:23:46 fems146 xinetd: xinetd startup succeeded
| Mar 19 00:23:46 fems146 nfs: Starting NFS services:  succeeded
| Mar 19 00:23:46 fems146 nfs: rpc.rquotad startup succeeded
| Mar 19 00:23:46 fems146 nfs: rpc.mountd startup succeeded
| Mar 19 00:23:46 fems146 nfs: rpc.nfsd startup succeeded
| Mar 19 00:23:47 fems146 crond: crond startup succeeded
| Mar 19 00:24:27 fems146 xfs: xfs startup succeeded
| Mar 19 00:24:27 fems146 xfs: listening on port 7100 
| Mar 19 00:24:27 fems146 anacron: anacron startup succeeded
| Mar 19 00:24:27 fems146 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
| Mar 19 00:24:27 fems146 xfs: ignoring font path element /usr/X11R6lib/X11/fonts/local (unreadable) 
| Mar 19 00:24:27 fems146 atd: atd startup succeeded
| Mar 19 00:24:27 fems146 rc: Starting dont_blank:  succeeded
| Mar 19 00:24:27 fems146 hdaset: 
| Mar 19 00:24:27 fems146 hdaset: /dev/hda:
| Mar 19 00:24:27 fems146 hdaset:  setting using_dma to 1 (on)
| Mar 19 00:24:27 fems146 hdaset:  using_dma    =  1 (on)
| Mar 19 00:24:27 fems146 rc: Starting hdaset:  succeeded
| Mar 19 00:24:28 fems146 linuxconf: Running Linuxconf hooks:  succeeded
| Mar 19 00:24:34 fems146 login(pam_unix)[1497]: session opened for user root by LOGIN(uid=0)
| Mar 19 00:24:34 fems146  -- root[1497]: ROOT LOGIN ON tty1
| Mar 19 00:24:58 fems146 anacron: anacron shutdown succeeded
| Mar 19 00:24:58 fems146 atd: atd shutdown succeeded
| Mar 19 00:24:58 fems146 Font Server[1428]: terminating 
| Mar 19 00:24:58 fems146 xfs: xfs shutdown succeeded
| Mar 19 00:24:58 fems146 rpc.mountd: Caught signal 15, un-registering and exiting. 
| Mar 19 00:24:58 fems146 nfs: rpc.mountd shutdown succeeded
| Mar 19 00:25:02 fems146 kernel: nfsd: last server has exited
| Mar 19 00:25:02 fems146 kernel: nfsd: unexporting all filesystems
| Mar 19 00:25:02 fems146 nfs: nfsd shutdown succEeded
| Mar 19 00:25:02 fems146 nfs: Shutting down NFS services:  succeeded
| Mar 19 00:25:03 fems146 nfs: rpc.rquotad shutdown succeeded
| Mar 19 00:25:03 fems146 sshd: sshd -TERM succeeded
| Mar 19 00:25:03 fems146 ucd-snmp[849]: Received TERM or STOP signal...  shutting down... 
| Mar 19 00:25:03 fems146 snmpd: snmpd shutdown succeeded
| Mar 19 00:25:03 fems146 xinetd[902]: Exiting...
| Mar 19 00:25:03 fems146 xinetd: xinetd shutdown succeeded
| Mar 19 00:25:03 fems146 crond: crond shutdoWn succeeded
| Mar 19 00:25:03 fems146 autofs: automount -USR2 succeeded
| Mar 19 00:25:03 fems146 automount[815]: shutting down, path = /G
| Mar 19 00:25:03 fems146 automount[823]: shutting down, path = /users
| Mar 19 00:25:03 fems146 netfs: Unmounting NFS filesystems:  succeeded
| Mar 19 00:25:05 fems146 gmond: gmond shutdown succeeded
| Mar 19 00:25:05 fems146 dd: 1+0 records in
| Mar 19 00:25:05 fems146 dd: 1+0 records out
| Mar 19 00:25:05 fems146 random: Saving random seed:  succeeded
| Mar 19 00:25:06 fems146 rpc.statd[577]: Caught signal 15, un-registering and exiting.
| Mar 19 0025:06 fems146 nfslock: rpc.statd shutdown succeeded
| Mar 19 00:25:06 fems146 portmap: portmap shutdown succeeded
| Mar 19 00:25:06 fems146 kernel: Kernel logging (proc) stopped.
| Mar 19 00:25:06 fems146 kernel: Kernel log daemon terminating.
| Mar 19 00:25:07 fems146 syslog: klogd shutdown succeeded
| Mar 19 00:25:07 fems146 exiting on signal 15
| Mar 19 00:35:59 fems146 syslogd 1.4.1: restart.
| Mar 19 00:35:59 fems146 syslog: syslogd startup succeeded
| Mar 19 00:35:59 fems146 kernel: klogd 1.4.1, log source = /proc/kmsg started.
| Mar 19 00:35:59 fems146 kernel: Inspecting /boot/System.map-2.4.17smp
| Mar 19 00:35:59 fems146 syslog: klogd startup succeeded
| Mar 19 00:35:59 fems146 portmap: portmap startup succeeded
| Mar 19 00:35:59 fems146 nfslock: rpc.statd startup succeeded
| Mar 19 00:35:59 fems146 rpc.statd[578]: Version 0.3.1 Starting
| Mar 19 00:35:59 fems146 kernel: Loaded 16042 symbols from /boot/System.map-2.4.17smp.
| Mar 19 00:35:59 fems146 kernel: Symbols match kernel version 2.4.17.
| Mar 19 00:35:59 fems146 kernel: Loaded 10 symbols from 2 modules.
| Mar 19 00:35:59 fems146 kernel: Linux version 2.4.17smp (root@dino) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #4 SMP Die Feb 5 14:00:50 CET 2002
| Mar 19 00:35:59 fems146 kernel: BIOS-provided physical RAM map:
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 000000007fff0000 - 000000007fff6c00 (ACPI data)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 000000007fff6c00 - 0000000080000000 (ACPI NVS)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
| Mar 19 00:35:59 fems146 kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
| Mar 19 00:35:59 fems146 kernel: 1151MB HIGHMEM available.
| Mar 19 00:35:59 fems146 kernel: found SMP MP-table at 000f74d0
| Mar 19 00:35:59 fems146 kernel: hm, page 000f7000 reserved twice.
| Mar 19 00:35:59 fems146 kernel: hm, page 000f8000 reserved twice.
| Mar 19 00:36:00 fems146 ypbind: Setting NIS domain name fd.de:  succeeded
| Mar 19 00:35:59 fems146 kernel: hm, page 0009f000 reserved twice.
| Mar 19 00:36:00 fems146 kernel: hm, page 000a0000 reserved twice.
| Mar 19 00:36:00 fems146 kernel: On node 0 totalpages: 524272
| Mar 19 00:36:00 fems146 kernel: zone(0): 4096 pages.
| Mar 19 00:36:00 fems146 kernel: zone(1): 225280 pages.
| Mar 19 00:36:00 fems146 kernel: zone(2): 294896 pages.
| Mar 19 00:36:00 fems146 kernel: Intel MultiProcessor Specification v1.4
| Mar 19 00:36:00 fems146 kernel:     Virtual Wire compatibility mode.
| Mar 19 00:36:00 fems146 kernel: OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
| Mar 19 00:36:00 fems146 kernel: Processor #1 Pentium(tm) Pro APIC version 16
| Mar 19 00:36:00 fems146 kernel: Processor #0 Pentium(tm) Pro APIC version 16
| Mar 19 00:36:00 fems146 ypbind: ypbind startup succeeded
| Mar 19 00:36:00 fems146 kernel: I/O APIC #2 Version 17 at 0xFEC00000.
| Mar 19 00:36:00 fems146 kernel: Processors: 2
| Mar 19 00:36:00 fems146 kernel: Kernel command line: auto BOOT_IMAGE=2.4.17smp ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.17smp
| Mar 19 00:36:00 fems146 kernel: Initializing CPU#0
| Mar 19 00:36:00 fems146 kernel: Detected 1592.920 MHz processor.
| Mar 19 00:36:00 fems146 kernel: Console: colour VGA+ 80x25
| Mar 19 00:36:00 fems146 kernel: Calibrating delay loop... 3178.49 BogoMIPS
| Mar 19 00:36:00 fems146 kernel: Memory: 2061276k/2097088k available (1279k kernel code, 35424k reserved, 386k data, 236k init, 1179584k highmem)
| Mar 19 00:36:00 fems146 kernel: Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
| Mar 19 00:36:00 fems146 kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
| Mar 19 00:36:00 fems146 ypbind: bound to NIS server ed0601
| Mar 19 00:36:00 fems146 kernel: Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
| Mar 19 00:36:00 fems146 kernel: Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
| Mar 19 00:36:00 fems146 kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
| Mar 19 00:36:00 fems146 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:36:00 fems146 kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:36:00 fems146 kernel: Intel machine check architecture supported.
| Mar 19 00:36:00 fems146 kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 00:36:00 fems146 kernel: Enabling fast FPU save and restore... done.
| Mar 19 00:36:00 fems146 kernel: Enabling unmasked SIMD FPU exception support... done.
| Mar 19 00:36:00 fems146 kernel: Checking 'hlt' instruction... OK.
| Mar 19 00:36:00 fems146 kernel: POSIX conformance testing by UNIFIX
| Mar 19 00:36:00 fems146 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
| Mar 19 00:36:00 fems146 kernel: mtrr: detected mtrr type: Intel
| Mar 19 00:36:00 fems146 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:36:00 fems146 kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:36:00 fems146 kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 00:36:00 fems146 kernel: CPU0: AMD Athlon(tm) MP 1900+ stepping 02
| Mar 19 00:36:00 fems146 kernel: per-CPU timeslice cutoff: 731.57 usecs.
| Mar 19 00:36:00 fems146 kernel: enabled ExtINT on CPU#0
| Mar 19 00:36:00 fems146 kernel: ESR value before enabling vector: 00000000
| Mar 19 00:36:00 fems146 kernel: ESR value after enabling vector: 00000000
| Mar 19 00:36:00 fems146 kernel: Booting processor 1/0 eip 2000
| Mar 19 00:36:00 fems146 kernel: Initializing CPU#1
| Mar 19 00:36:00 fems146 kernel: masked ExtINT on CPU#1
| Mar 19 00:36:00 fems146 kernel: ESR value before enabling vector: 00000000
| Mar 19 00:36:00 fems146 kernel: ESR value after enabling vector: 00000000
| Mar 19 00:36:00 fems146 kernel: Calibrating delay loop... 3185.04 BogoMIPS
| Mar 19 00:36:00 fems146 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:36:00 fems146 kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:36:00 fems146 kernel: Intel machine check reporting enabled on CPU#1.
| Mar 19 00:36:00 fems146 kernel: CPU1: AMD Athlon(tm) Processor stepping 02
| Mar 19 00:36:00 fems146 kernel: Total of 2 processors activated (6363.54 BogoMIPS).
| Mar 19 00:36:00 fems146 kernel: ENABLING IO-APIC IRQs
| Mar 19 00:36:00 fems146 kernel: Setting 2 in the phys_id_present_map
| Mar 19 00:36:00 fems146 kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
| Mar 19 00:36:00 fems146 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
| Mar 19 00:36:00 fems146 kernel: testing the IO APIC.......................
| Mar 19 00:36:00 fems146 kernel: 
| Mar 19 00:36:00 fems146 kernel: .................................... done.
| Mar 19 00:36:00 fems146 kernel: Using local APIC timer interrupts.
| Mar 19 00:36:00 fems146 kernel: calibrating APIC timer ...
| Mar 19 00:36:00 fems146 kernel: ..... CPU clock speed is 1592.8857 MHz.
| Mar 19 00:36:00 fems146 kernel: ..... host bus clock speed is 265.4809 MHz.
| Mar 19 00:36:00 fems146 kernel: cpu: 0, clocks: 2654809, slice: 884936
| Mar 19 00:36:00 fems146 kernel: CPU0<T0:2654800,T1:1769856,D:8,S:884936,C:2654809>
| Mar 19 00:36:00 fems146 kernel: cpu: 1, clocks: 2654809, slice: 884936
| Mar 19 00:36:00 fems146 kernel: CPU1<T0:2654800,T1:884928,D:0,S:884936,C:2654809>
| Mar 19 00:36:00 fems146 kernel: checking TSC synchronization across CPUs: passed.
| Mar 19 00:36:00 fems146 kernel: Waiting on wait_init_idle (map = 0x2)
| Mar 19 00:36:00 fems146 kernel: All processors have done init_idle
| Mar 19 00:36:00 fems146 kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
| Mar 19 00:36:00 fems146 kernel: mtrr: probably your BIOS does not setup all CPUs
| Mar 19 00:36:00 fems146 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
| Mar 19 00:36:00 fems146 kernel: PCI: Using configuration type 1
| Mar 19 00:36:00 fems146 kernel: PCI: Probing PCI hardware
| Mar 19 00:36:00 fems146 kernel: Unknown bridge resource 0: assuming transparent
| Mar 19 00:36:00 fems146 kernel: Unknown bridge resource 1: assuming transparent
| Mar 19 00:36:00 fems146 kernel: Unknown bridge resource 2: assuming transparent
| Mar 19 00:36:00 fems146 kernel: I/O APIC: AMD Errata #22 may be present. In the event of instability try
| Mar 19 00:36:00 fems146 kernel:         : booting with the "noapic" option.
| Mar 19 00:36:00 fems146 kernel: Linux NET4.0 for Linux 2.4
| Mar 19 00:36:00 fems146 kernel: Based upon Swansea University Computer Society NET3.039
| Mar 19 00:36:00 fems146 kernel: Initializing RT netlink socket
| Mar 19 00:36:00 fems146 kernel: Starting kswapd
| Mar 19 00:36:00 fems146 kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
| Mar 19 00:36:00 fems146 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
| Mar 19 00:36:00 fems146 kernel: pty: 256 Unix98 ptys configured
| Mar 19 00:36:00 fems146 kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
| Mar 19 00:36:00 fems146 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
| Mar 19 00:36:00 fems146 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
| Mar 19 00:36:00 fems146 kernel: block: 128 slots per queue, batch=32
| Mar 19 00:36:00 fems146 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
| Mar 19 00:36:00 fems146 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
| Mar 19 00:36:00 fems146 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
| Mar 19 00:36:00 fems146 kernel: AMD7411: IDE controller on PCI bus 00 dev 39
| Mar 19 00:36:00 fems146 kernel: AMD7411: chipset revision 1
| Mar 19 00:36:00 fems146 kernel: AMD7411: not 100%% native mode: will probe irqs later
| Mar 19 00:36:00 fems146 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
| Mar 19 00:36:00 fems146 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
| Mar 19 00:36:00 fems146 keytable: Loading keymap:  succeeded
| Mar 19 00:36:00 fems146 kernel: hda: ST340016A, ATA DISK drive
| Mar 19 00:36:00 fems146 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
| Mar 19 00:36:00 fems146 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
| Mar 19 00:36:00 fems146 kernel: Partition check:
| Mar 19 00:36:00 fems146 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
| Mar 19 00:36:00 fems146 kernel: Floppy drive(s): fd0 is 1.44M
| Mar 19 00:36:00 fems146 kernel: FDC 0 is a post-1991 82077
| Mar 19 00:36:00 fems146 kernel: SCSI subsystem driver Revision: 1.00
| Mar 19 00:36:00 fems146 kernel: request_module[scsi_hostadapter]: Root fs not mounted
| Mar 19 00:36:00 fems146 kernel: usb.c: registered new driver hub
| Mar 19 00:36:00 fems146 kernel: Initializing USB Mass Storage driver...
| Mar 19 00:36:00 fems146 kernel: usb.c: registered new driver usb-storage
| Mar 19 00:36:00 fems146 keytable: Loading system font:  succeeded
| Mar 19 00:36:00 fems146 kernel: USB Mass Storage support registered.
| Mar 19 00:36:00 fems146 kernel: md: linear personality registered as nr 1
| Mar 19 00:36:00 fems146 kernel: md: raid0 personality registered as nr 2
| Mar 19 00:36:00 fems146 kernel: md: raid1 personality registered as nr 3
| Mar 19 00:36:00 fems146 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
| Mar 19 00:36:00 fems146 kernel: md: Autodetecting RAID arrays.
| Mar 19 00:36:00 fems146 kernel: md: autorun ...
| Mar 19 00:36:00 fems146 kernel: md: ... autorun DONE.
| Mar 19 00:36:00 fems146 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
| Mar 19 00:36:00 fems146 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
| Mar 19 00:36:00 fems146 kernel: IP: routing cache hash table of 16384 buckets, 128Kbytes
| Mar 19 00:36:00 fems146 kernel: TCP: Hash tables configured (established 262144 bind 65536)
| Mar 19 00:36:00 fems146 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
| Mar 19 00:36:00 fems146 kernel: RAMDISK: Compressed image found at block 0
| Mar 19 00:36:00 fems146 kernel: Freeing initrd memory: 258k freed
| Mar 19 00:36:00 fems146 kernel: VFS: Mounted root (ext2 filesystem).
| Mar 19 00:36:00 fems146 kernel: Freeing unused kernel memory: 236k freed
| Mar 19 00:36:00 fems146 kernel: Real Time Clock Driver v1.10e
| Mar 19 00:36:00 fems146 kernel: Adding Swap: 2048248k swap-space (priority -1)
| Mar 19 00:36:00 fems146 kernel: Adding Swap: 1020088k swap-space (priority -2)
| Mar 19 00:36:00 fems146 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
| Mar 19 00:36:00 fems146 kernel: 00:0f.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x1400. Vers LK1.1.16
| Mar 19 00:36:00 fems146 gmond: gmond startup succeeded
| Mar 19 00:36:00 fems146 kernel: 00:10.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x1480. Vers LK1.1.16
| Mar 19 00:36:00 fems146 random: Initializing random number generator:  succeeded
| Mar 19 00:36:00 fems146 netfs: Mounting NFS filesystems:  succeeded
| Mar 19 00:36:00 fems146 netfs: Mounting other filesystems:  succeeded
| Mar 19 00:36:00 fems146 automount[817]: starting automounter version 3.1.7, path = /G, maptype = file, mapname = /etc/auto.work
| Mar 19 00:36:00 fems146 automount[824]: starting automounter version 3.1.7, path = /users, maptype = yp, mapname = auto.users
| Mar 19 00:36:00 fems146 autofs: automount startup succeeded
| Mar 19 00:36:01 fems146 automount[817]: using kernel protocol version 3
| Mar 19 00:36:01 fems146 automount[824]: using kernel protocol version 3
| Mar 19 00:36:01 fems146 snmpd: snmpd startup succeeded
| Mar 19 00:36:01 fems146 sshd: Starting sshd:
| Mar 19 00:33:02 fems146 rc.sysinit: Mounting proc filesystem:  succeeded 
| Mar 19 00:33:02 fems146 rc.sysinit: Unmounting initrd:  succeeded 
| Mar 19 00:33:02 fems146 sysctl: net.ipv4.ip_forward = 0 
| Mar 19 00:33:02 fems146 sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 00:33:02 fems146 sysctl: kernel.sysrq = 0 
| Mar 19 00:33:02 fems146 rc.sysinit: Configuring kernel parameters:  succeeded 
| Mar 19 00:33:02 fems146 date: Tue Mar 19 00:32:56 MET 2002 
| Mar 19 00:33:02 fems146 rc.sysinit: Setting clock  (localtime): Tue Mar 19 00:32:56 MET 2002 succeeded 
| Mar 19 00:33:02 fems146 rc.sysinit: Loading default keymap succeeded 
| Mar 19 00:33:02 fems146 rc.sysinit: Setting default font (lat0-sun16):  succeeded 
| Mar 19 00:33:02 fems146 rc.sysinit: Activating swap partitions:  succeeded 
| Mar 19 00:33:02 fems146 rc.sysinit: Setting hostname localhost.localdomain:  succeeded 
| Mar 19 00:33:02 fems146 fsck: /dev/hda2: clean, 137040/768544 files, 620812/1536215 blocks 
| Mar 19 00:36:02 fems146 sshd:  succeeded
| Mar 19 00:33:02 fems146 rc.sysinit: Checking root filesystem succeeded 
| Mar 19 00:36:02 fems146 sshd: ^[[60G
| Mar 19 00:33:02 fems146 rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
| Mar 19 00:36:02 fems146 sshd: 
| Mar 19 00:33:02 fems146 rc.sysinit: Finding module dependencies:  succeeded 
| Mar 19 00:36:02 fems146 rc: Starting sshd:  succeeded
| Mar 19 00:33:02 fems146 fsck: /dev/hda1: clean, 47/26104 files, 11455/104391 blocks 
| Mar 19 00:33:03 fems146 fsck: /1 
| Mar 19 00:33:03 fems146 fsck:  has gone 6213 days without being checked, check forced. 
| Mar 19 00:35:53 fems146 fsck: /1: 68669/3719168 files (0.9% non-contiguous), 552811/7438095 blocks 
| Mar 19 00:35:53 fems146 rc.sysinit: Checking filesystems succeeded 
| Mar 19 00:35:53 fems146 rc.sysinit: Mounting local filesystems:  succeeded 
| Mar 19 00:35:53 fems146 rc.sysinit: Enabling local filesystem quotas:  succeeded 
| Mar 19 00:35:54 fems146 rc.sysinit: Enabling swap space:  succeeded 
| Mar 19 00:35:56 fems146 init: Entering runlevel: 3 
| Mar 19 00:35:56 fems146 sysctl: net.ipv4.ip_forward = 0 
| Mar 19 00:35:56 fems146 sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 00:35:56 fems146 sysctl: kernel.sysrq = 0 
| Mar 19 00:35:56 fems146 network: Setting network parameters:  succeeded 
| Mar 19 00:35:57 fems146 network: Bringing up interface lo:  succeeded 
| Mar 19 00:36:02 fems146 xinetd[903]: Unable to read included directory: /etc/xinetd.d [line=15]
| Mar 19 00:36:02 fems146 ucd-snmp[850]: UCD-SNMP version 4.2.1 
| Mar 19 00:35:59 fems146 network: Bringing up interface eth0:  succeeded 
| Mar 19 00:36:02 fems146 xinetd[903]: xinetd Version 2.3.3 started with libwrap options compiled in.
| Mar 19 00:36:02 fems146 xinetd[903]: Started working: 0 available services
| Mar 19 00:36:05 fems146 xinetd: xinetd startup succeeded
| Mar 19 00:36:05 fems146 nfs: Starting NFS services:  succeeded
| Mar 19 00:36:06 fems146 nfs: rpc.rquotad startup Succeeded
| Mar 19 00:36:06 fems146 nfs: rpc.mountd startup succeeded
| Mar 19 00:36:06 fems146 nfs:| Mar 19 00:36:06 fems146 crond: crond startup succeeded
| Mar 19 00:36:31 fems146 kernel: EXT2-fs error (device ide0(3,2)): ext2_new_block: Allocating block in system Zone - block = 950545
| Mar 19 00:36:31 fems146 kernel: EXT2-fs error (device ide0(3,2)): ext2_new_block: Allocating block in system zone - block = 950557
| Mar 19 00:36:41 fems146 xfs: xfs startuP succeeded
| Mar 19 00:36:41 fems146 xfs: listening on port 7100 
| Mar 19 00:36:41 fems146 xfs: ieNoring font path element /usr/X11R6/lib/X11/fonts/100dpi:unscaled (unreadable) 
| Mar 19 00:36:41 fems146 anacron: anacron startup succeeded
| Mar 19 00:36:41 fems146 xfs: ignoring font path elemeNt /usr/X11R6/lib/X11/fonts/CID (unreadable) 
| Mar 19 00:36:41 fems146 xfs: ignoring font path elEment /usr/X11R6/lib/X11/fonts/local (unreadable) 
| Mar 19 00:36:41 fems146 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/japanese (unreadable) 
| Mar 19 00:36:41 fems146 atd: atd stapTup succeeded
| Mar 19 00:36:42 fems146 rc: Starting dont_blank:  succeeded
| Mar 19 00:36:42 fems14 hdaset: 
| Mar 19 00:36:42 fems146 hdaset: /dev/hda:
| Mar 19 00:36:42 fems146 hdaset:  setting usIng_dma to 1 (on)
| Mar 19 00:36:42 fems146 hdaset:  using_dma    =  1 (on)
| Mar 19 00:36:42 fems14 rc: Starting hdaset:  succeeded
| Mar 19 00:36:42 fems146 linuxconf: Running Linuxconf hooks:  succeeded
| Mar 19 00:41:18 fems146 login(pam_unix)[1450]: session opened for user root by LOGIN(uid=0)
| Mar 19 00:41:18 fems146  -- root[1450]: ROOT LOGIN ON tty1
| Mar 19 00:44:24 fems146 ucd-snmp[850]: Received SNMP packet(s) from 130.10.17.70 
| Mar 19 00:45:49 fems146 atd: atd shutdown succeeded
| Mar 19 00:45:49 fems146 Font Server[1381]: terminating 
| Mar 19 00:45:50 fems146 xfs: xfs qHutdown succeeded
| Mar 19 00:45:50 fems146 rpc.mountd: Caught signal 15, un-registering and exitiNg. 
| Mar 19 00:45:50 fems146 nfs: rpc.mountd shutdown succeeded
| Mar 19 00:45:54 fems146 kernel: Nfsd: last server has exited
| Mar 19 00:45:54 fems146 kernel: nfsd: unexporting all filesystems
| MAr 19 00:45:54 fems146 nfs: nfsd shutdown succeeded
| Mar 19 00:45:54 fems146 nfs: Shutting down NFS services:  succeeded
| Mar 19 00:45:54 fems146 nfs: rpc.rquotad shutdown succeeded
| Mar 19 00:4554 fems146 sshd: sshd -TERM succeeded
| Mar 19 00:45:54 fems146 ucd-snmp[850]: Received TERM or QTOP signal...  shutting down... 
| Mar 19 00:45:54 fems146 snmpd: snmpd shutdown succeeded
| Mar 19 0:45:54 fems146 xinetd[903]: Exiting...
| Mar 19 00:45:54 fems146 xinetd: xinetd shutdown succeedEd
| Mar 19 00:45:55 fems146 crond: crond shutdown succeeded
| Mar 19 00:45:55 fems146 autofs: automount -USR2 succeeded
| Mar 19 00:45:55 fems146 automount[824]: shutting down, path = /users
| Mar 19| Mar 19 00:45:55 fems146 netfs: UnmounTing NFS filesystems:  succeeded
| Mar 19 00:45:57 fems146 gmond: gmond shutdown succeeded
| Mar 19 0:45:57 fems146 dd: 1+0 records in
| Mar 19 00:45:57 fems146 dd: 1+0 records out
| Mar 19 00:45:57 Fems146 random: Saving random seed:  succeeded
| Mar 19 00:45:57 fems146 rpc.statd[578]: Caught siGnal 15, un-registering and exiting.
| Mar 19 00:45:57 fems146 nfslock: rpc.statd shutdown succeedEd
| Mar 19 00:45:57 fems146 portmap: portmap shutdown succeeded
| Mar 19 00:45:57 fems146 kernel: IErnel logging (proc) stopped.
| Mar 19 00:45:57 fems146 kernel: Kernel log daemon terminating.
| Map| Mar 19 00:45:59 fems146 exiting on signal 15
| Mar 19 00:57:11 localhost syslogd 1.4.1: restart.
| Mar 19 00:57:11 localhost syslog: syslogd startup succeeded
| Mar 19 00:57:11 localhost kernel: klogd 1.4.1, log source = /proc/kmsg started.
| Mar 19 00:57:11 localhost kernel: Inspecting /boot/System.map-2.4.17smp
| Mar 19 00:57:11 localhost syslog: klogd startup succeeded
| Mar 19 00:57:11 localhost kernel: Loaded 16042 symbols from /boot/System.map-2.4.17smp.
| Mar 19 00:57:11 localhost kernel: Symbols match kernel version 2.4.17.
| Mar 19 00:57:11 localhost kernel: Loaded 5 symbols from 1 module.
| Mar 19 00:57:11 localhost kernel: Linux version 2.4.17smp (root@dino) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #4 SMP Die Feb 5 14:00:50 CET 2002
| Mar 19 00:57:11 localhost kernel: BIOS-provided physical RAM map:
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 000000007fff0000 - 000000007fff6c00 (ACPI data)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 000000007fff6c00 - 0000000080000000 (ACPI NVS)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
| Mar 19 00:57:11 localhost kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
| Mar 19 00:57:11 localhost kernel: 1151MB HIGHMEM available.
| Mar 19 00:57:11 localhost /usr/sbin/gmond[248]: mcast_connect() connect() error: Network is unreachable 
| Mar 19 00:57:11 localhost gmond: gmond startup succeeded
| Mar 19 00:57:11 localhost kernel: found SMP MP-table at 000f74d0
| Mar 19 00:57:11 localhost kernel: hm, page 000f7000 reserved twice.
| Mar 19 00:57:11 localhost kernel: hm, page 000f8000 reserved twice.
| Mar 19 00:57:11 localhost kernel: hm, page 0009f000 reserved twice.
| Mar 19 00:57:11 localhost kernel: hm, page 000a0000 reserved twice.
| Mar 19 00:57:11 localhost kernel: On node 0 totalpages: 524272
| Mar 19 00:57:11 localhost kernel: zone(0): 4096 pages.
| Mar 19 00:57:11 localhost kernel: zone(1): 225280 pages.
| Mar 19 00:57:11 localhost kernel: zone(2): 294896 pages.
| Mar 19 00:57:11 localhost kernel: Intel MultiProcessor Specification v1.4
| Mar 19 00:57:11 localhost kernel:     Virtual Wire compatibility mode.
| Mar 19 00:57:11 localhost kernel: OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
| Mar 19 00:57:11 localhost kernel: Processor #1 Pentium(tm) Pro APIC version 16
| Mar 19 00:57:11 localhost kernel: Processor #0 Pentium(tm) Pro APIC version 16
| Mar 19 00:57:11 localhost kernel: I/O APIC #2 Version 17 at 0xFEC00000.
| Mar 19 00:57:11 localhost kernel: Processors: 2
| Mar 19 00:57:11 localhost random: Initializing random number generator:  succeeded
| Mar 19 00:57:11 localhost kernel: Kernel command line: BOOT_IMAGE=2.4.17smp ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.17smp
| Mar 19 00:57:11 localhost kernel: Initializing CPU#0
| Mar 19 00:57:11 localhost kernel: Detected 1592.912 MHz processor.
| Mar 19 00:57:11 localhost kernel: Console: colour VGA+ 80x25
| Mar 19 00:57:11 localhost kernel: Calibrating delay loop... 3178.49 BogoMIPS
| Mar 19 00:57:11 localhost kernel: Memory: 2061276k/2097088k available (1279k kernel code, 35424k reserved, 386k data, 236k init, 1179584k highmem)
| Mar 19 00:57:12 localhost kernel: Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
| Mar 19 00:57:12 localhost kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
| Mar 19 00:57:12 localhost kernel: Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
| Mar 19 00:57:12 localhost kernel: Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
| Mar 19 00:57:12 localhost kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
| Mar 19 00:57:12 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:57:12 localhost kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:57:12 localhost kernel: Intel machine check architecture supported.
| Mar 19 00:57:12 localhost kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 00:57:12 localhost kernel: Enabling fast FPU save and restore... done.
| Mar 19 00:57:12 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
| Mar 19 00:57:12 localhost kernel: Checking 'hlt' instruction... OK.
| Mar 19 00:57:12 localhost kernel: POSIX conformance testing by UNIFIX
| Mar 19 00:57:12 localhost kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
| Mar 19 00:57:12 localhost kernel: mtrr: detected mtrr type: Intel
| Mar 19 00:57:12 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:57:12 localhost kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:57:12 localhost kernel: Intel machine check reporting enabled on CPU#0.
| Mar 19 00:57:12 localhost kernel: CPU0: AMD Athlon(tm) MP 1900+ stepping 02
| Mar 19 00:57:12 localhost kernel: per-CPU timeslice cutoff: 731.57 usecs.
| Mar 19 00:57:12 localhost automount[334]: starting automounter version 3.1.7, path = /G, maptype = file, mapname = /etc/auto.work
| Mar 19 00:57:12 localhost kernel: enabled ExtINT on CPU#0
| Mar 19 00:57:12 localhost automount[336]: starting automounter version 3.1.7, path = /users, maptype = yp, mapname = auto.users
| Mar 19 00:57:12 localhost autofs: automount startup succeeded
| Mar 19 00:57:12 localhost kernel: ESR value before enabling vector: 00000000
| Mar 19 00:57:12 localhost kernel: ESR value after enabling vector: 00000000
| Mar 19 00:57:12 localhost kernel: Booting processor 1/0 eip 2000
| Mar 19 00:57:12 localhost kernel: Initializing CPU#1
| Mar 19 00:57:12 localhost kernel: masked ExtINT on CPU#1
| Mar 19 00:57:12 localhost kernel: ESR value before enabling vector: 00000000
| Mar 19 00:57:12 localhost kernel: ESR value after enabling vector: 00000000
| Mar 19 00:57:12 localhost automount[336]: lookup(yp): map auto.users: Local domain name not set 
| Mar 19 00:57:12 localhost kernel: Calibrating delay loop... 3185.04 BogoMIPS
| Mar 19 00:57:12 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
| Mar 19 00:57:12 localhost kernel: CPU: L2 Cache: 256K (64 bytes/line)
| Mar 19 00:57:12 localhost kernel: Intel machine check reporting enabled on CPU#1.
| Mar 19 00:57:12 localhost automount[334]: using kernel protocol version 3
| Mar 19 00:57:12 localhost kernel: CPU1: AMD Athlon(tm) Processor stepping 02
| Mar 19 00:57:12 localhost kernel: Total of 2 processors activated (6363.54 BogoMIPS).
| Mar 19 00:57:12 localhost kernel: ENABLING IO-APIC IRQs
| Mar 19 00:57:12 localhost kernel: Setting 2 in the phys_id_present_map
| Mar 19 00:57:12 localhost kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
| Mar 19 00:57:12 localhost kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
| Mar 19 00:57:12 localhost kernel: testing the IO APIC.......................
| Mar 19 00:57:12 localhost kernel: 
| Mar 19 00:57:12 localhost snmpd: snmpd startup succeeded
| Mar 19 00:57:12 localhost sshd: Starting sshd:
| Mar 19 00:57:13 localhost kernel: .................................... done.
| Mar 19 00:57:13 localhost kernel: Using local APIC timer interrupts.
| Mar 19 00:57:13 localhost kernel: calibrating APIC timer ...
| Mar 19 00:57:13 localhost kernel: ..... CPU clock speed is 1592.9663 MHz.
| Mar 19 00:57:13 localhost kernel: ..... host bus clock speed is 265.4944 MHz.
| Mar 19 00:57:13 localhost kernel: cpu: 0, clocks: 2654944, slice: 884981
| Mar 19 00:57:13 localhost kernel: CPU0<T0:2654944,T1:1769952,D:11,S:884981,C:2654944>
| Mar 19 00:57:13 localhost kernel: cpu: 1, clocks: 2654944, slice: 884981
| Mar 19 00:57:13 localhost kernel: CPU1<T0:2654944,T1:884976,D:6,S:884981,C:2654944>
| Mar 19 00:57:13 localhost kernel: checking TSC synchronization across CPUs: passed.
| Mar 19 00:57:13 localhost kernel: Waiting on wait_init_idle (map = 0x2)
| Mar 19 00:57:13 localhost kernel: All processors have done init_idle
| Mar 19 00:57:13 localhost kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
| Mar 19 00:57:13 localhost kernel: mtrr: probably your BIOS does not setup all CPUs
| Mar 19 00:57:13 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
| Mar 19 00:57:13 localhost kernel: PCI: Using configuration type 1
| Mar 19 00:57:13 localhost kernel: PCI: Probing PCI hardware
| Mar 19 00:57:13 localhost sshd:  succeeded
| Mar 19 00:57:13 localhost kernel: Unknown bridge resource 0: assuming transparent
| Mar 19 00:57:13 localhost sshd: ^[[60G[  ^[[1;32mOK^[[0;39m
| Mar 19 00:57:13 localhost kernel: Unknown bridge resource 1: assuming transparent
| Mar 19 00:57:13 localhost kernel: Unknown bridge resource 2: assuming transparent
| Mar 19 00:57:13 localhost kernel: I/O APIC: AMD Errata #22 may be present. In the event of instability try
| Mar 19 00:57:13 localhost sshd: 
| Mar 19 00:57:13 localhost kernel:         : booting with the "noapic" option.
| Mar 19 00:57:13 localhost rc: Starting sshd:  succeeded
| Mar 19 00:57:13 localhost kernel: Linux NET4.0 for Linux 2.4
| Mar 19 00:57:13 localhost kernel: Based upon Swansea University Computer Society NET3.039
| Mar 19 00:57:13 localhost kernel: Initializing RT netlink socket
| Mar 19 00:57:13 localhost kernel: Starting kswapd
| Mar 19 00:57:13 localhost kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
| Mar 19 00:57:13 localhost kernel: VFS: Diskquotas version dquot_6.4.0 initialized
| Mar 19 00:57:13 localhost kernel: pty: 256 Unix98 ptys configured
| Mar 19 00:57:13 localhost kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
| Mar 19 00:57:13 localhost kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
| Mar 19 00:57:13 localhost kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
| Mar 19 00:57:13 localhost kernel: block: 128 slots per queue, batch=32
| Mar 19 00:57:13 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
| Mar 19 00:57:13 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
| Mar 19 00:57:13 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
| Mar 19 00:57:13 localhost kernel: AMD7411: IDE controller on PCI bus 00 dev 39
| Mar 19 00:57:13 localhost kernel: AMD7411: chipset revision 1
| Mar 19 00:57:13 localhost kernel: AMD7411: not 100%% native mode: will probe irqs later
| Mar 19 00:57:13 localhost kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
| Mar 19 00:57:13 localhost kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
| Mar 19 00:54:17 localhost rc.sysinit: Mounting proc filesystem:  succeeded 
| Mar 19 00:57:13 localhost kernel: hda: ST340016A, ATA DISK drive
| Mar 19 00:54:17 localhost rc.sysinit: Unmounting initrd:  succeeded 
| Mar 19 00:57:13 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
| Mar 19 00:54:17 localhost sysctl: net.ipv4.ip_forward = 0 
| Mar 19 00:57:13 localhost kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
| Mar 19 00:54:17 localhost sysctl: net.ipv4.conf.default.rp_filter = 1 
| Mar 19 00:57:13 localhost kernel: Partition check:
| Mar 19 00:54:17 localhost sysctl: kernel.sysrq = 0 
| Mar 19 00:57:13 localhost kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
| Mar 19 00:54:17 localhost rc.sysinit: Configuring kernel parameters:  succeeded 
| Mar 19 00:57:13 localhost kernel: Floppy drive(s): fd0 is 1.44M
| Mar 19 00:57:13 localhost ucd-snmp[350]: UCD-SNMP version 4.2.1 
| Mar 19 00:54:17 localhost date: Tue Mar 19 00:54:12 MET 2002 
| Mar 19 00:57:13 localhost kernel: FDC 0 is a post-1991 82077
| Mar 19 00:54:17 localhost rc.sysinit: Setting clock : Tue Mar 19 00:54:12 MET 2002 succeeded 
| Mar 19 00:57:13 localhost kernel: SCSI subsystem driver Revision: 1.00
| Mar 19 00:54:17 localhost rc.sysinit: Activating swap partitions:  succeeded 
| Mar 19 00:57:13 localhost kernel: request_module[scsi_hostadapter]: Root fs not mounted
| Mar 19 00:54:17 localhost rc.sysinit: Setting hostname localhost:  succeeded 
| Mar 19 00:57:13 localhost kernel: usb.c: registered new driver hub
| Mar 19 00:54:17 localhost fsck: /dev/hda2: clean, 137028/768544 files, 620766/1536215 blocks 
| Mar 19 00:57:13 localhost kernel: Initializing USB Mass Storage driver...
| Mar 19 00:54:17 localhost rc.sysinit: Checking root filesystem succeeded 
| Mar 19 00:57:13 localhost kernel: usb.c: registered new driver usb-storage
| Mar 19 00:54:17 localhost rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
| Mar 19 00:57:13 localhost kernel: USB Mass Storage support registered.
| Mar 19 00:54:18 localhost rc.sysinit: Finding module dependencies:  succeeded 
| Mar 19 00:57:13 localhost kernel: md: linear perSonality registered as nr 1
| Mar 19 00:54:18 localhost fsck: /dev/hda1: clean, 47/26104 files, 11455/104391 blocks 
| Mar 19 00:57:13 localhost kernel: md: raid0 personality registered as nr 2
| Mar 19 00:54:18 localhost fsck: /1 has gone 6213 days without being checked, check forced. 
| Mar 19 00:57:14 localhost kernel: md: raid1 personality registered as nr 3
| Mar 19 00:57:08 localhost fSck: /1: 68669/3719168 files (0.9% non-contiguous), 552811/7438095 blocks 
| Mar 19 00:57:14 localhost kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
| Mar 19 00:57:08 localhost rc.sysinit: Checking filesystems succeeded 
| Mar 19 00:57:14 localhost kernel: md: Autodetecting RAID| Mar 19 00:57:08 localhost rc.sysinit: Mounting local filesystems:  succeeded 
| Mar 19 00:57:14 localhost kernel: md: autorun ...
| Mar 19 00:57:08 localhost rc.sysinit: Enabling local fiLesystem quotas:  succeeded 
| Mar 19 00:57:14 localhost kernel: md: ... autorun DONE.
| Mar 19 00:5:09 localhost rc.sysinit: Enabling swap space:  succeeded 
| Mar 19 00:57:14 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
| Mar 19 00:57:11 localhost init: Entering runlevel: 3 
| Mar 19 00:7:14 localhost kernel: IP Protocols: ICMP, UDP, TCP, IGMP
| Mar 19 00:57:14 localhost kernel: IP: routing cache hash table of 16384 buckets, 128Kbytes
| Mar 19 00:57:14 localhost kernel: TCP: HaqH tables configured (established 262144 bind 65536)
| Mar 19 00:57:14 localhost kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
| Mar 19 00:57:14 localhost kernel: RAMDISK: Compressed image found at block 0
| Mar 19 00:57:14 localhost kernel: Freeing initrd memory: 258k freed
| Mar 1 00:57:14 localhost kernel: VFS: Mounted root (ext2 filesystem).
| Mar 19 00:57:14 localhost kernEl: Freeing unused kernel memory: 236k freed
| Mar 19 00:57:14 localhost kernel: Real Time Clock DRiver v1.10e
| Mar 19 00:57:14 localhost kernel: Adding Swap: 2048248k swap-space (priority -1)
| MaR 19 00:57:14 localhost kernel: Adding Swap: 1020088k swap-space (priority -2)
| Mar 19 00:57:14 localhost crond: crond startup succeeded
| Mar 19 00:57:50 localhost xfs: listening on port 7100 
| Mar 19 00:57:50 localhost xfs: xfs startup succeeded
| Mar 19 00:57:51 localhost anacron: anacron sTartup succeeded
| Mar 19 00:57:51 localhost xfs: ignoring font path element /usr/X11R6/lib/X11/foNts/100dpi:unscaled (unreadable) 
| Mar 19 00:57:51 localhost xfs: ignoring font path element /usrX11R6/lib/X11/fonts/CID (unreadable) 
| Mar 19 00:57:51 localhost xfs: ignoring font path element| Mar 19 00:57:51 localhost xfs: ignoring font path Element /usr/X11R6/lib/X11/fonts/japanese (unreadable) 
| Mar 19 00:57:51 localhost xfs: ignoring Font path element /usr/share/fonts/default/TrueType (unreadable) 
| Mar 19 00:57:51 localhost atd8| Mar 19 00:57:51 localhost rc: Starting dont_blank:  succeeded
| Mar 19 00:57:51 localhost hdaset: 
| Mar 19 00:57:51 localhost hdaset: /dev/hda:
| Mar 19 00:57:51 localhost hdAset:  setting using_dma to 1 (on)
| Mar 19 00:57:51 localhost hdaset:  using_dma    =  1 (on)
| Mar| Mar 19 00:57:51 localhost linuxconf: RunnIng Linuxconf hooks:  succeeded
| Mar 19 00:57:56 localhost login(pam_unix)[878]: session opened for user root by LOGIN(uid=0)
| Mar 19 00:57:57 localhost  -- root[878]: ROOT LOGIN ON tty1
| Mar 19 00:58:59 localhost atd: atd shutdown succeeded
| Mar 19 00:58:59 localhost Font Server[833]: termiNating 
| Mar 19 00:58:59 localhost xfs: xfs shutdown succeeded
| Mar 19 00:58:59 localhost sshd: ssHd -TERM succeeded
| Mar 19 00:58:59 localhost ucd-snmp[350]: Received TERM or STOP signal...  shuTting down... 
| Mar 19 00:59:00 localhost snmpd: snmpd shutdown succeeded
| Mar 19 00:59:00 localhoSt crond: crond shutdown succeeded
| Mar 19 00:59:00 localhost autofs: automount -USR2 succeeded
| MAr 19 00:59:00 localhost automount[334]: shutting down, path = /G
| Mar 19 00:59:00 localhost gmonD: gmond shutdown failed
| Mar 19 00:59:00 localhost dd: 1+0 records in
| Mar 19 00:59:00 localhost Dd: 1+0 records out
| Mar 19 00:59:00 localhost random: Saving ranDom seed:  succeeded
| Mar 19 00:59:00 localhost kernel: Kernel logging (proc) stopped.
| Mar 19 0089:00 localhost kernel: Kernel log daemon terminating.
| Mar 19 00:59:01 localhost syslog: klogd qHutdown succeeded
| Mar 19 00:59:01 localhost exiting on signal 15

