Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261931AbTCQUC3>; Mon, 17 Mar 2003 15:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbTCQUC3>; Mon, 17 Mar 2003 15:02:29 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:53676 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S261931AbTCQUB4>; Mon, 17 Mar 2003 15:01:56 -0500
Message-ID: <3E762C30.8040504@bogonomicon.net>
Date: Mon, 17 Mar 2003 14:12:32 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>
Subject: ide-scsi 2.4.21-pre5-ac3 cdrecord failure report
Content-Type: multipart/mixed;
 boundary="------------030801020806060605010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030801020806060605010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I decided to see how broken ide-scsi was for recording.  Here are the 
results.  The system fails consistantly after trying to write about 
126MB of data.  There is a little jitter in the number of bytes written 
but it is within only a 1 MByte spread.  The failure happens in both 
real burning and -dummy write mode and -pre5-ac2.  I have run "hdparm 
-u1" for all drives.  I noticed that system performance goes to nearly 
nil while cdrecord is running.  With this same drive on another system 
it uses less than 5% cpu (system + user), same software versions, 
different kernel.  System performance was so bad the process monitor 
rarely updated while cdrecord was running and when it did nearly 100% of 
the time was system time.  As a side note I noticed that grip will 
consume about 80% system CPU while ripping a disk off the same drive. 
Near the end of burning the read rate plumeted so I moved the test.iso 
image to an otherwise empty partition and had the same results.  I 
included as an attachment the output of cdrecord with the -v and -V 
parameters set.  It is interesting the drive's buffer quickly drops off 
percentage full near the end while cdrecord's own internal buffer is at 
99% full.

I can run other tests later today, but Tewsday I'll be delivering some 
steers to market.

Here is an example output from a cdrecord session:

# cdrecord -eject -dummy -data test.iso
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'TOSHIBA '
Identifikation : 'DVD-ROM SD-R1202'
Revision       : '1026'
Device seems to be: Generic mmc2 DVD-ROM.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R96R
Starting to write CD/DVD at speed 16 in dummy TAO mode for single session.
Last chance to quit, starting dummy write    0 seconds. Operation starts.
cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 FC 5C 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 03 00 00 00 00 0A 00 00 00 00 0C 00 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x00 (write error) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.587s timeout 40s
write track data: error after 132308992 bytes
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00


# dmesg -s 88888
Linux version 2.4.21-pre5-ac3 (root@blip) (gcc version 3.2.1 20020924 
(Debian prerelease)) #2 SMP Wed Mar 12 18:47:39 CST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
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
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 ide0=ata66 
ide1=ata66 pci=biosirq hdg=scsi
ide_setup: ide0=ata66
ide_setup: ide1=ata66
ide_setup: hdg=scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 1737.274 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515464k/524224k available (1473k kernel code, 8368k reserved, 
563k data, 120k init, 0k highmem)
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
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU0: AMD Athlon(tm) XP 2100+ stepping 02
per-CPU timeslice cutoff: 731.30 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1737.2980 MHz.
..... host bus clock speed is 267.2764 MHz.
cpu: 0, clocks: 2672764, slice: 1336382
CPU0<T0:2672752,T1:1336368,D:2,S:1336382,C:2672764>
migration_task 0 on cpu=0
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
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
02:01.0: 3Com PCI 3c905C Tornado 2 at 0xd000. Vers LK1.1.18-ac
  00:26:54:07:f5:82, IRQ 5
   product code ffff rev 00.0 date 15-31-127
   Internal config register is 1600000, transceivers 0x40.
   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
   MII transceiver found at address 2, status 786d.
   Enabling bus-master transmits and whole-frame receives.
02:01.0: scatter/gather enabled. h/w checksums enabled
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unsupported bridge
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 
controller on pci00:09.0
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 01:08.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
PDC20269: IDE controller at PCI slot 01:09.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
     ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
     ide5: BM-DMA at 0xb408-0xb40f, BIOS settings: hdk:pio, hdl:pio
hda: C/H/S=22070/16/255 from BIOS ignored
hda: Maxtor 54610H6, ATA DISK drive
blk: queue c0386380, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 54610H6, ATA DISK drive
blk: queue c03867f8, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 98196H8, ATA DISK drive
blk: queue c0386c70, I/O limit 4095Mb (mask 0xffffffff)
hdg: TOSHIBA DVD-ROM SD-R1202, ATAPI CD/DVD-ROM drive
hdi: Maxtor 4G160J8, ATA DISK drive
blk: queue c0387560, I/O limit 4095Mb (mask 0xffffffff)
hdk: Maxtor 4G160J8, ATA DISK drive
blk: queue c03879d8, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9402 on irq 11
ide3 at 0x9800-0x9807,0x9c02 on irq 11
ide4 at 0xa400-0xa407,0xa802 on irq 10
ide5 at 0xac00-0xac07,0xb002 on irq 10
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, 
UDMA(100)
hdi: attached ide-disk driver.
hdi: host protected area => 1
hdi: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)
hdk: attached ide-disk driver.
hdk: host protected area => 1
hdk: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)
ide-cd: passing drive hdg to ide-scsi emulation.
hdg: attached ide-scsi driver.
Partition check:
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
  hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
  hde: hde1 hde2
  hdi: hdi1 hdi2
  hdk: hdk1 hdk2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-R1202  Rev: 1026
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 0, lun 1
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 0, lun 2
Attached scsi CD-ROM sr3 at scsi0, channel 0, id 0, lun 3
Attached scsi CD-ROM sr4 at scsi0, channel 0, id 0, lun 4
Attached scsi CD-ROM sr5 at scsi0, channel 0, id 0, lun 5
Attached scsi CD-ROM sr6 at scsi0, channel 0, id 0, lun 6
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr4: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr5: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr6: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding Swap: 1999832k swap-space (priority 2)
Adding Swap: 1999832k swap-space (priority 2)
Adding Swap: 530104k swap-space (priority 1)
Adding Swap: 530104k swap-space (priority 1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4191 
Mon Dec  9 11:49:01 PST 2002
PCI: Setting latency timer of device 00:04.0 to 64
Intel 810 + AC97 Audio, version 0.24, 20:41:23 Mar 16 2003
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
usb-ohci.c: USB OHCI at membase 0xe0c0a000, IRQ 5
usb-ohci.c: usb-00:02.0, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF de9eb500, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0c0a000
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
usb.c: hub driver claimed interface de9eb500
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: No IRQ known for interrupt pin B of device 00:02.1.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
Linux video capture interface: v1.00
se401.c: SE401 usb camera driver version 0.23 registering
usb.c: registered new driver se401
  [events: 000000d5]
md: bind<hdc7,1>
  [events: 000000d5]
md: bind<hda7,2>
md: hda7's event counter: 000000d5
md: hdc7's event counter: 000000d5
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda7 operational as mirror 0
raid1: device hdc7 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hda7 [events: 000000d6]<6>(write) hda7's sb offset: 28772736
md: hdc7 [events: 000000d6]<6>(write) hdc7's sb offset: 28772736
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
  [events: 000000a8]
md: bind<hdc6,1>
  [events: 000000a8]
md: bind<hda6,2>
md: hda6's event counter: 000000a8
md: hdc6's event counter: 000000a8
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda6 operational as mirror 0
raid1: device hdc6 operational as mirror 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hda6 [events: 000000a9]<6>(write) hda6's sb offset: 9999744
md: hdc6 [events: 000000a9]<6>(write) hdc6's sb offset: 9999744
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:02.0-1, assigned address 2
usb.c: kmalloc IF de9eb3c0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Product: CABO II
se401.c: SE401 camera found: Kensington VideoCAM 6701(5/7)
se401.c: firmware version: 30
se401.c: ExtraFeatures: 0 Sizes: 160x120 176x144 320x240 352x288 400x300 
640x480
se401.c: registered new video device: video0
usb.c: se401 driver claimed interface de9eb3c0
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
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
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide4(56,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide5(57,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------030801020806060605010903
Content-Type: application/octet-stream;
 name="cdrecord.out.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cdrecord.out.bz2"

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
1p50vbjWtcKqvsVVVVVVVVVVVVVVVVVVfiJRY9bwxsBE3W993+UtfO9dFtX16ta7gIeqAXtZ
RvjTKjptmicYTbKj38jRAJAQLwCbKF6qkEHjxkuy3XXcePPnn9vr6+32AbbbJJJIoAKgXMzP
fh7fPgc87vt7Hfrrr17663bUFVW2ySTMzFtqAbje9+ta1rS0aPekyIAlVZrasgCZpGo9RG4i
IVV9vKqr7X1pVVXpVVVVVVVVVVVXSqqqqqqqqqqqpxrWuHlVVVXevde/J79cff6129efv3nv
p+ZnxuuvLrvM8cEoWYId94qGQhXggDmOJygh1yKAGUKwQQzh/bARaN2kMBd+7nj8fjnmdu34
/H49fX3+360u9725mZ+sjVAAAAG229+3XXXS889vU8xXzmdZnS1tttCRttsmYttskbUMzMze
/nbqN58/I7fbrjjjXXOuNY18KqrrXGtPOuOFVVVVFVVVVVVnHHHDzxrXC9lVVVVVVVVVVVVV
VVVVVVVVzjWtcKviUvmj1qq7EAC31a3l76prWddthdaa/aXREQRqEDvkjllHPvp7s1QMQ6um
kGWIqrR/I9RQQtAS+VvN1QEbttkNNVOOuda1rjX41+Oeeefx+Px+L937FqTMzM3v75mK221A
KySSTW+u6vPPPPnPc9L6fGb38VW2Tp3ve9uYyKgAAADbZmZmb63e/Gta4pvzs41rXHzCFvsF
VVVVVV8ca1rhTTyqq4qqqqqqqqqqqvdVVVWKqqqqqqqqqqq+5zrWuu/2NZY9eX9r713Nc4vj
Wr0wghijFAQHoUoiADZJvYHbEc8ddaR2wnbEezCLnrWtb+y8867fXrbDqK59vtbZMzMWyRkb
bcZI225Ft7679rv53x6273nw6CSZ10OYySRqqqAFuZmYyZjJvfzq6m/W/e5nWMRXOONa0q+F
VVVeFVVVVVVVVVVVVVVVVVVVVXhVVVVVVVVVVdca1rWvk7a+3L39S+y959vGqnbpy46dc235
krllwwOmXGBrKmZDrlB7MiO2BXHfXX5rSPdgeGU3u2qqznpRdR9Ot0/U/NotYlZhP1fAIv4Q
qCQixQUEP2/pj1nzx/PT66F5qrVKn3UTQxihg+rUP05EOM55Przo1++UHWIZiqQffBEKIqVp
+CKmVOz9L+f44Kqb1BNLj6QfU+Wqd3mAeYoET2+0EKKyCoQVVuiCILf8f3S75XZ/H3Z6Z2fx
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
EhjiDlDg
--------------030801020806060605010903--

