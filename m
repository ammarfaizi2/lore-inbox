Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTHWKwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 06:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTHWKwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 06:52:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263752AbTHWKvV (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 06:51:21 -0400
Date: Sat, 23 Aug 2003 12:52:43 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: LKML <linux-kernel@vger.redhat.com>
Subject: 2.6.0-test4 - lost ACPI
Message-ID: <20030823105243.GA1245@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	LKML <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

I am using ACPI for few years now. As far as I can see, on my
machine it is only usfeul for binding events to Power button (like
running fbdump) and for powering off. I'm also experimenting
with swsusp, which I run by /proc/acpi/sleep.

2.6.0-test4 has a surprise for me:

Linux version 2.6.0-test4 (zdzichu@mother) (gcc version 3.3.1) #15 Sat Aug 23 12:03:
02 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
 BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77808 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI disabled because your bios is from 00 and too old
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
You can enable it with acpi=force
ACPI: RSDP (v000 VIA693                                    ) @ 0x000f70c0
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x13ff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x13ff3040
ACPI: DSDT (v001 VIA693 AWRDACPI 0x00001000 MSFT 0x0100000a) @ 0x00000000

WTF? My BIOS was perfectly good all those years! And no, there is
no upgrade for my motherboard available. Using acpi=force is ugly
and un-understandable.

There are also some strange directories in /proc :
dr-xr-xr-x    2 root     root            0 Aug 23 12:50 /proc/ac_adapter/
dr-xr-xr-x    2 root     root            0 Aug 23 12:50 /proc/fan

they are empty, but they should be in /proc/acpi/

Attached files:
Output from dmidecode, lspci -v, my dmesg and /proc/cpuinfo

[Please CC me on replies. Thank you].

-- 
Tomasz Torcz                 "God, root, what's the difference?" 
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."   

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo.txt"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 368.511
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 720.89


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmidecode.txt"

# dmidecode 1.8
SMBIOS 2.1 present.
DMI 2.1 present.
31 structures occupying 840 bytes.
DMI table at 0x000F0800.
Handle 0x0000
	DMI type 0, 19 bytes.
	BIOS Information Block
		Vendor: Award Software International, Inc.
		Version: 4.51 PG
		Release: 09/13/00
		BIOS base: 0xE0000
		ROM size: 256K
		Capabilities:
			Flags: 0x000000007FCBDE90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: VIA Technologies, Inc.
		Product: VT82C692BX
		Version:  
		Serial Number:  
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor:  
		Product: 693-686A
		Version:  
		Serial Number:  
Handle 0x0003
	DMI type 3, 13 bytes.
	Chassis Information Block
		Vendor:  
		Chassis Type: Unknown
		Version:  
		Serial Number:  
		Asset Tag:  
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor
		Socket Designation: SLOT 1
		Processor Type: Central Processor
		Processor Family: Pentium II processor
		Processor Manufacturer: Intel
		Processor Version: INTEL(R) CELERON(TM)
Handle 0x0005
	DMI type 5, 24 bytes.
	Memory Controller
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_0
		Banks: 0 1
		Speed: 60nS
		Type: 
		Installed Size: 64Mbyte
		Enabled Size: 64Mbyte
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_1
		Banks: 2 3
		Speed: 60nS
		Type: UNKNOWN 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_2
		Banks: 4 5
		Speed: 60nS
		Type: 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_3
		Banks: 6 7
		Speed: 60nS
		Type: FPM 
		Installed Size: 64Mbyte
		Enabled Size: 64Mbyte
Handle 0x000A
	DMI type 7, 19 bytes.
	Cache
		Socket: Internal Cache
		L1 Internal Cache: write-back
		L1 Cache Size: 32K
		L1 Cache Maximum: 32K
		L1 Cache Type: Synchronous 
Handle 0x000B
	DMI type 7, 19 bytes.
	Cache
		Socket: External Cache
		L2 External Cache: write-back
		L2 Cache Size: 128K
		L2 Cache Maximum: 2048K
		L2 Cache Type: Synchronous 
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Designator:  
		External Connector Type: None
		Port Type: Other
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Designator:  
		External Connector Type: None
		Port Type: Other
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: FDD
		Internal Connector Type: On Board Floppy
		External Designator:  
		External Connector Type: None
		Port Type: 8251 FIFO Compatible
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator:  
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16450 Compatible
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator:  
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16450 Compatible
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: LPT1
		Internal Connector Type: DB-25 pin female
		External Designator:  
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port ECP/EPP
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Keyboard
		Internal Connector Type: Other
		External Designator:  
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Designator: No Detected
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0014
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit Long ISA 
		Slot Features: 5v 
Handle 0x0015
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit Long ISA 
		Slot Features: 5v 
Handle 0x0016
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit Long ISA 
		Slot Features: 5v 
Handle 0x0017
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit Long ISA 
		Slot Features: 5v 
Handle 0x0018
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 
Handle 0x0019
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 
Handle 0x001A
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit Long PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x001B
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit Long PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x001C
	DMI type 9, 13 bytes.
	Card Slot
		Slot: AGP
		Type: 32bit Long AGP 
		Status: Available.
		Slot Features: 5v 
Handle 0x001D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: USB
		Internal Connector Type: None
		External Designator:  
		External Connector Type: Other
		Port Type: USB
Handle 0x001E
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 3
			n|US|iso8859-1
			r|CA|iso8859-1
			a|JP|unicode
		Currently Installed Language: n|US|iso8859-1
ACPI 1.0 present.
	OEM ID: VIA693
RSD table at 0x13FF3000.
BIOS32 Service Directory present.
	Calling Interface Address: 0x000FB280
PNP 1.0 present.
	Event Notification: Not Supported
	Real Mode Code Address: F000:BF20
	Real Mode Data Address: F000:0000
	Protected Mode Code Address: 0x000FBEF8
	Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
	Table Size: 144 bytes
	Router ID: 00:07.0
	Exclusive IRQs: 10 11 12
	Compatible Router: 1106:0596

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.0-test4 (zdzichu@mother) (gcc version 3.3.1) #15 Sat Aug 23 12:03:02 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
 BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77808 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI disabled because your bios is from 00 and too old
You can enable it with acpi=force
ACPI: RSDP (v000 VIA693                                    ) @ 0x000f70c0
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x13ff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x13ff3040
ACPI: DSDT (v001 VIA693 AWRDACPI 0x00001000 MSFT 0x0100000a) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux2_6fb root=304 video=matroxfb:off root=/dev/ide/host0/bus0/target0/lun0/part4 resume=/dev/hda2
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 368.511 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 720.89 BogoMIPS
Memory: 319716k/327616k available (2503k kernel code, 7144k reserved, 879k data, 160k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbed0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbef8, dseg 0xf0000
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
PM: Adding info for pnp:00:10
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.3
PM: Adding info for pci:0000:00:07.4
PM: Adding info for pci:0000:00:07.5
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
pty: 256 Unix98 ptys configured
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11a
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380011A, ATA DISK drive
PM: Adding info for No Bus:ide0
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: 8X4X32, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:07.3
ALSA device list:
  #0: Ensoniq AudioPCI ENS1370 at 0xec00, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (2559 buckets, 20472 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET4: Ethernet Bridge 008 for NET4.0
Bridge firewalling registered
swsusp: Resume From Partition: /dev/hda2, Device: hda2
Resume Machine: This is normal swap space
Resume Machine: Error -22 resuming
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
blk: queue d3de4800, I/O limit 4095Mb (mask 0xffffffff)
Adding 506036k swap on /dev/ide/host0/bus0/target0/lun0/part2.  Priority:2 extents:1
SGI XFS for Linux with ACLs, no debug enabled
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
PM: Adding info for No Bus:i2c-0
registering 0-6000
PM: Adding info for i2c:0-6000
Disabled Privacy Extensions on device c040d580(lo)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 12 for device 0000:00:0a.0
PCI: Sharing IRQ 12 with 0000:00:07.5
eth0: RealTek RTL8139 Fast Ethernet at 0xd4948000, 00:06:4f:00:e8:99, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Disabled Privacy Extensions on device d34d3c00(sxb0)
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 10 for device 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:0b.0
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 10, io base 0000d400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
PCI: Found IRQ 10 for device 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:0b.0
uhci-hcd 0000:00:07.3: UHCI Host Controller
uhci-hcd 0000:00:07.3: irq 10, io base 0000d800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
PCI: Found IRQ 12 for device 0000:00:07.5
PCI: Sharing IRQ 12 with 0000:00:0a.0
PCI: Setting latency timer of device 0000:00:07.5 to 64
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 44)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 1b)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 0e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 0e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 21)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 12
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
	Subsystem: Unknown device 4942:4c4c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=8 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2


--9jxsPFA5p3P2qPhR--
