Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSIKJ0I>; Wed, 11 Sep 2002 05:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSIKJ0I>; Wed, 11 Sep 2002 05:26:08 -0400
Received: from pop.gmx.net ([213.165.64.20]:32288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318562AbSIKJ0G> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 05:26:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@gmx.net>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [BUG] Linux 2.5.34 - problems setting >udma4 mode on IDE drives
Date: Wed, 11 Sep 2002 11:30:47 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111125.43938.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've tested 2.5.34 vanilla, also with Jens Axboe's new IDE patch (backport 
from 2.4.20-pre5-ac4) and I am not able to set my HD to udma5 mode.

root@codeman:[/] # hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 248 (on)
 geometry     = 7299/255/63, sectors = 117266688, start = 0

root@codeman:[/] # hdparm -i /dev/hda

/dev/hda:

 Model=MAXTOR 6L060J3, FwRev=A93.0500, SerialNo=663219752652
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117266688
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  1 2 3 4 5

root@codeman:[/] # hdparm -X69 /dev/hda 

/dev/hda:
 setting xfermode to 69 (UltraDMA mode5)

root@codeman:[/] # hdparm -i /dev/hda|grep udma
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 udma6 


the only thing I see in my dmesg (only with 2.4 ide backport) is:

ide_intr: woops


Nothing else, no errors. UDMA mode 5 works perfect with 2.4.18/2.4.19.


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:DMA

If you need more info's, other debugging etc. let me know!!

TIA!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


