Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272161AbRHVXi6>; Wed, 22 Aug 2001 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272162AbRHVXis>; Wed, 22 Aug 2001 19:38:48 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:2975 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272161AbRHVXid>;
	Wed, 22 Aug 2001 19:38:33 -0400
Message-ID: <3B84430C.6E07D1E9@candelatech.com>
Date: Wed, 22 Aug 2001 16:41:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: BUG:  Cardbus related lockup on Sony VAIO PCG-FX210 (IRQ related, most 
 likely)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Problem:  Sony VAIO laptop: PCG-FX210 hangs when second Intel Cardbus NIC
is inserted.  Un-hangs when NIC is removed again.  This is a continuation
of a problem I reported a month or so ago (I just got the laptop back).
This does not seem to be related to the NIC, as similar things happen when
the 3COM NIC is inserted.

The last I heard, Linus & Jeff Garziak were thinking it was a PCI
routing problem.  The dmesg from the 2.4.9-pre4 (seems 2.4.9 final has
issues) is attached belown, and the dump_pirq.pl output is at the
end of the file.

I'll offer whatever debugging or patch-testing support I can, just let
me know how I can help.

THanks,
Ben



Linux version 2.4.9-pre4 (root@lanforge-ice) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #1 Wed Aug 22 13:35:47 MST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01221000)
Kernel command line: auto BOOT_IMAGE=linux-dev ro root=305 BOOT_FILE=/ct2.img
Initializing CPU#0
Detected 800.031 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126380k/131008k available (1083k kernel code, 4240k reserved, 385k data, 240k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd83d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Cannot allocate resource region 0 of device 00:07.5
  got res[1400:14ff] for resource 0 of VIA Technologies, Inc. AC97 Audio Controller
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1420
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1420 (#2)
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHM2100AT, ATA DISK drive
hdc: HITACHI DVD-ROM GD-S200, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/2048KiB Cache, CHS=1222/255/63, UDMA(66)
ide-floppy driver 0.97
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ide-floppy driver 0.97
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Assigned IRQ 10 for device 00:0a.1
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:10.0
Intel PCIC probe: not found.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Yenta IRQ list 0808, PCI irq9
Socket status: 30000020
Yenta IRQ list 0808, PCI irq10
Socket status: 30000006
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5157
  got res[2000:207f] for resource 0 of PCI device 10b7:5157
  got res[10800000:1080007f] for resource 1 of PCI device 10b7:5157
  got res[10800080:108000ff] for resource 2 of PCI device 10b7:5157
  got res[10400000:1041ffff] for resource 6 of PCI device 10b7:5157
PCI: Enabling device 02:00.0 (0000 -> 0003)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 265032k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 14:03:03 Aug 22 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:07.2 (0010 -> 0011)
PCI: Assigned IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
PCI: Sharing IRQ 9 with 00:0e.0
PCI: Setting latency timer of device 00:07.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 00:07.3 (0010 -> 0011)
PCI: Found IRQ 9 for device 00:07.3
PCI: Sharing IRQ 9 with 00:07.2
PCI: Sharing IRQ 9 with 00:0e.0
PCI: Setting latency timer of device 00:07.3 to 64
usb-uhci.c: USB UHCI at I/O 0x1040, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
ip_conntrack (1023 buckets, 8184 max)
8139too Fast Ethernet driver 0.9.18a
PCI: Enabling device 00:10.0 (0000 -> 0003)
PCI: Found IRQ 10 for device 00:10.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:0a.1
PCI: Setting latency timer of device 00:10.0 to 64
eth0: RealTek RTL8139 Fast Ethernet at 0xc8852800, 08:00:46:1d:7b:d8, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x2000. Vers LK1.1.16
PCI: Setting latency timer of device 02:00.0 to 64
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
eth1: Setting promiscuous mode.
device eth1 entered promiscuous mode
eth0: Promiscuous mode enabled.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
eth1: Setting promiscuous mode.
ide-floppy driver 0.97
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
Via 686a audio driver 1.1.14b
PCI: Found IRQ 10 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:0a.1
PCI: Sharing IRQ 10 with 00:10.0
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: timeout while reading AC97 codec (0x800000)
ac97_codec: AC97  codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
via82cxxx: board #1 at 0x1400, IRQ 5
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
spurious 8259A interrupt: IRQ7.
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
cs: socket c124e000 timed out during reset.  Try increasing setup_delay.
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)




dump_pirq output:

Interrupt routing table found at address 0xfdf60:
  Version 1.0, size 0x0080
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x1106 device 0x0596

Device 00:07.0 (slot 0): ISA bridge
  INTA: link 0x55, irq mask 0x9eb8 [3,4,5,7,9,10,11,12,15]
  INTB: link 0x56, irq mask 0x9eb8 [3,4,5,7,9,10,11,12,15]
  INTC: link 0x56, irq mask 0x9cb8 [3,4,5,7,10,11,12,15]
  INTD: link 0x57, irq mask 0x06a0 [5,7,9,10]

Device 00:00.0 (slot 0): Host bridge
  INTA: link 0x55, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTB: link 0x56, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTC: link 0x56, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTD: link 0x57, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x56, irq mask 0x0020 [5]

Device 00:0a.0 (slot 0): CardBus bridge
  INTA: link 0x55, irq mask 0x0020 [5]
  INTB: link 0x56, irq mask 0x0020 [5]

Device 00:10.0 (slot 0): Ethernet controller
  INTA: link 0x56, irq mask 0x0400 [10]

Device 00:0e.0 (slot 0): FireWire (IEEE 1394)
  INTA: link 0x57, irq mask 0x0200 [9]

Interrupt router at 00:07.0: VIA 82C686 PCI-to-ISA bridge
  PIRQA (link 0x01): irq 9
  PIRQB (link 0x02): irq 10
  PIRQC (link 0x03): irq 5
  PIRQD (link 0x05): irq 9



-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
