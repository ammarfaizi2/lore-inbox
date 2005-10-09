Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVJIJbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVJIJbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 05:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVJIJbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 05:31:04 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:24811 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750790AbVJIJbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 05:31:02 -0400
Date: Sun, 9 Oct 2005 06:30:57 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [2.6.14-rc3] BUG: soft lockup detected on CPU#0
Message-ID: <20051009093057.GB4907@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi there, all.

I have been running kernel 2.6.14-rc3 for some time now and I see some
bugs.

One of them is a soft lockup detected on CPU#0 (the only CPU that I
have) during the stage when the kernel is probing for IDE
controllers/devices.

Here is the relevant part of the dmesg log (the whole dmesg log is
attached):

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: ROM enabled at 0x40000000
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: QUANTUM FIREBALLlct15 30, ATA DISK drive
ide2 at 0x8800-0x8807,0x8402 on irq 10
Probing IDE interface ide3...
BUG: soft lockup detected on CPU#0!

Pid: 1, comm:              swapper
EIP: 0060:[<c010cd9c>] CPU: 0
EIP is at delay_pmtmr+0xd/0x15
 EFLAGS: 00000293    Not tainted  (2.6.14-rc3-2.hm)
EAX: 33ef92a1 EBX: 0010f25e ECX: 33eab591 EDX: 00000009
ESI: c03ad430 EDI: 000088b8 EBP: c03ad430 DS: 007b ES: 007b
CR0: 8005003b CR2: fff9a000 CR3: 0036f000 CR4: 000006d0
 [<c0206ed1>] ide_wait_not_busy+0x19/0x48
 [<c0208442>] wait_hwif_ready+0x94/0xa5
 [<c02085a0>] probe_hwif+0xc1/0x3a0
 [<c0191ca4>] kobject_release+0x0/0xa
 [<c020888f>] probe_hwif_init_with_fixup+0x10/0x79
 [<c020afdb>] ide_setup_pci_device+0x70/0x7d
 [<c0360c2b>] ide_scan_pcidev+0x27/0x4c
 [<c0360c6f>] ide_scan_pcibus+0x1f/0x86
 [<c0360baa>] probe_for_hwifs+0xb/0xd
 [<c0360bef>] ide_init+0x43/0x58
 [<c034c6d1>] do_initcalls+0x43/0x8e
 [<c0100274>] init+0x0/0x110
 [<c010029b>] init+0x27/0x110
 [<c01012a1>] kernel_thread_helper+0x5/0xb
hde: max request size: 128KiB
hde: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
hde: cache flushes not supported
 hde: hde1 hde2 hde3 hde4
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Is there anything else that I could provide to get this fixed before
2.6.14 is released? I am willing to help test whatever you think is
necessary (think of me as a guinea pig).


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.14-rc3-2.hm (root@dumont) (gcc version 4.0.1 (Debian 4.0.1-2)) #1 Tue Oct 4 05:16:05 BRT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
On node 0 totalpages: 196588
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192492 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x2ffec000
ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x2ffec080
ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x2ffec040
ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 40000000 (gap: 30000000:cfff0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux root=2103
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01603000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1110.122 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 776028k/786352k available (1674k kernel code, 9824k reserved, 662k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2221.22 BogoMIPS (lpj=1110613)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1c3f9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e20)
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Generic PHY: Registered new driver
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dc800000-dddfffff
  PREFETCH window: ddf00000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized mga 3.2.0 20050607 on minor 0: 
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ttyS2 at I/O 0x9400 (irq = 11) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
lp0: using parport0 (interrupt-driven).
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
eth0: RealTek RTL8139 at 0xf0810000, 00:e0:7d:96:28:8f, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
eth1: RealTek RTL8139 at 0xf0812000, 00:e0:7d:95:c9:9c, IRQ 9
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: ROM enabled at 0x40000000
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: QUANTUM FIREBALLlct15 30, ATA DISK drive
ide2 at 0x8800-0x8807,0x8402 on irq 10
Probing IDE interface ide3...
BUG: soft lockup detected on CPU#0!

Pid: 1, comm:              swapper
EIP: 0060:[<c010cd9c>] CPU: 0
EIP is at delay_pmtmr+0xd/0x15
 EFLAGS: 00000293    Not tainted  (2.6.14-rc3-2.hm)
EAX: 33ef92a1 EBX: 0010f25e ECX: 33eab591 EDX: 00000009
ESI: c03ad430 EDI: 000088b8 EBP: c03ad430 DS: 007b ES: 007b
CR0: 8005003b CR2: fff9a000 CR3: 0036f000 CR4: 000006d0
 [<c0206ed1>] ide_wait_not_busy+0x19/0x48
 [<c0208442>] wait_hwif_ready+0x94/0xa5
 [<c02085a0>] probe_hwif+0xc1/0x3a0
 [<c0191ca4>] kobject_release+0x0/0xa
 [<c020888f>] probe_hwif_init_with_fixup+0x10/0x79
 [<c020afdb>] ide_setup_pci_device+0x70/0x7d
 [<c0360c2b>] ide_scan_pcidev+0x27/0x4c
 [<c0360c6f>] ide_scan_pcibus+0x1f/0x86
 [<c0360baa>] probe_for_hwifs+0xb/0xd
 [<c0360bef>] ide_init+0x43/0x58
 [<c034c6d1>] do_initcalls+0x43/0x8e
 [<c0100274>] init+0x0/0x110
 [<c010029b>] init+0x27/0x110
 [<c01012a1>] kernel_thread_helper+0x5/0xb
hde: max request size: 128KiB
hde: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
hde: cache flushes not supported
 hde: hde1 hde2 hde3 hde4
hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xa000, irq 5
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
ACPI wakeup devices: 
PWRB PCI0 UAR1 UAR2 USB0 USB1 
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
Adding 224900k swap on /dev/hde4.  Priority:-1 extents:1 across:224900k
EXT3 FS on hde3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 9, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.3: irq 9, io base 0x0000d000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
usb 2-2: new full speed USB device using uhci_hcd and address 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[db800000-db8007ff]  Max Packet=[2048]
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
usb 2-2.1: new full speed USB device using uhci_hcd and address 3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011066645555ead]
eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1: link up, 10Mbps, half-duplex, lpa 0x0000
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 16 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

--FsscpQKzF/jJk6ya--
