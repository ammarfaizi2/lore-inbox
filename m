Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319202AbSHNEpv>; Wed, 14 Aug 2002 00:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSHNEpu>; Wed, 14 Aug 2002 00:45:50 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13504 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S319202AbSHNEpk>; Wed, 14 Aug 2002 00:45:40 -0400
Date: Tue, 13 Aug 2002 23:39:52 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg Banks <gnb@alphalink.com.au>
cc: Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <3D59BFF5.2C3B4B6A@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208132329520.32010-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Greg Banks wrote:

> Peter Samuelson wrote:
> > 
> > [Greg Banks]
> > > Does "complete" mean all the ports have also made the change and
> > > been merged back?
> > [...]
> > Actually I suspect it would be more like the C99 thing: after the new
> > syntax is added, we start doing [TRIVIAL] patches to clean out the
> > old, and eventually once that is done we have the option of removing
> > the old syntax or leaving it in as a known oddity. [...]

Well, I think when the switch does not change any behavior, it's actually
okay to get it over with in one large but trivial patch. The other 
approach would be to give the new syntax the new behavior, and do the 
actual switch piecemeal, checking and fixing dep_* statements as they get 
converted.

It'd be nice to introduce a warning for statements where the old syntax is
used, but that seems not possible at least in Configure, since I think 
statements like

dep_tristate '...' CONFIG_FOO m

should remain valid.

> #
> # Testing mixed overlap, type 1
> # (mixed overlap, define first, query conditional, same menu)
> #
> 
> mainmenu_option next_comment
> comment 'xconfig needs this menu'
> 
>     define_bool CONFIG_QUUX y
> 
>     bool 'Set this symbol to ON' CONFIG_FOO
> 
>     if [ "$CONFIG_FOO" = "y" ]; then
> 	bool 'Here QUUX is a query symbol' CONFIG_QUUX
>     fi
> 
> endmenu

Well, it's a bug.

Setting CONFIG_QUUX to "y" when CONFIG_FOO is "n" can be done in
an else clause to the if statement. If you want to set a default, that's 
what defconfig is for.

What's nice is that you identified so many problematic cases already, so 
fixing shouldn't be hard. It may still make sense to add code to 
"Configure" which recognizes a redefinition and complains or even aborts.

--Kai

