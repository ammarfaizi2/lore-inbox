Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286662AbRLVEQY>; Fri, 21 Dec 2001 23:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286663AbRLVEQI>; Fri, 21 Dec 2001 23:16:08 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:12498 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S286662AbRLVEPz>; Fri, 21 Dec 2001 23:15:55 -0500
To: linux-kernel@vger.kernel.org
Subject: PCI IRQ routing on VIA82C686 (+ACPI)
Message-ID: <1008994554.3c2408fa0ad36@imp.free.fr>
Date: Sat, 22 Dec 2001 05:15:54 +0100 (MET)
From: Renaud Guerin <rguerin@free.fr>
Cc: kai@tp1.ruhr-uni-bochum.de
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.42
X-Originating-IP: 62.147.9.118
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having trouble with the PCI IRQ setup code on a Medion 9626 laptop (K7 
with VIA82C686 aka Apollo Super), both with the standard code and with the 
ACPI-based pci-irq.c patch from Kai (although the latter seems to get 
further).
The ACPI patch I'm referring to may be found here :
http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.1/0024.html

The short story is that the onboard RTL8139 net device gets IRQ 0 and can't 
work when using the standard code, and that it seemingly gets an IRQ but has 
odd behavior and fails when either using Kai's ACPI code, or warm booting 
into the standard kernel after WinXP has been run.

(and unrelated to this but very annoying anyway, ACPI thermal management turns off 
my CPU fan and never puts it back on...I'm taking ideas...)

I have conducted tests with the following kernels:
- Mandrake 8.1's stock 2.4.8-34.1mdk (based on -ac I believe)
- 2.4.17-rc1 + preempt patch + latest ACPI code from Intel's site + Kai's 
ACPI-based IRQ routing patch.

For each kernel, I've tried a cold boot and a warm boot after WinXP had been 
run.

Here are the (long) results. I don't know enough about these PCI/IRQ issues 
to interpret that correctly but let's hope someone will.

Linux 2.4.8-34.1mdk (cold boot)
=========================
[root@tux root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)
[root@tux root]# lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
        Flags: bus master, medium devsel, latency 8
        Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
        Subsystem: Unknown device 16be:0001
        Flags: medium devsel
        Memory at e8000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        I/O ports at 1800 [disabled] [size=256]
        Capabilities: [60] Power Management version 2
00: 13 18 00 40 00 00 10 02 02 00 80 07 00 00 00 00
10: 00 00 00 e8 01 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 be 16 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1420 [size=16]
        Capabilities: [c0] Power Management version 2
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1400 [size=32]
        Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 14 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
        Flags: medium devsel, IRQ 5
        I/O ports at 1000 [size=256]
        I/O ports at 1434 [size=4]
        I/O ports at 1430 [size=4]
        Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 10 00 00 35 14 00 00 31 14 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 40 18
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1c00 [size=256]
        Memory at 10000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 1c 00 00 00 00 00 10 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 20 40

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 10 00 10 a0 00 00 02 00 02 05 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 01 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 20 00 10 a0 00 00 02 00 06 09 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 02 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1831
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [80] AGP version 2.0
00: 33 53 02 8d 07 00 30 02 01 00 00 03 08 40 00 00
10: 00 00 10 e8 08 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 31 18
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 04 ff

[root@tux root]# dmesg
Linux version 2.4.8-34.1mdk (root@updates.mandrakesoft.com) (gcc version 2.96 
20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #1 Mon Nov 19 12:40:39 MST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7ffc00 (ACPI data)
 BIOS-e820: 000000000f7ffc00 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=248-341 ro root=306 hdc=ide-scsi devfs=mount
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1001.782 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 246680k/253888k available (1093k kernel code, 6820k reserved, 398k 
data, 708k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1cbf9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1cbf9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd81e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v0.120 (20011103) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 163816kB/54605kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
hdc: UJDA330, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63, UDMA(100)
ide-floppy driver 0.97
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ide-floppy driver 0.97
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Uncompressing.....done.
Freeing initrd memory: 79k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 708k freed
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Real Time Clock Driver v1.10d
Adding Swap: 248968k swap-space (priority -1)
EXT3 FS 2.4-0.9.6, 11 Aug 2001 on ide0(3,6), internal journal
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA330           Rev: 1.51
  Type:   CD-ROM                             ANSI SCSI revision: 02
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
8139too Fast Ethernet driver 0.9.18a
PCI: Enabling device 00:09.0 (0000 -> 0003)
PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try using 
pci=biosirq.
PCI: Setting latency timer of device 00:09.0 to 64
eth0: RealTek RTL8139 Fast Ethernet at 0xd0072000, 00:07:ca:00:25:90, IRQ 0
eth0:  Identified 8139 chip type 'RTL-8139C'
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 13:02:34 Nov 19 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Assigned IRQ 5 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
ip_tables: (c)2000 Netfilter core team
ip_conntrack (1983 buckets, 15864 max)
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by 
other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
Via 686a audio driver 1.1.14b
PCI: Found IRQ 4 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 4
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: timeout while reading AC97 codec (0x800000)
ac97_codec: AC97  codec, id: 0x4144:0x5361 (Unknown)
via82cxxx: board #1 at 0x1000, IRQ 5
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11


Linux 2.4.8-34.1mdk (warm-boot from WinXP)

[root@tux root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)
[root@tux root]# lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
        Flags: bus master, medium devsel, latency 8
        Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 ff ff ff ff
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
        Subsystem: Unknown device 16be:0001
        Flags: medium devsel
        Memory at e8000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        I/O ports at 1800 [disabled] [size=256]
        Capabilities: [60] Power Management version 2
00: 13 18 00 40 00 00 10 02 02 00 80 07 00 00 00 00
10: 00 00 00 e8 01 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 be 16 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1420 [size=16]
        Capabilities: [c0] Power Management version 2
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1400 [size=32]
        Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 14 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
        Flags: medium devsel, IRQ 5
        I/O ports at 1000 [size=256]
        I/O ports at 1434 [size=4]
        I/O ports at 1430 [size=4]
        Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 10 00 00 35 14 00 00 31 14 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 40 18
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 128, IRQ 10
        I/O ports at 1c00 [size=256]
        Memory at 10000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 80 00 00
10: 01 1c 00 00 00 00 00 10 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 10 00 10 a0 00 00 02 00 02 05 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 01 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 20 00 10 a0 00 00 02 00 06 09 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 02 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1831
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [80] AGP version 2.0
00: 33 53 02 8d 07 00 30 02 01 00 00 03 08 40 00 00
10: 00 00 10 e8 08 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 31 18
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 04 ff

[root@tux root]# cat /proc/interrupts
           CPU0
  0:      14745          XT-PIC  timer
  1:        125          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       2913          XT-PIC  usb-uhci, via82cxxx
  8:          1          XT-PIC  rtc
 10:          1          XT-PIC  eth0
 12:       1155          XT-PIC  PS/2 Mouse
 14:       4407          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          0
[root@tux root]# ifconfig eth0
eth0      Lien encap:Ethernet  HWaddr 00:07:CA:00:25:90
          inet adr:192.168.1.2  Bcast:192.168.1.255  Masque:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:4 overruns:0 carrier:0
          collisions:0 lg file transmission:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interruption:10 Adresse de base:0x2000

[root@tux root]# ping -d -c 5 192.168.1.1
PING 192.168.1.1 (192.168.1.1) from 192.168.1.2 : 56(84) bytes of data.
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable

--- 192.168.1.1 ping statistics ---
5 packets transmitted, 0 packets received, +5 errors, 100% packet loss
[root@tux root]# cat /proc/interrupts
           CPU0
  0:      24856          XT-PIC  timer
  1:        432          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       6089          XT-PIC  usb-uhci, via82cxxx
  8:          1          XT-PIC  rtc
 10:          2          XT-PIC  eth0
 12:       1614          XT-PIC  PS/2 Mouse
 14:       4657          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          0
[root@tux root]# ifconfig
eth0      Lien encap:Ethernet  HWaddr 00:07:CA:00:25:90
          inet adr:192.168.1.2  Bcast:192.168.1.255  Masque:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:8 overruns:0 carrier:0
          collisions:0 lg file transmission:100
          RX bytes:769 (769.0 b)  TX bytes:0 (0.0 b)
          Interruption:10 Adresse de base:0x2000

Linux 2.4.10-rc1 (cold-boot)
=============
NOTE: this was run with the Ethernet cable disconnected (I'm on a train right 
now)
[root@tux root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)
[root@tux root]# lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
        Flags: bus master, medium devsel, latency 8
        Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
        Subsystem: Unknown device 16be:0001
        Flags: medium devsel, IRQ 10
        Memory at e8000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        I/O ports at 1800 [disabled] [size=256]
        Capabilities: [60] Power Management version 2
00: 13 18 00 40 00 00 10 02 02 00 80 07 00 00 00 00
10: 00 00 00 e8 01 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 be 16 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1420 [size=16]
        Capabilities: [c0] Power Management version 2
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1400 [size=32]
        Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 14 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
        Flags: medium devsel, IRQ 5
        I/O ports at 1000 [size=256]
        I/O ports at 1434 [size=4]
        I/O ports at 1430 [size=4]
        Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 10 00 00 35 14 00 00 31 14 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 40 18
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 1c00 [size=256]
        Memory at 10000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 1c 00 00 00 00 00 10 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 20 40

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 10 00 10 a0 00 00 02 00 02 05 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 01 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 20 00 10 a0 00 00 02 00 06 09 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 02 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1831
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [80] AGP version 2.0
00: 33 53 02 8d 07 00 30 02 01 00 00 03 08 40 00 00
10: 00 00 10 e8 08 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 31 18
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 04 ff

[root@tux root]# cat /proc/interrupts
           CPU0
  0:       9520          XT-PIC  timer
  1:         87          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       1411          XT-PIC  usb-uhci, via82cxxx
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          1          XT-PIC  eth0
 12:        993          XT-PIC  PS/2 Mouse
 14:       4375          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:       9479
ERR:          5
MIS:          0
[root@tux root]# ifconfig eth0
eth0      Lien encap:Ethernet  HWaddr 00:07:CA:00:25:90
          inet adr:192.168.1.2  Bcast:192.168.1.255  Masque:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 lg file transmission:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interruption:10 Adresse de base:0xa000

[root@tux root]# ping -c 10 192.168.1.1
PING 192.168.1.1 (192.168.1.1) from 192.168.1.2 : 56(84) bytes of data.
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable

--- 192.168.1.1 ping statistics ---
10 packets transmitted, 0 packets received, +10 errors, 100% packet loss
[root@tux root]# cat /proc/interrupts
           CPU0
  0:      17122          XT-PIC  timer
  1:        305          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       4685          XT-PIC  usb-uhci, via82cxxx
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          2          XT-PIC  eth0
 12:        993          XT-PIC  PS/2 Mouse
 14:       4542          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:      17080
ERR:         10
MIS:          0
[root@tux root]# ifconfig eth0
eth0      Lien encap:Ethernet  HWaddr 00:07:CA:00:25:90
          inet adr:192.168.1.2  Bcast:192.168.1.255  Masque:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 lg file transmission:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interruption:10 Adresse de base:0xa000

Linux 2.4.10-rc1 (warm boot from WinXP)
=================================
NOTE: this was also run with the ethernet cable disconnected
[root@tux root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)
[root@tux root]# lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
        Flags: bus master, medium devsel, latency 8
        Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 
4000 (rev 02)
        Subsystem: Unknown device 16be:0001
        Flags: medium devsel, IRQ 10
        Memory at e8000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        I/O ports at 1800 [disabled] [size=256]
        Capabilities: [60] Power Management version 2
00: 13 18 00 40 00 00 10 02 02 00 80 07 00 00 00 00
10: 00 00 00 e8 01 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 be 16 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1420 [size=16]
        Capabilities: [c0] Power Management version 2
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1400 [size=32]
        Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 14 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 50)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
        Flags: medium devsel, IRQ 5
        I/O ports at 1000 [size=256]
        I/O ports at 1434 [size=4]
        I/O ports at 1430 [size=4]
        Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 10 00 00 35 14 00 00 31 14 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 40 18
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at f900 [size=256]
        Memory at fbefbf00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 f9 00 00 00 bf ef fb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 00 00 10 a0 00 00 02 00 02 05 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 01 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
        Flags: bus master, slow devsel, latency 0, IRQ 10
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
00: 17 12 33 69 07 00 10 04 01 00 07 06 00 00 82 00
10: 00 10 00 10 a0 00 00 02 00 06 09 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 0a 02 c0 00
40: 09 15 60 18 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1831
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [80] AGP version 2.0
00: 33 53 02 8d 07 00 30 02 01 00 00 03 08 40 00 00
10: 00 00 10 e8 08 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 15 31 18
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 04 ff

[root@tux root]# cat /proc/interrupts
           CPU0
  0:      12259          XT-PIC  timer
  1:         81          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       2622          XT-PIC  usb-uhci, via82cxxx
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          1          XT-PIC  eth0
 12:       1563          XT-PIC  PS/2 Mouse
 14:       4605          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:      12219
ERR:          7
MIS:          0
[root@tux root]# ifconfig eth0
eth0      Lien encap:Ethernet  HWaddr 00:07:CA:00:25:90
          inet adr:192.168.1.2  Bcast:192.168.1.255  Masque:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 lg file transmission:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interruption:10 Adresse de base:0xaf00

[root@tux root]# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) from 192.168.1.2 : 56(84) bytes of data.
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable
>From 192.168.1.2: Destination Host Unreachable

--- 192.168.1.1 ping statistics ---
10 packets transmitted, 0 packets received, +9 errors, 100% packet loss
[root@tux root]# cat /proc/interrupts
           CPU0
  0:      15544          XT-PIC  timer
  1:        231          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       3224          XT-PIC  usb-uhci, via82cxxx
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          2          XT-PIC  eth0
 12:       1563          XT-PIC  PS/2 Mouse
 14:       4664          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:      15503
ERR:          7
MIS:          0






I hope someone can help, it's so close from working it's terribly annoying to 
have to reboot to WinXP when I want to use this (supported) net device.

Thanks for any advice, I'm willing to conduct other tests if needed.
