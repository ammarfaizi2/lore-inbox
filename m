Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbUJ1R3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbUJ1R3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUJ1R3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:29:50 -0400
Received: from witte.sonytel.be ([80.88.33.193]:38828 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263015AbUJ1R3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:29:03 -0400
Date: Thu, 28 Oct 2004 19:28:57 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: massive cross-builds without too much PITA
In-Reply-To: <20041028165853.GT24336@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.61.0410281917420.4228@waterleaf.sonytel.be>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk>
 <Pine.GSO.4.61.0410281331320.7058@waterleaf.sonytel.be>
 <20041028165853.GT24336@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Al Viro wrote:
> On Thu, Oct 28, 2004 at 01:36:53PM +0200, Geert Uytterhoeven wrote:
> > On Thu, 28 Oct 2004, Al Viro wrote:
> > > 6) cross-sparse: sparse snapshots live on
> > > http://www.codemonkey.org.uk/projects/bitkeeper/sparse/;  I'm probably doing
> > > more work than necessary since I build a separate binary for each target.
> > > What it means is
> > > 	a) editing pre-process.h to point to cross-gcc headers (e.g.
> > > /usr/lib/gcc-lib/alpha-linux/3.3.4/include) and
> > > 	b) editing target.c (probably not needed these days)
> > > make CFLAGS=-O3
> > > mv ~/bin/sparse-<arch>{,-old}
> > > cp check ~/bin/sparse-<arch>
> > > does the build-and-install.
> > 
> > I use the native (ia32) sparse for m68k cross-builds, using the following trick
> > (IIRC as suggested by Linus) in arch/m68k/Makefile:
> > 
> >     CHECK := $(CHECK) -D__mc68000__=1 -I$(shell $(CC) -print-file-name=include)
> > 
> > I guess a similar construct would work for other archs, even for native builds.
> 
> Hrm...  That would work, but we probably want -I$(...) part in toplevel
> Makefile instead of duplicating it all over the place.

Of course. But the -D__mc68000__=1 (I guess the `=1' can be removed these days)
is architecture-specific.

> > > ext2 works fine for build boxen - you are not dealing with hard-to-recreate
> > > data there (diffs are going to master and you want them carved into small
> > > chunks from the very beginning anyway).  So journalling, etc. is a pointless
> > > overhead in this situation.  Keep in mind that forest of cp -rl'ed kernel
> > > trees gets hard on caches once it grows past ~60 copies regardless of the
> > > fs involved; if your patchset gets bigger than that, fragment it and do
> > > porting, etc. group-by-group.
> > 
> > Hmm, I seem to have 502 hardlinked copies of COPYING, that means at least 502
> > trees :-)
> 
> Oh, *having* that many is not a problem.  Try to run diff in a series of
> 502 trees, linked or not, and see how bad that'll get you.

Since my checked-out version of the latest Linux/m68k CVS is not hardlinked to
any other tree, I'm well aware of the speed difference between diff'ing between
that checked-out tree and any other tree (up to 20 minutes?), or diff'ing
between two mostly-hardlinked trees (less than 1 minute, usually just a few
seconds). That's on a system with one Maxtor 6Y160M0 SATA disk.

> > Just in case you ever want to start doing m68k as well: I already have a few
> > sparse-related cleanups at
> > http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/XXX-sparse-*
> 
> Hrm...  How far is Linus' tree from building on m68k these days?  I hadn't
> looked at the delta since 2.6.7 or so, but it used to be fairly invasive
> in some places...

For 2.6.8.1, the different task models (cfr. the thread titled `Re: Getting
kernel.org kernel to build for m68k?' on lkml last September) is the big
problem. If you apply the patch from that thread to plain 2.6.8.1, it'll build
fine!

2.6.9 introduced a new problem with the signal handling (for which BTW we don't
have a fix yet).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
