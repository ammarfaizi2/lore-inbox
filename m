Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTE2TKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTE2TKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:10:01 -0400
Received: from minmail.no ([213.160.234.15]:49120 "EHLO new.minmail.no")
	by vger.kernel.org with ESMTP id S262525AbTE2TJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:09:55 -0400
From: Morten Helgesen <morten.helgesen@nextframe.net>
Reply-To: morten.helgesen@nextframe.net
Organization: Nextframe AS
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: list_head debugging patch
Date: Thu, 29 May 2003 21:22:43 +0200
User-Agent: KMail/1.5
References: <20030529130807.GH19818@holomorphy.com>
In-Reply-To: <20030529130807.GH19818@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305292122.44041.morten.helgesen@nextframe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, 

On Thursday 29 May 2003 15:08, William Lee Irwin III wrote:
> This appears to get the kernel to crap its pants in very, very
> short order. Given the number of things going wrong, I almost
> wonder if I did something wrong. Things get real ugly, really,
> really fast.
>

[snip]

I gave this a go - booted without problems. I did some 
untaring/copying/deleting and didn`t see anything unusual, but a 
'dbench 8' died right away. 

elem = c0509b18, elem->next = c166d9c4, elem->next->prev = c3f71ea8
kernel BUG at include/linux/list.h:45!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c02c5178>]    Not tainted
EFLAGS: 00010096
EIP is at clear_queue_congested+0x78/0xb0
eax: 00000047   ebx: c0509b18   ecx: c04b8d24   edx: c043a8a0
esi: c0509b10   edi: c050db9c   ebp: c3f75c00   esp: c3f75be8
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 10, threadinfo=c3f74000 task=c3f73940)
Stack: c03d5f60 c0509b18 c166d9c4 c3f71ea8 c0661524 c0695c64 c3f75c20 
c02c7c35
       c050db9c 00000001 c0695c64 c04b9440 c050db9c c0661524 c3f75c68 
c02c8210
       c050db9c c0661524 c0695c64 00000200 00000000 014d98bc 00000008 
00000008
Call Trace:
 [<c02c7c35>] attempt_merge+0xc5/0x100
 [<c02c8210>] __make_request+0x490/0x610
 [<c02c84c7>] generic_make_request+0x137/0x1d0
 [<c01704ba>] bio_alloc+0xda/0x1c0
 [<c02c85b3>] submit_bio+0x53/0xa0
 [<c016e1b8>] __block_write_full_page+0x228/0x420
 [<c016f965>] block_write_full_page+0xd5/0xe0
 [<c01b6390>] ext3_get_block+0x0/0xa0
 [<c01b736a>] ext3_writepage+0x23a/0x440
 [<c01b6390>] ext3_get_block+0x0/0xa0
 [<c01b7110>] bget_one+0x0/0x10
 [<c0197f8c>] mpage_writepages+0x32c/0x5f0
 [<c01b7130>] ext3_writepage+0x0/0x440
 [<c011ed02>] schedule+0x2f2/0x6f0
 [<c014b627>] do_writepages+0x37/0x40
 [<c0195600>] __sync_single_inode+0x2c0/0x8f0
 [<c0196192>] sync_sb_inodes+0x312/0x7f0
 [<c02c7b64>] blk_congestion_wait+0x94/0xa0
 [<c01967f2>] writeback_inodes+0x182/0x2b0
 [<c014b359>] background_writeout+0xa9/0xe0
 [<c014bf57>] __pdflush+0x2f7/0x5f0
 [<c011f136>] preempt_schedule+0x36/0x50
 [<c011d870>] schedule_tail+0xc0/0xe0
 [<c014c250>] pdflush+0x0/0x20
 [<c014c261>] pdflush+0x11/0x20
 [<c014b2b0>] background_writeout+0x0/0xe0
 [<c01074e5>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 2d 00 95 42 3d c0 8b 46 08 39 d8 75 09 83 c4 10 5b 5e


wli also requested dmesg, so here goes:

Linux version 2.5.70list.h (morten@marge) (gcc version 3.2.2) #2 SMP 
Thu May 29 21:00:25 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
64MB LOWMEM available.
found SMP MP-table at 000f5810
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 16384
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 12288 pages, LIFO batch:3
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:5 APIC version 17
Processor #1 6:5 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.5.70-list.h ro root=302 
console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 342.640 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 673.79 BogoMIPS
Memory: 60132k/65536k available (2846k kernel code, 4924k reserved, 
968k data, 180k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1462.92 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 684.03 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU1: Intel Pentium II (Deschutes) stepping 02
Total of 2 processors activated (1357.82 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 342.0548 MHz.
..... host bus clock speed is 68.0509 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 116 entries (12 bytes)
biovec pool[1]:   4 bvecs: 116 entries (48 bytes)
biovec pool[2]:  16 bvecs:  58 entries (192 bytes)
biovec pool[3]:  64 bvecs:  29 entries (768 bytes)
biovec pool[4]: 128 bvecs:  14 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   7 entries (3072 bytes)
ACPI: Subsystem revision 20030522
tbxfroot-0324 [04] acpi_find_root_pointer: RSDP structure not found, 
AE_NOT_FOUND Flags=8
ACPI: System description tables not found
 tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, 
AE_NOT_FOUND
 tbxface-0134: *** Error: acpi_load_tables: Could not load tables: 
AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbff0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc018, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
aty128fb: Rage128 BIOS located at e8000000
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 32M 128-bit SDR SGRAM 
(1:1)
fb0: ATY Rage128 frame buffer device on Rage128 Pro PF (AGP)
aty128fb: Rage128 MTRR set to ON
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: AGP aperture is 64M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe400. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD273BA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: host protected area => 1
hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=53040/16/63, 
UDMA(33)
 hda: hda1 hda2 hda3 hda4
Console: switching to colour frame buffer device 80x30
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4
uhci-hcd 00:07.2: irq 19, io base 0000e000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is 
deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
oprofile: using NMI interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2730)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 265064k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
morten.helgesen@nextframe.net / 93445641
http://www.nextframe.net

