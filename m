Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266883AbRGHNhb>; Sun, 8 Jul 2001 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266890AbRGHNhV>; Sun, 8 Jul 2001 09:37:21 -0400
Received: from aeon.tvd.be ([195.162.196.20]:30602 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S266883AbRGHNhG>;
	Sun, 8 Jul 2001 09:37:06 -0400
Date: Sun, 8 Jul 2001 15:33:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10106211122180.1260-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10107081519110.9473-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Geert Uytterhoeven wrote:
> On Tue, 8 May 2001, Geert Uytterhoeven wrote:
> > In the mean time I down/upgraded to 2.2.17 on my PPC box (CHRP LongTrail,
> > Sym53c875, HP C5136A  DDS1) and I can confirm that the problem does not happen
> > under 2.2.17 neither.
> > 
> > My experiences:
> >   - reading works fine, writing doesn't
> >   - 2.2.x works fine, 2.4.x doesn't (at least since 2.4.0-test1-ac10)
> >   - hardware compression doesn't matter
> >   - I have a sym53c875, Lorenzo has an Adaptec, so most likely it's not a
> >     SCSI hardware driver bug
> >   - I have a PPC, Lorenzo doesn't, so it's not CPU-specific
> >   - corruption is always a block of 32 bytes being replaced by 32 bytes from
> >     the previous tape block (depending on block size!) (approx. 6 errors per
> >     256 MB)
> > 
> > Lorenzo, can you please investigate the exact nature of the corruption on your
> > system?
> >   - How many successive bytes are corrupted?
> >   - Where do the corrupted data come from?
> 
> Yesterday I noticed the same corruption under 2.2.19 (yes, I run amverify after
> backing up my system now, so it detects corruption through the gzip CRCs).
> 
> I'll do some more tests (when I find time) to get a higher statistical
> certainty that it really doesn't happen under earlier 2.2.x kernels.

New findings:
  - The problem doesn't happen with kernels <= 2.2.17. It does happen with all
    kernels starting with 2.2.18-pre1.
  - The only related stuff that changed in 2.2.18-pre1 seems to be the
    Sym53c8xx driver itself. I'll do some more tests soon to isolate the
    problem.
  - The changes to the Sym53c8xx driver in 2.2.18-pre1 are _huge_. Are the
    individual changes between sym53c8xx-1.3g and sym53c8xx-1.7.0 available
    somewhere?

BTW, I wrote a small test program which tries to analyze error bursts. You can
find it at http://home.tvd.be/cr26864/Download/genpseudorandom.c

Sample test using 200000000 bytes of data:

    genpseudorandom -o -l 200000000  > /dev/tape
    genpseudorandom -i < /dev/tape

So far I always saw problems when writing even only 10 MB to tape: ca. 3-5
bursts of 32 or 12 incorrect bytes, which are always a copy of the
corresponding bytes in the previous block. Of course I used a much larger test
stream to verify 2.2.17.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

