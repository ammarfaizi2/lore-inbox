Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUD0AFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUD0AFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 20:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUD0AFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 20:05:36 -0400
Received: from [80.72.36.106] ([80.72.36.106]:57473 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S263475AbUD0AEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 20:04:54 -0400
Date: Tue, 27 Apr 2004 02:04:40 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
In-Reply-To: <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net>
 <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 27, 2004 at 12:38:53AM +0200, Grzegorz Kulewski wrote:
> > On Mon, 26 Apr 2004, Linus Torvalds wrote:
> > > Try turning off MD first. Then quota, and if neither of those matters, 
> > > start tuning off the individual filesystem drivers (reiser, xfs).
> > 
> > Yes, when I turned off MD and DM it started to work. Thanks. Can I help 
> > more to track the problem down? (I currently have no MD or DM volumes in 
> > my system - I just wanted to start experimenting with them...)
> 
> Add
> 	printk("claim: %d:%d %p -> %d\n",
> 		MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev), holder, res);
> in the very end of fs/block_dev.c::bd_claim() (just before return) and
> 	printk("release: %d:%d\n", 
> 		MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> in bd_release() (same file).

Here is what I got:

Apr 27 01:49:23 polb01 syslog-ng[9702]: syslog-ng version 1.6.2 starting
Apr 27 01:49:23 polb01 syslog-ng[9702]: Changing permissions on special 
file /dev/tty12
Apr 27 01:49:23 polb01 Linux version 2.6.6-rc2-bk3 (root@polb01) (gcc 
version 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)) #4 Tue Apr 
27 01:43:01 CEST 2004
Apr 27 01:49:23 polb01 BIOS-provided physical RAM map:
Apr 27 01:49:23 polb01 BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Apr 27 01:49:23 polb01 BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Apr 27 01:49:23 polb01 BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Apr 27 01:49:23 polb01 BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Apr 27 01:49:23 polb01 BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Apr 27 01:49:23 polb01 BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Apr 27 01:49:23 polb01 BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Apr 27 01:49:23 polb01 511MB LOWMEM available.
Apr 27 01:49:23 polb01 On node 0 totalpages: 131056
Apr 27 01:49:23 polb01 DMA zone: 4096 pages, LIFO batch:1
Apr 27 01:49:23 polb01 Normal zone: 126960 pages, LIFO batch:16
Apr 27 01:49:23 polb01 HighMem zone: 0 pages, LIFO batch:1
Apr 27 01:49:23 polb01 DMI 2.2 present.
Apr 27 01:49:23 polb01 ACPI: RSDP (v000 761686                                    
) @ 0x000f6810
Apr 27 01:49:23 polb01 ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
Apr 27 01:49:23 polb01 ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
Apr 27 01:49:23 polb01 ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
Apr 27 01:49:23 polb01 ACPI: PM-Timer IO Port: 0x4008
Apr 27 01:49:23 polb01 Built 1 zonelists
Apr 27 01:49:23 polb01 Kernel command line: ro root=/dev/hdd4
Apr 27 01:49:23 polb01 Local APIC disabled by BIOS -- reenabling.
Apr 27 01:49:23 polb01 Found and enabled local APIC!
Apr 27 01:49:23 polb01 Initializing CPU#0
Apr 27 01:49:23 polb01 PID hash table entries: 2048 (order 11: 16384 
bytes)
Apr 27 01:49:23 polb01 Detected 1001.762 MHz processor.
Apr 27 01:49:23 polb01 Using pmtmr for high-res timesource
Apr 27 01:49:23 polb01 Console: colour VGA+ 80x25
Apr 27 01:49:23 polb01 Memory: 515000k/524224k available (2788k kernel 
code, 8472k reserved, 567k data, 132k init, 0k highmem)
Apr 27 01:49:23 polb01 Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Apr 27 01:49:23 polb01 Calibrating delay loop... 1982.46 BogoMIPS
Apr 27 01:49:23 polb01 Dentry cache hash table entries: 65536 (order: 6, 
262144 bytes)
Apr 27 01:49:23 polb01 Inode-cache hash table entries: 32768 (order: 5, 
131072 bytes)
Apr 27 01:49:23 polb01 Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Apr 27 01:49:23 polb01 CPU:     After generic identify, caps: 0183fbff 
c1c7fbff 00000000 00000000
Apr 27 01:49:23 polb01 CPU:     After vendor identify, caps: 0183fbff 
c1c7fbff 00000000 00000000
Apr 27 01:49:23 polb01 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Apr 27 01:49:23 polb01 CPU: L2 Cache: 256K (64 bytes/line)
Apr 27 01:49:23 polb01 CPU:     After all inits, caps: 0183fbf7 c1c7fbff 
00000000 00000020
Apr 27 01:49:23 polb01 Intel machine check architecture supported.
Apr 27 01:49:23 polb01 Intel machine check reporting enabled on CPU#0.
Apr 27 01:49:23 polb01 CPU: AMD Athlon(tm) processor stepping 02
Apr 27 01:49:23 polb01 Enabling fast FPU save and restore... done.
Apr 27 01:49:23 polb01 Checking 'hlt' instruction... OK.
Apr 27 01:49:23 polb01 POSIX conformance testing by UNIFIX
Apr 27 01:49:23 polb01 enabled ExtINT on CPU#0
Apr 27 01:49:23 polb01 ESR value before enabling vector: 00000000
Apr 27 01:49:23 polb01 ESR value after enabling vector: 00000000
Apr 27 01:49:23 polb01 Using local APIC timer interrupts.
Apr 27 01:49:23 polb01 calibrating APIC timer ...
Apr 27 01:49:23 polb01 ..... CPU clock speed is 1001.0108 MHz.
Apr 27 01:49:23 polb01 ..... host bus clock speed is 266.0962 MHz.
Apr 27 01:49:23 polb01 NET: Registered protocol family 16
Apr 27 01:49:23 polb01 PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last 
bus=1
Apr 27 01:49:23 polb01 PCI: Using configuration type 1
Apr 27 01:49:23 polb01 mtrr: v2.0 (20020519)
Apr 27 01:49:23 polb01 ACPI: Subsystem revision 20040326
Apr 27 01:49:23 polb01 ACPI: IRQ11 SCI: Level Trigger.
Apr 27 01:49:23 polb01 spurious 8259A interrupt: IRQ7.
Apr 27 01:49:23 polb01 ACPI: Interpreter enabled
Apr 27 01:49:23 polb01 ACPI: Using PIC for interrupt routing
Apr 27 01:49:23 polb01 ACPI: PCI Root Bridge [PCI0] (00:00)
Apr 27 01:49:23 polb01 PCI: Probing PCI hardware (bus 00)
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 
10 11 12 14 15)
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Apr 27 01:49:23 polb01 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Apr 27 01:49:23 polb01 PCI: Using ACPI for IRQ routing
Apr 27 01:49:23 polb01 PCI: if you experience problems, try using option 
'pci=noacpi' or even 'acpi=off'
Apr 27 01:49:23 polb01 ikconfig 0.7 with /proc/config*
Apr 27 01:49:23 polb01 Total HugeTLB memory allocated, 0
Apr 27 01:49:23 polb01 VFS: Disk quotas dquot_6.5.1
Apr 27 01:49:23 polb01 SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Apr 27 01:49:23 polb01 SGI XFS Quota Management subsystem
Apr 27 01:49:23 polb01 Initializing Cryptographic API
Apr 27 01:49:23 polb01 Serial: 8250/16550 driver $Revision: 1.90 $ 8 
ports, IRQ sharing disabled
Apr 27 01:49:23 polb01 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Apr 27 01:49:23 polb01 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Apr 27 01:49:23 polb01 8139too Fast Ethernet driver 0.9.27
Apr 27 01:49:23 polb01 eth0: RealTek RTL8139 at 0xe000, 00:06:4f:00:73:8b, 
IRQ 11
Apr 27 01:49:23 polb01 eth0:  Identified 8139 chip type 'RTL-8139C'
Apr 27 01:49:23 polb01 Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Apr 27 01:49:23 polb01 ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Apr 27 01:49:23 polb01 VP_IDE: IDE controller at PCI slot 0000:00:07.1
Apr 27 01:49:23 polb01 VP_IDE: chipset revision 6
Apr 27 01:49:23 polb01 VP_IDE: not 100% native mode: will probe irqs later
Apr 27 01:49:23 polb01 VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Apr 27 01:49:23 polb01 ide0: BM-DMA at 0xd400-0xd407, BIOS settings: 
hda:DMA, hdb:pio
Apr 27 01:49:23 polb01 ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: 
hdc:DMA, hdd:DMA
Apr 27 01:49:23 polb01 hda: SAMSUNG SV6004H, ATA DISK drive
Apr 27 01:49:23 polb01 Using anticipatory io scheduler
Apr 27 01:49:23 polb01 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 27 01:49:23 polb01 hdc: PIONEER DVD-ROM DVD-115, ATAPI CD/DVD-ROM 
drive
Apr 27 01:49:23 polb01 hdd: SAMSUNG SV3063H, ATA DISK drive
Apr 27 01:49:23 polb01 ide1 at 0x170-0x177,0x376 on irq 15
Apr 27 01:49:23 polb01 hda: max request size: 128KiB
Apr 27 01:49:23 polb01 hda: 117306000 sectors (60060 MB) w/468KiB Cache, 
CHS=65535/16/63, UDMA(100)
Apr 27 01:49:23 polb01 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Apr 27 01:49:23 polb01 hdd: max request size: 128KiB
Apr 27 01:49:23 polb01 hdd: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Apr 27 01:49:23 polb01 hdd: hdd1 hdd2 hdd3 hdd4
Apr 27 01:49:23 polb01 mice: PS/2 mouse device common for all mice
Apr 27 01:49:23 polb01 serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 27 01:49:23 polb01 input: PS/2 Generic Mouse on isa0060/serio1
Apr 27 01:49:23 polb01 serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 27 01:49:23 polb01 input: AT Translated Set 2 keyboard on 
isa0060/serio0
Apr 27 01:49:23 polb01 NET: Registered protocol family 2
Apr 27 01:49:23 polb01 IP: routing cache hash table of 1024 buckets, 
32Kbytes
Apr 27 01:49:23 polb01 TCP: Hash tables configured (established 32768 bind 
9362)
Apr 27 01:49:23 polb01 ACPI: (supports S0 S1 S4 S5)
Apr 27 01:49:23 polb01 claim: 22:68 c0407320 -> 0
Apr 27 01:49:23 polb01 release: 22:68
Apr 27 01:49:23 polb01 claim: 22:68 c0407aa0 -> 0
Apr 27 01:49:23 polb01 kjournald starting.  Commit interval 5 seconds
Apr 27 01:49:23 polb01 EXT3-fs: mounted filesystem with ordered data mode.
Apr 27 01:49:23 polb01 VFS: Mounted root (ext3 filesystem) readonly.
Apr 27 01:49:23 polb01 Freeing unused kernel memory: 132k freed
Apr 27 01:49:23 polb01 NET: Registered protocol family 1
Apr 27 01:49:23 polb01 EXT3 FS on hdd4, internal journal
Apr 27 01:49:23 polb01 CSLIP: code copyright 1989 Regents of the 
University of California
Apr 27 01:49:23 polb01 PPP generic driver version 2.4.2
Apr 27 01:49:23 polb01 PPP Deflate Compression module registered
Apr 27 01:49:23 polb01 NET: Registered protocol family 8
Apr 27 01:49:23 polb01 NET: Registered protocol family 20
Apr 27 01:49:23 polb01 ACPI: Power Button (FF) [PWRF]
Apr 27 01:49:23 polb01 ACPI: Sleep Button (CM) [SLPB]
Apr 27 01:49:23 polb01 ACPI: Processor [CPU0] (supports C1, 2 throttling 
states)
Apr 27 01:49:23 polb01 input: PC Speaker
Apr 27 01:49:23 polb01 inserting floppy driver for 2.6.6-rc2-bk3
Apr 27 01:49:23 polb01 Floppy drive(s): fd0 is 1.44M
Apr 27 01:49:23 polb01 FDC 0 is a post-1991 82077
Apr 27 01:49:23 polb01 loop: loaded (max 8 devices)
Apr 27 01:49:23 polb01 Non-volatile memory driver v1.2
Apr 27 01:49:23 polb01 BIOS EDD facility v0.13 2004-Mar-09, 2 devices 
found
Apr 27 01:49:23 polb01 Please report your BIOS at 
http://linux.dell.com/edd/results.html
Apr 27 01:49:23 polb01 device-mapper: 4.1.0-ioctl (2003-12-10) 
initialised: dm@uk.sistina.com
Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
Apr 27 01:49:23 polb01
Apr 27 01:49:23 polb01 device-mapper: error adding target to table
Apr 27 01:49:23 polb01 claim: 3:5 c0407aa0 -> -16
Apr 27 01:49:23 polb01 claim: 3:2 e0947800 -> -16
Apr 27 01:49:23 polb01 NTFS driver 2.1.6 [Flags: R/O MODULE].
Apr 27 01:49:23 polb01 claim: 3:3 e09176c0 -> -16
Apr 27 01:49:23 polb01 usbcore: registered new driver usbfs
Apr 27 01:49:23 polb01 usbcore: registered new driver hub
Apr 27 01:49:23 polb01 Real Time Clock Driver v1.12
Apr 27 01:49:23 polb01 parport_pc: Strange, can't probe Via 686A parallel 
port: io=0x378, irq=-1, dma=-1
Apr 27 01:49:23 polb01 USB Universal Host Controller Interface driver v2.2
Apr 27 01:49:23 polb01 uhci_hcd 0000:00:07.2: UHCI Host Controller
Apr 27 01:49:23 polb01 uhci_hcd 0000:00:07.2: irq 11, io base 0000d800
Apr 27 01:49:23 polb01 uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Apr 27 01:49:23 polb01 hub 1-0:1.0: USB hub found
Apr 27 01:49:23 polb01 hub 1-0:1.0: 2 ports detected
Apr 27 01:49:23 polb01 uhci_hcd 0000:00:07.3: UHCI Host Controller
Apr 27 01:49:23 polb01 uhci_hcd 0000:00:07.3: irq 11, io base 0000dc00
Apr 27 01:49:23 polb01 uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Apr 27 01:49:23 polb01 hub 2-0:1.0: USB hub found
Apr 27 01:49:23 polb01 hub 2-0:1.0: 2 ports detected
Apr 27 01:49:23 polb01 usb 1-1: new full speed USB device using address 2
Apr 27 01:49:23 polb01 usbcore: registered new driver speedtch
Apr 27 01:49:23 polb01 usb 1-2: new full speed USB device using address 3
Apr 27 01:49:23 polb01 gameport: pci0000:00:09.1 speed 1242 kHz
Apr 27 01:49:23 polb01 usb 1-1: usbfs: interface 1 claimed while 
'modem_run' sets config #1
Apr 27 01:49:23 polb01 usb 1-1: usbfs: interface 2 claimed while 
'modem_run' sets config #1
Apr 27 01:49:23 polb01 eth0: link down
Apr 27 01:49:23 polb01 usb 1-1: usbfs: interface 0 claimed while 
'modem_run' sets config #1
Apr 27 01:49:23 polb01 usb 1-1: usbfs: interface 1 claimed while 
'modem_run' sets config #1
Apr 27 01:49:23 polb01 usb 1-1: usbfs: interface 2 claimed while 
'modem_run' sets config #1
Apr 27 01:49:25 polb01 named[9892]: starting BIND 9.2.2-P1 -u named -n 1
Apr 27 01:49:25 polb01 named[9892]: using 1 CPU
Apr 27 01:49:25 polb01 named[9892]: loading configuration from 
'/etc/bind/named.conf'
Apr 27 01:49:25 polb01 named[9892]: listening on IPv4 interface lo, 
127.0.0.1#53
Apr 27 01:49:25 polb01 process `named' is using obsolete setsockopt 
SO_BSDCOMPAT
Apr 27 01:49:25 polb01 init: Activating demand-procedures for 'A'
Apr 27 01:49:25 polb01 named[9892]: command channel listening on 
127.0.0.1#953
Apr 27 01:49:25 polb01 named[9892]: zone 127.in-addr.arpa/IN: loaded 
serial 2002081601
Apr 27 01:49:25 polb01 named[9892]: zone localhost/IN: loaded serial 
2002081601
Apr 27 01:49:25 polb01 named[9892]: running
Apr 27 01:49:34 polb01 gdm[10087]: gdm_slave_xioerror_handler: Powany bd X 
- restartowanie :0
Apr 27 01:49:35 polb01 modem_run[9364]: [monitoring report] ADSL link went 
up
Apr 27 01:49:36 polb01 gdm[10233]: gdm_slave_xioerror_handler: Powany bd X 
- restartowanie :0
Apr 27 01:49:42 polb01 gdm[10371]: gdm_slave_xioerror_handler: Powany bd X 
- restartowanie :0
Apr 27 01:49:47 polb01 gdm[10515]: gdm_slave_xioerror_handler: Powany bd X 
- restartowanie :0
Apr 27 01:49:47 polb01 gdm[10085]: deal_with_x_crashes: Uruchamianie 
skryptu XKeepsCrashing
Apr 27 01:49:51 polb01 modem_run[8122]: ADSL synchronization has been 
obtained
Apr 27 01:49:51 polb01 modem_run[8122]: ADSL line is up (640 kbit/s down | 
160 kbit/s up)
Apr 27 01:49:51 polb01 modem_run[9364]: Error reading interrupts
Apr 27 01:49:51 polb01 modem_run[9364]: [monitoring report] ADSL link went 
down
Apr 27 01:49:52 polb01 modem_run[9364]: Device disconnected, shutting down
Apr 27 01:49:52 polb01 login(pam_unix)[9972]: session opened for user root 
by (uid=0)
Apr 27 01:49:52 polb01 pppd[10731]: Plugin /usr/lib/pppoatm.so loaded.
Apr 27 01:49:52 polb01 pppd[10731]: PPPoATM plugin_init
Apr 27 01:49:52 polb01 pppd[10731]: PPPoATM setdevname - remove unwanted 
options
Apr 27 01:49:52 polb01 pppd[10731]: PPPoATM setdevname_pppoatm - 
SUCCESS:0.35
Apr 27 01:49:52 polb01 pppd[10736]: pppd 2.4.2 started by root, uid 0
Apr 27 01:49:52 polb01 pppd[10736]: Using interface ppp0
Apr 27 01:49:52 polb01 pppd[10736]: Connect: ppp0 <--> 0.35
Apr 27 01:50:02 polb01 pppd[10736]: LCP: timeout sending Config-Requests
Apr 27 01:50:02 polb01 pppd[10736]: Connection terminated.
Apr 27 01:50:03 polb01 claim: 3:5 c0407aa0 -> -16
Apr 27 01:50:06 polb01 pppd[10736]: connect(0.35): Address already in use
Apr 27 01:50:06 polb01 pppd[10736]: Exit.
Apr 27 01:50:15 polb01 pppd[10875]: Plugin /usr/lib/pppoatm.so loaded.
Apr 27 01:50:15 polb01 pppd[10875]: PPPoATM plugin_init
Apr 27 01:50:15 polb01 pppd[10875]: PPPoATM setdevname - remove unwanted 
options
Apr 27 01:50:15 polb01 pppd[10875]: PPPoATM setdevname_pppoatm - 
SUCCESS:0.35
Apr 27 01:50:15 polb01 pppd[10876]: pppd 2.4.2 started by root, uid 0
Apr 27 01:50:15 polb01 pppd[10876]: Using interface ppp0
Apr 27 01:50:15 polb01 pppd[10876]: Connect: ppp0 <--> 0.35
Apr 27 01:50:22 polb01 pppd[10876]: CHAP authentication succeeded
Apr 27 01:50:22 polb01 PPP BSD Compression module registered
Apr 27 01:50:22 polb01 pppd[10876]: local  IP address 83.31.85.169
Apr 27 01:50:22 polb01 pppd[10876]: remote IP address 213.25.2.31
Apr 27 01:50:24 polb01 claim: 3:5 c0407aa0 -> -16
Apr 27 01:50:24 polb01 claim: 3:2 e0947800 -> -16
Apr 27 01:50:24 polb01 claim: 3:3 e09176c0 -> -16
Apr 27 01:50:45 polb01 init: Switching to runlevel: 6
Apr 27 01:50:48 polb01 SysRq : Emergency Sync
Apr 27 01:50:48 polb01 Emergency Sync complete
Apr 27 01:50:49 polb01 SysRq : Emergency Sync
Apr 27 01:50:49 polb01 Emergency Sync complete
Apr 27 01:50:49 polb01 SysRq : Emergency Sync
Apr 27 01:50:49 polb01 Emergency Sync complete
Apr 27 01:50:49 polb01 SysRq : Emergency Sync
Apr 27 01:50:49 polb01 Emergency Sync complete
Apr 27 01:50:59 polb01 named[9892]: shutting down
Apr 27 01:50:59 polb01 named[9892]: stopping command channel on 
127.0.0.1#953
Apr 27 01:50:59 polb01 named[9892]: no longer listening on 127.0.0.1#53
Apr 27 01:50:59 polb01 named[9892]: exiting
Apr 27 01:51:02 polb01 sshd[9558]: Received signal 15; terminating.
Apr 27 01:51:04 polb01 syslog-ng[9702]: syslog-ng version 1.6.2 going down


And here is my /etc/fstab:

/dev/hdd4               /               ext3            noatime                 
0 0
/dev/hda5               /mnt/old        ext3            noatime                 
0 0
/dev/hda6               /mnt/old/home   ext3            noatime                 
0 0
/dev/cdroms/cdrom0      /mnt/cdrom      auto            noauto,ro,user          
0 0
/dev/hda2               /mnt/fat        vfat            
defaults,dmask=0000,fmask=0111,noexec           0 0
/dev/hda3               /mnt/win        ntfs            
defaults,dmask=0222,fmask=0111,noexec,ro        0 0
 

I am going down now! (It is after 2am in Warsaw.) Goodnight.
But I will probably be accessible in the morning...


Grzegorz Kulewski

