Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUBYVdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUBYV36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:29:58 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:9452 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id S261622AbUBYV22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:28:28 -0500
Date: Wed, 25 Feb 2004 14:28:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
Message-ID: <20040225212826.GE1052@smtp.west.cox.net>
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz> <403D10DB.8060506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D10DB.8060506@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 01:17:15PM -0800, George Anzinger wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >
> >>>kgdb uses really confusing names for arch-dependend parts. This fixes
> >>>it. Okay to commit?
> >>
> >>Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is 
> >>indicative of architecture dependent code in it. Err, well so is the path.
> >
> >
> >
> >Well, looking at i386-stub.c, how do you know it is kgdb-related?
> >
> >
> >>PPC and sparc stubs in present vanilla kernel use this naming convention. 
> >>That's why I adopted it.
> >>
> >>I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent 
> >>compared to kernel/kgdbstub.c, arch/$x/kernel/kgdb.c
> >
> >
> >I actually made it kernel/kgdb.c and arch/*/kernel/kgdb.c. I believe
> >there's no point where one could be confused....
> 
> gdb itself gets confused with this.  Try, for example, time.c which, on the 
> x86, is in both arch and common code.  I use emacs with kgdb and it gets 
> confused when I point at a location in the source and tell it to set a 
> break point.
> 
> Please, lets have only one of each name.

We can't.  We've had various things (most notably MODVERSIONS prior to
2.6) which are unhappy with that, and in the end, the problem ends up
being fixed elsewhere.  In fact, this should be able to as well.  Using
your time.c example:
(gdb) break arch/i386/kernel/time.c:set_rtc_mmss
Breakpoint 3 at 0xc010ee90: file arch/i386/kernel/time.c, line 174.
(gdb) break kernel/time.c:sys_time 
Breakpoint 4 at 0xc011f0cc: file time.h, line 301.

So shouldn't it be a matter of somehow just not having a time.c
reference as well in the debug data?

-- 
Tom Rini
http://gate.crashing.org/~trini/
