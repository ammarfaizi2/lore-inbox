Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292329AbSBUK4k>; Thu, 21 Feb 2002 05:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292333AbSBUK4a>; Thu, 21 Feb 2002 05:56:30 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:24326 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292329AbSBUK4R>;
	Thu, 21 Feb 2002 05:56:17 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: SC1200 support?
Newsgroups: linux.kernel
In-Reply-To: <6985.1014251226@kao2.melbourne.sgi.com>
In-Reply-To: <20020221000202.363E6F5B@acolyte.hack.org>
Message-Id: <20020221105612.F12BEF5B@acolyte.hack.org>
Date: Thu, 21 Feb 2002 11:56:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>I assume that the nano files are in a shadow tree.  You can convert
>base plus shadow trees to a single view by
>
>  make -f $KBUILD_SRCTREE_000/Makefile-2.5 $KBUILD_OBJTREE/.tmp_src
>
>$KBUILD_OBJTREE/.tmp_src will be built as a directory containing 10,000
>symlinks pointing at the relevant source files.
>
>  diff -urN $KBUILD_SRCTREE_000 $KBUILD_OBJTREE/.tmp_src
>
>to generate a patch from base to base+shadow.  Use that diff against a
>separate copy of the base tree as a starting point for kbuild 2.4.

Ah, nice.  I'll probably do that the next time then.

I decided to try out kbuild properly the last time it was discussed
here, if I'm going to complain I'd better know what I'm talking about :-)

It is working really well, it's very convenient to just have to check
my rather small changes in CVS rather than the whole Linux kernel
tree.  It makes it rather easy to do automatic builds too, since to be
certain that everything really is recompiled properly with the old
kbuild I had to do "make distclean; cat saved_config >.config; make
oldconfig; make dep; make bzImage modules".  

I have a few small nits though:

I usually add "NO_MAKEFILE_GEN=anything" when compiling things so to
avoid the dependency checking when just doing small changes, but I'm
not allowed to do "make NO_MAKEFILE_GEN=anything install" which is a
bit of a pain.  I usually run everything on my test system over NFS so
I install the modules straight into the NFS tree.  So I'd really like
to be able to tell the kbuild system "I know what I'm doing, don't
babysit me".

Is it still possible to build modules outside of the kernel tree?  I
really like the MTD model of building some modules where the Makefile
looks like this:

ifndef TOPDIR
TOPDIR:=$(shell cd ../linux && pwd)
endif

all:
        make -C $(TOPDIR) SUBDIRS=`pwd` modules

M_OBJS := my_module.o

# Real actions are started from Rules.make
include $(TOPDIR)/Rules.make

Because this way I can build third party modules afterwards without
having to recompile everything else.

 /Christer






