Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbTASSNv>; Sun, 19 Jan 2003 13:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTASSNv>; Sun, 19 Jan 2003 13:13:51 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39697 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267685AbTASSNu>;
	Sun, 19 Jan 2003 13:13:50 -0500
Date: Sun, 19 Jan 2003 19:22:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Message-ID: <20030119182250.GA1495@mars.ravnborg.org>
Mail-Followup-To: Olaf Titz <olaf@bigred.inka.de>,
	linux-kernel@vger.kernel.org
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <20030119001256.GA11575@compsoc.man.ac.uk> <E18aEyl-0006O0-00@bigred.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18aEyl-0006O0-00@bigred.inka.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 01:55:11PM +0100, Olaf Titz wrote:
> 
> It is a bug that Documentation/modules.txt is so outdated that it
> contains little useful information any more.

An updated version that at least describe how to build modules sanely
outside the kernel tree is queued for inclusion[1].

> It is a bug that
> Documentation/kbuild/makefiles.txt is at least a bit outdated.

A totally revised makefiles.txt is queued for inclusion[1].

> It is a bug that the build process outside of the kernel tree changes
> files inside the kernel tree when MODVERSIONS is enabled. (At least
> this was the case last time I checked.) This means the kernel tree
> can't be mounted read-only, or at least you would have to do dirty
> tricks with symlinks.

I have posted 2-3 version of a "separate src-tree" patch.
But due to the existence of such weird things as oprofile and xfs it did
not work in all cases. I symlinked all makefiles, but wanted to avoid
catching the rest of the directories.
I want my queued stuff applied before revisiting this though.
Main usage has been to build kernels based on different configurations,
not to mount src on a read-only media, that's sort of a side-effect.

> It is a bug that the current Makefile can't compile modules in an
> object directory different from the source directory. This means the
> module source tree can't be mounted read-only (again, without
> resorting to symlinks).

make -C path/to/kernel/src SUBDIRS=$PWD modules
So simple when you know the trick. That what I have documented
in modules.txt.


[1] Most of what I have done has been submitted to lkml within the
past month. It can be found at http://linux-sam.bkbits.net in
the kbuild repository, where it is queued for inclusion.

	Sam
