Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266523AbRG1JLZ>; Sat, 28 Jul 2001 05:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbRG1JLQ>; Sat, 28 Jul 2001 05:11:16 -0400
Received: from maila.telia.com ([194.22.194.231]:34042 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S266523AbRG1JLE>;
	Sat, 28 Jul 2001 05:11:04 -0400
Message-Id: <200107280911.f6S9B3d17777@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] MAX_READAHEAD gives doubled throuput
Date: Sat, 28 Jul 2001 11:07:04 +0200
X-Mailer: KMail [version 1.2.3]
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <200107280144.DAA25730@mailb.telia.com> <3B622E12.404971A7@zip.com.au>
In-Reply-To: <3B622E12.404971A7@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturdayen den 28 July 2001 05:14, Andrew Morton wrote:
> Roger Larsson wrote:
> > Hi all,
> >
> > Got wondering why simultaneous streaming is so much slower than normal...
> >
> > Are there any reasons nowadays why we should not attempt to read ahead
> > more than 31 pages at once?
> >
> > 31 pages equals 0.1 MB, it is read from the HD in 4 ms => very close to
> > the average access times. Resulting in a maximum of half the possible
> > speed.
> >
> > With this patch copy and diff throughput are increased from 14 respective
> > 11 MB/s to 27 and 28 !!!
> >
> > I enable the profiling as well... (one printk warning fixed)
>
> It doesn't make any difference here.
>
> Dual 500MHz x86, 20 meg/sec IDE, 512 megs of RAM, kernel 2.4.7.
> Diffing two kernel trees is 129 seconds without patch, 130 with.
> Increasing MIN_READAHEAD to 31 as well saved eight seconds or so.
>

Do not diff the trees - diff the tars!
(most files in the tree is so small that they fit well in the 31 pages)
Even the tars might be to small for a second run (fits in memory...)


> What kernel did you test with, and what are the specs for the
> test machine?  Are your disks performing internal readahead?
> If so, how much, and how large is the on-disk cache?
>
>
>
> /dev/hdf:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 5606/255/63, sectors = 90069840, start = 0
> mnm:/home/akpm> 0 hdparm -I /dev/hdf
>

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5606/255/63, sectors = 90069840, start = 0

ok, so I did not have 32 bit nor unmaskirq turned on... should it matter?

> /dev/hdf:
>
>  Model=BI-MTDAL3-7040 5                        , FwRev=XTO66AA0, SerialNo= 
>       Y EMMYQG9424 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
>  CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=90069840
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 *udma3 udma4 udma5

/dev/hda:
 
 Model=BI-MTDAL3-7040 5                        , FwRev=XTO66AA0, SerialNo=
  Y EMMYQM0073
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=5606/255/63 PhysicalCHS=22075/16/255
-- 
Roger Larsson
Skellefteå
Sweden
