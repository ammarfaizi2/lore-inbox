Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135249AbRDRSwL>; Wed, 18 Apr 2001 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbRDRSwB>; Wed, 18 Apr 2001 14:52:01 -0400
Received: from [62.81.160.203] ([62.81.160.203]:6286 "EHLO smtp3.eresmas.com")
	by vger.kernel.org with ESMTP id <S135254AbRDRSvV>;
	Wed, 18 Apr 2001 14:51:21 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Manuel Ignacio Monge Garcia <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: ATA 100 & VIA and linux-2.4.3ac8
Date: Wed, 18 Apr 2001 20:50:53 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041820505300.01783@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi. I have a ASUS A7V133 Motherboard  with AMD ThinderBird 1 Ghz, and 
PDC20265/VIA. I've tried all the possible combinations on "IDE, ATA and ATAPI 
Block devices". I've read the "Unofficial Asus A7V and Linux ATA100 
"Quasi-Mini-Howto" on http://www.geocities.com/ender7007/. But I still can't 
use de IDE UDMA100 controler. I see some messages with this options on 
earlier version of the ac-kernel, so I guess what I need to do the right 
thing. My current kernel is 2.4.3-ac9.
Some settings:

a) "IDE, ATA and ATAPI Block devices" config in the kernel:
	CONFIG_IDE=y 
	CONFIG_BLK_DEV_IDEDISK=y
	CONFIG_BLK_DEV_IDECD=y
	CONFIG_BLK_DEV_IDEFLOPPY=y
	CONFIG_BLK_DEV_IDESCSI=y
	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_BLK_DEV_IDEDMA=y
	CONFIG_BLK_DEV_PDC202XX=y
	CONFIG_BLK_DEV_VIA82CXXX=y
	CONFIG_IDEDMA_AUTO=y
	CONFIG_IDEDMA_IVB=y
	CONFIG_BLK_DEV_IDE_MODES=y

b) cat /proc/ide/via output:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xb800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        DMA      UDMA       PIO       PIO
Address Setup:       30ns      30ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns      90ns     330ns     330ns
Data Recovery:       30ns      30ns     270ns     270ns
Cycle Time:         120ns      60ns     600ns     600ns
Transfer Rate:   16.5MB/s  33.0MB/s   3.3MB/s   3.3MB/s

c) Dmesg output:
Linux version 2.4.3-ac9 (root@localhost.localdomain) (gcc version 2.96 
20000731 (Linux-Mandrake 8.0 2.96-0.47mdk)) #6 mié abr 18 19:49:06 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98284
zone(0): 4096 pages.
zone(1): 94188 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=devel ro root=2102 hda=ide-scsi 
x86_serial_nr=1 bios=0x80ide_setup: hda=ide-scsi
Initializing CPU#0
Detected 1009.001 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2011.95 BogoMIPS
Memory: 384404k/393136k available (975k kernel code, 8340k reserved, 274k 
data, 208k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1009.0055 MHz.
..... host bus clock speed is 201.8011 MHz.
cpu: 0, clocks: 2018011, slice: 1009005
CPU0<T0:2018000,T1:1008992,D:3,S:1009005,C:2018011>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Applying VIA PCI latency patch.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 255234kB/124162kB, 768 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PCI: The same IRQ used for device 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:DMA
hda: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
hde: ST330621A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x8800-0x8807,0x8402 on irq 10
hde: 58633344 sectors (30020 MB) w/512KiB Cache, CHS=58168/16/63, UDMA(100)
hdb: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: [PTBL] [3649/255/63] hde1 hde2 hde3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
[drm] Initialized r128 2.1.2 20001215 on minor 63
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W8432T  Rev: 1.09
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 128516k swap-space (priority -1)
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.57 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:11.0
bttv0: Bt848 (rev 18) at 00:0b.0, irq: 10, latency: 32, memory: 0xdb000000
bttv0: model: BT848A( *** UNKNOWN *** ) [autodetected]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0x60
bttv0: i2c attach [(unset)]
i2c-core.o: client [(unset)] registered to adapter [bt848 #0](pos. 0).
ip_tables: (c)2000 Netfilter core team
ip_conntrack (3071 buckets, 24568 max)
es1371: version v0.30 time 18:59:37 Apr 18 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
PCI: Found IRQ 5 for device 00:0a.0
es1371: found es1371 rev 2 at io 0x9400 irq 5
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
spurious 8259A interrupt: IRQ7.
VFS: Disk change detected on device fd(2,0)
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
VFS: Disk change detected on device sr(11,0)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
mtrr: no MTRR for dc000000,2000000 found
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
lp0: using parport0 (polling).

(See the "spurious 8259A interrupt: IRQ7." line)

d) My lilo.conf:

boot=/dev/hde
map=/boot/map
install=/boot/boot.b
vga=normal
default=linux
keytable=/boot/es-latin1.klt
lba32
prompt
timeout=50
append="hda=ide-scsi hdb=ide-scsi"
message=/boot/message-graphic
menu-scheme=wb:bw:wb:bw

image=/vmlinuz
        label=devel
        root=/dev/hde2
        read-only
other=/dev/hde1
        label=windows
        table=/dev/hde
 
image=/boot/vmlinuz-2.4.3-20mdk
        label=linux
        root=/dev/hde2
        read-only

	
	Thanks a lot for your comments.

	Ignacio.
	
