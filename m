Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbRGHTDq>; Sun, 8 Jul 2001 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266963AbRGHTDg>; Sun, 8 Jul 2001 15:03:36 -0400
Received: from front3m.grolier.fr ([195.36.216.53]:31398 "EHLO
	front3m.grolier.fr") by vger.kernel.org with ESMTP
	id <S266962AbRGHTD1> convert rfc822-to-8bit; Sun, 8 Jul 2001 15:03:27 -0400
Date: Sun, 8 Jul 2001 21:01:17 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
X-X-Sender: <groudier@>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10107081519110.9473-100000@callisto.of.borg>
Message-ID: <20010708204508.D804-100000@>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Jul 2001, Geert Uytterhoeven wrote:

> On Thu, 21 Jun 2001, Geert Uytterhoeven wrote:
> > On Tue, 8 May 2001, Geert Uytterhoeven wrote:
> > > In the mean time I down/upgraded to 2.2.17 on my PPC box (CHRP LongTrail,
> > > Sym53c875, HP C5136A  DDS1) and I can confirm that the problem does not happen
> > > under 2.2.17 neither.
> > >
> > > My experiences:
> > >   - reading works fine, writing doesn't
> > >   - 2.2.x works fine, 2.4.x doesn't (at least since 2.4.0-test1-ac10)
> > >   - hardware compression doesn't matter
> > >   - I have a sym53c875, Lorenzo has an Adaptec, so most likely it's not a
> > >     SCSI hardware driver bug
> > >   - I have a PPC, Lorenzo doesn't, so it's not CPU-specific
> > >   - corruption is always a block of 32 bytes being replaced by 32 bytes from
> > >     the previous tape block (depending on block size!) (approx. 6 errors per
> > >     256 MB)
> > >
> > > Lorenzo, can you please investigate the exact nature of the corruption on your
> > > system?
> > >   - How many successive bytes are corrupted?
> > >   - Where do the corrupted data come from?
> >
> > Yesterday I noticed the same corruption under 2.2.19 (yes, I run amverify after
> > backing up my system now, so it detects corruption through the gzip CRCs).
> >
> > I'll do some more tests (when I find time) to get a higher statistical
> > certainty that it really doesn't happen under earlier 2.2.x kernels.
>
> New findings:
>   - The problem doesn't happen with kernels <= 2.2.17. It does happen with all
>     kernels starting with 2.2.18-pre1.
>   - The only related stuff that changed in 2.2.18-pre1 seems to be the
>     Sym53c8xx driver itself. I'll do some more tests soon to isolate the
>     problem.
>   - The changes to the Sym53c8xx driver in 2.2.18-pre1 are _huge_. Are the
>     individual changes between sym53c8xx-1.3g and sym53c8xx-1.7.0 available
>     somewhere?

No. But you can move the sym/ncr driver bundle from 2.2.18-pre1 to 2.2.17
and vice-versa.
 sym53c8xx.h, sym53c8xx_defs.h, sym53c8xx.c,
 sym53c8xx_comm.h, ncr53c8xx.h, ncr53c8xx.c

You also can download either sym-1.7.3c-ncr-3.4.3b, or sym-2.1.11, or just
both and play with all that stuff under 2.2.17 and later 2.2 kernels.

 ftp://ftp.tux.org/pub/roudier/README-drivers-linux

Btw, I am interested in results using sym-1.7.3c and sym-2.1.11 under
kernel 2.2.17 and possibly 2.2.18.

> BTW, I wrote a small test program which tries to analyze error bursts. You can
> find it at http://home.tvd.be/cr26864/Download/genpseudorandom.c
>
> Sample test using 200000000 bytes of data:
>
>     genpseudorandom -o -l 200000000  > /dev/tape
>     genpseudorandom -i < /dev/tape

Unfortunately, I haven't any tape device.

> So far I always saw problems when writing even only 10 MB to tape: ca. 3-5
> bursts of 32 or 12 incorrect bytes, which are always a copy of the
> corresponding bytes in the previous block. Of course I used a much larger test
> stream to verify 2.2.17.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
> 						Geert

Thanks for your testings,
  Gérard.

