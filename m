Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316759AbSFJH56>; Mon, 10 Jun 2002 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316764AbSFJH55>; Mon, 10 Jun 2002 03:57:57 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:22803 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316759AbSFJH5z>; Mon, 10 Jun 2002 03:57:55 -0400
Message-ID: <3D045B72.9000304@megapathdsl.net>
Date: Mon, 10 Jun 2002 00:55:30 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re:  2.5.21: "ata_task_file: unknown command 50"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now, I managed to work around this lockup by not using
the AMD IDE chipset support.  I no longer get the hang
or the "ata_task_file: unknown command 50" message.
Unfortunately, my 800MHz Athlon machine's performance has
dropped into the toilet with this configuration and 2.5.21.

/dev/hda:
  Timing buffered disk reads:  64 MB in 13.51 seconds =  4.74 MB/sec
/dev/hda:
  Timing buffer-cache reads:   128 MB in  0.85 seconds =150.59 MB/sec
/dev/hda:
  Model=QUANTUM FIREBALLP LM30, FwRev=A35.0700, SerialNo=186006831114
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
  BuffType=DualPortCache, BuffSize=1900kB, MaxMultSect=16, MultSect=off
  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58633344
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
  AdvancedPM=no
  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 
ATA-4 ATA-5

Also, I am getting some very scary kernel log messages:

hda: lost interrupt
raid0_make_request bug: can't convert block across chunks or bigger than 
64k 94712 8
raid0_make_request bug: can't convert block across chunks or bigger than 
64k 1340144 12
raid0_make_request bug: can't convert block across chunks or bigger than 
64k 1342192 20

I am getting long periodic hangs of up to 10 seconds where the only 
thing that
responds is the mouse.  Then, everything wakes up for a while.

This kernel has several patches applied, which got it to build:

	vmalloc patch
	Martin's ide-clean-86 patch
	Martin's locks patch
	emu10k1 patch
	ALSA misc.c patch

My configuration:


Jun 10 00:08:15 turbulence kernel: ATA/ATAPI device driver v7.0.0
Jun 10 00:08:15 turbulence kernel: ATA: PCI bus speed 33.3MHz
Jun 10 00:08:15 turbulence kernel: ATA: unknown interface: Advanced 
Micro Devices [AMD] AMD-756 [Viper] IDE, PCI slot 00:07.1
Jun 10 00:08:16 turbulence kernel: hda: QUANTUM FIREBALLP LM30, DISK drive
Jun 10 00:08:16 turbulence kernel: hdc: Pioneer DVD-ROM ATAPIModel 
DVD-114 0117, ATAPI CD/DVD-ROM drive
Jun 10 00:08:16 turbulence kernel: hdd: R/RW 4x4x24, ATAPI CD/DVD-ROM drive
Jun 10 00:08:16 turbulence kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 10 00:08:26 turbulence kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 10 00:08:26 turbulence kernel:  hda: 58633344 sectors w/1900KiB 
Cache, CHS=58168/16/63
Jun 10 00:08:26 turbulence kernel:  hda: [PTBL] [3649/255/63] hda1 hda2 
< hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
Jun 10 00:08:26 turbulence kernel: SCSI subsystem driver Revision: 1.00
Jun 10 00:08:26 turbulence kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI 
SCSI HBA DRIVER, Rev 6.2.4
Jun 10 00:08:26 turbulence kernel:         <Adaptec 2930CU SCSI adapter>
Jun 10 00:08:26 turbulence kernel:         aic7860: Ultra Single Channel 
A, SCSI Id=7, 3/253 SCBs
Jun 10 00:08:36 turbulence kernel: md: linear personality registered as nr 1
Jun 10 00:08:36 turbulence kernel: md: raid0 personality registered as nr 2
Jun 10 00:08:37 turbulence kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, 
MD_SB_DISKS=27
Jun 10 00:08:37 turbulence kernel: md: Autodetecting RAID arrays.
Jun 10 00:08:37 turbulence kernel:  [events: 000000f5]
Jun 10 00:08:37 turbulence kernel:  [events: 000000f5]
Jun 10 00:08:37 turbulence kernel: md: autorun ...
Jun 10 00:08:37 turbulence kernel: md: considering hda12 ...
Jun 10 00:08:47 turbulence kernel: md:  adding hda12 ...
Jun 10 00:08:47 turbulence kernel: md:  adding hda11 ...
Jun 10 00:08:47 turbulence kernel: md: created md0
Jun 10 00:08:47 turbulence kernel: md: bind<hda11,1>
Jun 10 00:08:47 turbulence kernel: md0: WARNING: hda12 appears to be on 
the same physical disk as hda11. True
Jun 10 00:08:47 turbulence kernel:      protection against single-disk 
failure might be compromised.
Jun 10 00:08:47 turbulence kernel: md: bind<hda12,2>
Jun 10 00:08:47 turbulence kernel: md: running: <hda12><hda11>
Jun 10 00:08:47 turbulence kernel: md: hda12's event counter: 000000f5
Jun 10 00:08:47 turbulence kernel: md: hda11's event counter: 000000f5
Jun 10 00:08:47 turbulence kernel: md0: max total readahead window set 
to 512k
Jun 10 00:08:47 turbulence kernel: md0: 2 data-disks, max readahead per 
data-disk: 256k
Jun 10 00:08:47 turbulence kernel: raid0: looking at hda11
Jun 10 00:08:47 turbulence kernel: raid0:   comparing hda11(1028032) 
with hda11(1028032)
Jun 10 00:08:47 turbulence kernel: raid0:   END
Jun 10 00:08:47 turbulence kernel: raid0:   ==> UNIQUE
Jun 10 00:08:47 turbulence kernel: raid0: 1 zones
Jun 10 00:08:47 turbulence kernel: raid0: looking at hda12
Jun 10 00:08:47 turbulence kernel: raid0:   comparing hda12(1028032) 
with hda11(1028032)
Jun 10 00:08:47 turbulence kernel: raid0:   EQUAL
Jun 10 00:08:47 turbulence kernel: raid0: FINAL 1 zones
Jun 10 00:08:47 turbulence kernel: raid0: zone 0
Jun 10 00:08:48 turbulence kernel: raid0: checking hda11 ... contained 
as device 0
Jun 10 00:08:48 turbulence kernel:   (1028032) is smallest!.
Jun 10 00:08:48 turbulence kernel: raid0: checking hda12 ... contained 
as device 1
Jun 10 00:08:48 turbulence kernel: raid0: zone->nb_dev: 2, size: 2056064
Jun 10 00:08:48 turbulence kernel: raid0: current zone offset: 1028032
Jun 10 00:08:58 turbulence kernel: raid0: done.
Jun 10 00:08:58 turbulence kernel: raid0 : md_size is 2056064 blocks.
Jun 10 00:09:08 turbulence kernel: raid0 : conf->smallest->size is 
2056064 blocks.
Jun 10 00:09:08 turbulence kernel: raid0 : nb_zone is 1.
Jun 10 00:09:09 turbulence kernel: raid0 : Allocating 8 bytes for hash.
Jun 10 00:09:09 turbulence kernel: md: updating md0 RAID superblock on 
device
Jun 10 00:09:09 turbulence kernel: md: hda12 [events: 
000000f6]<6>(write) hda12's sb offset: 1028032
Jun 10 00:09:09 turbulence kernel: md: hda11 [events: 
000000f6]<6>(write) hda11's sb offset: 1028032
Jun 10 00:09:09 turbulence kernel: md: ... autorun DONE.

