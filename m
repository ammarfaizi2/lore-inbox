Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316736AbSERBPn>; Fri, 17 May 2002 21:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316737AbSERBPm>; Fri, 17 May 2002 21:15:42 -0400
Received: from [195.223.140.120] ([195.223.140.120]:16971 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316736AbSERBPm>; Fri, 17 May 2002 21:15:42 -0400
Date: Sat, 18 May 2002 03:14:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020518011410.GD29509@dualathlon.random>
In-Reply-To: <Pine.GSO.4.44.0205030131470.11340-100000@epic7.Stanford.EDU> <11840.1020427634@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 10:07:14PM +1000, Keith Owens wrote:
> On Fri, 3 May 2002 01:33:34 -0700 (PDT), 
> Vikram <vvikram@stanford.edu> wrote:
> ><snip>
> >ccache is a compiler cache. It acts as a caching pre-processor to C/C++
> >compilers, using the -E compiler switch and a hash to detect when a
> >compilation can be satisfied from cache. This often results in a 5 to 10
> >times speedup in common compilations
> ></snip>
> >
> >http://ccache.samba.org/
> 
> Firstly kbuild 2.5 removes the need to make clean or make mrproper for
> most compilations.  You need to make mrproper when changing to a new
> architecture in the same directory (it is much better to use a separate
> object directory for each architecture), but apart from that you should
> not need to make clean or mrproper.  IMNSHO having to issue make clean

you're right if we need a make clean it's because the buildsystem is
broken. However one thing that happens all the time to me, is that I
change an header like mm.h or sched.h and ~everything needs to be
rebuilt then. And since I cannot trust the current buildsystem I need to
`make clean` first just in case somebody is getting mm.h included
implicitly and fastdep so cannot notice it has to rebuild such object
too. But in such case make clean doesn't hurt much because almost
everything needs to be rebuilt anyways. Now the only regression I can
see is that kbuild was quite slower in compiling the kernel from scrach
(so I suspect that for me after editing mm.h it would take more time
with kbuild2.5 to reach the vmlinux generation than it took with the old
buildsystem after the make clean) Is that the case, or did you improved
the performance of kbuild recently?

Said that I look forward to avoid touching those .h so it becomes
possible to do parallel developement from two hardlinked trees.  Also
the ability of compile out of the tree is very clean feature, even if
it's a secondary need for me at least.

> is a sign that your build system is broken, relying on human
> intervention in an automated build is falt out wrong.  Automatic
> detection of an arch switch is on the enhancement list for kbuild 2.5.
> 
> Secondly kbuild 2.5 keeps objects that were built but are not currently
> selected, it just does not link or install them.  Build a kernel,
> disable a set of drivers, build the kernel and it will just bump the
> version number and relink vmlinux.  Enable the drivers again, kbuild
> 2.5 does not need to compile them, they are still there, it just bumps
> the version number and relinks vmlinux.  Same with installing modules.
> Various .tmp files list the objects and modules required for the
> current .config.
> 
> So kbuild 2.5 removes the need to make clean after patches, changing
> configs, etc.  It gets it right without human intervention.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
