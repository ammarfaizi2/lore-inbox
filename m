Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbRGTVEw>; Fri, 20 Jul 2001 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbRGTVEm>; Fri, 20 Jul 2001 17:04:42 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:33543 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S267388AbRGTVEe> convert rfc822-to-8bit; Fri, 20 Jul 2001 17:04:34 -0400
Date: Fri, 20 Jul 2001 23:02:20 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
X-X-Sender: <groudier@gerard>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10107201902150.568-100000@callisto.of.borg>
Message-ID: <20010720222746.J3846-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 20 Jul 2001, Geert Uytterhoeven wrote:

> On Sun, 8 Jul 2001, Geert Uytterhoeven wrote:
> > New findings:
> >   - The problem doesn't happen with kernels <= 2.2.17. It does happen with all
> >     kernels starting with 2.2.18-pre1.
> >   - The only related stuff that changed in 2.2.18-pre1 seems to be the
> >     Sym53c8xx driver itself. I'll do some more tests soon to isolate the
> >     problem.
> >   - The changes to the Sym53c8xx driver in 2.2.18-pre1 are _huge_. Are the
> >     individual changes between sym53c8xx-1.3g and sym53c8xx-1.7.0 available
> >     somewhere?

Not completely. The reason is that I used manual diffing/patching against
various kernel versions and it would be a PITA to resurrect all
intermediate driver versions using these patches. If we consider patches
that went directly to kernel main stream without changing the driver
version, a double PITA it would be. Btw, for sym-2.1.x series, I now use a
CVS tree and each driver release is tagged independently. For those ones,
it will be much more easy to isolate broken changes.

> The problem is indeed introduced by the changes to the Sym53c8xx in 2.2.18-pre1.
> I managed to find some intermediate versions in the 2.3.x series, and here are the
> results:
>   - sym53c8xx-1.3g (from BK linuxppc_2_2): OK
>   - sym53c8xx-1.5e: crash in SCSI interrupt during driver init
>   - sym53c8xx-1.5f: lock up during driver init
>   - sym53c8xx-1.5g: random 32-byte error bursts when writing to tape

That's an interesting result. But 1.5g - 1.3g diffs are probably very
large. Patches available from ftp.tux.org should allow to resurrect
driver versions 1.4, 1.5, 1.5a, 1.5b, 1.5c, 1.5d.

ftp://ftp.tux.org/pub/roudier/drivers/linux/sym53c8xx/README

You may, for example, apply incremental patches that address kernel 2.2.5
to a fresh kernel 2.2.5 tree and extract driver files accordingly.

> Perhaps I can get 1.5e and 1.5g to work using some PPC-specific fixes from the
> 1.3.g driver in the linuxppc_2_2 tree (it differed a bit from the 1.3g in
> Alan's 2.2.17). But even then the changes in 1.5f and 1.5g are rather small,
> compared to the changes between 1.3g and 1.5f.

Some PPC specific changes are very probably not present in my driver
sources. I am unable to help on that point.

> So I'd be very happy if I could get my hand on more intermediate versions.
> Thanks for your help! I _really_ want to nail this one down!
>
> Gr{oetje,eeting}s,

Regards,
  Gérard.



