Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271123AbTGPVC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271122AbTGPVC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:02:59 -0400
Received: from CPE000625926cd6-CM014480115318.cpe.net.cable.rogers.com ([24.157.137.42]:20868
	"EHLO daedalus.samhome.net") by vger.kernel.org with ESMTP
	id S271123AbTGPU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:58:24 -0400
Subject: dma_timer_expiry on SATA siimage 3112 under 2.6.0-test1-ac1
From: Sam Bromley <bromley@uoguelph.ca>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Content-Type: text/plain
Organization: University of Guelph
Message-Id: <1058389994.3220.20.camel@daedalus.samhome.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 17:13:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day folks,
I am unable to enable DMA on a Maxtor 6Y120MO
on Asus A7N8X with a Silicon Image 3112 SATA
controller.

Specifically, after hdparm -X whatever -d1 /dev/hde

I get dma_timer_expiry errors and dma_status=0x21.

System becomes unresponsive if access to the drive
is attempted, and the errors above repeat continuously.

I believe this problem has come up in the past,
does a fix exist at this time?

I've tried both kernels 2.4.21-ac4 and 2.6.0-test1-ac2.

DMA is not enabled on the SATA drive at boot. However
DMA is enabled for the PATA CDROM drives, (at least
with acpi=off, else the PATA drives are not detected).

Below are the related outputs from dmesg and hdparm.
I'd appreciate any insight on this issue, and would
be happy to help in any way possible.

Cheers,
Sam.

---------------------------
Sam Bromley
Engineering Systems and Computing
School of Engineering
University of Guelph
Guelph, ON
Canada


hdparm -tT /dev/hde:

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.36 seconds =356.60 MB/sec
 Timing buffered disk reads:  64 MB in 48.30 seconds =  1.33 MB/sec

hdparm -I /dev/hde:


/dev/hde:

ATA device, with non-removable media
	Model Number:       Maxtor 6Y120M0                          
	Serial Number:      Y3JV3FSE            
	Firmware Revision:  YAR51BW0
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  240121728
	device size with M = 1024*1024:      117246 MBytes
	device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

dmesg:

Linux version 2.6.0-test1-ac1 (root@aura) (gcc version 3.3.1 20030626
(Debian prerelease)) #5 Wed Jul 16 11:26:11 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
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
Building zonelist for node : 0
Kernel command line: acpi=off hdg=none root=/dev/hde2 single
ide_setup: hdg=none
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1803.978 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3563.52 BogoMIPS
Memory: 514720k/524224k available (2319k kernel code, 8756k reserved,
866k data, 164k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1803.0876 MHz.
..... host bus clock speed is 267.0240 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
ACPI: Disabled via command line (acpi=off)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbfd0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc000, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
spurious 8259A interrupt: IRQ7.
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
Journalled Block Device driver loaded
udf: registering filesystem
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd8000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin
is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100
controller on pci0000:00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: MATSHITA CR-588, ATAPI CD/DVD-ROM drive
hdb: Pioneer DVD-ROM ATAPIModel DVD-114 0110, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
    ide2: MMIO-DMA at 0xe0838000-0xe0838007, BIOS settings: hde:pio,
hdf:pio
    ide3: MMIO-DMA at 0xe0838008-0xe083800f, BIOS settings: hdg:pio,
hdh:pio
hde: Maxtor 6Y120M0, ATA DISK drive
ide2 at 0xe0838080-0xe0838087,0xe083808a on irq 11
hde: max request size: 64KiB
hde: host protected area => 1
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
hda: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdb: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: PCI device 10de:0068 (nVidia Corporation)
ehci_hcd 0000:00:02.2: irq 5, pci mem e083a000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09
12:01:18 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0: clocking to 47391
ALSA device list:
  #0: NVidia nForce2 at 0xe2080000, irq 11
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 500432k swap on /dev/hde10.  Priority:-1 extents:1
EXT3 FS on hde2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.




