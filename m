Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSIWTzI>; Mon, 23 Sep 2002 15:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbSIWTzG>; Mon, 23 Sep 2002 15:55:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46855 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261470AbSIWTzB>;
	Mon, 23 Sep 2002 15:55:01 -0400
Date: Mon, 23 Sep 2002 21:59:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
Message-ID: <20020923215949.A1310@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0209221648180.338-100000@serv> <Pine.LNX.4.44.0209221727290.11808-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209221727290.11808-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Sun, Sep 22, 2002 at 05:36:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 05:36:25PM -0500, Kai Germaschewski wrote:
> > > scripts/lkc/Makefile*
> > > - As kbuild does not distingush between individual objects,
> > >   used for a given target, but (try to) build them all, I have
> > >   found a solution where I create one Makefile for each executable.
> > >   I could not see a clean way to integrate this in kbuild, and finally
> > >   decided that in this special case a number of Makefiles did not
> > >   hurt too much.
> > 
> > Here I thought about using "ifeq ($(MAKECMDGOALS),...)" to keep them in a
> > single file. Did you try something like this?
> 
> That's now handled without obvious hacks.

Applying $(sort ) to create a unique list of obj files does not solve
this issue, only hide it.
kbuild will compile all .o files originating from .c files when 
building conf and mconf.
Likewise when building qconf, all .o files originating from both .c _and_
.cc files will be built.
In other words the current solution leverage on the fact that the only
problematic object files is qconf.o based on qconf.cc.

It is OK that the first "make oldconfig" - automatic or not - 
needs to compile one extra .o file (mconf.o), since this is relatively fast.

PS. linux-isdn.bkbits.net/linux-2.5.kconfig has not showed up yet - mentioned
the patch you posted a diff for.

	Sam
