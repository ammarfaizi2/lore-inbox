Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTDUOSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbTDUOST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:18:19 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:39948 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S261301AbTDUORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:17:48 -0400
Date: Mon, 21 Apr 2003 16:29:19 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, alan@redhat.com
Subject: 2.5.68, acpi/apic and the VT6102 network problem
Message-ID: <20030421142919.GA906@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are some more data-points for the VT6102 network controller not
working with a local IOAPIC.

I have an Epox 8K9A3+ motherboard, with VIA KT400 chipset and a VT6102
network chip on-board.

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c860 (rev 13)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

In the following table, 'works' means the system works allright, and the
VT6102 functions fine.

(1) 2.5.68 + apm + local ioapic: boots & works
(2) 2.5.68 + acpi + local ioapic: boots, doesn't work
(3) 2.5.68 + acpi + no local ioapic: doesn't boot, hangs just after

ide1 at 0x170-0x177,0x376 on irq 15
^^^^^^^^^^^^^ it hangs just after this line.
it would continue like this (with the working kernels):
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)

I'll attach the 2 dmesg outputs, one of (1) as dmesg_2568_apm_apic.txt
and of on (2) as dmesg_2568_acpi_apic.txt.

I've cc'ed Jeff and Alan because they seemed to be interested in this
VT6102 problem.

If there's any information anybody wants, lspci -xxxxx or whatever,
just let me know.

Kind regards,
Jurriaan
-- 
When you become used to never being alone, you may consider
yourself Americanized.
Debian (Unstable) GNU/Linux 2.5.68 3940 bogomips load av: 1.51 1.02 0.46

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_2568_apm_apic.txt"

Linux version 2.5.68 (root@middle) (gcc version 3.2.3 20030415 (Debian prerelease)) #1 Mon Apr 21 10:17:44 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5aa0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 video=matroxfb:vesa:0x11E,fv:85 hdb=scsi
ide_setup: hdb=scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2000.474 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3940.35 BogoMIPS
Memory: 1032948k/1048512k available (2580k kernel code, 14620k reserved, 863k data, 412k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-20 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 001 01  1    1    0   1   0    1    1    A1
 13 001 01  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    B1
 16 001 01  1    1    0   1   0    1    1    B9
 17 001 01  1    1    0   1   0    1    1    C1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.0128 MHz.
..... host bus clock speed is 333.0354 MHz.
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I13,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 17
PCI->APIC IRQ transform: (B0,I14,P0) -> 17
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 21
PCI->APIC IRQ transform: (B0,I17,P0) -> 22
PCI->APIC IRQ transform: (B0,I17,P2) -> 22
PCI->APIC IRQ transform: (B0,I18,P0) -> 23
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages
Journalled Block Device driver loaded
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
PCI: Via IRQ fixup for 00:10.1, from 10 to 5
PCI: Via IRQ fixup for 00:10.2, from 11 to 5
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD0000000, mapped to 0xf8805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX frame buffer device
pty: 1024 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT400 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xd6002000, 00:04:61:02:0e:ea, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xd000-0xd007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xd008-0xd00f, BIOS settings: hdk:pio, hdl:pio
hde: WDC WD800JB-00CRA1, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 17
hdi: WDC WD800JB-00CRA1, ATA DISK drive
ide4 at 0xc000-0xc007,0xc402 on irq 17
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hdb: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 4G120J6, ATA DISK drive
hdd: Maxtor 4G120J6, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hde: hde1 hde2
hdi: host protected area => 1
hdi: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hdi: hdi1 hdi2
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: host protected area => 1
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
 hdc: hdc1 hdc2
hdd: host protected area => 1
hdd: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
 hdd: hdd1 hdd2
ide-cd: passing drive hdb to ide-scsi emulation.
scsi HBA driver sym53c8xx didn't set a release method, please fix the template
sym.0.10.0: setting PCI_COMMAND_PARITY...
sym.0.10.0: setting PCI_COMMAND_INVALIDATE.
sym0: <860> rev 0x13 on pci bus 0 device 10 function 0 irq 18
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20030413, fixed bufsize 32768, s/g segs 256
sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sym0:5: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
sr3: scsi3-mmc drive: 255x/48x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3020.000 MB/sec
   8regs_prefetch:  2748.000 MB/sec
   32regs    :  1980.000 MB/sec
   32regs_prefetch:  1788.000 MB/sec
   pIII_sse  :  5332.000 MB/sec
   pII_mmx   :  5296.000 MB/sec
   p5_mmx    :  7080.000 MB/sec
raid5: using function: pIII_sse (5332.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 00:11.5 to 64
ALSA device list:
  #0: VIA 8235 at 0xe400, irq 22
  #1: Sound Blaster Live! (rev.7) at 0xa400, irq 19
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdi2 ...
md:  adding hdi2 ...
md: hdi1 has different UUID to hdi2
md:  adding hde2 ...
md: hde1 has different UUID to hdi2
md: created md1
md: bind<hde2>
md: bind<hdi2>
md: running: <hdi2><hde2>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdi2
raid0:   comparing hdi2(17670656) with hdi2(17670656)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde2
raid0:   comparing hde2(17670656) with hdi2(17670656)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 35341312 blocks.
raid0 : conf->smallest->size is 35341312 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering hdi1 ...
md:  adding hdi1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdi1>
md: running: <hdi1><hde1>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdi1
raid0:   comparing hdi1(60479872) with hdi1(60479872)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(60479872) with hdi1(60479872)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 120959744 blocks.
raid0 : conf->smallest->size is 120959744 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 412k freed
Adding 2000368k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,8), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,6), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,5), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,5)) for (ide0(3,5))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,10), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,10)) for (ide0(3,10))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,0), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,0)) for (md(9,0))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,1)) for (md(9,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,1)) for (ide1(22,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,2)) for (ide1(22,2))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,65), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,65)) for (ide1(22,65))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,66), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,66)) for (ide1(22,66))
Using r5 hash to sort names
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_2568_acpi_apic.txt"

Linux version 2.5.68 (root@middle) (gcc version 3.2.3 20030415 (Debian prerelease)) #1 Mon Apr 21 15:58:19 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5aa0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
ACPI: RSDP (v000 KT400                      ) @ 0x000f74a0
ACPI: RSDT (v001 KT400  AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 KT400  AWRDACPI 16944.11825) @ 0x3fff3040
ACPI: MADT (v001 KT400  AWRDACPI 16944.11825) @ 0x3fff71c0
ACPI: DSDT (v001 KT400  AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x1])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 video=matroxfb:vesa:0x11E,fv:85 hdb=scsi
ide_setup: hdb=scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2000.474 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3940.35 BogoMIPS
Memory: 1032680k/1048512k available (2771k kernel code, 14888k reserved, 952k data, 420k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.0276 MHz.
..... host bus clock speed is 333.0379 MHz.
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030328
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................
Table [DSDT] - 523 Objects with 49 Devices 140 Methods 28 Regions
ACPI Namespace successfully loaded at root c05315dc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at 0000000000004020 on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x0F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L03 as GPE number 0x03
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L05 as GPE number 0x05
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L08 as GPE number 0x08
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L09 as GPE number 0x09
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0E as GPE number 0x0E
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0A as GPE number 0x0A
Executing all Device _STA and_INI methods:.................................................
49 Devices found containing: 49 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................................
Initialized 23/28 Regions 11/13 Fields 19/20 Buffers 18/18 Packages (523 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
pci_link-0256 [17] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
pci_link-0256 [19] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
pci_link-0256 [21] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
pci_link-0256 [23] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
pci_link-0256 [21] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
pci_link-0256 [22] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
pci_link-0256 [23] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
pci_link-0256 [24] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:08[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:08[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:08[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:08[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
ACPI: No IRQ known for interrupt pin A of device 00:10.0
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.1
ACPI: No IRQ known for interrupt pin B of device 00:10.1
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.2
ACPI: No IRQ known for interrupt pin C of device 00:10.2
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.3
ACPI: No IRQ known for interrupt pin D of device 00:10.3
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.1
ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.5
ACPI: No IRQ known for interrupt pin C of device 00:11.5
pci_link-0502 [24] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [23] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:12.0
ACPI: No IRQ known for interrupt pin A of device 00:12.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages
Journalled Block Device driver loaded
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (47 C)
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD0000000, mapped to 0xf8811000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX frame buffer device
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT400 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
pci_link-0502 [23] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [22] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [22] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:12.0
ACPI: No IRQ known for interrupt pin A of device 00:12.0
eth0: VIA VT6102 Rhine-II at 0xd6002000, 00:04:61:02:0e:ea, IRQ 5.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xd000-0xd007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xd008-0xd00f, BIOS settings: hdk:pio, hdl:pio
hde: WDC WD800JB-00CRA1, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 17
hdi: WDC WD800JB-00CRA1, ATA DISK drive
ide4 at 0xc000-0xc007,0xc402 on irq 17
VP_IDE: IDE controller at PCI slot 00:11.1
pci_link-0502 [23] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [22] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [22] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.1
ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hdb: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 4G120J6, ATA DISK drive
hdd: Maxtor 4G120J6, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hde: hde1 hde2
hdi: host protected area => 1
hdi: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hdi: hdi1 hdi2
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: host protected area => 1
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
 hdc: hdc1 hdc2
hdd: host protected area => 1
hdd: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
 hdd: hdd1 hdd2
ide-cd: passing drive hdb to ide-scsi emulation.
scsi HBA driver sym53c8xx didn't set a release method, please fix the template
sym.0.10.0: setting PCI_COMMAND_PARITY...
sym.0.10.0: setting PCI_COMMAND_INVALIDATE.
sym0: <860> rev 0x13 on pci bus 0 device 10 function 0 irq 18
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20030413, fixed bufsize 32768, s/g segs 256
sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sym0:5: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
sr3: scsi3-mmc drive: 255x/48x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2840.000 MB/sec
   8regs_prefetch:  2748.000 MB/sec
   32regs    :  1980.000 MB/sec
   32regs_prefetch:  1788.000 MB/sec
   pIII_sse  :  5328.000 MB/sec
   pII_mmx   :  5296.000 MB/sec
   p5_mmx    :  7044.000 MB/sec
raid5: using function: pIII_sse (5328.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
pci_link-0502 [23] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [22] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [22] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.5
ACPI: No IRQ known for interrupt pin C of device 00:11.5
PCI: Setting latency timer of device 00:11.5 to 64
ALSA device list:
  #0: VIA 8235 at 0xe400, irq 11
  #1: Sound Blaster Live! (rev.7) at 0xa400, irq 19
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdi2 ...
md:  adding hdi2 ...
md: hdi1 has different UUID to hdi2
md:  adding hde2 ...
md: hde1 has different UUID to hdi2
md: created md1
md: bind<hde2>
md: bind<hdi2>
md: running: <hdi2><hde2>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdi2
raid0:   comparing hdi2(17670656) with hdi2(17670656)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde2
raid0:   comparing hde2(17670656) with hdi2(17670656)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 35341312 blocks.
raid0 : conf->smallest->size is 35341312 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering hdi1 ...
md:  adding hdi1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdi1>
md: running: <hdi1><hde1>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdi1
raid0:   comparing hdi1(60479872) with hdi1(60479872)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(60479872) with hdi1(60479872)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 120959744 blocks.
raid0 : conf->smallest->size is 120959744 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 420k freed
Adding 2000368k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,8), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,6), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,5), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,5)) for (ide0(3,5))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,10), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,10)) for (ide0(3,10))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,0), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,0)) for (md(9,0))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,1)) for (md(9,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,1)) for (ide1(22,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,2)) for (ide1(22,2))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,65), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,65)) for (ide1(22,65))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,66), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,66)) for (ide1(22,66))
Using r5 hash to sort names
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

--9amGYk9869ThD9tj--
