Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276538AbRJCQ4g>; Wed, 3 Oct 2001 12:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276540AbRJCQ40>; Wed, 3 Oct 2001 12:56:26 -0400
Received: from changeofhabit.mr.itd.umich.edu ([141.211.144.17]:19180 "EHLO
	changeofhabit.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S276538AbRJCQ4L>; Wed, 3 Oct 2001 12:56:11 -0400
Subject: Fwd: TI 8021 OHCI Firewire card not being detected as OHCI1394
From: "G. Clark Haynes" <gchaynes@umich.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-tKl+uu4bLktdcAuZ0uxD"
X-Mailer: Evolution/0.14 (Preview Release)
Date: 03 Oct 2001 12:54:45 -0400
Message-Id: <1002128085.1302.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tKl+uu4bLktdcAuZ0uxD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm forwarding a message I sent to linux1394 developers, but we were
unfortunately unable to find a solution.

This is in a new SONY VAIO laptop, and I am having problems with the IRQ
routing in the machine.  For several devices, I get errors about "No IRQ
known for interrupt pin ...", both while booting, and when I try to
activate this ohci1394 module.  I have tried 2.4.2, 2.4.3, 2.4.9 and
2.4.10, with different PCI irq settings, as well as turning ACPI on and
off.  The only suggestion I got from the linux1394 folks was to make
sure Plug & Play was off in the bios, which I have also tested, and it
didn't help.  And supplying "pci=bioirq" into lilo doesn't seem to do
anything useful.  It just gets rid of the annoying "Please try using
pci=biosirq" messages.  I have a guess, being a very new laptop, that
the problem here is coming from it being a ACPI based system (APM
doesn't even return anything on this system, so I'm pretty sure it's all
ACPI).

If anyone has any suggestions on how to get this machine up and running,
that would be wonderful.

Forwarded below is another message detailing the problem.
Attached to this e-mail are the files:
 dmesg.out - output from dmesg
 lspci.out - output from lspci -vvvxx
 dump_pirq.out - output from the pcmcia-cs perl script, pirq.out

Thanks for your time!
Clark


-----Forwarded Message-----

From: G. Clark Haynes <gchaynes@umich.edu>
To: linux1394-devel@sourceforge.net
Subject: TI 8021 OHCI Firewire card not being detected as OHCI1394
Date: 26 Sep 2001 18:41:51 -0400

Hello, I am trying to setup a VAIO GR series (PCG-GR100K) laptop with
Firewire.  I am familiar with the driver, having used it on an older
VAIO (though with a cardbus PCI card, since that laptop had the
proprietary Sony chip.

Here is output taken from lspci -v:

02:02.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021
(rev 02) (prog-if 10 [OHCI])
Here are some specs.  lspci -v
	Subsystem: Sony Corporation: Unknown device 80e7
	Flags: bus master, medium devsel, latency 64
	Memory at d0205000 (32-bit, non-prefetchable) [size=2K]
	Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

In windows, the card is detected and works properly, and reported as a
Texas Instruments OHCI compliant card.

I am using a 2.4.3 kernel, and have applied the patch available from the
ohci1394 website.

When I try to modprobe ohci1394, I get the following messages (kernel
debugging messages turned on):

Sep 26 18:28:17 localhost kernel: ieee1394: registered ohci1394 driver,
initializing now
Sep 26 18:28:17 localhost kernel: ohci1394: looking for Ohci1394 cards
Sep 26 18:28:17 localhost kernel: PCI: No IRQ known for interrupt pin A
of device 02:02.0. Please try using pci=biosirq.
Sep 26 18:28:17 localhost kernel: ohci1394_0: remapped memory spaces reg
0xe082f000
Sep 26 18:28:17 localhost kernel: ohci1394: failed to allocate shared
interrupt 0
Sep 26 18:28:17 localhost kernel: ohci1394_0: soft reset finished
Sep 26 18:28:17 localhost kernel: ohci1394_0: Freeing dma_rcv_ctx 0
Sep 26 18:28:17 localhost kernel: ohci1394_0: Freeing dma_rcv_ctx 1
Sep 26 18:28:17 localhost kernel: ohci1394_0: Freeing dma_trm_ctx 0
Sep 26 18:28:17 localhost kernel: ohci1394_0: Freeing dma_trm_ctx 1
Sep 26 18:28:17 localhost kernel: ohci1394_0: Freeing dma_rcv_ctx 2
Sep 26 18:28:17 localhost kernel: ohci1394_0: Freeing dma_trm_ctx 2
Sep 26 18:28:17 localhost kernel: Trying to free free IRQ0
Sep 26 18:28:17 localhost kernel: ohci1394: no operable Ohci1394 cards
found
Sep 26 18:28:17 localhost kernel: ieee1394: detected 0 ohci1394 adapters

It obviously seems that the problem here is the PCI subsystem, since it
cannot find a suitable IRQ for device 02:02, the Firewire card.  This
causes ohci1394 to not find the card, and currently has me rather
flustered.

Any ideas??  This laptop is being used as a tele-op unit to control a
robot (video coming in over firewire, and commands being sent to robot
via 802.11b network).  I would just use my old cardbus PCMCIA card, but
I need a slot free to keep the 802.11b card in use.

Thanks!
Galen Clark Haynes
gchaynes@umich.edu
University of Michigan
Artificial Intelligence Lab

--=-tKl+uu4bLktdcAuZ0uxD
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg.out
Content-ID: <1002127998.1289.12.camel@localhost.localdomain>
Content-Transfer-Encoding: 7bit

Linux version 2.4.3-12 (root@localhost.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-97.1)) #10 Wed Oct 3 11:57:05 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
On node 0 totalpages: 130944
zone(0): 4096 pages.
zone(1): 126848 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=linuxnew ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.3-new hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1126.844 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2247.88 BogoMIPS
Memory: 508520k/523776k available (1209k kernel code, 10708k reserved, 94k data, 244k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
  got res[d0206000:d0206fff] for resource 0 of Ricoh Co Ltd RL5c476 II
  got res[d0207000:d0207fff] for resource 0 of Ricoh Co Ltd RL5c476 II (#2)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 2048 Unix98 ptys configured
block: queued sectors max/low 337696kB/206624kB, 1024 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=248a
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: No IRQ known for interrupt pin A of device 00:1f.1. Please try using pci=biosirq.
PCI_IDE: chipset revision 1
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATDA04-0, ATA DISK drive
hdc: UJDA710, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=3648/255/63
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
floppy0: no floppy controllers found
Serial driver version 5.05a (2001-03-20) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Enabling device 00:1f.6 (0000 -> 0001)
PCI: No IRQ known for interrupt pin B of device 00:1f.6. Please try using pci=biosirq.
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
Adding Swap: 265032k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 12:16:10 Oct  3 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:1d.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: No IRQ known for interrupt pin C of device 00:1d.2. Please try using pci=biosirq.
usb-uhci.c: found UHCI device with no IRQ assigned. check BIOS settings!
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x461/0x4d04) is not claimed by any active driver.
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [0461:4d04] on usb1:2.0
mice: PS/2 mouse device common for all mice
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.20
  Type:   CD-ROM                             ANSI SCSI revision: 02
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 15
0x378: readIntrThreshold is 15
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x40
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ip_conntrack (4092 buckets, 32736 max)
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.6.6
Copyright (c) 2001 Intel Corporation
PCI: Found IRQ 9 for device 02:08.0

eth0: Intel(R) PRO/100 VE Network Connection
  Mem:0xd0204000  IRQ:9  Speed:100 Mbps  Dx:Full
  Hardware receive checksums disabled
  ucode was not loaded
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 3 for device 02:05.0
PCI: No IRQ known for interrupt pin B of device 02:05.1. Please try using pci=biosirq.
Yenta IRQ list 0cb0, PCI irq3
Socket status: 30000006
Yenta IRQ list 04b0, PCI irq0
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Intel 810 + AC97 Audio, version 0.02, 12:15:21 Oct  3 2001

--=-tKl+uu4bLktdcAuZ0uxD
Content-Type: text/plain
Content-Disposition: attachment; filename=dump_pirq.out
Content-ID: <1002128003.1289.13.camel@localhost.localdomain>
Content-Transfer-Encoding: 7bit

Interrupt routing table found at address 0xfdf30:
  Version 1.0, size 0x00b0
  Interrupt router is device 00:1f.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x8086 device 0x122e

Device 00:1e.0 (slot 0): PCI bridge

Device 02:02.0 (slot 0): FireWire (IEEE 1394)

Device 02:05.0 (slot 0): CardBus bridge
  INTA: link 0x69, irq mask 0x0008 [3]

Device 02:08.0 (slot 0): Ethernet controller
  INTA: link 0x68, irq mask 0x0200 [9]

Device 00:00.0 (slot 0): Host bridge

Device 00:1f.0 (slot 0): 

Device 00:1d.0 (slot 0): USB Controller
  INTA: link 0x60, irq mask 0x0200 [9]
  INTB: link 0x63, irq mask 0x0200 [9]

Device 00:02.0 (slot 0): 
  INTA: link 0x60, irq mask 0x0200 [9]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x60, irq mask 0x0200 [9]

Interrupt router at 00:1f.0: Intel 82371FB PIIX PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 9
  PIRQ2 (link 0x61): unrouted
  PIRQ3 (link 0x62): unrouted
  PIRQ4 (link 0x63): irq 9
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=4]
  Level mask: 0x0200 [9]

--=-tKl+uu4bLktdcAuZ0uxD
Content-Type: text/plain
Content-Disposition: attachment; filename=lspci.out
Content-ID: <1002128007.1289.14.camel@localhost.localdomain>
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] #09 [0105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW+ Rate=x1
00: 86 80 75 35 06 01 10 20 02 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation: Unknown device 3576 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 76 35 07 00 20 00 02 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 82 24 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 84 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00

00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 0
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 87 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 03 00 00

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 41) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d02fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 00 80 00 41 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 22
20: 20 d0 20 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corporation: Unknown device 248c (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 8c 24 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 8a 24 07 00 80 02 01 8a 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 61 18 00 00 00 00 00 d0 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 01)
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 83 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 02 00 00

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2485 (rev 01)
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at 1c00 [disabled] [size=256]
	Region 1: I/O ports at 18c0 [disabled] [size=64]
00: 86 80 85 24 00 00 80 02 01 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00

00:1f.6 Modem: Intel Corporation: Unknown device 2486 (rev 01) (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
00: 86 80 86 24 01 00 80 02 01 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 59 4c 83 02 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 d8 01 30 00 00 00 00 10 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 58 00 00 00 00 00 00 00 09 01 08 00

02:02.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d0205000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 21 80 06 00 10 02 02 10 00 0c 08 40 00 00
10: 00 50 20 d0 00 00 20 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 03 04

02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 a8 82 00
10: 00 60 20 d0 dc 00 00 02 02 03 03 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 44 00 00
30: fc 44 00 00 00 48 00 00 fc 48 00 00 03 01 80 05
40: 4d 10 e7 80 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=07, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000
	I/O window 0: 00004c00-00004cff
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 a8 82 00
10: 00 70 20 d0 dc 00 00 02 02 07 07 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 4c 00 00
30: fc 4c 00 00 00 00 00 00 00 00 00 00 00 02 00 05
40: 4d 10 e7 80 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:08.0 Ethernet controller: Intel Corporation: Unknown device 1031 (rev 41)
	Subsystem: Sony Corporation: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 4000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 31 10 07 00 90 02 41 00 00 02 08 42 00 00
10: 00 40 20 d0 01 40 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 38


--=-tKl+uu4bLktdcAuZ0uxD--

