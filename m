Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSKOOru>; Fri, 15 Nov 2002 09:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSKOOru>; Fri, 15 Nov 2002 09:47:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33296 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266319AbSKOOrq>;
	Fri, 15 Nov 2002 09:47:46 -0500
Date: Fri, 15 Nov 2002 15:53:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021115145312.GA1320@mars.ravnborg.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021114174246.GB10723@mars.ravnborg.org> <Pine.LNX.3.96.1021114192150.5672C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021114192150.5672C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 07:31:24PM -0500, Bill Davidsen wrote:
> > No need for that, when make clean deletes enough.
> 
> Unless you want to make a distribution, or see that a distribution made
> from your patched kernel would build.
Then let me repeat again:
distclean and mrproper is combined today. They do exactly the same.
So what was deleted by make distclean in 2.40 is still deleted by
make distclean in 2.5.47.
What has happened is that mrproper and distclean now deletes the sum of files
they delted before.

> > Only caveat is that people are forced to wait for the modversion stuff,
> 
> I get "nothing to be done" for make dep after make distclean.
Which is unrelated. Thats due to the module work that Rusty is performing.
Relevant part of his patch: (from linus-BK-latest)

===== init/Kconfig 1.1 vs 1.2 =====
--- 1.1/init/Kconfig	Wed Oct 30 02:16:55 2002
+++ 1.2/init/Kconfig	Sat Nov  9 05:08:33 2002
@@ -116,21 +116,14 @@
 	  may want to make use of modules with this kernel in the future, then
 	  say Y here.  If unsure, say Y.
 
-config MODVERSIONS
-	bool "Set version information on all module symbols"



See, modversion support is taken out.
And when you try make dep, you get "nothing to be done" because
CONFIG_MODVERSION is not set to y.
If it was set in your previous .config, then the implicit make oldconfig
takes care of deleting it.

Try:
$grep MODVERSION .config
and see yourself.

> > but to my understanding Rusty is making that step obsolete soon.
> 
> I hope he isn't wasting his time on stuff like this when modules don't
> work! I have more faith in his sense of priorities.
Getting modules to work is one step in that direction, and making
modversion obsolete is obviously a side-effect.

> Possibly. Try this:
> 1 - unpack a kernel from the full tarball
> 2 - config
> 3 - make all
> 4 - make distclean
> Now all the files left which weren't in the original tarball shouldn't be
> in a tree someone might tar up and ship! Look at what make distclean used
> to do beyond mrproper in 2.5.41 or so, that's what should be happening.
Let me know which files are left, and I will take care they are delted.
I have tested this many times on my own setup, and here I have no files
left hanging after make distclean/mrproper
If there are any error, I will be happy to fix it.

> I don't see why you ever thought it was a good idea to change this,
> distclean is that standard target used by many other things. And perhaps
> mrproper shouldn't bother to clean up all the leftovers, patch backups,
> they are documentation.
I have explained how I would like it to work - any comments on that proposal?

Anyway this kind of changes always go throuh kai - and he is busy doing
other stuff at the moment. So I will do an eventual patch later.

	Sam
