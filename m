Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSKGSsM>; Thu, 7 Nov 2002 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSKGSsM>; Thu, 7 Nov 2002 13:48:12 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:24474 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S261464AbSKGSsL>; Thu, 7 Nov 2002 13:48:11 -0500
Date: Thu, 7 Nov 2002 12:52:06 -0600
To: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107185206.GQ4182@cadcamlab.org>
References: <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org> <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org> <Pine.LNX.4.44.0211071258550.13258-100000@serv> <20021107123753.GN4182@cadcamlab.org> <Pine.LNX.4.44.0211071352270.13258-100000@serv> <20021107132245.GO4182@cadcamlab.org> <20021107152454.GH5219@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107152454.GH5219@pasky.ji.cz>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Petr Baudis]
> I'm a bit lost here - the kernel uses tons of gcc extensions - how is
> another compiler supposed to understand them? And if it is
> specifically extended to understand them, isn't it likely that it'll
> understand the -shared switch in gcc-like way as well?

There is a difference between $(CC) and $(HOSTCC).  We have both of
them for a reason.  $(CC) specifies the compiler used to build the
kernel - it may or may not be your regular system compiler.  It can
even be for another architecture - for example, it may produce PowerPC
object files from the comfort (?) of your x86 PC.

$(HOSTCC) is specifically to build executables that are to run *on* the
build system itself - kconfig, for example.  If you're running on x86
and building a PowerPC kernel, you need an x86 version of kconfig, not
a PowerPC version.

So $(CC) *must* be a gcc (or a convincing facsimile) - but $(HOSTCC)
can be *any* C compiler on your system.  I don't think anyone tries to
use any gcc extensions with $(HOSTCC).

> And how likely is situation when someone want to configure a kernel
> with non-gcc compiler and actually build it with gcc?

Not very likely, but you take a lot for granted.  On many combinations
of Unix + gcc versions, `gcc -shared' doesn't work until you spend half
a day hand-tweaking the specs file whilst poring over the obscure flags
section of the `ld' manpage.  Try it for gcc 2.95 on AIX sometime, for
a bit of good clean fun.

My point was and is that while shared libraries are a (relative!)
breeze on Linux, they have always been a horrible portability headache;
furthermore, the kernel build system doesn't need them and ought to do
without.

Peter
