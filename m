Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264627AbRFPN4n>; Sat, 16 Jun 2001 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbRFPN4e>; Sat, 16 Jun 2001 09:56:34 -0400
Received: from cx648115-a.blvue1.ne.home.com ([24.17.100.128]:47870 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264627AbRFPN4c>; Sat, 16 Jun 2001 09:56:32 -0400
Date: Sat, 16 Jun 2001 08:42:01 -0500 (CDT)
From: Thomas Molina <tmolina@home.com>
X-X-Sender: <tmolina@localhost.localdomain>
To: Rachel Greenham <rachel@linuxgrrls.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
In-Reply-To: <3B2B31C7.5020708@linuxgrrls.org>
Message-ID: <Pine.LNX.4.33.0106160827100.13727-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Rachel Greenham wrote:

> Thomas Molina wrote:
>
> >So is there no correlation from particular hardware to problems reported?
> >I'm running the A7V133 with a Western Digital WD300BB UDMA 5 drive on
> >kernel 2.4.5 with no trouble.
> >
> Well, I don't know. I'd guess there'd *have* to be some correlation, but
> we're not gathering enough information to see the pattern. ie: which
> BIOS version, what exact BIOS options are set, what processor/speed,
> what memory, what exact model of hard disk... We just may not have a big
> enough sample size. Even in my case the crashes aren't predictable in
> nature - 2.4.4 passed my bonnie test the first time, making me think the
> problem was introduced in 2.4.5, and only failed later in normal usage -
> next time I tested it it failed in the first minute or so. *Most* of the
> time failures occur during the bonnie test, but at all sorts of random
> times during the test.

I'm certainly willing to provide any data it's decided is necessary to
collect to make the correlations.  I'll even volunteer to be the
collection point for such data.  Beyond mainboard version, bios version,
and perhaps hard drive info I'm not sure what's appropriate.

I've tried most of the tests you all have been discussing, with a couple
of exceptions.  I haven't tried bonnie ( don't even know where to get it
or what it is supposed to test ).  I do create a number of CDs each week
so I am copying a moderate amount of data per session; my setup may be a
bit different - I have the hard drive on the promise interface (ide2) and
cdroms on the first ide interface (ide0) so I'm probably not testing the
same ide-to-ide copy problem that others are seeing.

> <redundant>as long as you're sure you do have DMA enabled that is - SuSE
> at least leaves it disabled by default, under which conditions all
> kernels are stable for me</redundant>

Fairly certain.  I could be misinterpreting things, though.  Here is some
output I'm seeing:

[root@localhost /root]# hdparm -tT /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
 Timing buffered disk reads:  64 MB in  2.31 seconds = 27.71 MB/sec
[root@localhost /root]# hdparm /dev/hde

/dev/hde:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3649/255/63, sectors = 58633344, start = 0
[root@localhost /root]# hdparm -i /dev/hde

/dev/hde:

 Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6W1592536
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq
}
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58633344
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5


