Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSHFHcm>; Tue, 6 Aug 2002 03:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSHFHcm>; Tue, 6 Aug 2002 03:32:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60562 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318407AbSHFHcl>;
	Tue, 6 Aug 2002 03:32:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] automatic module_init ordering 
In-reply-to: Your message of "Mon, 05 Aug 2002 21:05:13 +0200."
             <3D4ECC69.F0084A2C@linux-m68k.org> 
Date: Tue, 06 Aug 2002 17:28:14 +1000
Message-Id: <20020806073804.2E30F4BA3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D4ECC69.F0084A2C@linux-m68k.org> you write:
> Are you sure sent the right patch? This one misses a few changes.
> Anyway, I stole all the good ideas and integrated them into my patch. :)

Great, I was hoping you'd do that!

> - I use a separate initcall for the module initialization, that's the
> only way I can solve my IDE problems.

That's horrible 8(  I think we need figure out why this is happening:
do you know?  What does it actually need?

Ahh, I just came across the same problem!  See my
ordered-core-initcalls patch, for bio.c changes: you probably need to
change this too (and I deleted the redundany explicit IDE inits).

> - I put the initcall for that directly into the generated file.
> - raid autodetect became a late_initcall()

Icky, but that's what my follow-on patch for explicit initcalls is
for.  So raid is an example where it doesn't have an implicit
dependency, but it does have an actual dependency.

> - I don't use trap to clean up, so people can send us the temporary
> files, if something should go wrong. These files will be removed by a
> normal 'make clean' anyway.

Hmmm... Good idea, at least for the moment.  Eventually we won't have
any bugs 8)

I've updated my explicit core initcalls patch on top of your new one,
thanks!

	http://www.kernel.org/pub/linux/kernel/people/rusty/Misc/ordered-core-initcalls.patch.2.5.30.gz

It reverts your module initcall change, and boots here.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
