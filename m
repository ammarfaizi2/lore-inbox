Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRJHDIO>; Sun, 7 Oct 2001 23:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275713AbRJHDIE>; Sun, 7 Oct 2001 23:08:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34576 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S275693AbRJHDHq>; Sun, 7 Oct 2001 23:07:46 -0400
Date: Mon, 8 Oct 2001 05:07:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles
Message-ID: <20011008050753.V726@athlon.random>
In-Reply-To: <20011008041215.O726@athlon.random> <440.1002509365@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440.1002509365@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Oct 08, 2001 at 12:49:25PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 12:49:25PM +1000, Keith Owens wrote:
> On Mon, 8 Oct 2001 04:12:15 +0200, 
> Andrea Arcangeli <andrea@suse.de> wrote:
> >On Mon, Oct 08, 2001 at 11:34:04AM +1000, Keith Owens wrote:
> >The main thing I like is to be able to compile out of the tree and
> >avoiding touching the header files during compilation (that's really
> >annoying).
> 
> All fixed in kbuild 2.5.

Of course I know, this is why I mentioned it :) That's most exiting
thing from my point of view.

> >I personally don't care about correctness in the sense of getting "make"
> >doing everything for you regardless of what you changed, I'm fine with
> >some "make distclean" forced checkpoint after PATCHLEVEL changed etc...,
> >you said infact full compile is needed sometime, not to tell about
> >kernel configuration.
> 
> Strongly disagree.  One of the biggest problems with kbuild is the user
> who applies a patch and expects the kernel to automatically rebuild
> just the bits that are affected.  We must not rely on every user doing
> make distclean or mrproper after applying a patch, we know that does
> not happen, resulting in inconsistent kernels.  If you want to do a
> complete recompile after a patch that is your choice, but we cannot

As everybody out there I have to evaluate every time if a recompile is
needed or not in function of the patch. Not a big deal.

But for mixed collection of patches like pre-patches or -ac, I don't
care, I just recompile the whole thing since it's unlikely I can trust
the build system to do everything right (mkdep problem for example) and
there are usually too many changes to save a rasonable amount of
compile time anyways.

> rely on the entire user population doing that.  kbuild must be
> automatic and correct.

If it's fast as well I'm fine of course :) But waiting the double of the
time isn't an obvious improvement for me, note that when the SUBLEVEL
changes all modules have to be recompiled at least, and so the smarter
buildsystem cannot take advantage of the fact the module sourcecode
didn't changed, and a small change in the include files can have a large
impact of the rebuild percentage etc...

> >One good example is the mkdep hack, it's far from correct: the header
> >dependences is nearly random.  We cannot trust it unless we remeber
> >every user included us (one more reason I'm used to full recompiles),
> 
> Absolutely agree.  The design assumption for mkdep is that the source
> and/or .config do not change after make dep.  That might have been true
> once but with several kernel trees, separate arch patches, separate sub
> system patches and compiling for multiple configurations it is not true
> now.  kbuild 2.5 completely redesigned the dependency tree and gets it
> right!

The mkdep logic (seen as "not going deeper than the explicit #include")
is quite orthogonal with the separate tree issue, you could build the
current .depend tree outside the kernel source tree too, that wouldn't
be a problem.

> However we are getting off the original patch which removes spurious
> compiles from the existing system.

Indeed :).

Andrea
