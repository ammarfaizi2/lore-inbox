Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSHCBDW>; Fri, 2 Aug 2002 21:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSHCBDW>; Fri, 2 Aug 2002 21:03:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50624 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317396AbSHCBDU>; Fri, 2 Aug 2002 21:03:20 -0400
Date: Fri, 2 Aug 2002 20:05:42 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <tytso@mit.edu>,
       <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <axel@hh59.org>
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
In-Reply-To: <20020803005626.D16963@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208021954170.24984-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002, Russell King wrote:

> When I build 8250.c into the kernel, linux/module.h doesn't include
> linux/version.h, so when we include linux/serialP.h, the compiler
> assumes that LINUX_VERSION_CODE is zero.  So we end up including
> linux/serial.h.
> 
> However, when building as a module, linux/module.h does include
> linux/version.h, so when we don't include linux/serial.h.
> 
> Oh, the problems of trying to reduce the includes...  I think we should
> re-include linux/serial.h and eliminate linux/serialP.h.
> 
> Hmm, I wonder how many other oddities like this are in the tree today.
> It sounds like we want to create a rule similar to the one for using
> CONFIG_* symbols.  Does this sound reasonable: if you use
> LINUX_VERSION_CODE, you must include linux/version.h into that very
> same file to guarantee that it is defined.
> 
> Well, I took checkconfig.pl and created checkversion.pl (attached).
> Oh god, can I please put the worms back in the can?  Now?  I think
> there's lots of work to do here; lots of stuff including linux/version.h
> for the hell of it, and a comparitively small number not including it
> when they use LINUX_VERSION_CODE.
> 
> (No, I'm just off to zzz, so this must be a nightmare, maybe it'll go
> away by the time I wake up later today.) 8/

Hmmh, note that checkconfig.pl is actually not necessary anymore, it could 
be replaced by just including config.h unconditionally, or even include 
the macros from the commandline (-imacro include/linux/autoconf.h, I think 
you yourself did suggest that ;). The old build system relied on
#include <linux/config.h> to get "make dep" right, but that's not 
necessary anymore.

So I'm not sure introducing such a kind-of-weird rule for "version.h" is
the right way to go. An alternative would be to follow kaos' suggestion
and split version.h into uts_release.h (for the UTS_RELEASE macro) and
version.h for the numeric version. Then just include version.h from
kernel.h and be done with it.

--Kai


