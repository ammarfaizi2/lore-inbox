Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUEVVx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUEVVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUEVVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 17:53:56 -0400
Received: from impact.colo.mv.net ([199.125.75.20]:35560 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP id S261443AbUEVVxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 17:53:10 -0400
Message-ID: <40AFCBC0.70807@nerdvest.com>
Date: Sat, 22 May 2004 16:53:04 -0500
From: Bryan Andersen <bryan@nerdvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "R. J. Wysocki" <rjwysocki@sisk.pl>, jgarzik@pobox.com
Subject: Re: 2.6.6-mm4 and failing SATA drive
References: <200405212353.28845.rjwysocki@sisk.pl>
In-Reply-To: <200405212353.28845.rjwysocki@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R. J. Wysocki wrote:
> Hi,
> 
> Seemingly, I'm having a problem with one of my SATA drives.  It is connected 
> via a SII3114 chip (on-board) and worked just fine until a couple of hours 
> ago when I tried to scp ~700 MB of data to it.  Then, the process handling 
> that request hung in a kernel code (ie. became unkillable with -9) and I got 
> this in the log:
> 
> May 21 22:26:31 chimera kernel: ata1: DMA timeout, stat 0x61
> May 21 22:26:31 chimera kernel: ATA: abnormal status 0xD8 on port 
> 0xFFFFFF0000655C87
> May 21 22:26:31 chimera kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: 
> Write (10) 00 03 2a 14 17 00 02 58 00 
> May 21 22:26:31 chimera kernel: Current sdc: sense key Medium Error
> May 21 22:26:31 chimera kernel: Additional sense: Write error - auto 
> reallocation failed
> May 21 22:26:31 chimera kernel: end_request: I/O error, dev sdc, sector 
> 53089303
> May 21 22:26:31 chimera kernel: ATA: abnormal status 0xD8 on port 
> 0xFFFFFF0000655C87
> May 21 22:26:31 chimera last message repeated 2 times

I too have been bitten by this same problem but under kernel 
2.4.27-pre3.  ASUS A7N8X-Deluxe notherboard with 3112 controller. 
Kernel is 2.4.27-pre3 with kraxel bttv patches (patch for 2.4.26 applied 
cleanly with only some line shifts to 2.4.27-pre3).

May 21 23:29:16 blip kernel: ata2: DMA timeout, stat 0x1
May 21 23:29:16 blip kernel: ATA: abnormal status 0x58 on port 0xE09FA0C7
May 21 23:29:16 blip kernel: scsi2: ERROR on channel 0, id 0, lun 0, 
CDB: Write (10) 00 05 28 95 a7 00 00 58 00
May 21 23:29:16 blip kernel: Current sd08:11: sense key Medium Error
May 21 23:29:16 blip kernel: Additional sense indicates Write error - 
auto reallocation failed
May 21 23:29:16 blip kernel:  I/O error: dev 08:11, sector 86545768
May 21 23:29:16 blip kernel: ata1: DMA timeout, stat 0x1
May 21 23:29:16 blip kernel: ATA: abnormal status 0x58 on port 0xE09FA087
May 21 23:29:16 blip kernel: scsi1: ERROR on channel 0, id 0, lun 0, 
CDB: Write (10) 00 05 28 95 bf 00 00 48 00
May 21 23:29:16 blip kernel: Current sd08:01: sense key Medium Error
May 21 23:29:16 blip kernel: Additional sense indicates Write error - 
auto reallocation failed
May 21 23:29:16 blip kernel:  I/O error: dev 08:01, sector 86545792

The system soon locked hard after the error occured.  I was in the 
process of investigating how to reset the RAID partition when the system 
locked up hard.  A thing to note is it looks like both drives in the 
RAID locked up rather than just one or am I reading the error messages 
wrong?  I'll be out for the next few days so I won't be able to reply 
for a few days but will when I get back.

> So, there probably is a hardware problem, but:
> 
> 1) can you, please, tell me what _exactly_ this means,
> 
> 2) after it had happened I was unable to do anything with the partition in 
> question and I couldn't reboot the machine softly (SysRq+S did not work too) 
> so I had to use the red button to get around it (_bad_ thing, IMO).
> 
> Well, I would like the kernel to behave more "nicely" in such cases, if 
> possible.  In other words, there should be a way to get around a failing 
> piece of equipment without rebooting the machine (I know it may be impossible 
> but this is not the case, AFAICS).
> 
> The kernel is a 2.6.6-mm4 and my box is a dual Opteron.
> 
> If you need any more information, just let me know.
> 
> Yours,
> RJW
> 

dmesg -s 999999
Linux version 2.4.27-pre3 (root@blip) (gcc version 3.2.3 (Debian)) #2 
Fri May 21 15:52:16 CDT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
  BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=302 ide0=ata66 ide1=ata66 
acpi=off
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Found and enabled local APIC!
Initializing CPU#0
Detected 2004.553 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3997.69 BogoMIPS
Memory: 515380k/524224k available (1650k kernel code, 8452k reserved, 
642k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2004.5759 MHz.
..... host bus clock speed is 267.2768 MHz.
cpu: 0, clocks: 2672768, slice: 1336384
CPU0<T0:2672768,T1:1336384,D:0,S:1336384,C:2672768>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:01.0: 3Com PCI 3c920 Tornado at 0xd000. Vers LK1.1.18-ac
  00:26:54:07:f5:82, IRQ 10
   product code ffff rev 00.0 date 15-31-127
   Internal config register is 1600000, transceivers 0x40.
   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
   MII transceiver found at address 2, status 786d.
   Enabling bus-master transmits and whole-frame receives.
02:01.0: scatter/gather enabled. h/w checksums enabled
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Setting latency timer of device 00:04.0 to 64
eth1: forcedeth.c: subsystem: 01043:80a7 bound to 00:04.0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 01:08.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
hda: C/H/S=22070/16/255 from BIOS ignored
hda: Maxtor 54610H6, ATA DISK drive
blk: queue c03a6e40, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 54610H6, ATA DISK drive
blk: queue c03a7294, I/O limit 4095Mb (mask 0xffffffff)
hde: CREATIVE DVD-ROM DVD1241E, ATAPI CD/DVD-ROM drive
hdg: Maxtor 6Y160P0, ATA DISK drive
hdh: Maxtor 98196H8, ATA DISK drive
blk: queue c03a7b3c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03a7c78, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa000-0xa007,0xa402 on irq 11
ide3 at 0xa800-0xa807,0xac02 on irq 11
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, 
UDMA(133)
hdh: attached ide-disk driver.
hdh: host protected area => 1
hdh: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, 
UDMA(100)
hde: attached ide-cdrom driver.
hde: ATAPI 40X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
  hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
  hdg: hdg1
  hdh: hdh1 hdh2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 9
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding Swap: 1999832k swap-space (priority 5)
Adding Swap: 1999832k swap-space (priority 5)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xE09FA080 ctl 0xE09FA08A bmdma 0xE09FA000 
irq 11
ata2: SATA max UDMA/100 cmd 0xE09FA0C0 ctl 0xE09FA0CA bmdma 0xE09FA008 
irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors:  lba48
ata1: dev 0 configured for UDMA/100
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors:  lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
scsi2 : sata_sil
   Vendor: ATA       Model: ST3160023AS       Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3160023AS       Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
  sda: sda1
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
  sdb: sdb1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed 
Jan 14 18:29:26 PST 2004
Intel 810 + AC97 Audio, version 1.00, 17:20:22 May 21 2004
PCI: Setting latency timer of device 00:06.0 to 64
i810: NVIDIA nForce Audio found at IO 0xe400 and 0xe000, MEM 0x0000 and 
0x0000, IRQ 11
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value = 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xe0cbd000, IRQ 10
usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF de22f700, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0cbd000
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface de22f700
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xe0cbf000, IRQ 10
usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF de22f980, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0cbf000
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface de22f980
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
Linux video capture interface: v1.00
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 01:09.0, irq: 10, latency: 32, mmio: 0xdc001000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio Pro [card=52,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ffebff [init]
i2c-core.o: adapter bt878 #0 [sw] registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: pinnacle/mt: id=6 info="NTSC / stereo" radio=no
bttv0: using tuner=33
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3425G-B8 +nicam +simple +radio
i2c-core.o: client [MSP3425G-B8] registered to adapter [bt878 #0 
[sw]](pos. 0).
msp3410: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c tda9887 driver registered.
tda9885/6/7: chip found @ 0x86
i2c-core.o: client [tda9887] registered to adapter [bt878 #0 [sw]](pos. 1).
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
tuner: microtune: companycode=4d54 part=04 rev=04
tuner: microtune MT2032 found, OK
i2c-core.o: client [MT20xx universal] registered to adapter [bt878 #0 
[sw]](pos. 2).
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
i2c-core.o: driver generic i2c audio driver registered.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
  [events: 00000293]
md: bind<hdc6,1>
  [events: 00000293]
md: bind<hda6,2>
md: hda6's event counter: 00000293
md: hdc6's event counter: 00000293
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda6 operational as mirror 0
raid1: device hdc6 operational as mirror 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hda6 [events: 00000294]<6>(write) hda6's sb offset: 9999744
md: hdc6 [events: 00000294]<6>(write) hdc6's sb offset: 9999744
  [events: 000002c0]
md: bind<hdc7,1>
  [events: 000002c0]
md: bind<hda7,2>
md: hda7's event counter: 000002c0
md: hdc7's event counter: 000002c0
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda7 operational as mirror 0
raid1: device hdc7 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hda7 [events: 000002c1]<6>(write) hda7's sb offset: 28772736
md: hdc7 [events: 000002c1]<6>(write) hdc7's sb offset: 28772736
  [events: 000000ca]
md: bind<sdb1,1>
  [events: 000000ca]
md: bind<sda1,2>
md: sda1's event counter: 000000ca
md: sdb1's event counter: 000000ca
md: raid0 personality registered as nr 2
md2: max total readahead window set to 496k
md2: 2 data-disks, max readahead per data-disk: 248k
raid0: looking at sda1
raid0:   comparing sda1(156288256) with sda1(156288256)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb1
raid0:   comparing sdb1(156288256) with sda1(156288256)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda1 ... contained as device 0
   (156288256) is smallest!.
raid0: checking sdb1 ... contained as device 1
raid0: zone->nb_dev: 2, size: 312576512
raid0: current zone offset: 156288256
raid0: done.
raid0 : md_size is 312576512 blocks.
raid0 : conf->smallest->size is 312576512 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md2 RAID superblock on device
md: sda1 [events: 000000cb]<6>(write) sda1's sb offset: 156288256
md: sdb1 [events: 000000cb]<6>(write) sdb1's sb offset: 156288256
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide3(34,66), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide3(34,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
bttv0: PLL can sleep, using XTAL (28636363).
spurious 8259A interrupt: IRQ7.
