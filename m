Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUJJCTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUJJCTm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUJJCTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:19:41 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:6528 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S268053AbUJJCTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:19:05 -0400
Date: Sun, 10 Oct 2004 12:19:29 +1000
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041010021929.GA1322@zip.com.au>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org> <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org> <20041001103032.GA1049@zip.com.au> <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org> <20041002045725.GC1049@zip.com.au> <Pine.LNX.4.58.0410021211120.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410021211120.2301@ppc970.osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry for the delay in getting back. Long weekend + RL tied things up.

On Sat, Oct 02, 2004 at 12:17:48PM -0700, Linus Torvalds wrote:
> On Sat, 2 Oct 2004, CaT wrote:
> > > Can you send me your ioports from 2.6.9-rc3 _with_ the 
> > > "request_resource()" change..
> > 
> > Diff says that the file is thesame as the one without patch+change
> > that doesn't work.
> 
> That's really wrong. Hmm.. Can you enable debugging for the PCI resource 
> stuff? It's DEBUG_CONFIG in drivers/pci/setup-res.c, and DEBUG in 
> arch/i386/pci/pci.h, and now your dmesg should be a lot more verbose about 
> the bootup resources..

I did this:

./setup-res.c:#define DEBUG_CONFIG 1
./pci.h:#define DEBUG

dmesg attached.

> Also (independently - I really do want to see the debug info) can you try
> making the "drivers/pci/setup-res.c" version of "insert_resource()" be a
> request_resource() too?

No change. :/

-- 
    Red herrings strewn hither and yon.

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.debug"

Linux version 2.6.9-rc3 (root@nessie) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #12 Fri Oct 8 09:58:38 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001c000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
448MB LOWMEM available.
On node 0 totalpages: 114688
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110592 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=l ro root=302
Initializing CPU#0
CPU 0 irqstacks, hard=c04f6000 soft=c04f5000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 348.301 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449816k/458752k available (2713k kernel code, 8456k reserved, 917k data, 396k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 686.08 BogoMIPS (lpj=343040)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0183f9ff 00000000 00000000 00000040
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: BIOS32 Service Directory structure at 0xc00fa000
PCI: BIOS32 Service Directory entry at 0xec700
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xed728, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address fixup for 0000:00:14.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f7050
00:0d slot=01 0:60/0ef8 1:61/0ef8 2:62/0ef8 3:63/0ef8
00:0e slot=02 0:61/0ef8 1:62/0ef8 2:63/0ef8 3:60/0ef8
00:0f slot=03 0:62/0ef8 1:63/0ef8 2:60/0ef8 3:61/0ef8
00:10 slot=04 0:63/0ef8 1:60/0ef8 2:61/0ef8 3:62/0ef8
00:14 slot=00 0:00/0000 1:00/0000 2:00/0000 3:63/0ef8
00:01 slot=00 0:62/0ef8 1:63/0ef8 2:00/0000 3:00/0000
PCI: Attempting to find IRQ router for 0000:0000
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:14.0
PCI: IRQ fixup
0000:00:14.2: ignoring bogus IRQ 255
IRQ for 0000:00:14.2:3 -> PIRQ 63, mask 0ef8, excl 0000<4>PCI: IRQ 0 for device 0000:00:14.2 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 ... failed
PCI: Allocating resources
PCI: Resource 44000000-47ffffff (f=1208, d=0, p=0)
PCI: Resource 000010f0-000010f7 (f=101, d=0, p=0)
PCI: Resource 00001800-00001803 (f=101, d=0, p=0)
PCI: Resource 000010f8-000010ff (f=101, d=0, p=0)
PCI: Resource 00001804-00001807 (f=101, d=0, p=0)
PCI: Resource 00001080-000010bf (f=101, d=0, p=0)
PCI: Resource 42000000-4201ffff (f=200, d=0, p=0)
PCI: Resource 00001000-0000107f (f=101, d=0, p=0)
PCI: Resource 40900000-4090007f (f=200, d=0, p=0)
PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
PCI: Resource 42100000-421000ff (f=200, d=0, p=0)
PCI: Resource 000010a0-000010af (f=101, d=0, p=0)
PCI: Resource 41000000-41ffffff (f=1208, d=0, p=0)
PCI: Resource 40800000-40803fff (f=200, d=0, p=0)
PCI: Resource 40000000-407fffff (f=200, d=0, p=0)
PCI: Sorting device list...
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
  got res [10c0:10df] bus [10c0:10df] flags 101 for BAR 4 of 0000:00:14.2
PCI: moved device 0000:00:14.2 resource 4 (101) to 10c0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
IRQ for 0000:00:0e.0:0 -> PIRQ 61, mask 0ef8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 0000:00:0e.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Linux Tulip driver version 1.1.13 (May 11, 2002)
IRQ for 0000:00:0f.0:0 -> PIRQ 62, mask 0ef8, excl 0000 -> newirq=9 -> got IRQ 9
PCI: Found IRQ 9 for device 0000:00:0f.0
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xdc80e000, 00:A0:CC:64:35:FF, IRQ 9.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller at PCI slot 0000:00:0d.0
IRQ for 0000:00:0d.0:0 -> PIRQ 60, mask 0ef8, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Unable to reserve I/O region #5:40@1080 for device 0000:00:0d.0
PIIX4: IDE controller at PCI slot 0000:00:14.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SV1022D, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: AOPEN CD-RW CRW3248 1.12 20020417, ATAPI CD/DVD-ROM drive
hdd: QUANTUM FIREBALLlct20 10, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 19931184 sectors (10204 MB) w/472KiB Cache, CHS=19773/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdd: max request size: 128KiB
hdd: 20044080 sectors (10262 MB) w/418KiB Cache, CHS=19885/16/63
hdd: cache flushes not supported
 hdd: hdd1 hdd2
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 8192kB Cache
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
GACT probability on
u32 classifier
    Perfomance counters on
    Actions configured 
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (3584 buckets, 28672 max) - 332 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 396k freed
Adding 506008k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Disabled Privacy Extensions on device c0426840(lo)

--cWoXeonUoKmBZSoM--
