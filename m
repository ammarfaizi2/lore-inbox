Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTEZVsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTEZVsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:48:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:7808 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262259AbTEZVs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:48:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 26 May 2003 14:52:20 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x 
In-Reply-To: <3ED21CE3.9060400@winischhofer.net>
Message-ID: <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003, Thomas Winischhofer wrote:

> and I had (and have) no problems with irqs or USB (or anything) on any
> of these machines.
>
> Are you sure that checking the revision number of the device is enough?

It seems reasonble, at least without having the spec for the chipset. All
my searches failed about docs. Previous cases are correctly handled like
before, as you can see from the patch.



> Are you aware of the fact that SiS only produces the chips but never the
> mainboards, and that SiS chips are in a 1000 ways "customizible" which

You happen to have the spec for the SIS650 ? The reality is that the
chipset issues 0x60..0x63 router request and the current kernel will not
correctly initialize device under that spot. So either we have a too
strict implementation in the current router (we should by default pass
thru unknown requests) or we need to fix it according to the new requests.
The "stdroute" thing is a way to keep the strict behaviour by default, and
yet have the ability to pass thru w/out the need of patching the kernel.



> not in a single case I came accross so far was detectable by the device
> revision number?

Below is reported the boot with PCI debug enabled and the content of my
PCI devices configuration space. If you have a better idea on how to fix
it, please submit a patch.



- Davide



BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bff0000 (usable)
 BIOS-e820: 000000001bff0000 - 000000001bffffc0 (ACPI data)
 BIOS-e820: 000000001bffffc0 - 000000001c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
447MB LOWMEM available.
On node 0 totalpages: 114672
zone(0): 4096 pages.
zone(1): 110576 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.20custom ro BOOT_FILE=/boot/vmlinuz-2.4.20-8custom hdc=ide-scsi root=LABEL=/
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2400.135 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 446712k/458688k available (1348k kernel code, 9412k reserved, 1000k data, 132k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00e6050
PCI: BIOS32 Service Directory entry at 0xe84b0
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xe84c4, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address trash cleared for 00:02.5
PCI: IDE base address fixup for 00:02.5
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fe840
00:02 slot=00 0:41/0ca8 1:42/0ca8 2:43/0ca8 3:44/0ca8
00:03 slot=00 0:60/0ca8 1:61/0ca8 2:62/0ca8 3:63/0ca8
00:02 slot=00 0:44/0ca8 1:00/0ca8 2:00/0ca8 3:00/0ca8
00:0b slot=01 0:44/0ca8 1:00/0ca8 2:00/0ca8 3:00/0ca8
00:0c slot=02 0:44/0ca8 1:00/0ca8 2:00/0ca8 3:00/0ca8
00:09 slot=03 0:42/0ca8 1:43/0ca8 2:00/0ca8 3:00/0ca8
01:00 slot=00 0:41/0ca8 1:00/0ca8 2:00/0ca8 3:00/0ca8
PCI: Attempting to find IRQ router for 1039:0008
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI: IRQ fixup
00:0b.0: ignoring bogus IRQ 255
IRQ for 00:03.0:0 -> PIRQ 60, mask 0ca8, excl 0000 -> newirq=0 ... failed
IRQ for 00:03.1:1 -> PIRQ 61, mask 0ca8, excl 0000 -> newirq=0 ... failed
IRQ for 00:03.2:2 -> PIRQ 62, mask 0ca8, excl 0000 -> newirq=0 ... failed
IRQ for 00:03.3:3 -> PIRQ 63, mask 0ca8, excl 0000 -> newirq=0 ... failed
IRQ for 00:0b.0:0 -> PIRQ 44, mask 0ca8, excl 0000 -> newirq=0 -> got IRQ 3
PCI: Found IRQ 3 for device 00:0b.0
PCI: Sharing IRQ 3 with 00:0c.0
PCI: Allocating resources
PCI: Resource f8000000-fbffffff (f=200, d=0, p=0)
PCI: Resource fc000000-fc000fff (f=200, d=0, p=0)
PCI: Resource 00001100-0000110f (f=101, d=0, p=0)
PCI: Resource 0000e000-0000e0ff (f=101, d=0, p=0)
PCI: Resource 0000e100-0000e17f (f=101, d=0, p=0)
PCI: Resource 0000e200-0000e2ff (f=101, d=0, p=0)
PCI: Resource 0000e300-0000e37f (f=101, d=0, p=0)
PCI: Resource f4002000-f4002fff (f=200, d=0, p=0)
PCI: Resource f4003000-f4003fff (f=200, d=0, p=0)
PCI: Resource fc002000-fc003fff (f=200, d=0, p=0)
PCI: Resource 0000e400-0000e4ff (f=101, d=0, p=0)
PCI: Resource fc004000-fc0040ff (f=200, d=0, p=0)
PCI: Resource a0000000-a7ffffff (f=1208, d=0, p=0)
PCI: Resource e0000000-e001ffff (f=200, d=0, p=0)
PCI: Resource 0000c000-0000c07f (f=101, d=0, p=0)
PCI: Sorting device list...
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
IRQ for 00:02.6:2 -> PIRQ 43, mask 0ca8, excl 0000 -> newirq=5 -> got IRQ 5
PCI: Found IRQ 5 for device 00:02.6
PCI: Sharing IRQ 5 with 00:02.7
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS650    ATA 133 controller
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-60, ATA DISK drive
blk: queue c03c9f40, I/O limit 4095Mb (mask 0xffffffff)
hdc: DW-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/2048KiB Cache, CHS=7296/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 144k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
IRQ for 00:03.0:0 -> PIRQ 60, mask 0ca8, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
PCI: Assigned IRQ 11 for device 00:03.0
PCI: Setting latency timer of device 00:03.0 to 64
usb-ohci.c: USB OHCI at membase 0xdc84a000, IRQ 11
usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
IRQ for 00:03.1:1 -> PIRQ 61, mask 0ca8, excl 0000 -> newirq=10 -> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 00:03.1
PCI: Setting latency timer of device 00:03.1 to 64
usb-ohci.c: USB OHCI at membase 0xdc84c000, IRQ 10
usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 00:03.2 (0000 -> 0002)
IRQ for 00:03.2:2 -> PIRQ 62, mask 0ca8, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
PCI: Assigned IRQ 11 for device 00:03.2
PCI: Setting latency timer of device 00:03.2 to 64
usb-ohci.c: USB OHCI at membase 0xdc84e000, IRQ 11
usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] 7001 (#3)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 00:03.3 (0000 -> 0002)
IRQ for 00:03.3:3 -> PIRQ 63, mask 0ca8, excl 0000 -> newirq=3 -> assigning IRQ 3 ... OK
PCI: Assigned IRQ 3 for device 00:03.3
PCI: Setting latency timer of device 00:03.3 to 64
ehci-hcd 00:03.3: PCI device 1039:7002 (Silicon Integrated Systems [SiS])
ehci-hcd 00:03.3: irq 3, pci mem dc856000
usb.c: new USB bus registered, assigned bus number 4
PCI: 00:03.3 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:03.3 PCI cache line size corrected to 128.
ehci-hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1052248k swap-space (priority -1)
hub.c: new USB device 00:03.0-1, assigned address 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 00:03.0-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x781/0x8888) is not claimed by any active driver.
hub.c: new USB device 00:03.0-1.1, assigned address 4
input0: USB HID v1.10 Keyboard [Silitek IBM USB HUB KEYBOARD] on usb1:4.0
hub.c: new USB device 00:03.0-1.2, assigned address 5
input1: USB HID v1.00 Mouse [04b3:3105] on usb1:5.0
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: SanDisk   Model: Cruzer            Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
USB Mass Storage support registered.
ohci1394: $Rev: 693 $ Ben Collins <bcollins@debian.org>
IRQ for 00:02.3:1 -> PIRQ 42, mask 0ca8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 00:02.3
PCI: Sharing IRQ 10 with 00:09.0
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[fc000000-fc0007ff]  Max Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Host added: Node[00:1023]  GUID[00508b719ed520cf]  [Linux OHCI-1394]
ieee1394: Host removed: Node[00:1023]  GUID[00508b719ed520cf]  [Linux OHCI-1394]
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 693 $ Ben Collins <bcollins@debian.org>
IRQ for 00:02.3:1 -> PIRQ 42, mask 0ca8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 00:02.3
PCI: Sharing IRQ 10 with 00:09.0
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[fc000000-fc0007ff]  Max Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Host added: Node[00:1023]  GUID[00508b719ed520cf]  [Linux OHCI-1394]
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: DW-224E           Rev: W.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
IRQ for 00:0c.0:0 -> PIRQ 44, mask 0ca8, excl 0000 -> newirq=3 -> got IRQ 3
PCI: Found IRQ 3 for device 00:0c.0
PCI: Sharing IRQ 3 with 00:0b.0
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xdc95c000, 00:08:02:d5:20:cf, IRQ 3
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
IRQ for 00:0b.0:0 -> PIRQ 44, mask 0ca8, excl 0000 -> newirq=3 -> got IRQ 3
PCI: Found IRQ 3 for device 00:0b.0
PCI: Sharing IRQ 3 with 00:0c.0
Yenta IRQ list 0000, PCI irq3
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x300-0x307 0x310-0x31f 0x378-0x37f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready




00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 11)
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 128
	Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
00: 39 10 50 06 07 00 10 22 11 00 00 06 00 80 80 00
10: 00 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fe 09 70 8b 03 13 b7 0e 02 25 c0 00 32 d1 f3 00
60: 67 67 00 20 c3 01 98 80 01 10 e0 00 48 02 00 00
70: 0f 9f 00 0f 02 00 00 00 00 00 00 00 02 00 11 00
80: 22 26 30 00 85 00 80 0b 20 0c 00 01 00 00 04 1c
90: 00 00 00 00 40 04 00 01 00 16 79 10 00 00 00 00
a0: 42 d4 33 c2 03 03 01 77 00 50 00 c2 42 09 08 02
b0: 00 00 00 10 80 00 00 4f f0 7f 30 30 00 00 80 00
c0: 02 00 20 00 07 02 00 1f 00 00 00 00 00 00 00 00
d0: 22 02 33 02 49 ff ff 01 60 60 aa 00 00 89 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: a0000000-afffffff
00: 39 10 01 00 07 01 00 00 00 00 04 06 00 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 d0 00 20
20: 00 e0 f0 ef 00 a0 f0 af 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
	Flags: bus master, medium devsel, latency 0
00: 39 10 08 00 0f 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 91 0b 0a 05 03 04 3c 50 10 00 00 00 11 20 04 01
50: 11 28 02 01 62 0b 66 0b 9c 2e 12 00 36 06 00 00
60: 0b 0a 0b 03 ff c1 eb 12 09 81 08 66 b7 00 06 80
70: 00 00 ff ff 00 10 02 54 00 00 00 80 04 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 20 04 00 01 00 00 00 00 00 00 00 00 aa aa aa aa
e0: 40 00 00 80 7c 00 04 00 00 00 00 00 00 00 00 00
f0: 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 128, IRQ 10
	Memory at fc000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [64] Power Management version 2
00: 39 10 07 70 06 00 10 02 00 10 00 0c 00 80 00 00
10: 00 00 00 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 64 00 00 00 00 00 00 00 0a 02 04 0c
40: 00 00 00 00 11 00 01 00 02 00 04 04 00 00 08 00
50: 00 00 10 00 00 00 00 00 ff 00 88 88 00 04 00 00
60: 00 00 00 00 01 00 42 fe 00 80 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 128
	I/O ports at 1100 [size=16]
	Capabilities: [58] Power Management version 2
00: 39 10 13 55 05 00 10 02 00 80 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: f2 00 f2 00 ea 96 d5 d0 01 00 02 86 00 00 00 00
60: ff aa ff aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 17 21 06 04 02 60 1c 1e 56 23 06 04 02 60 1c 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 128, IRQ 5
	I/O ports at e000 [size=256]
	I/O ports at e100 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 13 70 05 00 90 02 a0 00 03 07 00 80 00 00
10: 01 e0 00 00 01 e1 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 03 34 0b
40: 02 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 128, IRQ 5
	I/O ports at e200 [size=256]
	I/O ports at e300 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 12 70 05 00 90 02 a0 00 01 04 00 80 00 00
10: 01 e2 00 00 01 e3 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f4002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 39 10 01 70 07 00 90 02 0f 10 03 0c 00 40 80 00
10: 00 20 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 01 00 50
40: 00 00 00 00 5c bc 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at f4003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 39 10 01 70 07 00 90 02 0f 10 03 0c 00 40 00 00
10: 00 30 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 02 00 50
40: 00 00 00 00 5c bc 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at 1c000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 39 10 01 70 06 00 90 02 0f 10 03 0c 00 40 00 00
10: 00 00 00 1c 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 03 00 50
40: 00 00 00 00 5c bc 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 64, IRQ 3
	Memory at 1c001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
00: 39 10 02 70 06 00 90 02 00 20 03 0c 00 40 00 00
10: 00 10 00 1c 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 04 00 50
40: 80 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 0c c0 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Network controller: Broadcom Corporation: Unknown device 4320 (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 00e7
	Flags: bus master, fast devsel, latency 128, IRQ 10
	Memory at fc002000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
00: e4 14 20 43 06 00 10 00 02 00 80 02 00 80 00 00
10: 00 20 00 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e e7 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00
40: 01 00 c2 ff 00 40 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 10 00 18 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: df 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 168, IRQ 3
	Memory at 1c002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 1c400000-1c7ff000 (prefetchable)
	Memory window 1: 1c800000-1cbff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
00: 24 15 10 14 07 00 10 02 00 00 07 06 20 a8 02 00
10: 00 20 00 1c a0 00 00 02 00 03 03 b0 00 00 40 1c
20: 00 f0 7f 1c 00 00 80 1c 00 f0 bf 1c 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 ff 01 c0 05
40: 11 0e 3c 08 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 44 08 00 00 00 00 00 00 00 00 02 10 00 01
90: c0 02 44 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 fe 00 00 c0 00 01 00 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 10 00 00 80 00 80 00 00 04 08 10 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: bus master, medium devsel, latency 128, IRQ 3
	I/O ports at e400 [size=256]
	Memory at fc004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 80 00 00
10: 01 e4 00 00 00 40 00 fc 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 50 00 00 00 00 00 00 00 03 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 083c
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at a0000000 (32-bit, prefetchable) [size=128M]
	Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at c000 [size=128]
	Capabilities: [40] Power Management version 2
	Capabilities: [50] AGP version 2.0
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 a0 00 00 00 e0 01 c0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 3c 08
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 20 00 07 02 00 0f 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
