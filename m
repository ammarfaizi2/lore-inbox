Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUAUWYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUAUWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:24:05 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:35283 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S266129AbUAUWXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:23:34 -0500
Date: Wed, 21 Jan 2004 17:23:20 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: kernel BUG under 2.6.1-mm5
Message-ID: <Pine.GSO.4.58.0401211708090.15123@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am seeing some scary looking kernel bug entries in my dmesg under
2.6.1-mm5.  Its behavior varies.... I first rebooted my machine under
2.6.1-mm5 remotely, and when I got home I found the computer frozen at the
bug screen.

However, I rebooted it, and I saw the bug in dmesg again, but the system
fully booted and was useable this time.

Now, I rebooted for a second time, and the bug shows up twice (!) in my
dmesg.  It definately only showed up once under the last reboot.  Even so,
the boot completed and my computer is useable (I'm typing this e-mail
under 2.6.1-mm5).

Since its the scariest looking, below is the 2 kernel bug reports from my
current boot.  Under that I included my complete dmesg from the previous
boot, then I included alot more configuration information under that.
Please note I did not load the nvidia kernel module until AFTER boot time
(after I encountered these bugs).

thanks,
Jim Faulkner

----------------------------------------------
2 kernel bug entries from current boot
-----------------------------------------------

------------[ cut here ]------------
kernel BUG at fs/dcache.c:760!
invalid operand: 0000 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<c0179627>]    Not tainted VLI
EFLAGS: 00010287
EIP is at d_instantiate+0x17/0x90
eax: f7baf200   ebx: c1b8bac0   ecx: 000021a4   edx: 00000000
esi: f7a4f868   edi: f7baf200   ebp: f7a4f840   esp: f7a79e3c
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 24, threadinfo=f7a78000 task=c1b06d00)
Stack: 00000000 f7a992e4 c1b8bac0 c1b35940 f7a78000 f7a4f840 c01ad6de
f7a4f840
       f7baf200 f7a4f840 f7a41e1c c1bbeb40 00000000 c1b06d00 c011f5b0
00000000
       00000000 f7a96d00 c1b06d00 c011bb7d 00000000 c1b06d00 c011f5b0
00000000
Call Trace:
 [<c01ad6de>] devfs_d_revalidate_wait+0xbe/0x1b0
 [<c011f5b0>] default_wake_function+0x0/0x20
 [<c011bb7d>] do_page_fault+0x32d/0x512
 [<c011f5b0>] default_wake_function+0x0/0x20
 [<c016e868>] do_lookup+0x68/0xb0
 [<c016ede8>] link_path_walk+0x538/0xa30
 [<c016fd03>] open_namei+0x83/0x420
 [<c011b850>] do_page_fault+0x0/0x512
 [<c040d4cb>] error_code+0x2f/0x38
 [<c015e61e>] filp_open+0x3e/0x70
 [<c015eb9b>] sys_open+0x5b/0x90
 [<c040c992>] sysenter_past_esp+0x43/0x65

Code: 31 c0 e9 5b ff ff ff 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 57 56
53 83 ec 08 8b 6c 24 1c 8b 7c 24 20 8d 75 28 39 75 28 74 08 <0f> 0b f8 02
96 6e 42 c0 bb 00 e0 ff ff 21 e3 ff 43 14 31 c0 86
 ------------[ cut here ]------------
kernel BUG at fs/dcache.c:760!
invalid operand: 0000 [#2]
PREEMPT SMP
CPU:    0
EIP:    0060:[<c0179627>]    Not tainted VLI
EFLAGS: 00010283
EIP is at d_instantiate+0x17/0x90
eax: f7baecc0   ebx: c1b20340   ecx: 000021b6   edx: 00000000
esi: f7a4f7a8   edi: f7baecc0   ebp: f7a4f780   esp: f7a65e3c
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 25, threadinfo=f7a64000 task=f7a67980)
Stack: 00000000 f7ab84a4 c1b20340 c1b35940 f7a64000 f7a4f780 c01ad6de
f7a4f780
       f7baecc0 f7a4f780 f7a3fe1c c1bbeb40 00000000 f7a67980 c011f5b0
00000000
       00000000 f7a963c0 f7a67980 c011bb7d 00000000 f7a67980 c011f5b0
00000000
Call Trace:
 [<c01ad6de>] devfs_d_revalidate_wait+0xbe/0x1b0
 [<c011f5b0>] default_wake_function+0x0/0x20
 [<c011bb7d>] do_page_fault+0x32d/0x512
 [<c011f5b0>] default_wake_function+0x0/0x20
 [<c016e868>] do_lookup+0x68/0xb0
 [<c016ede8>] link_path_walk+0x538/0xa30
 [<c016fd03>] open_namei+0x83/0x420
 [<c011b850>] do_page_fault+0x0/0x512
 [<c040d4cb>] error_code+0x2f/0x38
 [<c015e61e>] filp_open+0x3e/0x70
 [<c015eb9b>] sys_open+0x5b/0x90
 [<c040c992>] sysenter_past_esp+0x43/0x65

Code: 31 c0 e9 5b ff ff ff 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 57 56
53 83 ec 08 8b 6c 24 1c 8b 7c 24 20 8d 75 28 39 75 28 74 08 <0f> 0b f8 02
96 6e 42 c0 bb 00 e0 ff ff 21 e3 ff 43 14 31 c0 86

------------------------------------------
complete dmesg output from previous boot
-----------------------------------------
98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:0D:61:0C:1C:FE, IRQ 169.
  Board assembly a30469-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
8139too Fast Ethernet driver 0.9.27
eth1: RealTek RTL8139 at 0xf8818000, 00:50:ba:b7:d8:c3, IRQ 177
eth1:  Identified 8139 chip type 'RTL-8139C'
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:02:06.0, irq: 185, latency: 32, mmio:
0xf5000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fffffb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=38061, tuner=Philips FI1236 MK2 (2),
radio=no
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z
ir-kbd-i2c: i2c IR (Hauppauge) detected at i2c-0/0-0018/ir0
tuner: chip found @ 0xc2
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-32EVA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 96147H8, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20276: IDE controller at PCI slot 0000:02:08.0
PDC20276: chipset revision 1
PDC20276: 100% native mode on irq 185
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD1200JB-32EVA0, ATA DISK drive
ide2 at 0xb000-0xb007,0xb402 on irq 185
hdg: WDC WD450AA-00BAA0, ATA DISK drive
hdh: WDC WD200BB-75AUA1, ATA DISK drive
ide3 at 0xb800-0xb807,0xbc02 on irq 185
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1
hdc: max request size: 128KiB
hdc: 120060864 sectors (61471 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1
hde: max request size: 1024KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1
hdg: max request size: 128KiB
hdg: 87930864 sectors (45020 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(66)
 /dev/ide/host2/bus1/target0/lun0: p1
hdh: max request size: 128KiB
hdh: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63,
UDMA(100)
 /dev/ide/host2/bus1/target1/lun0: p1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 16)
  Vendor: SEAGATE   Model: ST39102LW         Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1010
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: GENERIC   Model: CRD-BP5           Rev: 7.42
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
(scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: WDIGTL    Model: WDE18310 ULTRA2   Rev: 1.30
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: FUJITSU   Model: MAN3367MP         Rev: 2601
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
st: Version 20031228, fixed bufsize 32768, s/g segs 256
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35761710 512-byte hdwr sectors (18310 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 71771688 512-byte hdwr sectors (36747 MB)
SCSI device sdc: drive cache: write back
 /dev/scsi/host1/bus0/target2/lun0: p1
Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg4 at scsi1, channel 0, id 2, lun 0,  type 0
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:02:00.0: OHCI Host Controller
ohci_hcd 0000:02:00.0: irq 193, pci mem f8832000
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
gameport: pci0000:02:04.1 speed 903 kHz
serio: i8042 AUX port at 0x60,0x64 irq 12
atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 1.0.1 (Tue Dec 30
10:04:14 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
hub 1-0:1.0: new USB device on port 2, assigned address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
ALSA device list:
  #0: Sound Blaster Live! (rev.7) at 0xa000, irq 169
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 304 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdh1 ...
md:  adding hdh1 ...
md:  adding hdg1 ...
md: hde1 has different UUID to hdh1
md: hdc1 has different UUID to hdh1
md: hda1 has different UUID to hdh1
md: created md0
md: bind<hdg1>
md: bind<hdh1>
md: running: <hdh1><hdg1>
md: considering hde1 ...
md:  adding hde1 ...
md: hdc1 has different UUID to hde1
md:  adding hda1 ...
md: created md1
md: bind<hda1>
md: bind<hde1>
md: running: <hde1><hda1>
md1: setting max_sectors to 16, segment boundary to 4095
raid0: looking at hde1
raid0:   comparing hde1(117218176) with hde1(117218176)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hda1
raid0:   comparing hda1(117218176) with hde1(117218176)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 234436352 blocks.
raid0 : conf->hash_spacing is 234436352 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: considering hdc1 ...
md:  adding hdc1 ...
md: created md2
md: bind<hdc1>
md: running: <hdc1>
md2: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid0: looking at hdc1
raid0:   comparing hdc1(60026752) with hdc1(60026752)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: FINAL 1 zones
raid0: too few disks (1 of 2) - aborting!
md: pers->run() failed ...
md :do_md_run() returned -22
md: md2 stopped.
md: unbind<hdc1>
md: export_rdev(hdc1)
md: ... autorun DONE.
found reiserfs format "3.6" with standard journal
hub 1-2:1.0: new USB device on port 3, assigned address 3
input: USB HID v1.00 Keyboard [Mitsumi Electric Mitsumi USB Keyboard] on
usb-0000:02:00.0-2.3
Reiserfs journal params: device sda2, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda2) for (sda2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 204k freed
hub 1-2:1.0: new USB device on port 4, assigned address 4
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with
IntelliEye(TM)] on usb-0000:02:00.0-2.4
------------[ cut here ]------------
kernel BUG at fs/dcache.c:760!
invalid operand: 0000 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<c0179627>]    Not tainted VLI
EFLAGS: 00010287
EIP is at d_instantiate+0x17/0x90
eax: f7baf200   ebx: c1b8bac0   ecx: 000021a4   edx: 00000000
esi: f7a47868   edi: f7baf200   ebp: f7a47840   esp: f7a65e3c
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 25, threadinfo=f7a64000 task=f7a67980)
Stack: f7a7eec0 f7a992e4 c1b8bac0 c1b35940 f7a64000 f7a47840 c01ad6de
f7a47840
       f7baf200 f7a47840 f7a41e1c c1bbeb40 00000000 f7a67980 c011f5b0
00000000
       00000000 f7a96c40 f7a67980 c011bb7d 00000000 f7a67980 c011f5b0
00000000
Call Trace:
 [<c01ad6de>] devfs_d_revalidate_wait+0xbe/0x1b0
 [<c011f5b0>] default_wake_function+0x0/0x20
 [<c011bb7d>] do_page_fault+0x32d/0x512
 [<c011f5b0>] default_wake_function+0x0/0x20
 [<c016e868>] do_lookup+0x68/0xb0
 [<c016ede8>] link_path_walk+0x538/0xa30
 [<c016fd03>] open_namei+0x83/0x420
 [<c011b850>] do_page_fault+0x0/0x512
 [<c040d4cb>] error_code+0x2f/0x38
 [<c015e61e>] filp_open+0x3e/0x70
 [<c015eb9b>] sys_open+0x5b/0x90
 [<c040c992>] sysenter_past_esp+0x43/0x65

Code: 31 c0 e9 5b ff ff ff 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 57 56
53 83 ec 08 8b 6c 24 1c 8b 7c 24 20 8d 75 28 39 75 28 74 08 <0f> 0b f8 02
96 6e 42 c0 bb 00 e0 ff ff 21 e3 ff 43 14 31 c0 86
 <6>Adding 2008084k swap on /dev/sda1.  Priority:-1 extents:1
md: autorun ...
md: considering md0 ...
md:  adding md0 ...
md:  adding hdc1 ...
md: created md2
md: bind<hdc1>
md: bind<md0>
md: running: <md0><hdc1>
md2: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid0: looking at md0
raid0:   comparing md0(63512640) with md0(63512640)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc1
raid0:   comparing hdc1(60026752) with md0(63512640)
raid0:   NOT EQUAL
raid0:   comparing hdc1(60026752) with hdc1(60026752)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hdc1 ... nope.
raid0: checking md0 ... contained as device 0
  (63512640) is smallest!.
raid0: zone->nb_dev: 1, size: 3485888
raid0: current zone offset: 63512640
raid0: done.
raid0 : md_size is 123539392 blocks.
raid0 : conf->hash_spacing is 120053504 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sdb1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sdb1) for (sdb1)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sdc1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sdc1) for (sdc1)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md1) for (md1)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md2, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md2) for (md2)
Using r5 hash to sort names
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 02:06.1, irq: 185, latency: 32, mmio:
0xf5001000
btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 760MP chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xe0000000
process `named' is using obsolete setsockopt SO_BSDCOMPAT
request_module: failed /sbin/modprobe -- ppp0. error = 256
blk: queue f7de4200, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7db3a00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7db3200, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7da6a00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7da6600, I/O limit 4095Mb (mask 0xffffffff)
eth1: link up, 10Mbps, half-duplex, lpa 0x0000
delta-9 root #

-------------------------------------------------
alot more configuration information
------------------------------------------------

delta-9 linux # scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux delta-9 2.6.1-mm5 #1 SMP Wed Jan 21 15:59:08 EST 2004 i686 AMD
Athlon(tm) MP 2200+ AuthenticAMD GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.12
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         nvidia ipt_LOG amd_k7_agp agpgart btaudio

delta-9 linux # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2200+
stepping        : 1
cpu MHz         : 1800.303
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3547.13

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 1800.303
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3596.28

delta-9 linux # cat /proc/modules
nvidia 2071816 12 - Live 0xf92a4000
ipt_LOG 5760 1 - Live 0xf8dcc000
amd_k7_agp 7820 1 - Live 0xf8d6d000
agpgart 32748 2 amd_k7_agp, Live 0xf8d78000
btaudio 17488 1 - Live 0xf8d67000

delta-9 linux # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
a000-cfff : PCI Bus #02
  a000-a01f : 0000:02:04.0
    a000-a01f : EMU10K1
  a400-a407 : 0000:02:04.1
    a400-a407 : emu10k1-gp
  a800-a8ff : 0000:02:05.0
    a800-a8ff : 8139too
  ac00-ac3f : 0000:02:07.0
    ac00-ac3f : eepro100
  b000-b007 : 0000:02:08.0
    b000-b007 : ide2
  b400-b403 : 0000:02:08.0
    b402-b402 : ide2
  b800-b807 : 0000:02:08.0
    b800-b807 : ide3
  bc00-bc03 : 0000:02:08.0
    bc02-bc02 : ide3
  c000-c00f : 0000:02:08.0
    c000-c007 : ide2
    c008-c00f : ide3
e000-e0ff : 0000:00:09.0
e400-e4ff : 0000:00:09.1
e800-e803 : 0000:00:00.0
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

delta-9 linux # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d55ff : Extension ROM
000d6000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0040d68b : Kernel code
  0040d68c-0052793f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
e0000000-e7ffffff : 0000:00:00.0
e8000000-efffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:05.0
f0000000-f1ffffff : PCI Bus #01
  f0000000-f0ffffff : 0000:01:05.0
f3000000-f4ffffff : PCI Bus #02
  f4000000-f401ffff : 0000:02:07.0
  f4020000-f4023fff : 0000:02:08.0
  f4024000-f4024fff : 0000:02:00.0
    f4024000-f4024fff : ohci_hcd
  f4025000-f40250ff : 0000:02:05.0
    f4025000-f40250ff : 8139too
  f4026000-f4026fff : 0000:02:07.0
    f4026000-f4026fff : eepro100
f5000000-f50fffff : PCI Bus #02
  f5000000-f5000fff : 0000:02:06.0
    f5000000-f5000fff : bttv0
  f5001000-f5001fff : 0000:02:06.1
    f5001000-f5001fff : btaudio
f5100000-f5100fff : 0000:00:09.1
  f5100000-f5100fff : aic7xxx
f5101000-f5101fff : 0000:00:09.0
  f5101000-f5101fff : aic7xxx
f5102000-f5102fff : 0000:00:00.0
fec00000-ffffffff : reserved

delta-9 linux # lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at f5102000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e800 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW+
Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP
Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev
05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
(rev 04) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev
01)
        Subsystem: Adaptec AHA-3960D U160/m
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 177
        BIST result: 00
        Region 0: I/O ports at e000 [disabled] [size=256]
        Region 1: Memory at f5101000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev
01)
        Subsystem: Adaptec AHA-3960D U160/m
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 185
        BIST result: 00
        Region 0: I/O ports at e400 [disabled] [size=256]
        Region 1: Memory at f5100000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev
05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: f3000000-f4ffffff
        Prefetchable memory behind bridge: f5000000-f50fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV15GL [Quadro2 Pro]
(rev a4) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 006d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW+
Rate=x4

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
(rev 07) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 193
        Region 0: Memory at f4024000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at a400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
        Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at f4025000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f5000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f5001000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at f4026000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at ac00 [size=64]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:08.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev
01) (prog-if 85)
        Subsystem: Giga-byte Technology: Unknown device b001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at b000 [size=8]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=16]
        Region 5: Memory at f4020000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



