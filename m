Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285007AbRLFGPE>; Thu, 6 Dec 2001 01:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285006AbRLFGOq>; Thu, 6 Dec 2001 01:14:46 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:19694 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S285001AbRLFGOg>; Thu, 6 Dec 2001 01:14:36 -0500
To: linux-kernel@vger.kernel.org
Subject: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@in.tum.de>
Date: 06 Dec 2001 07:13:13 +0100
Message-ID: <87d71s7u6e.fsf@bitch.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

over the last few days, i've been experiencing lengthy syslog
complaints like the following:

Dec  6 06:33:42 bitch kernel: hdc: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec  6 06:33:42 bitch kernel: hdc: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=1753708, sector=188216
Dec  6 06:33:42 bitch kernel: end_request: I/O error, dev 16:06 (hdc),
sector 188216
Dec  6 06:33:42 bitch kernel: vs-13070: reiserfs_read_inode2: i/o
failure occurred trying to find stat data of [113248 120445 0x0 SD]
Dec  6 06:33:47 bitch kernel: hdc: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec  6 06:33:47 bitch kernel: hdc: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=1753708, sector=188216
Dec  6 06:33:47 bitch kernel: end_request: I/O error, dev 16:06 (hdc),
sector 188216
Dec  6 06:33:47 bitch kernel: vs-13070: reiserfs_read_inode2: i/o
failure occurred trying to find stat data of [113248 120439 0x0 SD]
Dec  6 06:33:52 bitch kernel: hdc: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec  6 06:33:52 bitch kernel: hdc: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=1753708, sector=188216
Dec  6 06:33:52 bitch kernel: end_request: I/O error, dev 16:06 (hdc),
sector 188216
Dec  6 06:33:52 bitch kernel: vs-13070: reiserfs_read_inode2: i/o
failure occurred trying to find stat data of [113248 120449 0x0 SD]
Dec  6 06:33:57 bitch kernel: hdc: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec  6 06:33:57 bitch kernel: hdc: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=1753708, sector=188216
Dec  6 06:33:57 bitch kernel: end_request: I/O error, dev 16:06 (hdc),
sector 188216

always goes on for about 2 minutes, then may disappear for the rest of
the day or longer.

my main question is whether this could be a kernel problem or whether
i just need to hurry a little getting my backups up to date and think
about a new disk.


- linux is 2.4.16 + preemption + buggy nvidia-1.0-2013 modules
- board is an asus p5a, k6-2 550Mhz, Aladdin chipset

thanx,
dns


bitch:/home/dns/src/mcnet/driver# uname -a
Linux bitch 2.4.16 #1 Wed Nov 28 03:18:38 CET 2001 i586 unknown

bitch:/home/dns/src/mcnet/driver# mount
/dev/md1 on / type reiserfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda4 on /boot type ext2 (rw)
/dev/md0 on /var type reiserfs (rw)
/dev/md2 on /home type reiserfs (rw)
/dev/hda3 on /export01 type reiserfs (rw)
/dev/hdc3 on /export02 type reiserfs (rw)
/dev/sda1 on /export03 type reiserfs (rw)
/proc/bus/usb on /proc/bus/usb type usbdevfs (rw)

bitch:/proc/ide# lsmod
Module                  Size  Used by    Tainted: P
ov511                  37476   0
videodev                5120   1  [ov511]
hisax                 137888   3  (autoclean)
isdn                  104800   4  (autoclean) [hisax]
slhc                    4704   1  (autoclean) [isdn]
sd_mod                 10588   2  (autoclean)
ide-scsi                7776   0
ncr53c8xx              52000   1
scsi_mod               91384   3  [sd_mod ide-scsi ncr53c8xx]
eeprom                  3200   0  (unused)
w83781d                17312   0  (unused)
i2c-proc                6176   0  [eeprom w83781d]
i2c-ali15x3             4484   0  (unused)
i2c-core               13288   0  [eeprom w83781d i2c-proc
i2c-ali15x3]
mousedev                4128   1
hid                    13024   0  (unused)
input                   3616   0  [mousedev hid]
usb-ohci               21024   0  (unused)
usbcore                49824   1  [ov511 hid usb-ohci]
rtc                     6360   0  (autoclean)
unix                   17124  11  (autoclean)

bitch:/proc/ide# cat /proc/interrupts
           CPU0
  0:     106679          XT-PIC  timer
  1:       4919          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:        108          XT-PIC  HiSax
  8:          2          XT-PIC  rtc
 10:         71          XT-PIC  ncr53c8xx
 12:       4091          XT-PIC  usb-ohci
 14:      25224          XT-PIC  ide0
 15:      17892          XT-PIC  ide1
NMI:          0
ERR:          0

bitch:/home/dns/src/mcnet/driver# cat /proc/mdstat
Personalities : [raid0]
read_ahead 1024 sectors
md2 : active raid0 hdc7[1] hda7[0]
      31848576 blocks 4k chunks

md0 : active raid0 hdc5[1] hda5[0]
      1049088 blocks 4k chunks

md1 : active raid0 hdc6[1] hda6[0]
      8389376 blocks 4k chunks

unused devices: <none>

bitch:/home/dns/src/mcnet/driver# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 551.273
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 1101.00


bitch:/proc/ide# find . -type f | xargs cat

                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       Off                               Off
both channels togth:  Yes                               Yes
Channel state:        OK                                OK            
Add. Setup Timing:    1T                                1T
Command Act. Count:   8T                                8T
Command Rec. Count:   16T                               16T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      Yes              Yes               Yes              No 
FIFO threshold:    4 Words          4 Words           8 Words          8 Words
FIFO mode:        FIFO Off         FIFO Off          FIFO On          FIFO On 
Dt RW act. Cnt     3T               3T                3T               8T
Dt RW rec. Cnt     1T               1T                1T              16T

-----------------------------------UDMA Timings--------------------------------

UDMA:             OK               No                OK               No
UDMA timings:     2.5T             2.5T              2.5T             1.5T

ide-scsi version 0.9
ide-disk version 1.10
0010 3c01 0000 0000 0000 0000 0000 3202
0000 0000 0000 0000 0000 1803 0000 0000
0000 0000 0000 0004 0000 0000 0000 0000
0000 0505 0000 0000 0000 0000 0000 4307
0000 0000 0000 0000 0000 1408 0000 0000
0000 0000 0000 0009 0000 0000 0000 0000
0000 3c0a 0000 0000 0000 0000 0000 000c
0000 0000 0000 0000 0000 32c0 0000 0000
0000 0000 0000 32c1 0000 0000 0000 0000
0000 00c2 0000 0000 0000 0000 0000 00c4
0000 0000 0000 0000 0000 00c5 0000 0000
0000 0000 0000 00c6 0000 0000 0000 0000
0000 00c7 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 d800
0010 0b01 6400 0064 0000 0000 0000 0502
6400 0064 0000 0000 0000 0703 6100 e561
dc00 0400 0000 1204 6400 2764 0000 0000
0000 3305 6400 0164 0000 0000 0000 0b07
6400 0064 0000 0000 0000 0508 6400 0064
0000 0000 0000 1209 6400 7164 0012 0000
0000 130a 6400 0064 0000 0000 0000 320c
6400 2764 0000 0000 0000 32c0 6400 2764
0000 0000 0000 12c1 6400 2764 0000 0000
0000 02c2 b100 1fb1 0000 0000 0000 32c4
6400 0164 0000 0000 0000 22c5 6400 0164
0000 0000 0000 08c6 6400 0064 0000 0000
0000 0ac7 c800 00c8 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 06e2 1b01
0003 0001 1302 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 2400
physical     59560/16/63
logical      59560/16/63
1916
60036480
name			value		min		max		mode
----			-----		---		---		----
bios_cyl                59560           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
current_speed           66              0               69              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              66              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      127             1               127             rw
multcount               0               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
IBM-DTLA-307030
disk
045a 3fff 37c8 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 2059 4b30
594b 464c 3733 3633 0003 0ef8 0028 5458
344f 4135 3043 4942 4d2d 4454 4c41 2d33
3037 3033 3020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0100 1580 0394 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 001f 0000 0000 0000 0000
003c 0015 74eb 43ea 4000 7469 0002 4000
043f 000d 0000 0000 fffe 600b 80fe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 000b 0001 0000 0000 001b 0000 0000
4000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 61a5
ide-disk version 1.10
pci
ide0
pci bus 00 device 78 vid 10b9 did 5229 channel 1
b9 10 29 52 05 00 80 02 c1 8a 01 01 00 20 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 04
00 00 00 7a 00 00 00 00 00 00 00 4a 00 80 ba 3a
00 00 00 89 00 55 2a 0a 01 00 31 31 01 00 31 00
00 00 1d 00 02 00 01 01 00 00 00 00 08 00 ca ec
e0 07 4f c2 00 00 00 00 21 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1
2147483647
name			value		min		max		mode
----			-----		---		---		----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           34              0               69              rw
ide_scsi                0               0               1               rw
init_speed              34              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  1               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
ASUS CD-S500/A
cdrom
85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5631
2e31 4b20 2020 4153 5553 2043 442d 5335
3030 2f41 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0b00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0407
0003 0078 0078 00e3 0078 0000 0000 0000
0000 0004 0009 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0007 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
ide-scsi version 0.9
0010 3c01 0000 0000 0000 0000 0000 3202
0000 0000 0000 0000 0000 1803 0000 0000
0000 0000 0000 0004 0000 0000 0000 0000
0000 0505 0000 0000 0000 0000 0000 4307
0000 0000 0000 0000 0000 1408 0000 0000
0000 0000 0000 0009 0000 0000 0000 0000
0000 3c0a 0000 0000 0000 0000 0000 000c
0000 0000 0000 0000 0000 32c0 0000 0000
0000 0000 0000 32c1 0000 0000 0000 0000
0000 00c2 0000 0000 0000 0000 0000 00c4
0000 0000 0000 0000 0000 00c5 0000 0000
0000 0000 0000 00c6 0000 0000 0000 0000
0000 00c7 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 d800
0010 0b01 6400 0064 0000 0000 0000 0502
6400 0064 0000 0000 0000 0703 6000 e360
e500 0400 0000 1204 6400 1064 0000 0000
0000 3305 6400 0064 0000 0000 0000 0b07
6400 0064 0000 0000 0000 0508 6400 0064
0000 0000 0000 1209 6400 5464 000e 0000
0000 130a 6400 0064 0000 0000 0000 320c
6400 1064 0000 0000 0000 32c0 6400 1064
0000 0000 0000 12c1 6400 1064 0000 0000
0000 02c2 a600 21a6 0000 0000 0000 32c4
6400 0064 0000 0000 0000 22c5 6400 0064
0000 0000 0000 08c6 6400 0064 0000 0000
0000 0ac7 c800 00c8 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 06e2 1b01
0003 0001 1302 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 b300
physical     59560/16/63
logical      59560/16/63
1916
60036480
name			value		min		max		mode
----			-----		---		---		----
bios_cyl                59560           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
current_speed           66              0               69              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              66              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      127             1               127             rw
multcount               0               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
IBM-DTLA-307030
disk
045a 3fff 37c8 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 2059 4b45
594b 4e4a 3137 3932 0003 0ef8 0028 5458
344f 4136 3841 4942 4d2d 4454 4c41 2d33
3037 3033 3020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0100 1580 0394 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 001f 0000 0000 0000 0000
003c 0015 74eb 43ea 4000 7469 0002 4000
043f 000d 0000 0000 fffe 603b 80fe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 000b 0000 0000 0000 001b 0000 0000
4000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 10a5
ide-disk version 1.10
pci
ide1
pci bus 00 device 78 vid 10b9 did 5229 channel 0
b9 10 29 52 05 00 80 02 c1 8a 01 01 00 20 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 04
00 00 00 7a 00 00 00 00 00 00 00 4a 00 80 ba 3a
00 00 00 89 00 55 2a 0a 01 00 31 31 01 00 31 00
00 00 1d 00 02 00 01 01 00 00 00 00 00 00 ec ec
4f c2 4f c2 00 00 00 00 21 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0


-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de

