Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWACKE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWACKE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 05:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWACKE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 05:04:59 -0500
Received: from vvv.conterra.de ([212.124.44.162]:45992 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1750958AbWACKE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 05:04:58 -0500
Message-ID: <43BA4C3D.4060206@conterra.de>
Date: Tue, 03 Jan 2006 11:04:45 +0100
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>
In-Reply-To: <p73k6difvm3.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Can you please post the full boot log? 
> ...
> When you not compile in the SKGE network driver does everything else work?
> skge supports 64bit DMA, so it shouldn't use any IOMMU.  But I'm somewhat
> suspicious of the >4GB support in the VIA chipset. We had problems with
> that before. It's possible that it's just not supported in the hardware
> or that the BIOS sets up the MTRRs wrong.

sorry for the delay, we are a few hors off here...

here comes a more complete dmsg. Its a bit long, as its a large LVM system
with 7 SATA disks attached. There are lots of messages about USB stuff,
but I actually don't use any USB. But indeed I dicovered some mtrr message
missed in the snipplet before.

Unfortunately this is a production server, so I can't reboot and play with
any time. But may be this night, in about 12h, I can perform further tests.

Let me know, what kind of tests I may perform with all the SATA devices.
I have a PDC-20378 and a VIA-VT6420 on board and a PDC-20318 on a PCI slot.
Do those have any problems with 64-bit? For testing I would prefer to use
them R/only. Would a parallel dummy tar to /dev/zero be meaningful?.

Dieter.
-----------
Bootdata ok (command line is root=/dev/sda1 log_buf_len=32k video=matroxfb:vesa:0x1B8 s)
Linux version 2.6.15-rc7 (root@Rescue) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #9 Sun Jan 1 19:54:26 CET 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bff30000 (usable)
  BIOS-e820: 00000000bff30000 - 00000000bff40000 (ACPI data)
  BIOS-e820: 00000000bff40000 - 00000000bfff0000 (ACPI NVS)
  BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa850
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000517 MSFT 0x00000097) @ 0x00000000bff30100
ACPI: FADT (v003 A M I  OEMFACP  0x06000517 MSFT 0x00000097) @ 0x00000000bff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000517 MSFT 0x00000097) @ 0x00000000bff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000517 MSFT 0x00000097) @ 0x00000000bff40040
ACPI: DSDT (v001  SK8V_ SK8V_033 0x00000033 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 1029568
   DMA zone: 3160 pages, LIFO batch:0
   DMA32 zone: 767848 pages, LIFO batch:31
   Normal zone: 258560 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
Looks like a VIA chipset. Disabling IOMMU. Overwrite with "iommu=allowed"
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3ff80000)
Built 1 zonelists
Kernel command line: root=/dev/sda1 log_buf_len=32k video=matroxfb:vesa:0x1B8 s
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2002.656 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x5c39000 - 0x9c39000
Memory: 4043548k/5242880k available (1809k kernel code, 148908k reserved, 770k data, 160k init)
Calibrating delay using timer specific routine.. 4014.56 BogoMIPS (lpj=8029129)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Opteron(tm) Processor 146 stepping 0a
  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control 
Methods:...................................................................................................................................................
Table [DSDT](id 0005) - 538 Objects with 45 Devices 147 Methods 25 Regions
ACPI Namespace successfully loaded at root ffffffff803b8dc0
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package 
initialization:..................................................................................................................................
Initialized 24/25 Regions 44/44 Fields 47/47 Buffers 15/16 Packages (547 nodes)
Executing all Device _STA and_INI methods:.................................................
49 Devices found containing: 49 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xf4000000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: fbb00000-fcefffff
   PREFETCH window: efa00000-f39fffff
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:00:01.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1136141830.556:1): initialized
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
  0000:00:10.0: uhci_check_and_reset_hc: legsup = 0x8030
  0000:00:10.0: Performing full reset
  0000:00:10.1: uhci_check_and_reset_hc: legsup = 0x8030
  0000:00:10.1: Performing full reset
  0000:00:10.2: uhci_check_and_reset_hc: legsup = 0x8030
  0000:00:10.2: Performing full reset
  0000:00:10.3: uhci_check_and_reset_hc: legsup = 0x8030
  0000:00:10.3: Performing full reset
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
matroxfb: Matrox G400 (AGP) detected
PInS memtype = 0
mtrr: type mismatch for f0000000,1000000 old: write-back new: write-combining
matroxfb: MTRR's turned on
matroxfb: 1024x768x24bpp (virtual: 1024x5461)
matroxfb: framebuffer at 0xF0000000, mapped to 0xffffc20000080000, size 16777216
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdd: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI wakeup devices:
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 160k freed
SCSI subsystem initialized
libata version 1.20 loaded.
sata_promise 0000:00:08.0: version 1.03
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004200 ctl 0xFFFFC20000004238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004280 ctl 0xFFFFC200000042B8 bmdma 0x0 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
isa bounce pool size: 16 pages
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
   Vendor: ATA       Model: HDS725050KLA360   Rev: K2AO
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
ata3: SATA max UDMA/133 cmd 0xFFFFC20000006200 ctl 0xFFFFC20000006238 bmdma 0x0 irq 16
ata4: SATA max UDMA/133 cmd 0xFFFFC20000006280 ctl 0xFFFFC200000062B8 bmdma 0x0 irq 16
ata5: SATA max UDMA/133 cmd 0xFFFFC20000006300 ctl 0xFFFFC20000006338 bmdma 0x0 irq 16
ata6: SATA max UDMA/133 cmd 0xFFFFC20000006380 ctl 0xFFFFC200000063B8 bmdma 0x0 irq 16
ata3: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:203f
ata3: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_promise
ata4: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:203f
ata4: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_promise
ata5: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3e02 87:4023 88:203f
ata5: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata5: dev 0 configured for UDMA/100
scsi4 : sata_promise
ata6: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3e02 87:4023 88:203f
ata6: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata6: dev 0 configured for UDMA/100
scsi5 : sata_promise
   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
  sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sde: drive cache: write back
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sde: drive cache: write back
  sde: sde1
sd 4:0:0:0: Attached scsi disk sde
   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdf: drive cache: write back
  sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ata7: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 17
ata8: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 17
ata7: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123 88:407f
ata7: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata7: dev 0 configured for UDMA/133
scsi6 : sata_via
ata8: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123 88:407f
ata8: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata8: dev 0 configured for UDMA/133
scsi7 : sata_via
   Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdg: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdg: drive cache: write back
SCSI device sdg: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdg: drive cache: write back
  sdg: sdg1
sd 6:0:0:0: Attached scsi disk sdg
   Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdh: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdh: drive cache: write back
SCSI device sdh: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdh: drive cache: write back
  sdh: sdh1
sd 7:0:0:0: Attached scsi disk sdh
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
eth0: 3Com Gigabit LOM (3C940)
       PrefPort:A  RlmtMode:Check Link State
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 4
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh 7 uframes 256/512/1024
ehci_hcd 0000:00:10.4: capability 0001 at 68
ehci_hcd 0000:00:10.4: MWI active
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 20, io mem 0xfdf00000
ehci_hcd 0000:00:10.4: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:10.4: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.15-rc7 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.4
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
USB Universal Host Controller Interface driver v2.3
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 4
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: detected 2 ports
uhci_hcd 0000:00:10.0: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.0: Performing full reset
drivers/usb/core/inode.c: creating file '002'
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 20, io base 0x0000b400
uhci_hcd 0000:00:10.0: supports USB remote wakeup
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.15-rc7 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
uhci_hcd 0000:00:10.0: port 1 portsc 018a,00
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 4
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: detected 2 ports
uhci_hcd 0000:00:10.1: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.1: Performing full reset
drivers/usb/core/inode.c: creating file '003'
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 20, io base 0x0000b800
uhci_hcd 0000:00:10.1: supports USB remote wakeup
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.15-rc7 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.0: port 2 portsc 008a,00
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
drivers/usb/core/inode.c: creating file '001'
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 4
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: detected 2 ports
uhci_hcd 0000:00:10.2: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.2: Performing full reset
drivers/usb/core/inode.c: creating file '004'
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 20, io base 0x0000c000
uhci_hcd 0000:00:10.2: supports USB remote wakeup
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.15-rc7 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.1: port 1 portsc 018a,00
hub 3-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
drivers/usb/core/inode.c: creating file '001'
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 4
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: detected 2 ports
uhci_hcd 0000:00:10.3: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.3: Performing full reset
drivers/usb/core/inode.c: creating file '005'
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 20, io base 0x0000c400
uhci_hcd 0000:00:10.3: supports USB remote wakeup
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.15-rc7 uhci_hcd
usb usb5: SerialNumber: 0000:00:10.3
usb usb5: hotplug
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
drivers/usb/core/inode.c: creating file '001'
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.1: port 2 portsc 018a,00
hub 3-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.2: port 1 portsc 008a,00
hub 4-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:10.2: port 2 portsc 018a,00
hub 4-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.3: port 1 portsc 008a,00
hub 5-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:10.3: port 2 portsc 018a,00
hub 5-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:10.0: suspend_rh (auto-stop)
uhci_hcd 0000:00:10.1: suspend_rh (auto-stop)
uhci_hcd 0000:00:10.2: suspend_rh (auto-stop)
uhci_hcd 0000:00:10.3: suspend_rh (auto-stop)
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
NET: Registered protocol family 1
EXT3 FS on sda1, internal journal

