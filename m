Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUBYWyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUBYWwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:52:03 -0500
Received: from gprs151-5.eurotel.cz ([160.218.151.5]:9860 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261594AbUBYVZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:25:44 -0500
Date: Wed, 25 Feb 2004 22:25:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: [Kgdb-bugreport] Re: kgdb: rename i386-stub.c to kgdb.c
Message-ID: <20040225212515.GE1307@elf.ucw.cz>
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz> <403D10DB.8060506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D10DB.8060506@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

That's a gdb bug, surely?

My gdb seems to work okay:

(gdb) b time.c:3
Breakpoint 1 at 0xc01e8b30: file fs/ntfs/time.c, line 3.
(gdb) b kernel/time.c:3
Breakpoint 2 at 0xc0122540: file kernel/time.c, line 3.
(gdb)

....that seems more or less right.

> Please, lets have only one of each name.

You can't have that, anyway.. Filenames are already repeating.

Well, I already commited it. It is possible to revert last change, and
we'll get kernel/kgdbstub.c but arch/*/kernel/kgdb.c.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
