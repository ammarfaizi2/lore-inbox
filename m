Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTKWCQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 21:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTKWCQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 21:16:10 -0500
Received: from attila.bofh.it ([213.92.8.2]:55244 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S263203AbTKWCPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 21:15:50 -0500
Date: Sun, 23 Nov 2003 03:15:38 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031123021537.GA1816@wonderland.linux.it>
References: <20031122235539.GA14576@wonderland.linux.it> <Pine.LNX.4.44.0311221741250.2379-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311221741250.2379-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, Linus Torvalds <torvalds@osdl.org> wrote:

 >The problem _appears_ to be the fact that we already registered irq15 for 
 >the IDE driver, which will cause the probe to fail (you can't probe 
 >something that is already in use).
 >
 >Can you try this patch, and see if it makes a difference? I'd also like to 
 >see the full "dmesg" output (regardless of whether it works or not).
It does not. This is the output with your patch applied and PCI
debugging enabled:

klogd 1.4.1#11, log source = /proc/kmsg started.
k highmem)
Calibrating delay loop... 2875.39 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) MP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: BIOS32 Service Directory structure at 0xc00f2000
PCI: BIOS32 Service Directory entry at 0xf1940
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................
Table [DSDT](id F004) - 363 Objects with 50 Devices 124 Methods 19 Regions
ACPI Namespace successfully loaded at root c03b30bc
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 19/19 Regions 2/2 Fields 23/23 Buffers 11/11 Packages (371 nodes)
Executing all Device _STA and_INI methods:...................................................
51 Devices found containing: 51 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address fixup for 0000:00:0f.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fa100
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa130, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
 -> edgeACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 3
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 7
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 15
 -> edge<6>PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: IRQ init
PCI: Allocating resources
PCI: Resource f0000000-f7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000b400-0000b407 (f=101, d=0, p=0)
PCI: Resource 0000b000-0000b003 (f=101, d=0, p=0)
PCI: Resource 0000a800-0000a807 (f=101, d=0, p=0)
PCI: Resource 0000a400-0000a403 (f=101, d=0, p=0)
PCI: Resource 0000a000-0000a00f (f=101, d=0, p=0)
PCI: Resource 00009800-000098ff (f=101, d=0, p=0)
PCI: Resource 00009400-0000940f (f=101, d=0, p=0)
PCI: Resource 00009000-0000901f (f=101, d=0, p=0)
PCI: Resource 00008800-0000881f (f=101, d=0, p=0)
PCI: Resource 00008400-0000841f (f=101, d=0, p=0)
PCI: Resource 00008000-0000801f (f=101, d=0, p=0)
PCI: Resource d5800000-d58000ff (f=200, d=0, p=0)
PCI: Resource 0000e000-0000e0ff (f=101, d=0, p=0)
PCI: Resource e8000000-efffffff (f=1208, d=0, p=0)
PCI: Resource 0000d800-0000d8ff (f=101, d=0, p=0)
PCI: Resource d7800000-d780ffff (f=200, d=0, p=0)
PCI: Resource d6800000-d6803fff (f=200, d=1, p=1)
PCI: Resource 0000b800-0000b8ff (f=101, d=1, p=1)
PCI: Resource d6000000-d60003ff (f=200, d=1, p=1)
PCI: Resource d5000000-d50000ff (f=200, d=1, p=1)
PCI: Resource d8000000-dfffffff (f=1208, d=1, p=1)
PCI: Resource d7000000-d700ffff (f=200, d=1, p=1)
PCI: Sorting device list...
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100%% native mode on irq 3
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IRQ probe failed (0x3cfa: 0). Guessing at 15
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: 32X10, ATAPI CD/DVD-ROM drive
irq 15: nobody cared!
Call Trace:
 [<c010a92b>] __report_bad_irq+0x2b/0x90
 [<c010aa24>] note_interrupt+0x64/0xa0
 [<c010ac2a>] do_IRQ+0xea/0xf0
 [<c01092a0>] common_interrupt+0x18/0x20
 [<c011d0c4>] do_softirq+0x44/0xa0
 [<c010ac11>] do_IRQ+0xd1/0xf0
 [<c01092a0>] common_interrupt+0x18/0x20
 [<c010aff4>] setup_irq+0x64/0xb0
 [<c021a730>] ide_intr+0x0/0x130
 [<c010acaf>] request_irq+0x7f/0xc0
 [<c021bca6>] init_irq+0x156/0x400
 [<c021a730>] ide_intr+0x0/0x130
 [<c021c336>] hwif_init+0xb6/0x250
 [<c021b96c>] probe_hwif_init+0x2c/0x80
 [<c022765a>] ide_setup_pci_device+0x7a/0x80
 [<c021902d>] via_init_one+0x3d/0x50
 [<c039791d>] ide_scan_pcidev+0x5d/0x70
 [<c0397976>] ide_scan_pcibus+0x46/0xd0
 [<c0397823>] probe_for_hwifs+0x13/0x20
 [<c0397838>] ide_init_builtin_drivers+0x8/0x20
 [<c0397898>] ide_init+0x48/0x70
 [<c038674b>] do_initcalls+0x2b/0xa0
 [<c01278b2>] init_workqueues+0x12/0x60
 [<c0105097>] init+0x27/0x110
 [<c0105070>] init+0x0/0x110
 [<c01072a9>] kernel_thread_helper+0x5/0xc

handlers:
[<c021a730>] (ide_intr+0x0/0x130)
Disabling IRQ #15
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1820KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 15
BIOS EDD facility v0.10 2003-Oct-11, 2 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html


Before receiving your second message I tried booting with pci=noacpi and
it worked:

Linux version 2.6.0-test9 (md@Knoppix) (gcc version 3.3.2 20030831 (Debian prerelease)) #0 Sun Oct 19 21:15:05 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f62a0
ACPI: RSDT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7V600   0x00001000 MSFT 0x0100000b) @ 0x00000000
Building zonelist for node : 0
Kernel command line: reboot=warm root=/dev/md0 pci=noacpi init=/bin/bash
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1459.817 MHz processor.
Console: colour VGA+ 80x25
Memory: 515396k/524272k available (1818k kernel code, 8080k reserved, 753k data, 124k init, 0k highmem)
Calibrating delay loop... 2875.39 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) MP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: BIOS32 Service Directory structure at 0xc00f2000
PCI: BIOS32 Service Directory entry at 0xf1940
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................
Table [DSDT](id F004) - 363 Objects with 50 Devices 124 Methods 19 Regions
ACPI Namespace successfully loaded at root c03b30bc
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 19/19 Regions 2/2 Fields 23/23 Buffers 11/11 Packages (371 nodes)
Executing all Device _STA and_INI methods:...................................................
51 Devices found containing: 51 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address fixup for 0000:00:0f.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fa100
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa130, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
PCI: Probing PCI hardware
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f1f20
00:09 slot=00 0:03/1eb8 1:00/1eb8 2:00/1eb8 3:00/1eb8
00:0c slot=01 0:05/1eb8 1:01/1eb8 2:02/1eb8 3:03/1eb8
00:0d slot=02 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:05/1eb8
00:0e slot=03 0:02/1eb8 1:03/1eb8 2:05/1eb8 3:01/1eb8
00:13 slot=04 0:03/1eb8 1:05/1eb8 2:01/1eb8 3:02/1eb8
00:0b slot=05 0:05/1eb8 1:01/1eb8 2:02/1eb8 3:03/1eb8
00:0a slot=06 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:05/1eb8
01:00 slot=07 0:01/1eb8 1:02/1eb8 2:00/1eb8 3:00/1eb8
00:0f slot=00 0:06/1eb8 1:07/1eb8 2:00/1eb8 3:00/1eb8
00:10 slot=00 0:06/1eb8 1:07/1eb8 2:08/1eb8 3:09/1eb8
00:11 slot=00 0:00/1eb8 1:00/1eb8 2:08/1eb8 3:09/1eb8
PCI: Attempting to find IRQ router for 1106:0586
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
PCI: IRQ fixup
0000:00:09.0: ignoring bogus IRQ 255
0000:00:0a.0: ignoring bogus IRQ 255
0000:00:0f.1: ignoring bogus IRQ 255
0000:00:10.5: ignoring bogus IRQ 255
IRQ for 0000:00:09.0:0 -> PIRQ 03, mask 1eb8, excl 0000<4>PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 ... failed
IRQ for 0000:00:0a.0:0 -> PIRQ 01, mask 1eb8, excl 0000<4>PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:0a.0
PCI: Sharing IRQ 11 with 0000:01:00.0
IRQ for 0000:00:0f.1:0 -> PIRQ 06, mask 1eb8, excl 0000<4>PCI: IRQ 0 for device 0000:00:0f.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 -> got IRQ 3
PCI: Found IRQ 3 for device 0000:00:0f.1
PCI: Sharing IRQ 3 with 0000:00:0f.0
PCI: Sharing IRQ 3 with 0000:00:10.0
PCI: Sharing IRQ 3 with 0000:00:10.1
IRQ for 0000:00:10.5:3 -> PIRQ 09, mask 1eb8, excl 0000<4>PCI: IRQ 0 for device 0000:00:10.5 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 -> got IRQ 9
PCI: Found IRQ 9 for device 0000:00:10.5
PCI: Allocating resources
PCI: Resource f0000000-f7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000b400-0000b407 (f=101, d=0, p=0)
PCI: Resource 0000b000-0000b003 (f=101, d=0, p=0)
PCI: Resource 0000a800-0000a807 (f=101, d=0, p=0)
PCI: Resource 0000a400-0000a403 (f=101, d=0, p=0)
PCI: Resource 0000a000-0000a00f (f=101, d=0, p=0)
PCI: Resource 00009800-000098ff (f=101, d=0, p=0)
PCI: Resource 00009400-0000940f (f=101, d=0, p=0)
PCI: Resource 00009000-0000901f (f=101, d=0, p=0)
PCI: Resource 00008800-0000881f (f=101, d=0, p=0)
PCI: Resource 00008400-0000841f (f=101, d=0, p=0)
PCI: Resource 00008000-0000801f (f=101, d=0, p=0)
PCI: Resource d5800000-d58000ff (f=200, d=0, p=0)
PCI: Resource 0000e000-0000e0ff (f=101, d=0, p=0)
PCI: Resource e8000000-efffffff (f=1208, d=0, p=0)
PCI: Resource 0000d800-0000d8ff (f=101, d=0, p=0)
PCI: Resource d7800000-d780ffff (f=200, d=0, p=0)
PCI: Resource d6800000-d6803fff (f=200, d=1, p=1)
PCI: Resource 0000b800-0000b8ff (f=101, d=1, p=1)
PCI: Resource d6000000-d60003ff (f=200, d=1, p=1)
PCI: Resource d5000000-d50000ff (f=200, d=1, p=1)
PCI: Resource d8000000-dfffffff (f=1208, d=1, p=1)
PCI: Resource d7000000-d700ffff (f=200, d=1, p=1)
PCI: Sorting device list...
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
IRQ for 0000:00:0f.0:0 -> PIRQ 06, mask 1eb8, excl 0000 -> newirq=3 -> got IRQ 3PCI: Found IRQ 3 for device 0000:00:0f.0
PCI: Sharing IRQ 3 with 0000:00:0f.1
PCI: Sharing IRQ 3 with 0000:00:10.0
PCI: Sharing IRQ 3 with 0000:00:10.1
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 3
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
IRQ for 0000:00:0f.1:0 -> PIRQ 06, mask 1eb8, excl 0000 -> newirq=3 -> got IRQ 3PCI: Found IRQ 3 for device 0000:00:0f.1
PCI: Sharing IRQ 3 with 0000:00:0f.0
PCI: Sharing IRQ 3 with 0000:00:10.0
PCI: Sharing IRQ 3 with 0000:00:10.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: 32X10, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1820KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >

-- 
ciao, |
Marco | [3231 omfANXwAx0hcc]
