Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTAZWGq>; Sun, 26 Jan 2003 17:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTAZWGq>; Sun, 26 Jan 2003 17:06:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:34779 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267013AbTAZWGp>; Sun, 26 Jan 2003 17:06:45 -0500
Date: Mon, 27 Jan 2003 00:12:32 +0100
From: Christian Zander <zander@minion.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126231232.GE394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 03:46:30PM -0600, Kai Germaschewski wrote:
> 
> That's not true. For example, how would an old external build system
> magically starting to compile modules as .ko without updating? How
> would it have added -DKBUILD_BASENAME and -DKBUILD_MODNAME, which
> are required by the new module code. And, how did they avoid subtle
> breakage like not giving the same switches on the command line?
> (This list goes on...)
> 

I hear you, but these changes were easy enough to adapt to.

> Also, it's not true that they've been broken deliberately. As work
> progresses, breakage occurs, that's just a fact of live. However,
> introduction of __vermagic was not introduced in order to make live
> for maintainers of external modules harder, it was introduced since
> loading modules compiled with gcc3 into a kernel compiled with gcc2
> caused crashes for people.
> 

Well, in this specific case an alternate solution was proposed that
would have solved any of the potential problems pointed out.

> Okay, you have a point here, there's still a bug. vermagic.o will be
> rebuilt when the version changes or any of the recorded config
> options change, but it doesn't pick up changes in the compiler
> version, if the new gcc has the same name.
> 
> That's a bug for internal use as well, the patch below fixes it.
> 

Fair enough.

> o One thing I do not understand at all: What is the problem with
> using the internal build system? It makes maintainance of external
> modules much easier than keeping track of what happens in the kernel
> and patching a private solution all the time.
> 

My primary concern is compatibility with those kernels that do not use
kbuild or a different version of it. Ideally, one would want to use
the same build system for all possible kernel versions rather than use
Makefiles that attempt to pick the best choice. I guess I'm convinced
that the latter is the "best" solution to dealing with this problem at
this point, and I can live with that.

What's the most reliable way to tell if kbuild is available, and what
differences among kbuild versions will one have to look out for?

>   I don't even see any license issues, first of all you don't even
>   distribute it, the user who's building the module will already
>   have it along with his kernel source. And if you're using it to
>   compile (possibly binary) modules you want to distribute, you can
>   just use it just like gcc without any further obligations, so no
>   problem there either. (IANAL, of course)
> 

I don't see any problems with kbuild, I was referring to vermagic.c.

-- 
christian zander
zander@minion.de
