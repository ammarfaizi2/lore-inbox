Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268521AbUHLL6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268521AbUHLL6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268518AbUHLL6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 07:58:23 -0400
Received: from proxy.quengel.org ([213.146.113.159]:1920 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S268521AbUHLL4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 07:56:52 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: rc4-mm1 pci-routing
References: <200408111642.59938.bjorn.helgaas@hp.com>
From: Ralf Gerbig <rge@quengel.org>
In-Reply-To: <200408111642.59938.bjorn.helgaas@hp.com> (Bjorn Helgaas's
 message of "Wed, 11 Aug 2004 16:42:59 -0600")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Date: Thu, 12 Aug 2004 13:56:49 +0200
Message-ID: <877js47eny.fsf-news@hsp-law.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* On Wed, 11 Aug 2004 16:42:59 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> said:

> Hi Ralf,
> Thanks very much for your report.  It looks like this device is the problem:

> 	0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)

> and it should get IRQ 21:

> 	ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
> 	ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21

> The driver for this should be intel8x0.o, and it looks like you are
> loading it as a module.  Could you build it in statically to the kernel
> and collect the complete dmesg from a boot with "pci=routeirq" (one
> from the boot that hangs would be nice as well, but that is a pain to
> collect unless you're using a serial console)?

> The usual problem is that a driver looks at pci_dev->irq before calling
> pci_enable_device(), but intel8x0.c seems to be doing the right thing
> in this regard.

Hi Bjorn,

[ your MTU still does not like me ;) ]

this is with intel8x0 compiled in and routeirq. The serial console
will have to wait until tomorrow, maybe tonight.

Linux version 2.6.8-rc4-mm1-dvb (rge@gerlin1) (gcc version 3.3.3 (SuSE Linux)) #2 Thu Aug 12 11:25:16 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f74e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7e00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hde2 pci=routeirq
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2091.607 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515004k/524224k available (2116k kernel code, 8708k reserved, 1170k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4145.15 BogoMIPS (lpj=2072576)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 806 Objects with 77 Devices 275 Methods 36 Regions
ACPI Namespace successfully loaded at root c048e9dc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0980 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000004020 on int 0x9
evgpeblk-0989 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 1 Runtime GPEs in this block
evgpeblk-0980 [06] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs at 00000000000044A0 on int 0x9
evgpeblk-0989 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..............................................................................................
Initialized 36/36 Regions 9/9 Fields 31/31 Buffers 18/26 Packages (815 nodes)
Executing all Device _STA and_INI methods:.................................................................................
81 Devices found containing: 81 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 23 (level, high) -> IRQ 23
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 19 (level, high) -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 17 (level, high) -> IRQ 17
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
vesafb: probe of vesafb0 failed with error -6
Machine check exception polling timer started.
cpufreq: Detected nForce2 chipset revision C1
cpufreq: FSB changing is maybe unstable and can lead to crashes and data loss.
cpufreq: FSB currently at 167 MHz, FID 12.5
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (61 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 4D040H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 2B020H1, ATA DISK drive
hdd: SAMSUNG DVD-ROM SD-616E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 0000:01:09.0
ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
PDC20268: chipset revision 2
PDC20268: 100% native mode on irq 17
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: SAMSUNG SV4002H, ATA DISK drive
ide2 at 0x8800-0x8807,0x8c02 on irq 17
Probing IDE interface ide3...
hdg: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
ide3 at 0x9000-0x9007,0x9402 on irq 17
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78156288 sectors (40016 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: max request size: 128KiB
hdc: 40020624 sectors (20490 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(100)
hdc: cache flushes not supported
 hdc: hdc1 hdc2 hdc3 hdc4
hde: max request size: 128KiB
hde: 78242976 sectors (40060 MB) w/1945KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2
libata version 1.02 loaded.
sata_sil version 0.54
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma 0xE0802000 irq 16
ata2: SATA max UDMA/100 cmd 0xE08020C0 ctl 0xE08020CA bmdma 0xE0802008 irq 16
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3e01 87:4003 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun May 30 10:49:40 2004 UTC).
ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49562 usecs
intel8x0: clocking to 47422
ALSA device list:
  #0: Brooktree Bt878 at 0xe4001000, irq 18
  #1: NVidia nForce2 at 0xe7000000, irq 21
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
subfs 0.9
Adding 307400k swap on /dev/hda6.  Priority:42 extents:1
Adding 133552k swap on /dev/hdc2.  Priority:42 extents:1
Adding 313228k swap on /dev/hde1.  Priority:42 extents:1
Generic RTC Driver v1.07
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per conntrack
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01695:1000 bound to 0000:00:04.0
eth0: no link during initialization.
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
Linux agpgart interface v0.100 (c) Dave Jones
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 22, pci mem e08e8000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 21, pci mem e08f2000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 20, pci mem e08f4000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
ieee1394: Initialized config rom entry `ip1394'
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 17 (level, high) -> IRQ 17
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[e6088000-e60887ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000461000003e56a]
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
eth1: RealTek RTL8139 at 0xe09e6000, 00:00:1c:d7:58:77, IRQ 16
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
eth2: RealTek RTL8139 at 0xe09e8000, 00:04:61:4a:11:a5, IRQ 19
eth2:  Identified 8139 chip type 'RTL-8101'
eth1: link up, 10Mbps, full-duplex, lpa 0x4061
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 24
NET: Registered protocol family 10
u32 classifier
    Perfomance counters on
    OLD policer on 
Disabled Privacy Extensions on device c03b6600(lo)
IPv6 over IPv4 tunneling driver
Ingress scheduler: Classifier actions prefered over netfilter
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
lp0: using parport0 (interrupt-driven).
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
eth0: no IPv6 routers present
eth1: no IPv6 routers present
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 4x mode
[drm] Loading R200 Microcode
DROP-NEW:IN=ppp0 OUT= MAC= SRC=65.33.178.18 DST=213.146.113.159 LEN=836 TOS=0x00 PREC=0x00 TTL=112 ID=7383 PROTO=UDP SPT=22518 DPT=1026 LEN=816 

           CPU0       
  0:    1868635          XT-PIC  timer
  1:         15    IO-APIC-edge  i8042
  7:       2089    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 12:         93    IO-APIC-edge  i8042
 14:         41    IO-APIC-edge  ide0
 15:       8437    IO-APIC-edge  ide1
 16:       6134   IO-APIC-level  libata, eth1
 17:      10787   IO-APIC-level  ide2, ide3, ohci1394
 18:          0   IO-APIC-level  Bt87x audio
 19:     123358   IO-APIC-level  radeon@PCI:2:0:0
 20:          0   IO-APIC-level  ehci_hcd
 21:          0   IO-APIC-level  NVidia nForce2, ohci_hcd
 22:     187250   IO-APIC-level  eth0, ohci_hcd
NMI:          0 
LOC:    1868588 
ERR:          0
MIS:          0

hope this helps,

Ralf

-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
