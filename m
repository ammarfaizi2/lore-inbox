Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276737AbRJHBVE>; Sun, 7 Oct 2001 21:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276743AbRJHBUy>; Sun, 7 Oct 2001 21:20:54 -0400
Received: from [195.223.140.107] ([195.223.140.107]:24573 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276737AbRJHBUe>;
	Sun, 7 Oct 2001 21:20:34 -0400
Date: Mon, 8 Oct 2001 03:20:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles
Message-ID: <20011008032022.M726@athlon.random>
In-Reply-To: <20011008020544.K726@athlon.random> <29190.1002501776@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29190.1002501776@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Oct 08, 2001 at 10:42:56AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 10:42:56AM +1000, Keith Owens wrote:
> On Mon, 8 Oct 2001 02:05:44 +0200, 
> Andrea Arcangeli <andrea@suse.de> wrote:
> >On Mon, Oct 08, 2001 at 09:29:06AM +1000, Keith Owens wrote:
> >> I did not miss it.  Changing cflags is detected by the
> >> .<object>.o.flags files.
> >> 
> >> ifeq (-D__KERNEL__ -I/build/kaos/2.4.11-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586,$(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_vt.o))))
> >> FILES_FLAGS_UP_TO_DATE += vt.o
> >> endif
> >
> >Ok, so the point of all those .flags is to catch per-object cflags changes.
> 
> It catches all cflags changes, from global CFLAGS, per directory cflags
> and per object cflags.  I repeat, you do not need to detect changes to
> the top level Makefile in order to detect cflag changes.

Sure I understand that.

> >CFLAGS was only an example, think if I change CC or EXTRAVERSION, but, as
> >said in the earlier email, I doubt an EXTRAVERSION change would work
> >without a full distclean in between anyways.
> 
> Of course it works.  EXTRAVERSION is only a human readable string used
> by 15 sources (via UTS_RELEASE) and by the various logo.h files.
> Changing EXTRAVERSION has no effect on executable code, it only affects
> display fields.  Any other files changed at the same time as
> EXTRAVERSION (say by a patch) will be recompiled, based on the
> timestamp changes.  Adding a patch which changes EXTRAVERSION does not
> require a full recompile, which is why the existing system is broken.

I didn't expected it to work including module versioning without a full
recompile, but good to know.

> I admit that kbuild 2.4 does not correctly handle changes to CC, if you
> "make CC=gcc" then "make CC=kgcc", the kernel is not rebuilt.  You must
> manually make distlean or mrproper when changing CC.  Note that
> overriding flags on the command line does not change the Makefile so
> you cannot rely on the Makefile timestamp to detect command changes,
> 
> IOW a check for Makefile timestamp is both overkill (it recompiles too
> much) and incomplete (it does not detect command line overrides).  BTW,
> kbuild 2.5 gets this right.

That sounds fine. Of course the only regression could be the build time.
Do you have a benchmark on the build time with kbuild 2.5 applied to
2.4.10 compared to the build time of 2.4.10?

> 
> module.h currently uses the full UTS_RELEASE which includes
> EXTRAVERSION but that is spurious, modutils ignores EXTRAVERSION when
> loading a module.  modutils only cares about VERSION, PATCHLEVEL and
> SUBLEVEL.

Well again EXTRAVERSION was just an example, SUBLEVEL was the same
problem as EXTRAVERSION for me, I mean after you apply an -ac patch that
for example goes backwards in the SUBLEVEL, do you recompile everything
or do you just run make after your Makefile patch is applied to the
kernel?

Andrea
