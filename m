Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUDPFby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDPFby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:31:54 -0400
Received: from [202.28.93.1] ([202.28.93.1]:10506 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S262415AbUDPFbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:31:32 -0400
Date: Fri, 16 Apr 2004 12:31:44 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: daniel.ritz@alcatel.ch, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] fix Acer TravelMate 360 interrupt routing
Message-Id: <20040416123144.4b70af15.kitt@gear.kku.ac.th>
In-Reply-To: <200404141547.36010.daniel.ritz@alcatel.ch>
References: <A6974D8E5F98D511BB910002A50A6647615F8369@hdsmsx403.hd.intel.com>
	<1081906004.2258.673.camel@dhcppc4>
	<200404141547.36010.daniel.ritz@alcatel.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Wednesday 14 April 2004 03:26, Len Brown wrote:
> > On Sat, 2004-04-10 at 16:24, Daniel Ritz wrote:
> > >  ... routing via ACPI fails too.
> >
> > Does everything work when booted in ACPI mode with "pci=noacpi"?
> 
> i think yes.
> 
> but let's ask the originator of the bug report. kitt you there?

Sorry for a bit late reply, it was a long holiday in Thailand and I was totally offline for few days :)

I'm not sure whether this is about ACPI or not. As far as I tried, without Daniel's patch the cardbus would not work, no matter what boot params specified (I've tried acpi=on, acpi=off, acpi=on pci=noacpi, pci=biosirq).

With the patch, it seems to work fine, at least with "acpi=on" and "acpi=on pci=noacpi". I haven't try the others. I'm now using 2.6.5-mm4 (that includes the patch), boot param is "acpi=on". It produced some warning about "pci=usepirqmask" but the cardbus controllers work.

If you want me to test anything on this, please let me know. Below is dmesg with "acpi=on".

rgds,
kitt

# dmesg
Linux version 2.6.5-mm4 (root@peorth.kitty.in.th) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 Sun Apr 11 11:46:57 ICT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7e0000 (usable)
 BIOS-e820: 000000000f7e0000 - 000000000f7e8000 (ACPI data)
 BIOS-e820: 000000000f7e8000 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 000000000f800000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63456
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59360 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Acer TravelMate 36x Laptop detected - fixing broken IRQ routing
Acer TravelMate 36x Laptop detected: force use of pci=noacpi
ACPI: RSDP (v000 Acer                                      ) @ 0x000fe030
ACPI: RSDT (v001 Acer   TM360    0x00000001 Acer 0x00000000) @ 0x0f7e0000
ACPI: FADT (v001 Acer   TM360    0x00000001 Acer 0x00000000) @ 0x0f7e0054
ACPI: BOOT (v001 Acer   TM360    0x00000001 Acer 0x00000000) @ 0x0f7e002c
ACPI: DSDT (v001   Acer   AN360  0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf108
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/hda2 acpi=on vga=791
CPU 0 irqstacks, hard=c03d1000 soft=c03d0000
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1000.200 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 248028k/253824k available (1950k kernel code, 5068k reserved, 761k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1982.46 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmaskPCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
vesafb: framebuffer at 0x98000000, mapped to 0xd000e000, size 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x6e set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THR1] (54 C)
ACPI: Thermal Zone [THR2] (48 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0x98000000
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa890-0xa897, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa898-0xa89f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4025GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000a4a0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: IRQ 10 for device 0000:00:1d.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1d.1
IRQ routing conflict for 0000:01:09.0, have irq 11, want irq 10
IRQ routing conflict for 0000:01:09.1, have irq 11, want irq 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 0000a4e0
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000a800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [A4Tech USB Optical Mouse] on usb-0000:00:1d.0-1
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49569 usecs
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:01:03.0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[80100000-801007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0120900300000000]
microcode: error! Bad data in microcode data file
microcode: Error in the microcode data
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 10 for device 0000:01:08.0
PCI: Sharing IRQ 10 with 0000:01:05.0
e100: eth0: e100_probe: addr 0x80101000, irq 10, MAC addr 00:00:E2:61:54:AE
mtrr: base(0x98000000) is not aligned on a size(0x180000) boundary
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
PCI: Found IRQ 10 for device 0000:01:05.0
PCI: Sharing IRQ 10 with 0000:01:08.0
Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:01:05.0, mfunc 0x01000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 10
Socket status: 30000011
PCI: IRQ 10 for device 0000:01:09.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:01:09.0
PCI: Sharing IRQ 10 with 0000:00:1d.1
IRQ routing conflict for 0000:01:09.1, have irq 11, want irq 10
Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000006
PCI: IRQ 10 for device 0000:01:09.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:01:09.1
PCI: Sharing IRQ 10 with 0000:00:1d.1
PCI: Sharing IRQ 10 with 0000:01:09.0
Yenta: CardBus bridge found at 0000:01:09.1 [1025:1022]
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000410
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x240-0x247 0x370-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0006:0010
eth1: Looks like a Lucent/Agere firmware version 6.16
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:46:11:44
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 10, io 0x0100-0x013f
eth1: New link status: Connected (0001)


> and a pointer to the original discussion.
> 	http://marc.theaimsgroup.com/?t=108113124000003&r=1&w=2
> i first thougt it was the cardbus bridge sending the pci interrupt thru the
> interrupt serializer, but that was not the case.
> 
> some other pointers to the problem:
> 	http://www.naos.co.nz/hardware/laptop/acer-361evi/x94.html#AEN138
> 	http://sourceforge.net/tracker/index.php?func=detail&aid=533863&group_id=2405&atid=102405
> 
> 
> >
> > If so, I wouldn't be eager to add a model-specific !ACPI mode workaround
> > -- which if it goes into the kernel will be there forever.
> >
> > Also, I'm not enthusiastic about adding the dmi entry for "pci=noacpi"
> > until we've taken a swing at finding out why Linux/ACPI doesn't work out
> > of the box on this platform and given up.  For we might find a fix for
> > this platform that helps other platforms.  Adding the platform-specific
> > automatic workaround just masks the problem for owners of that exact
> > model.
> >
> > So for the ACPI mode part, I encourage you to file a bug here
> >
> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> > Component Config-Interrupts
> > and assign it to me.  Or if a bug is open already,
> > please direct me to it.
> >
> > thanks,
> > -Len
> 
