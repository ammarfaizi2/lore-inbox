Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285454AbRLSUTv>; Wed, 19 Dec 2001 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285466AbRLSUTc>; Wed, 19 Dec 2001 15:19:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44016 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285454AbRLSURK>; Wed, 19 Dec 2001 15:17:10 -0500
Date: Wed, 19 Dec 2001 15:16:36 -0500
From: Jean-Francois Levesque <jfl@jfworld.net>
To: linux-kernel@vger.kernel.org
Subject: UDMA problem with Maxtor 7200rpm disk
Message-Id: <20011219151636.50e930ac.jfl@jfworld.net>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a problem regarding my new Asus A7V266 board with VIA KT266 chipset.  Byron Stanoszek told me to ask my problem to this list so here it is :

My hard drive is a Maxtor 5T030H3 ATA DISK drive (30 gig).  The problem is that I'm not able to read more than 7 MB/sec :

[root@xyz jfl]# /sbin/hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  9.18 seconds =  6.97 MB/sec


[root@xyz jfl]# /sbin/hdparm -d1 -X66 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 setting xfermode to 66 (UltraDMA mode2)
 using_dma    =  1 (on)
[root@xyz jfl]# /sbin/hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  9.70 seconds =  6.60 MB/sec

[root@xyz jfl]# /sbin/hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3736/255/63, sectors = 60030432, start = 0
[root@xyz jfl]#



I also have some idebus errors.

The problem seems to be the DMA (ATA100 compatible board and disk).

Here is a part of my dmesg output (on kernel 2.4.2) :


[...]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 5T030H3, ATA DISK drive
hdd: CD620E, ATAPI CD/DVD-ROM drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(33)
Partition check:
 hda:hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled
ide0: reset: success
 hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 >
Floppy drive(s): fd0 is 1.44M

[...]

hdd: ATAPI 5X CD-ROM drive, 240kB Cache
Uniform CD-ROM driver Revision: 3.12
es1371: version v0.27 time 20:52:56 Apr  8 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
PCI: Found IRQ 10 for device 00:0e.0
es1371: found es1371 rev 2 at io 0xd800 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
end_request: I/O error, dev 16:40 (hdd), sector 0
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
es1371: unloading
es1371: version v0.27 time 20:52:56 Apr  8 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
PCI: Found IRQ 10 for device 00:0e.0
es1371: found es1371 rev 2 at io 0xd800 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
hdd: irq timeout: status=0xd0 { Busy }
end_request: I/O error, dev 16:40 (hdd), sector 0
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
es1371: unloading
hdd: ATAPI reset complete
es1371: version v0.27 time 20:52:56 Apr  8 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
PCI: Found IRQ 10 for device 00:0e.0
es1371: found es1371 rev 2 at io 0xd800 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
es1371: unloading
es1371: version v0.27 time 20:52:56 Apr  8 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
PCI: Found IRQ 10 for device 00:0e.0
es1371: found es1371 rev 2 at io 0xd800 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
end_request: I/O error, dev 16:40 (hdd), sector 0
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
hdd: ATAPI reset complete


hda is my Maxtor 30 gig hard disk
hdd is a old IDE CDROM that was working very well but now I get a lot of errors.

IRQ problems?
DMA problems?

I use the 80-pin blue IDE cable.

I'm using kernel 2.4.2 (from RH 7.1) because when I try the 2.4.9 (from RH 7.1), I get "hda: drive not ready for command" error (when the kernel is checking for the partitions on the disk) and my system hangs (freeze) on this.  I also tried 2.4.12-ac5 (what Byron was using and it was working with his VIA chipset) and 2.4.16 (lastest stable version) but I have the exact same error (not ready for command).

Any idea?

Thank you in advance for your help!

Jean-François Lévesque
jfl@jfworld.net

PS: My disk also "freeze" my system for a few seconds (from 1/2 to maybe 3sec) while checking some data.
