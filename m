Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVDVV4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVDVV4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDVV4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:56:25 -0400
Received: from 114.135.160.66.in-arpa.com ([66.160.135.114]:6663 "EHLO
	furrylvs.randyg.org") by vger.kernel.org with ESMTP id S261154AbVDVVzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:55:51 -0400
Message-ID: <426972E5.4000408@bushytails.net>
Date: Fri, 22 Apr 2005 14:55:49 -0700
From: Randy Gardner <lkml@bushytails.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-cd?  Can burn DVDs, just not read them...
Content-Type: multipart/mixed;
 boundary="------------040306010500000906000707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040306010500000906000707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I just bought a shiny new 16x dvd burner (box says IOMagic IDVD16DD, 
drive says Magicspin 1016IM), and can burn dvds perfectly...  just not 
read them.

Tried with both a dvd I burnt and with a purchased factory-made DVD, on 
two computers, with three different IDE controllers, with no change.

Under 2.6.8.1, trying to read files off a dvd instantly oopses.  Under 
2.6.11.7, reads are very, very slow, pegs the CPU at 100% (with dma 
on!), and sometimes give errors in the logs.  Under 2.6.12-rc3, reads 
don't work at all, 100% cpu, always logs errors, dma gets disabled, and 
typically the box takes a reboot to get it usable after trying to read 
(box is bogged down; 2 second keyboard delay, etc).  Those are using 
ide-cd; trying ide-scsi just panics.

Burning works perfectly; 8x burns use about 3% cpu, with no errors.

Motherboard in this system is a MSI 694D Pro (dual pentium 3) with Via 
VT82c686a chipset.  I use pci=noacpi, as acpi causes other problems 
(most notably two of my PCI slots stop working, even with the board 
flashed to the latest bios; putting a card in them causes either hangs 
or nobody cared errors).  Enabling acpi doesn't change the dvd problems. 
  Tested using both the standard ata/66 controller and the promise 
PDC20265 ide RAID controller.

As a test, I drove the drive over to a relative's house, and popped it 
into her dual-boot system, with a via 82c596b chipset, no acpi at all. 
under 2.6.11.7, it has the exact same symptoms as on my box.  Under 
windoze, the drive works flawlessly, and can even read the dvds I burnt 
under linux with no errors.

I don't have a copy of the oops under 2.6.8.1, however I'm guessing that 
has been fixed already, since it doesn't happen under newer kernels. 
Under .12-rc3, the following gets logged:  (ugly paste alert!)

Apr 21 19:18:57 localhost kernel: ISO 9660 Extensions: Microsoft Joliet 
Level 3
Apr 21 19:18:57 localhost kernel: ISO 9660 Extensions: RRIP_1991A
Apr 21 19:19:27 localhost kernel: hdf: command error: status=0x51 { 
DriveReady SeekComplete Error }
Apr 21 19:19:27 localhost kernel: hdf: command error: error=0x54 { 
AbortedCommand LastFailedSense=0x05 }
Apr 21 19:19:27 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:19:32 localhost kernel: hdf: command error: status=0x51 { 
DriveReady SeekComplete Error }
Apr 21 19:19:32 localhost kernel: hdf: command error: error=0x54 { 
AbortedCommand LastFailedSense=0x05 }
Apr 21 19:19:32 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:19:32 localhost kernel: end_request: I/O error, dev hdf, 
sector 8107876
Apr 21 19:19:32 localhost kernel: Buffer I/O error on device hdf, 
logical block 2026969
Apr 21 19:19:37 localhost kernel: hdf: command error: status=0x51 { 
DriveReady SeekComplete Error }
Apr 21 19:19:37 localhost kernel: hdf: command error: error=0x54 { 
AbortedCommand LastFailedSense=0x05 }
Apr 21 19:19:37 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:19:37 localhost kernel: end_request: I/O error, dev hdf, 
sector 8107880
Apr 21 19:19:37 localhost kernel: Buffer I/O error on device hdf, 
logical block 2026970
Apr 21 19:19:43 localhost kernel: hdf: command error: status=0x51 { 
DriveReady SeekComplete Error }
Apr 21 19:19:43 localhost kernel: hdf: command error: error=0x54 { 
AbortedCommand LastFailedSense=0x05 }
Apr 21 19:19:43 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:19:43 localhost kernel: end_request: I/O error, dev hdf, 
sector 8107884
Apr 21 19:19:43 localhost kernel: Buffer I/O error on device hdf, 
logical block 2026971

Or, sometimes:

Apr 21 19:21:32 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:21:32 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:21:32 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:21:39 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:21:39 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:21:39 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:21:45 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:21:45 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:21:45 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:21:52 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:21:52 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:21:52 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:21:52 localhost kernel: hdf: ide_intr: huh? expected NULL 
handler on exit
Apr 21 19:21:52 localhost kernel: hdf: ATAPI reset complete
Apr 21 19:21:59 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:21:59 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:21:59 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:22:06 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:22:06 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:22:06 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:22:13 localhost kernel: hdf: cdrom_decode_status: status=0x51 
{ DriveReady SeekComplete Error }
Apr 21 19:22:13 localhost kernel: hdf: cdrom_decode_status: error=0x40 { 
LastFailedSense=0x04 }
Apr 21 19:22:13 localhost kernel: ide: failed opcode was: unknown
Apr 21 19:22:13 localhost kernel: hdf: ide_intr: huh? expected NULL 
handler on exit
Apr 21 19:22:13 localhost kernel: hdf: ATAPI reset complete
Apr 21 19:22:13 localhost kernel: end_request: I/O error, dev hdf, 
sector 8107972
Apr 21 19:22:13 localhost kernel: Buffer I/O error on device hdf, 
logical block 2026993

Errors with "huh?" in them are always fun.  :)

In addition, I've attached the complete output of dmesg (at a fresh 
boot; attempting to read a dvd very quickly clobbers the boot 
information with the errors), in case it's helpful at all.

The errors and symptoms do not change of the DVD is ISO or UDF.

I have also observed problems reading CDs on my cd-rw drive (the other 
drive visible in the dmesg output), specifically the log entries, but 
without the other problems, and the reads always complete and go normal 
speed.  Reading a cd gives:

hdg: command error: status=0x51 { DriveReady SeekComplete Error }
hdg: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdg, sector 0
Buffer I/O error on device hdg, logical block 0
hdg: command error: status=0x51 { DriveReady SeekComplete Error }
hdg: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdg, sector 0
Buffer I/O error on device hdg, logical block 0
hdg: command error: status=0x51 { DriveReady SeekComplete Error }
hdg: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdg, sector 0
Buffer I/O error on device hdg, logical block 0
hdg: command error: status=0x51 { DriveReady SeekComplete Error }
hdg: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdg, sector 0
Buffer I/O error on device hdg, logical block 0
cdrom: hdg: mrw address space DMA selected


Any ideas?  If there's any tests/output that would help track it down, 
I'll be glad to try/post them.


Thanks in advance,
--Randy


--------------040306010500000906000707
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.12-rc3 (root@dualbox) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #1 SMP Thu Apr 21 13:46:49 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5fd0
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294896 pages, LIFO batch:16
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f78c0
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x7fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x7fff3040
ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x7fff5740
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 80000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro pci=noacpi
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 869.110 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075844k/2097088k available (1768k kernel code, 20384k reserved, 774k data, 188k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1699.84 BogoMIPS (lpj=849920)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 1732.60 BogoMIPS (lpj=866304)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3432.44 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI->APIC IRQ transform: 0000:00:07.2[D] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:07.3[D] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:07.5[C] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:0c.0[A] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:0e.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 12
PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:11.0[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:12.0[A] -> IRQ 12
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 11
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L080L4, ATA DISK drive
hdb: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6B200R0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(66)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
hdb: max request size: 1024KiB
hdb: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(66)
hdb: cache flushes supported
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
hdc: max request size: 1024KiB
hdc: 398297088 sectors (203928 MB) w/16384KiB Cache, CHS=24792/255/63, UDMA(33)
hdc: cache flushes supported
 /dev/ide/host0/bus1/target0/lun0: p1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 15
Starting balanced_irq
ACPI wakeup devices: 
SLPB PCI0 USB0 USB1 UAR1 UAR2 ECP1 
ACPI: (supports S0 S1 S4bios S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
kjournald starting.  Commit interval 5 seconds
input: AT Translated Set 2 keyboard on isa0060/serio0
Adding 3958912k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Linux agpgart interface v0.101 (c) Dave Jones
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport_pc: VIA parallel port: io=0x378, irq=7
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0001dc00, 00:C0:F0:3E:1B:0A, IRQ 5.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:10.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.2: irq 11, io mem 0xe0023000
ehci_hcd 0000:00:10.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: over-current change on port 3
hub 1-0:1.0: over-current change on port 4
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.2: irq 5, io base 0x0000a000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:07.3: irq 5, io base 0x0000a400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.0: irq 10, io base 0x0000d400
usb 2-1: new low speed USB device using uhci_hcd and address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.1: irq 5, io base 0x0000d800
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 3
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 7 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 3-2: new full speed USB device using uhci_hcd and address 3
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:07.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0 - 2.6.11.3-pc-0.1:USB HID core driver
usb 2-2.2: new full speed USB device using uhci_hcd and address 4
input: USB HID v1.00 Device [XITEL MD-PORT AN1] on usb-0000:00:07.2-2.2
usb 2-2.4: new full speed USB device using uhci_hcd and address 5
usb 3-1.3: new full speed USB device using uhci_hcd and address 4
usb 3-2.2: new full speed USB device using uhci_hcd and address 5
usbhid: probe of 3-2.2:1.0 failed with error -5
usb 3-2.3: new full speed USB device using uhci_hcd and address 6
usbhid: probe of 3-2.3:1.0 failed with error -5
Linux video capture interface: v1.00
V4L-Driver for Vision CPiA based cameras v1.2.3
Since in-kernel colorspace conversion is not allowed, it is disabled by default now. Users should fix the applications in case they don't work without conversion reenabled by setting the 'colorspace_conv' module parameter to 1<6>USB driver for Vision CPiA based cameras v1.2.3
usb 3-2.4: new full speed USB device using uhci_hcd and address 7
usbhid: probe of 3-2.4:1.0 failed with error -5
usbcore: registered new driver snd-usb-audio
USB CPiA camera found
videodev: "CPiA Camera" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
PCI: Setting latency timer of device 0000:00:07.5 to 64
  CPiA Version: 1.33 (2.10)
  CPiA PnP-ID: 0813:0001:0106
  VP-Version: 1.0 0100
usbcore: registered new driver cpia
input: Wacom Intuos 9x12 on usb-0000:00:07.3-2.2
input: Wacom Intuos 4x5 on usb-0000:00:07.3-2.3
input: Wacom Intuos 6x8 on usb-0000:00:07.3-2.4
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.40 - 2.6.11.3-pc-0.2:USB Wacom Graphire and Wacom Intuos tablet driver
PDC20265: IDE controller at PCI slot 0000:00:0c.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: IOMEGA CDRW64892EXT3-B, ATAPI CD/DVD-ROM drive
ide3 at 0xc000-0xc007,0xc402 on irq 10
hdg: ATAPI 12X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Single Channel A, SCSI Id=7, 16/253 SCBs

NET: Registered protocol family 17
eth0: Setting half-duplex based on MII#1 link partner capability of 00a1.
lp0: using parport0 (interrupt-driven).
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:44:39 PST 2005
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode

--------------040306010500000906000707--
