Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131492AbRAXPy2>; Wed, 24 Jan 2001 10:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131412AbRAXPyT>; Wed, 24 Jan 2001 10:54:19 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:8010 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S131240AbRAXPyL>;
	Wed, 24 Jan 2001 10:54:11 -0500
Date: Wed, 24 Jan 2001 08:54:15 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 disk speed 66% slowdown...
In-Reply-To: <3A6E573D.5210644C@sgi.com>
Message-ID: <Pine.LNX.4.31.0101240841550.10119-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a datapoint, my Via IDE chipset (on atb850/kt133) and Promise
Ultra66 (on 2xpp200/82440FX/PIIX3) works fine with 2.4.0, getting speeds
about correct:

 Model=IBM-DTLA-307045, FwRev=TX6OA60A
 [snip.  unused info cut]
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
 Timing buffered disk reads:  64 MB in  1.78 seconds = 35.96 MB/sec
 Timing buffered disk reads:  64 MB in  1.79 seconds = 35.75 MB/sec
 Timing buffered disk reads:  64 MB in  1.79 seconds = 35.75 MB/sec

 Model=QUANTUM FIREBALLP LM30, FwRev=A35.0700
 [snip.  unused info cut]
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 *mode4

 Timing buffered disk reads:  64 MB in  4.30 seconds = 14.88 MB/sec
 Timing buffered disk reads:  64 MB in  4.34 seconds = 14.75 MB/sec

Quite slow for the drive is capable of, but it's very fast for the
computer.  All I care for that machine is it to be able to sustain a
100Mbit file transfer to it at near full speed :)

Some things I did notice is that sometimes I forget to mark down some of
the options (dma especially) while compiling the kernel - and this killed
my disk transfer rate...

(Also something weird: my Fujitsu just doesn't seem to want to get into
UDMA66 (stays in udma33) in linux, but its head read rate is maxed out at
19MB/sec anyway, so it doesn't matter.  It's also on the same IDE channel
as the IBM on the Via.  I really wonder why it's:

 Model=FUJITSU MPD3137AH, FwRev=DH-05-09
 [snip.  unused info cut]
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 Timing buffered disk reads:  64 MB in  3.23 seconds = 19.81 MB/sec

Maybe a firmware bug...
)

ydsmv

-bc

On Tue, 23 Jan 2001, Linda Walsh wrote:

> Date: Tue, 23 Jan 2001 20:17:01 -0800
> From: Linda Walsh <law@sgi.com>
> To: Andre Hedrick <andre@linux-ide.org>
> Cc: Florin Andrei <florin@sgi.com>, lkml <linux-kernel@vger.kernel.org>
> Subject: Re: 2.4 disk speed 66% slowdown...
>
> Mine was actually out of a stock 2.2.17 -- I tried your patch in an attempt
> to fix a disk problem - but the disk was just going bad and the slow speeds were
> coming from the automatic sector remapping.
>
> pardon my ignorance, but where do you get UDMA-100-66?
>
> Here is the hdparm -i output on 2.4:
>
> /dev/hda:
>
>  Model=IBM-DARA-225000, FwRev=SHAOA54A, SerialNo=SQASQ202564
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=3(DualPortCache), BuffSize=418kB, MaxMultSect=16, MultSect=off
>  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
>  CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=49577472
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
>  UDMA modes: mode0 mode1 *mode2 mode3 mode4
>  Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4
>
> UDMA mode (2) seems to be identical to before.
>
>
> Andre Hedrick wrote:
> >
> > On Tue, 23 Jan 2001, Florin Andrei wrote:
> >
> > > Linda Walsh wrote:
> > > >
> > > > The REAL problem was in disk performance.  The apm made no difference:
> > >
> > >       Same problem here. I had a huge HDD performance drop when upgrading
> > > from 2.2.18 to 2.4.0
> > >       It's an Intel i815 motherboard, and the HDD is Ultra-ATA.
> >
> > ER, were you getting UDMA-100-66 out of 2.2.18 stock?
> > Now what are you getting in 2.4.0?
>
> --
> Linda A Walsh                    | Trust Technology, Core Linux, SGI
> law@sgi.com                      | Voice: (650) 933-5338
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
