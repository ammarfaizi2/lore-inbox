Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268749AbUHLU0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268749AbUHLU0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUHLU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:26:13 -0400
Received: from proxy.quengel.org ([213.146.113.159]:4480 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S268740AbUHLUY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:24:59 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: rc4-mm1 pci-routing
References: <200408111642.59938.bjorn.helgaas@hp.com>
	<877js47eny.fsf-news@hsp-law.de>
From: Ralf Gerbig <rge@quengel.org>
Date: Thu, 12 Aug 2004 22:24:56 +0200
In-Reply-To: <877js47eny.fsf-news@hsp-law.de> (Ralf Gerbig's message of
 "Thu, 12 Aug 2004 13:56:49 +0200")
Message-ID: <87acx0je93.fsf-news@hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* On Thu, Ingrid said:

* On Wed, 11 Aug 2004 16:42:59 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> said:
>> Hi Ralf,
>> Thanks very much for your report.  It looks like this device is the problem:

>> 0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)

>> and it should get IRQ 21:

>> ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
>> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21

>> The driver for this should be intel8x0.o, and it looks like you are
>> loading it as a module.  Could you build it in statically to the kernel
>> and collect the complete dmesg from a boot with "pci=routeirq" (one
>> from the boot that hangs would be nice as well, but that is a pain to
>> collect unless you're using a serial console)?

>> The usual problem is that a driver looks at pci_dev->irq before calling
>> pci_enable_device(), but intel8x0.c seems to be doing the right thing
>> in this regard.

Hi Bjorn, all,

scratch that one, one should check the facts before posting to lkml.

On the serial I got some nice oops from wondershaper, bt878 etc. After moving the
wonder to later stages, irgrouting works. Including ALSA and DVB with
a Twinhan card.

           CPU0       
  0:    2225422          XT-PIC  timer
  1:       4147    IO-APIC-edge  i8042
  3:         29    IO-APIC-edge  serial
  7:       2868    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 12:      26161    IO-APIC-edge  i8042
 14:         42    IO-APIC-edge  ide0
 15:       5981    IO-APIC-edge  ide1
 16:       2225   IO-APIC-level  libata, eth1
 17:      13325   IO-APIC-level  ide2, ide3, ohci1394
 18:     474409   IO-APIC-level  bttv0, bt878
 19:     131535   IO-APIC-level  radeon@PCI:2:0:0
 20:          0   IO-APIC-level  ohci_hcd
 21:       1187   IO-APIC-level  ohci_hcd, NVidia nForce2
 22:     221920   IO-APIC-level  eth0, ehci_hcd
NMI:          0 
LOC:    2224326 
ERR:          0
MIS:          0

Inspecting /boot/System.map-2.6.8-rc4-mm1-dvb
Loaded 26621 symbols from /boot/System.map-2.6.8-rc4-mm1-dvb.
Symbols match kernel version 2.6.8.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.8-rc4-mm1-dvb (rge@gerlin1) (gcc version 3.3.3 (SuSE Linux)) #5 Thu Aug 12 21:15:35 CEST 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
<4> BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
<4> BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
<4> BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>511MB LOWMEM available.
<7>On node 0 totalpages: 131056
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 126960 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI 2.2 present.
<6>ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f74e0
<6>ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
<6>ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
<6>ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7e00
<6>ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
<6>ACPI: PM-Timer IO Port: 0x4008
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 6:10 APIC version 16
<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
<4>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<6>Using ACPI (MADT) for SMP configuration information
<4>Built 1 zonelists
<6>Initializing CPU#0
<4>Kernel command line: root=/dev/hde2 console=ttyS1,9600 console=tty0 3
<4>PID hash table entries: 2048 (order 11: 16384 bytes)
<4>Detected 2091.760 MHz processor.
<6>Using pmtmr for high-res timesource
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<6>Memory: 515232k/524224k available (1959k kernel code, 8480k reserved, 1103k data, 160k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
<4>Calibrating delay loop... 4145.15 BogoMIPS (lpj=2072576)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
<7>CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 512K (64 bytes/line)
<7>CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: AMD Athlon(tm) XP 2800+ stepping 00
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>ENABLING IO-APIC IRQs
<6>..TIMER: vector=0x31 pin1=2 pin2=-1
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ...  failed.
<6>...trying to set up timer as Virtual Wire IRQ... failed.
<6>...trying to set up timer as ExtINT IRQ... works.
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20040715
<4> tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
<4>Parsing all Control Methods:...................................................................................................................................................................................................................................................................................
<4>Table [DSDT](id F004) - 806 Objects with 77 Devices 275 Methods 36 Regions
<4>ACPI Namespace successfully loaded at root c04559dc
<4>evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
<4>evgpeblk-0980 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000004020 on int 0x9
<4>evgpeblk-0989 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 1 Runtime GPEs in this block
<4>evgpeblk-0980 [06] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs at 00000000000044A0 on int 0x9
<4>evgpeblk-0989 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
<4>Completing Region/Field/Buffer/Package initialization:..............................................................................................
<4>Initialized 36/36 Regions 9/9 Fields 31/31 Buffers 18/26 Packages (815 nodes)
<4>Executing all Device _STA and_INI methods:.................................................................................
<4>81 Devices found containing: 81 _STA, 2 _INI methods
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
<4>ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
<4>ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
<4>ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
<4>ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
<4>ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
<4>ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>PnPBIOS: Scanning system for PnP BIOS support...
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
<6>PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
<5>SCSI subsystem initialized
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>PCI: Using ACPI for IRQ routing
<6>** PCI interrupts are no longer routed automatically.  If this
<6>** causes a device to stop working, it is probably because the
<6>** driver failed to call pci_enable_device().  As a temporary
<6>** workaround, the "pci=routeirq" argument restores the old
<6>** behavior.  If this argument makes the device work again,
<6>** please email the output of "lspci" to bjorn.helgaas@hp.com
<6>** so I can fix the driver.
<4>vesafb: probe of vesafb0 failed with error -6
<6>Machine check exception polling timer started.
<6>cpufreq: Detected nForce2 chipset revision C1
<6>cpufreq: FSB changing is maybe unstable and can lead to crashes and data loss.
<6>cpufreq: FSB currently at 167 MHz, FID 12.5
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Fan [FAN] (on)
<6>ACPI: Processor [CPU0] (supports C1)
<6>ACPI: Thermal Zone [THRM] (61 C)
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>Using anticipatory io scheduler
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>NFORCE2: IDE controller at PCI slot 0000:00:09.0
<6>NFORCE2: chipset revision 162
<6>NFORCE2: not 100%% native mode: will probe irqs later
<4>NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
<4>NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
<6>NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
<6>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
<6>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
<6>Probing IDE interface ide0...
<4>hda: Maxtor 4D040H2, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<6>Probing IDE interface ide1...
<4>hdc: Maxtor 2B020H1, ATA DISK drive
<4>hdd: SAMSUNG DVD-ROM SD-616E, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>PDC20268: IDE controller at PCI slot 0000:01:09.0
<4>ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
<6>ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
<6>PDC20268: chipset revision 2
<6>PDC20268: 100%% native mode on irq 17
<6>    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
<6>    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
<6>Probing IDE interface ide2...
<4>hde: SAMSUNG SV4002H, ATA DISK drive
<4>ide2 at 0x8800-0x8807,0x8c02 on irq 17
<6>Probing IDE interface ide3...
<4>hdg: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
<4>ide3 at 0x9000-0x9007,0x9402 on irq 17
<6>Probing IDE interface ide4...
<4>ide4: Wait for ready failed before probe !
<6>Probing IDE interface ide5...
<4>ide5: Wait for ready failed before probe !
<4>hda: max request size: 128KiB
<6>hda: 78156288 sectors (40016 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
<4>hda: cache flushes not supported
<6> hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
<4>hdc: max request size: 128KiB
<6>hdc: 40020624 sectors (20490 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(100)
<4>hdc: cache flushes not supported
<6> hdc: hdc1 hdc2 hdc3 hdc4
<4>hde: max request size: 128KiB
<6>hde: 78242976 sectors (40060 MB) w/1945KiB Cache, CHS=65535/16/63, UDMA(100)
<4>hde: cache flushes supported
<6> hde: hde1 hde2
<7>libata version 1.02 loaded.
<7>sata_sil version 0.54
<4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
<6>ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
<6>ata1: SATA max UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma 0xE0802000 irq 16
<6>ata2: SATA max UDMA/100 cmd 0xE08020C0 ctl 0xE08020CA bmdma 0xE0802008 irq 16
<7>ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:20ff
<6>ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : sata_sil
<7>ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3e01 87:4003 88:20ff
<6>ata2: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
<6>ata2: dev 0 configured for UDMA/100
<6>scsi1 : sata_sil
<5>  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
<5>SCSI device sdb: drive cache: write back
<6> sdb: sdb1 sdb2 sdb3 sdb4
<5>Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
<6>usbcore: registered new driver usblp
<6>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>usbcore: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>mice: PS/2 mouse device common for all mice
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
<6>input: PC Speaker
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 65536)
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<6>ACPI: (supports S0 S1 S4 S5)
<4>ACPI wakeup devices: 
<4>HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>VFS: Mounted root (ext3 filesystem) readonly.
<6>Freeing unused kernel memory: 160k freed
<6>EXT3 FS on hde2, internal journal
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on hdc4, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sdb4, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>subfs 0.9
<6>Adding 307400k swap on /dev/hda6.  Priority:42 extents:1
<6>Adding 133552k swap on /dev/hdc2.  Priority:42 extents:1
<6>Adding 313228k swap on /dev/hde1.  Priority:42 extents:1
<6>Generic RTC Driver v1.07

[...]

Inspecting /boot/System.map-2.6.8-rc4-mm1-dvb
Loaded 26621 symbols from /boot/System.map-2.6.8-rc4-mm1-dvb.
Symbols match kernel version 2.6.8.
No module symbols loaded - kernel modules not enabled. 
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per conntrack
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01695:1000 bound to 0000:00:04.0
eth0: no link during initialization.
Linux agpgart interface v0.100 (c) Dave Jones
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 21 (level, high) -> IRQ 21
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 21, pci mem e08a2000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 20 (level, high) -> IRQ 20
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 20, pci mem e08ac000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 22 (level, high) -> IRQ 22
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 22, pci mem e08ae000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 17 (level, high) -> IRQ 17
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[e6088000-e60887ff]  Max Packet=[2048]
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
eth1: RealTek RTL8139 at 0xe093a000, 00:00:1c:d7:58:77, IRQ 16
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
eth2: RealTek RTL8139 at 0xe093c000, 00:04:61:4a:11:a5, IRQ 19
eth2:  Identified 8139 chip type 'RTL-8101'
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000461000003e56a]
agpgart: Detected NVIDIA nForce2 chipset
eth1: link up, 10Mbps, full-duplex, lpa 0x4061
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 24
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 50240 usecs
intel8x0: clocking to 47440
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0387600(lo)
IPv6 over IPv4 tunneling driver

[...]

Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:01:06.0, irq: 18, latency: 32, mmio: 0xe4000000
bttv0: detected: Twinhan VisionPlus DVB-T [card=113], PCI subsystem ID is 1822:0001
bttv0: using: Twinhan DST + clones [card=113,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00f935fe [init]
bttv0: using tuner=4
tuner: Ignoring new-style parameters in presence of obsolete ones
bttv0: add subdevice "dvb0"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
bt878(0): Bt878 (rev 17) at 01:06.1, irq: 18, latency: 32, memory: 0xe4001000
attach: checking "bt878 #0 [hw]"
find by pci: checking "bt878 #0 [hw]"
attach: "bt878 #0 [hw]", to card 0

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
