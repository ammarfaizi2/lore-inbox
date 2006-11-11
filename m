Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947166AbWKKJ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947166AbWKKJ3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 04:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947172AbWKKJ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 04:29:13 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:30085 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1947166AbWKKJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 04:29:10 -0500
Date: Sat, 11 Nov 2006 10:25:06 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] 2.6.19-rc5: known regressions (v2)
Message-ID: <20061111102506.5f98688c@localhost>
In-Reply-To: <200611111008.37986.rjw@sisk.pl>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061111015035.GU4729@stusta.de>
	<200611111008.37986.rjw@sisk.pl>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 10:08:37 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > Subject    : BUG: scheduling while atomic: events/0/0x00000001/4
> >              after resume
> > References : http://lkml.org/lkml/2006/11/2/209
> > Submitter  : Paolo Ornati <ornati@fastwebnet.it>
> > Status     : unknown
> 
> I couldn't find anything in the report that would indicate the problem occured
> after a resume.  Was it really the case?

Ahh, I've written that in another email but I trimmed LKML from CC by
mistake ;)


Relevant portion of that mail follows... anyway it seems that "-rc5" is
_OK_ since I'm running it by 2 days and it survived 9 suspend/resume
cycles.

------------------------------------------------------------------

I've reproduced it (with rc4-g4b1c46a3), and I think it is
suspend/resume related sice the messages start flooding dmesg just
after a resume...

I'll see if it is reproducible just doing suspend/resume a couple of
times... and if so I'll try with -rc5.


dmesg (stripped at the end):

[    0.000000] Linux version 2.6.19-rc4-g4b1c46a3 (paolo@tux) (gcc version 4.1.1 (Gentoo 4.1.1)) #17 PREEMPT Wed Nov 1 18:36:28 CET 2006
[    0.000000] Command line: root=/dev/sda6 elevator=cfq video=radeonfb:1024x768@60
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
[    0.000000]  BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 130864) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000fa850
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x06000517 MSFT 0x00000097) @ 0x000000001ff30000
[    0.000000] ACPI: FADT (v001 A M I  OEMFACP  0x06000517 MSFT 0x00000097) @ 0x000000001ff30200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x06000517 MSFT 0x00000097) @ 0x000000001ff30390
[    0.000000] ACPI: OEMB (v001 A M I  OEMBIOS  0x06000517 MSFT 0x00000097) @ 0x000000001ff40040
[    0.000000] ACPI: DSDT (v001  A0058 A0058002 0x00000002 MSFT 0x0100000d) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 130864) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   130864
[    0.000000] On node 0 totalpages: 130767
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1183 pages reserved
[    0.000000]   DMA zone: 2760 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 1733 pages used for memmap
[    0.000000]   DMA32 zone: 125035 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
[    0.000000] Built 1 zonelists.  Total pages: 127795
[    0.000000] Kernel command line: root=/dev/sda6 elevator=cfq video=radeonfb:1024x768@60
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 16384 bytes)
[   32.727602] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   32.727605] time.c: Detected 2202.943 MHz processor.
[   32.730265] Console: colour VGA+ 80x25
[   32.733073] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[   32.733509] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[   32.733646] Checking aperture...
[   32.733705] CPU 0: aperture @ f8000000 size 64 MB
[   32.740581] Memory: 507900k/523456k available (2708k kernel code, 14716k reserved, 1343k data, 200k init)
[   32.800438] Calibrating delay using timer specific routine.. 4409.08 BogoMIPS (lpj=2204542)
[   32.800591] Mount-cache hash table entries: 256
[   32.800771] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   32.800833] CPU: L2 Cache: 512K (64 bytes/line)
[   32.800913] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 00
[   32.801063] ACPI: Core revision 20060707
[   32.814145] Using local APIC timer interrupts.
[   32.859518] result 12516743
[   32.859573] Detected 12.516 MHz APIC timer.
[   32.860328] testing NMI watchdog ... OK.
[   32.870515] checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
[   32.873517] Freeing initrd memory: 2000k freed
[   32.875609] NET: Registered protocol family 16
[   32.875754] ACPI: bus type pci registered
[   32.875818] PCI: Using configuration type 1
[   32.881215] ACPI: Interpreter enabled
[   32.881276] ACPI: Using IOAPIC for interrupt routing
[   32.882250] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   32.882315] PCI: Probing PCI hardware (bus 00)
[   32.884489] PCI: enabled onboard AC97/MC97 devices
[   32.884765] Boot video device is 0000:01:00.0
[   32.884843] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   32.896169] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
[   32.896831] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
[   32.897488] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *7 10 11 14 15)
[   32.898143] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
[   32.898809] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   32.899560] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   32.900312] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   32.901052] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   32.901700] Linux Plug and Play Support v0.97 (c) Adam Belay
[   32.901768] pnp: PnP ACPI init
[   32.904855] pnp: PnP ACPI: found 13 devices
[   32.905045] SCSI subsystem initialized
[   32.905158] usbcore: registered new interface driver usbfs
[   32.905247] usbcore: registered new interface driver hub
[   32.905335] usbcore: registered new device driver usb
[   32.905452] PCI: Using ACPI for IRQ routing
[   32.905511] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   32.905592] PCI: Cannot allocate resource region 0 of device 0000:00:00.0
[   32.905754] agpgart: Detected AGP bridge 0
[   32.908913] agpgart: AGP aperture is 64M @ 0xf8000000
[   32.908997] PCI-DMA: Disabling IOMMU.
[   32.909754] PCI: Bridge: 0000:00:01.0
[   32.909812]   IO window: a000-afff
[   32.909871]   MEM window: fd100000-fd6fffff
[   32.909931]   PREFETCH window: d5000000-f4ffffff
[   32.910006] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   32.910026] NET: Registered protocol family 2
[   32.918232] IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
[   32.918368] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   32.918516] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[   32.918624] TCP: Hash tables configured (established 16384 bind 8192)
[   32.918684] TCP reno registered
[   32.919334] io scheduler noop registered
[   32.919440] io scheduler cfq registered (default)
[   32.920310] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   32.920477] radeonfb: Found Intel x86 BIOS ROM Image
[   32.920539] radeonfb: Retrieved PLL infos from BIOS
[   32.920598] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
[   32.920671] radeonfb: PLL min 20000 max 40000
[   32.921735] radeonfb: Monitor 1 type CRT found
[   32.921793] radeonfb: Monitor 2 type no found
[   32.955438] Console: switching to colour frame buffer device 128x48
[   32.975175] radeonfb (0000:01:00.0): ATI Radeon Yd 
[   32.975352] ACPI: Power Button (FF) [PWRF]
[   32.975477] ACPI: Power Button (CM) [PWRB]
[   32.975586] ACPI: Sleep Button (CM) [SLPB]
[   32.977202] Real Time Clock Driver v1.12ac
[   32.977313] Linux agpgart interface v0.101 (c) Dave Jones
[   32.977457] [drm] Initialized drm 1.0.1 20051102
[   32.978126] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[   32.978294] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   32.978587] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   32.978834] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   32.979259] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   32.979511] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   32.979773] Floppy drive(s): fd0 is 1.44M
[   32.994906] FDC 0 is a post-1991 82077
[   32.996382] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   32.996766] loop: loaded (max 8 devices)
[   32.996906] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
[   32.999471] skge 1.9 addr 0xfdc00000 irq 17 chip Yukon-Lite rev 9
[   33.001981] skge eth0: addr 00:11:d8:1c:a0:7a
[   33.004520] 8139too Fast Ethernet driver 0.9.28
[   33.007047] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   33.010258] eth1: RealTek RTL8139 at 0xffffc20000004000, 00:e0:4c:f0:ab:b8, IRQ 19
[   33.013135] eth1:  Identified 8139 chip type 'RTL-8139C'
[   33.013151] Linux video capture interface: v2.00
[   33.016118] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   33.019236] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   33.022583] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[   33.026030] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
[   33.029676] VP_IDE: chipset revision 6
[   33.033379] VP_IDE: not 100% native mode: will probe irqs later
[   33.037248] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[   33.041286]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[   33.045502]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
[   33.049751] Probing IDE interface ide0...
[   33.841448] hda: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
[   34.152000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   34.156490] Probing IDE interface ide1...
[   34.948226] hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
[   35.257686] ide1 at 0x170-0x177,0x376 on irq 15
[   35.264947] hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   35.269964] Uniform CD-ROM driver Revision: 3.20
[   35.283252] hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
[   35.289395] libata version 2.00 loaded.
[   35.289419] sata_via 0000:00:0f.0: version 2.0
[   35.289430] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
[   35.294798] sata_via 0000:00:0f.0: routed to hard irq line 10
[   35.300148] ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 20
[   35.305530] ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 20
[   35.310844] scsi0 : sata_via
[   35.515983] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.673125] ata1.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 0/32)
[   35.678757] ata1.00: ata1: dev 0 multi count 16
[   35.686006] ata1.00: configured for UDMA/133
[   35.691568] scsi1 : sata_via
[   35.897218] ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
[   35.913718] ATA: abnormal status 0x7F on port 0xE007
[   35.919332] scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 ANSI: 5
[   35.925134] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[   35.930882] sda: Write Protect is off
[   35.936662] sda: Mode Sense: 00 3a 00 00
[   35.936675] SCSI device sda: drive cache: write back
[   35.942505] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[   35.948370] sda: Write Protect is off
[   35.954136] sda: Mode Sense: 00 3a 00 00
[   35.954148] SCSI device sda: drive cache: write back
[   35.959889]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
[   36.027032] sd 0:0:0:0: Attached scsi disk sda
[   36.032710] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   36.038359] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   36.044338] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   36.050131] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
[   36.055834] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfd900000
[   36.061409] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   36.067109] usb usb1: configuration #1 chosen from 1 choice
[   36.072686] hub 1-0:1.0: USB hub found
[   36.078141] hub 1-0:1.0: 8 ports detected
[   36.183732] USB Universal Host Controller Interface driver v3.0
[   36.189136] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   36.194595] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   36.200026] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[   36.205457] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b000
[   36.211000] usb usb2: configuration #1 chosen from 1 choice
[   36.216430] hub 2-0:1.0: USB hub found
[   36.221776] hub 2-0:1.0: 2 ports detected
[   36.327443] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   36.332864] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   36.338237] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   36.343600] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000b400
[   36.348985] usb usb3: configuration #1 chosen from 1 choice
[   36.354262] hub 3-0:1.0: USB hub found
[   36.359430] hub 3-0:1.0: 2 ports detected
[   36.465147] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   36.470440] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   36.475698] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   36.480965] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000b800
[   36.486227] usb usb4: configuration #1 chosen from 1 choice
[   36.491386] hub 4-0:1.0: USB hub found
[   36.496528] hub 4-0:1.0: 2 ports detected
[   36.601875] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   36.607110] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   36.612333] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   36.617549] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c000
[   36.622729] usb usb5: configuration #1 chosen from 1 choice
[   36.627812] hub 5-0:1.0: USB hub found
[   36.632845] hub 5-0:1.0: 2 ports detected
[   37.161683] usbcore: registered new interface driver cdc_acm
[   37.166690] drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
[   37.171947] usbcore: registered new interface driver usblp
[   37.177212] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   37.182561] Initializing USB Mass Storage driver...
[   37.187966] usbcore: registered new interface driver usb-storage
[   37.193343] USB Mass Storage support registered.
[   37.198710] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   37.204404] serio: i8042 KBD port at 0x60,0x64 irq 1
[   37.209839] serio: i8042 AUX port at 0x60,0x64 irq 12
[   37.215222] mice: PS/2 mouse device common for all mice
[   37.220524] i2c /dev entries driver
[   37.226206] Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
[   37.231946] ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
[   37.239539] PCI: Setting latency timer of device 0000:00:11.5 to 64
[   37.251526] input: AT Translated Set 2 keyboard as /class/input/input0
[   37.751566] codec_read: codec 0 is not valid [0xfe0000]
[   37.764869] codec_read: codec 0 is not valid [0xfe0000]
[   37.778121] codec_read: codec 0 is not valid [0xfe0000]
[   37.791242] codec_read: codec 0 is not valid [0xfe0000]
[   37.808500] ALSA device list:
[   37.813631]   #0: VIA 8237 with AD1980 at 0xec00, irq 22
[   37.818899] oprofile: using NMI interrupt.
[   37.824105] TCP cubic registered
[   37.829169] NET: Registered protocol family 1
[   37.834229] NET: Registered protocol family 17
[   37.839196] NET: Registered protocol family 15
[   37.844134] ACPI: (supports S0 S1 S3 S4 S5)
[   37.961630] input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
[   38.050012] RAMDISK: ext2 filesystem found at block 0
[   38.054928] RAMDISK: Loading 2000KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done.
[   38.066647] VFS: Mounted root (ext2 filesystem).
[   38.129633] kjournald starting.  Commit interval 5 seconds
[   38.134550] EXT3-fs: mounted filesystem with ordered data mode.
[   38.139493] VFS: Mounted root (ext3 filesystem) readonly.
[   38.144469] Trying to move old root to /initrd ... /initrd does not exist. Ignored.
[   38.149670] Unmounting old root
[   38.154701] Trying to free ramdisk memory ... okay
[   38.159878] Freeing unused kernel memory: 200k freed
[   38.164962] Write protecting the kernel read-only data: 560k
[   40.454619] warning: process `touch' used the removed sysctl system call
[   40.890041] warning: process `sleep' used the removed sysctl system call
[   40.999232] warning: process `sleep' used the removed sysctl system call
[   41.104730] warning: process `sleep' used the removed sysctl system call
[   41.873966] warning: process `sleep' used the removed sysctl system call
[   43.453372] EXT3 FS on sda6, internal journal
[   43.999154] kjournald starting.  Commit interval 5 seconds
[   43.999164] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[   43.999323] EXT3 FS on sda8, internal journal
[   43.999328] EXT3-fs: mounted filesystem with ordered data mode.
[   44.117933] Adding 1004016k swap on /dev/sda7.  Priority:-1 extents:1 across:1004016k
[   50.175883] skge eth0: enabling interface
[   62.993341] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
[   62.993361] agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
[   62.993436] agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[   63.288516] [drm] Setting GART location based on new memory map
[   63.288604] [drm] Loading R200 Microcode
[   63.288694] [drm] writeback test succeeded in 1 usecs
[   79.495845] eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
[   81.127324] ip_tables: (C) 2000-2006 Netfilter Core Team
[   81.170715] ip_conntrack version 2.4 (2044 buckets, 16352 max) - 248 bytes per conntrack
[  180.334016] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  306.826671] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
[  306.826693] agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
[  306.826768] agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[  306.826780] [drm] Loading R200 Microcode
[  340.827814] Stopping tasks: ==========================================================================================================================================|
[  340.828658] Shrinking memory...  -\|/-done (51711 pages freed)
[  340.925349] Suspending console(s)
[  341.809883] pnp: Device 00:0b disabled.
[  341.810124] pnp: Device 00:0a disabled.
[  341.810148] radeonfb (0000:01:00.0): suspending for event: 1...
[  341.887207] skge eth0: disabling interface
[  341.899219] pci_set_power_state(): 0000:00:00.0: state=3, current state=5
[  341.912910] swsusp: Need to copy 63368 pages
[   26.062737] APIC error on CPU0: 00(00)
[   26.062827] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   26.146592] PM: Writing back config space on device 0000:00:0a.0 at offset f (was 1f170100, writing 1f17010a)
[   26.146599] PM: Writing back config space on device 0000:00:0a.0 at offset c (was 0, writing fdb00000)
[   26.146609] PM: Writing back config space on device 0000:00:0a.0 at offset 5 (was 1, writing c801)
[   26.146614] PM: Writing back config space on device 0000:00:0a.0 at offset 4 (was 0, writing fdc00000)
[   26.146619] PM: Writing back config space on device 0000:00:0a.0 at offset 3 (was 0, writing 4010)
[   26.146626] PM: Writing back config space on device 0000:00:0a.0 at offset 1 (was 2b00000, writing 2b00117)
[   26.146658] skge eth0: enabling interface
[   26.160202] eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
[   26.171176] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   26.171218] usb usb2: root hub lost power or was reset
[   26.182150] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   26.182188] usb usb3: root hub lost power or was reset
[   26.193128] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   26.193165] usb usb4: root hub lost power or was reset
[   26.204106] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   26.204143] usb usb5: root hub lost power or was reset
[   26.215084] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   26.215109] usb usb1: root hub lost power or was reset
[   26.215127] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   26.226082] ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
[   26.226088] PCI: Setting latency timer of device 0000:00:11.5 to 64
[   26.229463] radeonfb (0000:01:00.0): resuming from state: 1...
[   26.247263] pnp: Failed to activate device 00:03.
[   26.247391] pnp: Failed to activate device 00:04.
[   26.248318] pnp: Device 00:0a activated.
[   26.249004] pnp: Device 00:0b activated.
[   27.134110] Restarting tasks... done
[   27.565554] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
[   27.565593] agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
[   27.565670] agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[   27.565682] [drm] Loading R200 Microcode
[   28.443446] ip_conntrack version 2.4 (2044 buckets, 16352 max) - 248 bytes per conntrack
[  752.692523] Stopping tasks: ======================================================================================================================================|
[  752.693363] Shrinking memory...  -\|/-\done (58183 pages freed)
[  756.669812] Suspending console(s)
[  757.578446] pnp: Device 00:0b disabled.
[  757.578702] pnp: Device 00:0a disabled.
[  757.578727] radeonfb (0000:01:00.0): suspending for event: 1...
[  757.655322] skge eth0: disabling interface
[  757.695225] swsusp: Need to copy 58533 pages
[   25.139916] APIC error on CPU0: 00(00)
[   25.293551] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   25.377319] PM: Writing back config space on device 0000:00:0a.0 at offset f (was 1f170100, writing 1f17010a)
[   25.377326] PM: Writing back config space on device 0000:00:0a.0 at offset c (was 0, writing fdb00000)
[   25.377338] PM: Writing back config space on device 0000:00:0a.0 at offset 5 (was 1, writing c801)
[   25.377343] PM: Writing back config space on device 0000:00:0a.0 at offset 4 (was 0, writing fdc00000)
[   25.377348] PM: Writing back config space on device 0000:00:0a.0 at offset 3 (was 0, writing 4010)
[   25.377353] PM: Writing back config space on device 0000:00:0a.0 at offset 1 (was 2b00000, writing 2b00117)
[   25.377384] skge eth0: enabling interface
[   25.382084] BUG: scheduling while atomic: events/0/0x00000001/4
[   25.382086] 
[   25.382087] Call Trace:
[   25.382097]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   25.382102]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   25.382107]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   25.382110]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   25.382115]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   25.382119]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   25.382124]  [<ffffffff80239269>] kthread+0xce/0x101
[   25.382128]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   25.382132]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   25.382137]  [<ffffffff8023919b>] kthread+0x0/0x101
[   25.382140]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   25.382141] 
[   25.387073] BUG: scheduling while atomic: events/0/0x00000001/4
[   25.387074] 
[   25.387075] Call Trace:
[   25.387078]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   25.387081]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   25.387085]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   25.387088]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   25.387092]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   25.387096]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   25.387099]  [<ffffffff80239269>] kthread+0xce/0x101
[   25.387103]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   25.387106]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   25.387111]  [<ffffffff8023919b>] kthread+0x0/0x101
[   25.387114]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   25.387115] 
[   25.391072] eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
[   25.392063] BUG: scheduling while atomic: events/0/0x00000001/4
[   25.392065] 
[   25.392065] Call Trace:
[   25.392068]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   25.392072]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   25.392075]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   25.392079]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   25.392082]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   25.392086]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   25.392090]  [<ffffffff80239269>] kthread+0xce/0x101
[   25.392093]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   25.392097]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   25.392101]  [<ffffffff8023919b>] kthread+0x0/0x101
[   25.392104]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   25.392106] 
[   25.402046] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   25.402095] usb usb2: root hub lost power or was reset
[   25.413022] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   25.413067] usb usb3: root hub lost power or was reset
[   25.423998] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   25.424043] usb usb4: root hub lost power or was reset
[   25.434977] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   25.435020] usb usb5: root hub lost power or was reset
[   25.445955] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   25.445987] usb usb1: root hub lost power or was reset
[   25.446006] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   25.456957] ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
[   25.456963] PCI: Setting latency timer of device 0000:00:11.5 to 64
[   25.460339] radeonfb (0000:01:00.0): resuming from state: 1...
[   25.478130] pnp: Failed to activate device 00:03.
[   25.478258] pnp: Failed to activate device 00:04.
[   25.479252] pnp: Device 00:0a activated.
[   25.479961] pnp: Device 00:0b activated.
[   26.365424] Restarting tasks... done
[   26.441032] BUG: sleeping function called from invalid context at include/asm/semaphore.h:105
[   26.441035] in_atomic():1, irqs_disabled():0
[   26.441037] 
[   26.441038] Call Trace:
[   26.441046]  [<ffffffff8049ff6c>] thread_return+0x0/0xf9
[   26.441054]  [<ffffffff802226ae>] __might_sleep+0xb2/0xb4
[   26.441058]  [<ffffffff8022749a>] acquire_console_sem+0x66/0x90
[   26.441064]  [<ffffffff80358086>] console_callback+0xe/0xde
[   26.441068]  [<ffffffff80235fce>] run_workqueue+0xb6/0x126
[   26.441072]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   26.441075]  [<ffffffff802365ff>] worker_thread+0xe6/0x11b
[   26.441079]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   26.441083]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   26.441088]  [<ffffffff80239269>] kthread+0xce/0x101
[   26.441112]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   26.441117]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   26.441121]  [<ffffffff8023919b>] kthread+0x0/0x101
[   26.441125]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   26.441126] 
[   26.441160] BUG: scheduling while atomic: events/0/0x00000001/4
[   26.441162] 
[   26.441162] Call Trace:
[   26.441166]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   26.441171]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   26.441174]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   26.441178]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   26.441181]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   26.441185]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   26.441189]  [<ffffffff80239269>] kthread+0xce/0x101
[   26.441193]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   26.441196]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   26.441201]  [<ffffffff8023919b>] kthread+0x0/0x101
[   26.441204]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   26.441206] 
[   27.289287] BUG: scheduling while atomic: events/0/0x00000001/4
[   27.289292] 
[   27.289293] Call Trace:
[   27.289305]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   27.289310]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   27.289315]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   27.289319]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   27.289324]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   27.289328]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   27.289333]  [<ffffffff80239269>] kthread+0xce/0x101
[   27.289337]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   27.289342]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   27.289346]  [<ffffffff8023919b>] kthread+0x0/0x101
[   27.289349]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   27.289351] 
[   27.427130] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
[   27.427152] agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
[   27.427228] agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[   27.427240] [drm] Loading R200 Microcode
[   29.285334] BUG: scheduling while atomic: events/0/0x00000001/4
[   29.285339] 
[   29.285340] Call Trace:
[   29.285352]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   29.285358]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   29.285363]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   29.285366]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   29.285372]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   29.285376]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   29.285380]  [<ffffffff80239269>] kthread+0xce/0x101
[   29.285384]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   29.285389]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   29.285394]  [<ffffffff8023919b>] kthread+0x0/0x101
[   29.285397]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   29.285399] 
[   31.281290] BUG: scheduling while atomic: events/0/0x00000001/4
[   31.281295] 
[   31.281296] Call Trace:
[   31.281309]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   31.281314]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   31.281319]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   31.281323]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   31.281329]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   31.281333]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   31.281338]  [<ffffffff80239269>] kthread+0xce/0x101
[   31.281342]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   31.281346]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   31.281351]  [<ffffffff8023919b>] kthread+0x0/0x101
[   31.281354]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   31.281356] 
[   32.949597] ip_conntrack version 2.4 (2044 buckets, 16352 max) - 248 bytes per conntrack
[   33.277294] BUG: scheduling while atomic: events/0/0x00000001/4
[   33.277298] 
[   33.277299] Call Trace:
[   33.277311]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   33.277317]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   33.277322]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   33.277325]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   33.277331]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   33.277335]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   33.277340]  [<ffffffff80239269>] kthread+0xce/0x101
[   33.277344]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   33.277348]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   33.277353]  [<ffffffff8023919b>] kthread+0x0/0x101
[   33.277357]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   33.277359] 
[   35.273273] BUG: scheduling while atomic: events/0/0x00000001/4
[   35.273278] 
[   35.273279] Call Trace:
[   35.273291]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
[   35.273296]  [<ffffffff802f34b6>] list_add+0xc/0xe
[   35.273302]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   35.273305]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
[   35.273311]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
[   35.273315]  [<ffffffff80236519>] worker_thread+0x0/0x11b
[   35.273320]  [<ffffffff80239269>] kthread+0xce/0x101
[   35.273324]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
[   35.273329]  [<ffffffff8020a238>] child_rip+0xa/0x12
[   35.273334]  [<ffffffff8023919b>] kthread+0x0/0x101
[   35.273337]  [<ffffffff8020a22e>] child_rip+0x0/0x12
[   35.273339] 

[...]

------------------------------------------------------------------

-- 
	Paolo Ornati
	Linux 2.6.19-rc5 on x86_64
