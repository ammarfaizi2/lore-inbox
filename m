Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264603AbSIVXOh>; Sun, 22 Sep 2002 19:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264608AbSIVXOh>; Sun, 22 Sep 2002 19:14:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20609 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264603AbSIVXOg>; Sun, 22 Sep 2002 19:14:36 -0400
Date: Sun, 22 Sep 2002 18:19:38 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <Pine.LNX.4.44.0209230102170.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0209221813430.11808-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Roman Zippel wrote:

> > I intentionally only printed a message and errored out in this case, and I
> > think that's more useful, particularly for people doing
> >
> > make all 2>&1 > make.log
> >
> > which now may take forever waiting for input.
> 
> You should have tried this first :) :

Yup, obviously ;) Sorry about that.

> 
> $ make | cat
> make[1]: Entering directory `/home/roman/src/linux-lkc/scripts'
> make[1]: Leaving directory `/home/roman/src/linux-lkc/scripts'
> make[1]: Entering directory `/home/roman/src/lc'
> make[1]: `conf' is up to date.
> make[1]: Leaving directory `/home/roman/src/lc'
> ./scripts/lkc/conf -s arch/i386/config.new
> #
> # using defaults found in .config
> #
> *
> * Restart config...
> *
> Enable loadable module support (MODULES) [Y/n/?] y
>   Set version information on all module symbols (MODVERSIONS) [N/y/?] (NEW) aborted!
> 
> Console input/output is redirected. Run 'make oldconfig' to update configuration.
> 
> make: *** [include/linux/autoconf.h] Error 1

I'm still not happy at least for the ".config does not exist" case. Since 
when I forget to "cp ../config-2.5 .config", I don't really want "make 
oldconfig", I want to do the forgotten cp. I think there's hardly anyone 
who wants oldconfig in that case, rather menuconfig/xconfig or a cp like I 
mentioned. Since kbuild/lkc does not know, it shouldn't make that (bad) 
guess.

If .config exist but is not current, I think in 99% of the cases we really 
want make oldconfig, so that's fine.

--Kai


