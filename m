Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267584AbUG3FGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267584AbUG3FGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUG3FGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:06:48 -0400
Received: from fmr12.intel.com ([134.134.136.15]:62905 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267597AbUG3FFx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:05:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reporting "Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please report."
Date: Fri, 30 Jul 2004 13:05:42 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F03712EAF@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reporting "Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please report."
Thread-Index: AcR17KHWt5uYXHehQTSvcyLqLvhbVQABe90w
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Neil Brown" <neilb@cse.unsw.edu.au>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jul 2004 05:05:45.0394 (UTC) FILETIME=[DED03920:01C475F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Looks like an ACPI bug. Could you please file a bug report in
bugme.osdl.org, and please attach your 'acpidmp' and 'lspci -vv' output.


Thanks,
Shaohua

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Neil Brown
>Sent: Friday, July 30, 2004 12:11 PM
>To: linux-kernel@vger.kernel.org
>Subject: Reporting "Yenta TI: socket 0000:02:03.0 no PCI interrupts.
Fish.
>Please report."
>
>
>Hi,
> I just tried upgrading my notebook (Dell Latitude D800) from
> 2.6.4-rc1-mm1 to 2.6.8-rc2-mm1.  It didn't work really well for me.
> Both the Wireless (internal Orinico pcmcia device) and the sound
> (i810) don't work.
>
> There seems to be a problem with allocating interrupts.  Interrupt
> 11, which seems to be used for just about everything, isn't being
> handled well.
>
> Below is a diff -U100 between "dmesg" for a working boot with
> 2.6.4-rc1-mm1, and "dmesg" from a boot with 2.6.8-rc2-mm1
>
> One thing that stands out is
>-Yenta: ISA IRQ mask 0x0000, PCI irq 11
>+Yenta TI: socket 0000:02:03.0, mfunc 0x01000002, devctl 0x60
>+Yenta: request_irq() in yenta_probe_cb_irq() failed!
>+Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please report.
>+Yenta: ISA IRQ mask 0x0000, PCI irq 0
>
> which asks me to report, so I am.
>
>
> After the diff is /proc/interrupts and the output of lspci when
> booted under 2.6.8-rc2-mm1.
>
>Any help would be appreciated.
>
>Thanks,
>NeilBrown
>
>
>--- dmesg.orig	2004-07-30 13:57:32.000000000 +1000
>+++ dmesg	2004-07-30 13:41:51.000000000 +1000
>@@ -1,261 +1,282 @@
>-Linux version 2.6.4-rc1-mm1 (root@notabene) (gcc version 3.3.3
20040214
>(prerelease) (Debian)) #3 Mon Mar 1 20:53:30 EST 2004
>+Linux version 2.6.8-rc2-mm1 (neilb@notabene) (gcc version 3.3.4
(Debian
>1:3.3.4-4)) #2 Thu Jul 29 23:48:46 EST 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ffae000 (usable)
>  BIOS-e820: 000000003ffae000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
>-zapping low mappings.
> On node 0 totalpages: 229376
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> Dell Latitude with broken BIOS detected. Refusing to enable the local
APIC.
> ACPI: RSDP (v000 DELL                                      ) @
0x000fdf00
> ACPI: RSDT (v001 DELL    CPi R   0x27d3091e ASL  0x00000061) @
0x3fff0000
> ACPI: FADT (v001 DELL    CPi R   0x27d3091e ASL  0x00000061) @
0x3fff0400
> ACPI: ASF! (v016 DELL    CPi R   0x27d3091e ASL  0x00000061) @
0x3fff0800
> ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @
0x00000000
> ACPI: PM-Timer IO Port: 0x808
> Built 1 zonelists
> Initializing CPU#0
>-Kernel command line: auto BOOT_IMAGE=4 ro root=301 resume=/dev/hda2
>+Kernel command line: auto BOOT_IMAGE=8 ro root=301 resume=/dev/hda2
> PID hash table entries: 4096 (order 12: 32768 bytes)
>-Detected 1598.664 MHz processor.
>+Detected 1598.665 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
>-Memory: 903188k/917504k available (1975k kernel code, 13572k reserved,
>957k data, 240k init, 0k highmem)
>-Calibrating delay loop... 3191.60 BogoMIPS
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>+Memory: 904148k/917504k available (2001k kernel code, 12612k reserved,
>993k data, 240k init, 0k highmem)
>+Checking if this processor honours the WP bit even in supervisor
mode...
>Ok.
>+Calibrating delay loop... 3191.60 BogoMIPS (lpj=15958016)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>-CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000
00000000
>-CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000
00000000
>+CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
>+CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 1024K
>-CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
>+CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
> CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
>-POSIX conformance testing by UNIFIX
> NET: Registered protocol family 16
> EISA bus registered
> PCI: PCI BIOS revision 2.10 entry at 0xfc97e, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
>-ACPI: Subsystem revision 20040220
>+ACPI: Subsystem revision 20040715
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
>acquired
> Parsing all Control
>Methods:...............................................................
....
>.......................................................................
....
>.............................
> Table [DSDT](id F004) - 422 Objects with 67 Devices 171 Methods 5
Regions
>-ACPI Namespace successfully loaded at root c053993c
>+ACPI Namespace successfully loaded at root c054905c
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
>successful
>-evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs
at
>0000000000000828 on int 9
>-Completing Region/Field/Buffer/Package
>initialization:........................................................
....
>....
>-Initialized 5/5 Regions 10/10 Fields 23/23 Buffers 26/26 Packages (430
>nodes)
>-Executing all Device _STA and_INI
>methods:...............................................................
....
>..
>-69 Devices found containing: 69 _STA, 3 _INI methods
>+evgpeblk-0980 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs
at
>0000000000000828 on int 0x9
>+evgpeblk-0989 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 2
Runtime
>GPEs in this block
>+Completing Region/Field/Buffer/Package
>initialization:.....................................................
>+Initialized 5/5 Regions 9/10 Fields 22/23 Buffers 17/26 Packages (431
>nodes)
>+Executing all Device _STA and_INI
>methods:...............................................................
....
>....
>+71 Devices found containing: 71 _STA, 3 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
>-Transparent bridge - 0000:00:1e.0
>+PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
>-ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7)
>+ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
> ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
>-ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
>+ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
>disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: the driver 'system' has been registered
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
> pnp: match found with the PnP device '00:01' and the driver 'system'
>-pnp: 00:01: ioport range 0x800-0x85f has been reserved
>+pnp: 00:01: ioport range 0x800-0x85f could not be reserved
> pnp: 00:01: ioport range 0x860-0x87f has been reserved
> pnp: 00:01: ioport range 0x880-0x8bf has been reserved
> pnp: 00:01: ioport range 0x8c0-0x8ff has been reserved
> pnp: 00:01: ioport range 0x3f0-0x3f1 has been reserved
> pnp: 00:01: ioport range 0x900-0x97f has been reserved
>-pnp: 00:01: ioport range 0xf400-0xf4fe has been reserved
>+pnp: 00:01: ioport range 0xf400-0xf4fe could not be reserved
> PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
> SCSI subsystem initialized
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
>-drivers/usb/core/usb.c: registered new driver usbfs
>-drivers/usb/core/usb.c: registered new driver hub
>+usbcore: registered new driver usbfs
>+usbcore: registered new driver hub
>+PCI: Using ACPI for IRQ routing
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
>+ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
>+ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
>+ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
>-ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
>-PCI: Using ACPI for IRQ routing
>-PCI: if you experience problems, try using option 'pci=noacpi' or even
>'acpi=off'
>-ikconfig 0.7 with /proc/config*
>+ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
>+ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
>+ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
>+ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI interrupt 0000:02:01.1[A] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI interrupt 0000:02:01.2[A] -> GSI 11 (level, low) -> IRQ 11
>+ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 7 (level, low) -> IRQ 7
>+vesafb: probe of vesafb0 failed with error -6
> Initializing Cryptographic API
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Lid Switch [LID]
> ACPI: Power Button (CM) [PBTN]
> ACPI: Sleep Button (CM) [SBTN]
> ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
>-ACPI: Thermal Zone [THM] (57 C)
>+ACPI: Thermal Zone [THM] (58 C)
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>+ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
> pnp: the driver 'serial' has been registered
> pnp: match found with the PnP device '00:0b' and the driver 'serial'
> pnp: the driver 'parport_pc' has been registered
> pnp: match found with the PnP device '00:0d' and the driver
'parport_pc'
>-parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
>-parport0: irq 7 detected
>-parport0: cpp_daisy: aa5500ff(38)
>-parport0: assign_addrs: aa5500ff(38)
>-parport0: cpp_daisy: aa5500ff(38)
>-parport0: assign_addrs: aa5500ff(38)
>+parport: PnPBIOS parport detected.
>+parport0: PC-style at 0x378 (0x778), irq 7, dma 1
>[PCSPP,TRISTATE,COMPAT,ECP,DMA]
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
> ICH4: IDE controller at PCI slot 0000:00:1f.1
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>+ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
> ICH4: chipset revision 1
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
> hda: HITACHI_DK23EA-60, ATA DISK drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: max request size: 128KiB
> hda: 117210240 sectors (60011 MB) w/2048KiB Cache, CHS=65535/16/63,
>UDMA(100)
>+hda: cache flushes supported
>  hda: hda1 hda2 hda3
> PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
>+ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
> Yenta: CardBus bridge found at 0000:02:01.0 [1028:014e]
>-Yenta: ISA IRQ mask 0x04f8, PCI irq 11
>+Yenta: ISA IRQ mask 0x0478, PCI irq 11
> Socket status: 30000006
>+ACPI: PCI interrupt 0000:02:01.1[A] -> GSI 11 (level, low) -> IRQ 11
> Yenta: CardBus bridge found at 0000:02:01.1 [1028:014e]
>-Yenta: ISA IRQ mask 0x04f8, PCI irq 11
>+Yenta: ISA IRQ mask 0x0478, PCI irq 11
> Socket status: 30000047
>+ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 7 (level, low) -> IRQ 7
> Yenta: CardBus bridge found at 0000:02:03.0 [12a3:ab01]
> Yenta: Enabling burst memory read transactions
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
>-Yenta: ISA IRQ mask 0x0000, PCI irq 11
>+Yenta TI: socket 0000:02:03.0, mfunc 0x01000002, devctl 0x60
>+Yenta: request_irq() in yenta_probe_cb_irq() failed!
>+Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please report.
>+Yenta: ISA IRQ mask 0x0000, PCI irq 0
> Socket status: 30000010
> Databook TCIC-2 PCMCIA probe: not found.
>-mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
>+mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> EISA: Probing bus 0 at eisa0
>-Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05
>15:41:49 2004 UTC).
>+Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun May 30
>10:49:40 2004 UTC).
> ALSA device list:
>   No soundcards found.
> NET: Registered protocol family 2
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
>
>=======================================================================
====
>===
>/proc/interrupts
>           CPU0
>  0:      23343          XT-PIC  timer
>  1:       1048          XT-PIC  i8042
>  2:          0          XT-PIC  cascade
>  3:        889          XT-PIC  serial
>  7:          0          XT-PIC  parport0
>  8:          4          XT-PIC  rtc
>  9:          1          XT-PIC  acpi
> 11:       3092          XT-PIC  yenta, yenta, uhci_hcd, uhci_hcd,
uhci_hcd,
>ehci_hcd, ohci1394, eth0
> 12:         46          XT-PIC  i8042
> 14:       6341          XT-PIC  ide0
>NMI:          0
>LOC:          0
>ERR:          0
>MIS:          0
>
>=======================================================================
====
>lspci
>0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
Controller
>(rev 03)
>0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
Controller
>(rev 03)
>0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-
>M) USB UHCI Controller #1 (rev 01)
>0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-
>M) USB UHCI Controller #2 (rev 01)
>0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-
>M) USB UHCI Controller #3 (rev 01)
>0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0
>EHCI Controller (rev 01)
>0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
>0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller
(rev
>01)
>0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage
>Controller (rev 01)
>0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
>(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97
>Modem Controller (rev 01)
>0000:01:00.0 VGA compatible controller: nVidia Corporation NV28
[GeForce4
>Ti 4200 Go AGP 8x] (rev a1)
>0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5705M
>Gigabit Ethernet (rev 01)
>0000:02:01.0 CardBus bridge: Texas Instruments: Unknown device ac47
(rev 01)
>0000:02:01.1 CardBus bridge: Texas Instruments: Unknown device ac4a
(rev 01)
>0000:02:01.2 FireWire (IEEE 1394): Texas Instruments: Unknown device
802b
>0000:02:01.3 System peripheral: Texas Instruments: Unknown device 8204
>0000:02:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
>Controller (rev 01)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
