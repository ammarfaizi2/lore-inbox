Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUD3VlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUD3VlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUD3VlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:41:12 -0400
Received: from vena.lwn.net ([206.168.112.25]:9904 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261440AbUD3Vkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:40:42 -0400
Message-ID: <20040430214040.25268.qmail@lwn.net>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 30 Apr 2004 23:00:55 +0200."
             <m3ad0t9o54.fsf@averell.firstfloor.org> 
Date: Fri, 30 Apr 2004 15:40:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My Radeon 9200SE goes nuts if I build a GART-enabled
> > kernel.  Haven't figured out why...
> 
> Define 'nuts' and supply full boot log (with GART enabled)

Oops, sorry for the technical term...:)

"Nuts" means that the X server goes into an unkillable, 100% system time
state.  It manages to scribble a mess onto the screen first.  Pointer moves
(I believe that's in hardware) but the server does not respond to anything.

Andrew asked for a profile to help track down where the kernel loop is.  I
just did one, but the results are less than illuminating:

	105219 total                                      0.0448
	 85232 __delay                                  2663.5000
	 14076 default_idle                             293.2500
	  4679 __do_softirq                              26.5852
	   474 check_poison_obj                           1.0216
	   197 handle_IRQ_event                           2.0521
	    91 kmem_cache_free                            0.1034
	    44 clear_page                                 0.7719
	    24 memset                                     0.1277
	    20 uhci_irq                                   0.0312
	    14 ide_outb                                   0.8750
	    14 do_page_fault                              0.0097
	    14 copy_user_generic_c                        0.3889
	    13 i8042_interrupt                            0.0220
	    11 zap_pte_range                              0.0176
	    11 ide_end_request                            0.0176
	    11 __d_lookup                                 0.0196
	    10 group_send_sig_info                        0.0195
	    10 copy_page                                  0.0446

Boot log follows.

Thanks,

jon

Bootdata ok (command line is ro root=/dev/hda1 2 profile=2)
Linux version 2.6.6-rc3 (corbet@bike.lwn.net) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #10 Fri Apr 30 15:19:03 MDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: have wakeup address 0x10000001000
No mptable found.
No mptable found.
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257840 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
PCI bridge 00:01 from 1106 found. Setting "noapic". Overwrite with "apic"
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000fa8b0
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000409 MSFT 0x00000097) @ 0x000000003ff30000
ACPI: FADT (v001 A M I  OEMFACP  0x02000409 MSFT 0x00000097) @ 0x000000003ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000409 MSFT 0x00000097) @ 0x000000003ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000409 MSFT 0x00000097) @ 0x000000003ff40040
ACPI: DSDT (v001  A0058 A0058001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  <6>Product ID: DELUXE       <6>APIC at: 0xFEE00000
I/O APIC #2 Version 3 at 0xFEC00000.
Processors: 1
Checking aperture...
CPU 0: aperture @ f8000000 size 64 MB
Built 1 zonelists
Kernel command line: ro root=/dev/hda1 2 profile=2 console=tty0
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2002.589 MHz processor.
Console: colour VGA+ 80x25
Memory: 1026468k/1047744k available (2299k kernel code, 20516k reserved, 1006k data, 152k init)
Calibrating delay loop... 3932.16 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xf8000000
PCI-DMA: Disabling IOMMU.
vga16fb: initializing
vga16fb: mapped to 0xffffff000002f000
fb0: VGA16 VGA frame buffer device
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 10
    ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio
hde: ST3160023AS, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0xe400-0xe407,0xe002 on irq 10
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6E040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DW-U18A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 1024KiB
hde: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
 hde: hde1 hde2 hde3
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 hda: hda1 hda2 hda3
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
sata_promise version 0.92
ata1: SATA max UDMA/133 cmd 0xFFFFFF000004D200 ctl 0xFFFFFF000004D238 bmdma 0x0 irq 5
ata2: SATA max UDMA/133 cmd 0xFFFFFF000004D280 ctl 0xFFFFFF000004D2B8 bmdma 0x0 irq 5
ata1: no device found (phy stat 00000000)
ata1: thread exiting
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_promise
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 5, pci mem ffffff000004f000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. USB
uhci_hcd 0000:00:10.0: irq 11, io base 000000000000b400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:10.1: irq 11, io base 000000000000b800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. USB (#3)
uhci_hcd 0000:00:10.2: irq 10, io base 000000000000c000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. USB (#4)
uhci_hcd 0000:00:10.3: irq 10, io base 000000000000c400
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 56Kbytes
TCP: Hash tables configured (established 262144 bind 37449)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
usb 2-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.0-1
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
EXT3 FS on hda1, internal journal
Adding 1024120k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
eth0: 
      PrefPort:A  RlmtMode:Check Link State
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
