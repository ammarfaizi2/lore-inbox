Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319330AbSH2UOJ>; Thu, 29 Aug 2002 16:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319332AbSH2UOJ>; Thu, 29 Aug 2002 16:14:09 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:20753 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S319330AbSH2UOH>;
	Thu, 29 Aug 2002 16:14:07 -0400
Date: Thu, 29 Aug 2002 23:18:30 +0300 (EEST)
From: Meelis Roos <mroos@tartu.cyber.ee>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
In-Reply-To: <Pine.LNX.4.10.10208291235060.24156-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208292306230.27082-100000@ondatra.tartu-labor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > pcibus = 33333
> > 00:07.1 vendor=8086 device=7111 class=0101 irq=0 base4=f001
> > ----------PIIX BusMastering IDE Configuration---------------
> > Driver Version:                     1.3
> > South Bridge:                       28945
> > Revision:                           IDE 0x1
> > Highest DMA rate:                   UDMA33
> > BM-DMA base:                        0xf000
> > PCI clock:                          33.3MHz
> > -----------------------Primary IDE-------Secondary IDE------
> > Enabled:                      yes                 yes
> > Simplex only:                  no                  no
> > Cable Type:                   40w                 40w
> > -------------------drive0----drive1----drive2----drive3-----
> > Prefetch+Post:        yes       yes       yes       yes
> > Transfer Mode:        PIO       PIO       PIO       PIO
> > Address Setup:       90ns      90ns      90ns      90ns
> > Cmd Active:         360ns     360ns     360ns     360ns
> > Cmd Recovery:       540ns     540ns     540ns     540ns
> > Data Active:         90ns      90ns      90ns      90ns
> > Data Recovery:       30ns      30ns      90ns      30ns
> > Cycle Time:         120ns     120ns     180ns     120ns
> > Transfer Rate:   16.6MB/s  16.6MB/s  11.1MB/s  16.6MB/s
> 
> That is not my work and you are on your own for that mess.
> That looks straight out of 2.5.30.

Actaully, I made a mistake in the report and this atapci output was from 
2.2.15 (and hdparm output too). Sorry for this stupid mistake.

Here are hdparm and atapci output from 2.4.20-pre5, and additionally 
/proc/ide/piix (quite terse when compared to the output of atapci).

/dev/hda:

 Model=QUANTUM FIREBALL ST1.6A, FwRev=A0F.0800, SerialNo=851715434518
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3128/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
 BuffType=DualPortCache, BuffSize=81kB, MaxMultSect=16, MultSect=16
 CurCHS=3128/16/63, CurSects=3153024, LBA=yes, LBAsects=3153024
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3

/dev/hdb:

 Model=QUANTUM FIREBALL ST1.6A, FwRev=A0F.0400, SerialNo=851712135299
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3128/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
 BuffType=DualPortCache, BuffSize=81kB, MaxMultSect=16, MultSect=16
 CurCHS=3128/16/63, CurSects=3153024, LBA=yes, LBAsects=3153024
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3

/dev/hdd:

 Model=ST32531A, FwRev=0.62, SerialNo=VE047143
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=4956/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=4956/16/63, CurSects=4996476, LBA=yes, LBAsects=4996476
 IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2
 AdvancedPM=no
Segmentation fault

(yes, it segfaults in 2.4 too)

Output of atapci 0.50:

pcibus = 33333
00:07.1 vendor=8086 device=7111 class=0101 irq=0 base4=f001
----------PIIX BusMastering IDE Configuration---------------
Driver Version:                     1.3
South Bridge:                       28945
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Prefetch+Post:        yes       yes       yes       yes
Transfer Mode:       UDMA      UDMA       DMA       DMA
Address Setup:       90ns      90ns      90ns      90ns
Cmd Active:         360ns     360ns     360ns     360ns
Cmd Recovery:       540ns     540ns     540ns     540ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      90ns      30ns
Cycle Time:          60ns      60ns     180ns     120ns
Transfer Rate:   33.3MB/s  33.3MB/s  11.1MB/s  16.6MB/s

And here is /proc/ide/piix:

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
UDMA enabled:   yes              yes             no                no
UDMA enabled:   2                2               X                 X
UDMA
DMA
PIO

-- 
Meelis Roos (mroos@tartu.cyber.ee)

