Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUJ1Q65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUJ1Q65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUJ1Q65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:58:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61088 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261726AbUJ1Q6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:58:54 -0400
Date: Thu, 28 Oct 2004 17:58:53 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: massive cross-builds without too much PITA
Message-ID: <20041028165853.GT24336@parcelfarce.linux.theplanet.co.uk>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.61.0410281331320.7058@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410281331320.7058@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 01:36:53PM +0200, Geert Uytterhoeven wrote:
> On Thu, 28 Oct 2004, Al Viro wrote:
> > 6) cross-sparse: sparse snapshots live on
> > http://www.codemonkey.org.uk/projects/bitkeeper/sparse/;  I'm probably doing
> > more work than necessary since I build a separate binary for each target.
> > What it means is
> > 	a) editing pre-process.h to point to cross-gcc headers (e.g.
> > /usr/lib/gcc-lib/alpha-linux/3.3.4/include) and
> > 	b) editing target.c (probably not needed these days)
> > make CFLAGS=-O3
> > mv ~/bin/sparse-<arch>{,-old}
> > cp check ~/bin/sparse-<arch>
> > does the build-and-install.
> 
> I use the native (ia32) sparse for m68k cross-builds, using the following trick
> (IIRC as suggested by Linus) in arch/m68k/Makefile:
> 
>     CHECK := $(CHECK) -D__mc68000__=1 -I$(shell $(CC) -print-file-name=include)
> 
> I guess a similar construct would work for other archs, even for native builds.

Hrm...  That would work, but we probably want -I$(...) part in toplevel
Makefile instead of duplicating it all over the place.

> > ext2 works fine for build boxen - you are not dealing with hard-to-recreate
> > data there (diffs are going to master and you want them carved into small
> > chunks from the very beginning anyway).  So journalling, etc. is a pointless
> > overhead in this situation.  Keep in mind that forest of cp -rl'ed kernel
> > trees gets hard on caches once it grows past ~60 copies regardless of the
> > fs involved; if your patchset gets bigger than that, fragment it and do
> > porting, etc. group-by-group.
> 
> Hmm, I seem to have 502 hardlinked copies of COPYING, that means at least 502
> trees :-)

Oh, *having* that many is not a problem.  Try to run diff in a series of
502 trees, linked or not, and see how bad that'll get you.

> Just in case you ever want to start doing m68k as well: I already have a few
> sparse-related cleanups at
> http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/XXX-sparse-*

Hrm...  How far is Linus' tree from building on m68k these days?  I hadn't
looked at the delta since 2.6.7 or so, but it used to be fairly invasive
in some places...
