Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRDQMZz>; Tue, 17 Apr 2001 08:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDQMZj>; Tue, 17 Apr 2001 08:25:39 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:38148 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132517AbRDQMZX> convert rfc822-to-8bit; Tue, 17 Apr 2001 08:25:23 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: linux-kernel@vger.kernel.org
Subject: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Tue, 17 Apr 2001 14:25:04 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01041714250400.01376@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judging from the thread started Jan 1, 2001, by Andre Hedrick, 
I thought IDE DVD-RAM just works out of the box and got a
Toshiba SD-W2002. 

Problem: /dev/hdc cannot be read or written to when the drive contains
  DVD-RAM media. The behavior is the same for the stock 2.4.3 kernel
  and the SuSE-2.4.0 kernel.  Strangely enough, the disk can be read,
  but not written to, with the 2.2.18 kernel.

Diagnostics:
(1) The hardware is properly connected: mounting CD-ROMs and the SuSE-7.1
    DVD-ROM works.
(2) The drive is recognized at boot time (2.4.3 kernel):
from "/var/log/boot.msg":
<4>ide_setup: idebus=33
<4>ide_setup: ide0=dma
<4>ide_setup: ide0=ata66
<4>ide: Assuming 33MHz system bus speed for PIO modes
<4>AMD7409: IDE controller on PCI bus 00 dev 39
<4>AMD7409: chipset revision 7
<4>AMD7409: not 100%% native mode: will probe irqs later
<4>AMD7409: ATA-66/100 forced bit set (WARNING)!!
<4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: IBM-DTLA-307030, ATA DISK drive
<4>hdc: TOSHIBA DVD-RAM SD-W2002, ATAPI CD/DVD-ROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
<4>hdc: ATAPI 24X DVD-ROM DVDAM drive, 8192kB Cache, DMA
<6>Uniform CD-ROM driver Revision: 3.12

# cat /proc/sys/dev/cdrom/info 
CD-ROM information, Id: cdrom.c 3.12 2000/10/18

drive name:             hdc
drive speed:            0
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         0
Can write CD-RW:        0
Can read DVD:           1
Can write DVD-R:        0
Can write DVD-RAM:      1

# cat /proc/ide/hdc/settings 
name                    value           min             max             mode
----                    -----           ---             ---             ----
breada_readahead        4               0               127             rw
current_speed           34              0               69              rw
dsc_overlap             0               0               1               rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              34              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      127             1               127             rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

(3) the DVD-RAM medium cannot be read from or written to:
# dd if=/dev/hdc of=/dev/null bs=2048 count=8 
0+0 records in
0+0 records out
# dd if=/dev/null of=/dev/hdc bs=2048 count=8 
0+0 records in
0+0 records out
# fdisk /dev/hdc
Unable to read /dev/hdc
# badblocks /dev/hdc
0
1
2
3
4
...
# mke2fs -v -b 2048 -m 0 /dev/hdc
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/hdc: Memory allocation failed while setting up superblock
# mkudf --media-type=dvdram --blocksize=2048 /dev/hdc
7200 (CEST)/-120
mkudf: min blocks=1762

(Just to make sure, I tried 2 different DVD-RAM media.)
______________________________________________________________________________


I am somewhat clueless what to do next.
Are there any experiences with this or other IDE DVD-RAM drives?

Stefan J.


-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
