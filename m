Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSE3CAk>; Wed, 29 May 2002 22:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSE3CAj>; Wed, 29 May 2002 22:00:39 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64138 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316113AbSE3CAi>; Wed, 29 May 2002 22:00:38 -0400
Date: Wed, 29 May 2002 21:00:33 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Paul P Komkoff Jr <i@stingr.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <3CF540F8.6000802@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0205292019090.9971-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Jeff Garzik wrote:

> Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> he wanted an evolution to a new build system... not an unreasonable 
> request to at least consider.  Despite Keith's quality of code (again -- 
> I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> very "take it or leave it dammit".  Not the best way to win friends and 
> influence people.
> 
> If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
> work with Kai to integrate it into 2.5.x.

Oh well, it really wasn't my intention to start the good old kbuild-2.5
thread at all.

Anyway, I believe kbuild-2.5 has lots of useful ideas and I'll go pick 
pieces - from kbuild-2.5, from dancing-makefiles, from stuff I've done 
myself and work on improving the current build system. But I believe in 
make, and don't think I'll move away from it.

One thing these patches show is that gradual improvement is actually
possible, so far the kbuild process has gained quite some features with a
lot of small patches - and some bigger ones, but these are only trivial
cleanups.

Of course it happened that I introduced some bugs in the process, but the
fact that fixes were posted to linux-kernel by the next morning shows that
it's obviously possible for other people to grasp what's going on and fix
bugs. Rules.make is some 400 lines currently, that's quite a difference to 
kbuild-2.5 core's 30000 lines of code.

Anyway, fortunately it's not up to me to decide what happens. From my 
perspective the plan is to go on with this gradual improvement, in
particular 
o fix dependencies / modversions (that includes "make dep" going away)
o allow for separate objdir (this one is actually easy for 95% of the
  compiled files which use standard rules, and lots of work for the 
  remaining 5%. So it'll take time to remove the 5% special cases, after
  that things are pretty easy)

I believe that Keith will keep maintaining his kbuild-2.5 (if he isn't
willing to put work into it, that's definitely a reason not to merge it,
after all he's the only one who can fix bugs in it for all I can see).  
At the end of the day we will see how the two systems compare and, who
knows, maybe my work will even have simplified getting kbuild-2.5 into the
kernel.

Unfortunately Keith, for all I can see, has an all-or-nothing attitude. 
There's definitely things which could be broken out of kbuild-2.5,
like e.g.

o standardize asm-offsets.h generation
o make the build target a config option (I'm not actually sure if that
  is a good idea at all, using different targets for make seems a 
  sensible concept to me, but anyway)

Splitting things would at least allow for discussing whether these (and
other) individual features are considered worthwhile or not, as opposed to
getting the full bag or nothing.

Also, getting back to the 95%, if you compare kbuild-2.5's Makefile.in's
and the Makefiles in 2.5.19, you will see that 95% of what's in there has
a one-to-one relationship between the two Makefiles. I can't teach "make"  
to read the Makefile.in's which use an entirely new syntax, but since
kbuild-2.5 uses its owner parser, it could be adapted to understand the
old syntax (which expresses the exact same thing, so I don't really
understand why Keith didn't use the old format in the first place). That
would allow to drastically cut down the 20.000 lines Makefile.in diff and
would also simplify maintaining kbuild-2.5.

So that's my point of view.

--Kai
  

