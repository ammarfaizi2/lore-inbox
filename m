Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSKOAjy>; Thu, 14 Nov 2002 19:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSKOAjy>; Thu, 14 Nov 2002 19:39:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4360 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265484AbSKOAjv>; Thu, 14 Nov 2002 19:39:51 -0500
Date: Thu, 14 Nov 2002 19:31:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <20021114174246.GB10723@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.96.1021114192150.5672C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Sam Ravnborg wrote:

> In other words a more powerfull clean compared to today.
> The difference between clean and mrproper is then _only_ the configuration
> files. That easy to explain, and thats easy to understand. Today only
> very few people know the difference, and simply save their config,
> and do make mrproper.
> 
> I have many times seen people do something like:
> cp .config xxx
> make mrproper
> mv xxx .config
> 
> No need for that, when make clean deletes enough.

Unless you want to make a distribution, or see that a distribution made
from your patched kernel would build.
 
> Only caveat is that people are forced to wait for the modversion stuff,

I get "nothing to be done" for make dep after make distclean.

> but to my understanding Rusty is making that step obsolete soon.

I hope he isn't wasting his time on stuff like this when modules don't
work! I have more faith in his sense of priorities.

> Did I miss something obvious?

Possibly. Try this:
1 - unpack a kernel from the full tarball
2 - config
3 - make all
4 - make distclean
Now all the files left which weren't in the original tarball shouldn't be
in a tree someone might tar up and ship! Look at what make distclean used
to do beyond mrproper in 2.5.41 or so, that's what should be happening.

I don't see why you ever thought it was a good idea to change this,
distclean is that standard target used by many other things. And perhaps
mrproper shouldn't bother to clean up all the leftovers, patch backups,
they are documentation.

I believe you went into this not understanding the difference and why
there was one, and now you are defending how good it is not to have a way
to get a clean tree other than write a script which does what distclean
used to do. And the solution is not to have mrproper delete the original
files, they are useful!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

