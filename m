Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbUJ1Lkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUJ1Lkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbUJ1Lkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:40:35 -0400
Received: from witte.sonytel.be ([80.88.33.193]:15257 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262971AbUJ1LhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:37:15 -0400
Date: Thu, 28 Oct 2004 13:36:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: massive cross-builds without too much PITA
In-Reply-To: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.61.0410281331320.7058@waterleaf.sonytel.be>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Al Viro wrote:
> 6) cross-sparse: sparse snapshots live on
> http://www.codemonkey.org.uk/projects/bitkeeper/sparse/;  I'm probably doing
> more work than necessary since I build a separate binary for each target.
> What it means is
> 	a) editing pre-process.h to point to cross-gcc headers (e.g.
> /usr/lib/gcc-lib/alpha-linux/3.3.4/include) and
> 	b) editing target.c (probably not needed these days)
> make CFLAGS=-O3
> mv ~/bin/sparse-<arch>{,-old}
> cp check ~/bin/sparse-<arch>
> does the build-and-install.

I use the native (ia32) sparse for m68k cross-builds, using the following trick
(IIRC as suggested by Linus) in arch/m68k/Makefile:

    CHECK := $(CHECK) -D__mc68000__=1 -I$(shell $(CC) -print-file-name=include)

I guess a similar construct would work for other archs, even for native builds.

> ext2 works fine for build boxen - you are not dealing with hard-to-recreate
> data there (diffs are going to master and you want them carved into small
> chunks from the very beginning anyway).  So journalling, etc. is a pointless
> overhead in this situation.  Keep in mind that forest of cp -rl'ed kernel
> trees gets hard on caches once it grows past ~60 copies regardless of the
> fs involved; if your patchset gets bigger than that, fragment it and do
> porting, etc. group-by-group.

Hmm, I seem to have 502 hardlinked copies of COPYING, that means at least 502
trees :-)
That's on ext3fs, Athlon XP2800+ with 1 GiB RAM.

And I use same to merge trees after each release.

> Currently i386, amd, sparc32, sparc64, alpha and ppc all survive allmodconfig
> with relatively few patches; amount of new breakage showing up is not too
> bad and so far didn't take much time to deal with.  Bringing in new targets...
> hell knows - parisc probably will be the next one (which will mean adding
> delta between Linus' and parisc trees into -bird), arm going after it (that
> will mean untangling the mess around drivers/net/8390.c first ;-/)  After
> getting the target to build (and barring the acts of Cthulhu or Ingo) it
> doesn't add a lot of overhead...

Just in case you ever want to start doing m68k as well: I already have a few
sparse-related cleanups at
http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/XXX-sparse-*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
