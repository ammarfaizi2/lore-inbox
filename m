Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUB2J1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 04:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbUB2J1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 04:27:13 -0500
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:19922 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262021AbUB2J1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 04:27:07 -0500
From: Paolo Ornati <ornati@fastwebnet.it>
To: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: 2.6.x: iowait problem while burning a CD
Date: Sun, 29 Feb 2004 10:27:34 +0100
User-Agent: KMail/1.5.4
Cc: Rik van Riel <riel@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com> <200402281014.19842.ornati@fastwebnet.it> <1077979936.2791.69.camel@cambridge.braddahead.com>
In-Reply-To: <1077979936.2791.69.camel@cambridge.braddahead.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291027.34655.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 February 2004 15:52, Alex Bennee wrote:
> > >
> > > At that point, mkisofs is probably running into a bazillion
> > > small files, in subdirectories all over the place.
> > >
> > > Because a disk seek + track read takes 10ms, it's simply not
> > > possible to read more than maybe 100 of these small files a
> > > second, so mkisofs can't keep up.
> >
> > No... mkfs is reading only ONE big file ( ~ 700 MB )!
> >
> > And my system shouldn't be so slow:
> >
> > CPU: AMD Duron 750
> > RAM: 128 MB PC100
> > HD: 7200 RPM udma 4
> > File System: ResiserFS
>
> Could this be related to your low(ish) physical memory and the need swap
> stuff in and out? Maybe you could look at the vmstat output as you run
> the two cases?

No... swap is never touched !

But I think to have found where the problem is:

if I only create an ISO image of 672.4 MB I must wait more then 5 minutes... 
this means about 2.2 MB/s !

If I write a CD at 16x (~2400 KB/s) how can the image creation process be to 
the step with the writing one?

OK, if I create an ISO image I must (read from)/(write to) the disk, while 
burning on-the-fly requires only "read from disk".... But what happens if I 
write at 24x / 32x / 40x ???

Is 2,2 MB/s one acceptable speed?

My HD:

/dev/hda:

 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 38792/16/63, sectors = 39102336, start = 0

/dev/hda:

 Model=WDC WD200BB-53AUA1, FwRev=18.20D18, SerialNo=WD-WMA6Y1501425
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39102336
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5


FILE SYSTEM: ReiserFS


I have also noticed that raising the writing speed (24x/32x) I have the same 
problems with the buffer also having created the ISO image!

Bye

-- 
	Paolo Ornati
	Linux v2.6.3

