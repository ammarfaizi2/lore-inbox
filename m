Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbTASMsH>; Sun, 19 Jan 2003 07:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTASMsH>; Sun, 19 Jan 2003 07:48:07 -0500
Received: from quechua.inka.de ([193.197.184.2]:22728 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S267454AbTASMsG>;
	Sun, 19 Jan 2003 07:48:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <20030119001256.GA11575@compsoc.man.ac.uk>
Organization: private Linux site, southern Germany
Date: Sun, 19 Jan 2003 13:55:11 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18aEyl-0006O0-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Compiling modules is one of the things which always have been among
> > the most broken things in the kernel build systems, can this please be
> > fixed and properly documented?
>   ^^^^^
>
> Some actual bug reports would be good.

The general bug is that there is incomplete infrastructure for
building modules outside of the kernel. You see the problem when
looking at the CIPE configure scripts, or the ALSA configure scripts.
Up to kernel version 2.4, it takes considerable effort to find out
just what compiler options to use. This is information which belongs
in some easily accessed location.

The desirable situation for module developers would be that a kernel
tree after configure run contains a Makefile (or equivalent) with all
necessary definitions which can be called from an outside module
source tree and just DTRT. The 2.5 kbuild stuff is close, but not
complete.

It is a bug that Documentation/modules.txt is so outdated that it
contains little useful information any more. It is a bug that
Documentation/kbuild/makefiles.txt is at least a bit outdated.

It is a bug that the build process outside of the kernel tree changes
files inside the kernel tree when MODVERSIONS is enabled. (At least
this was the case last time I checked.) This means the kernel tree
can't be mounted read-only, or at least you would have to do dirty
tricks with symlinks.

It is a bug that the current Makefile can't compile modules in an
object directory different from the source directory. This means the
module source tree can't be mounted read-only (again, without
resorting to symlinks).

It is also a bug that parts of the development infrastructure are
installed in /lib/modules/<version> and it's somewhat documented that
compiling modules needs this /lib/modules/<version> stuff. That may be
true for the ideal, simplified Red Hat world but in reality the
machine and running OS version of the development machine is likely
different from the box it will run on. Mixing development environment
and install target only causes confusion.

I don't know if real cross-compilation (i.e. for a different
architecture than the compiler runs on) of modules is possible
yet. If not, that's a bug too.[1]

Olaf

[1] Okay, on this count I'm guilty too with CIPE (just trying to sort
that out...)

