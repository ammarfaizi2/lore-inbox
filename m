Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264574AbSIVWbf>; Sun, 22 Sep 2002 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264575AbSIVWbf>; Sun, 22 Sep 2002 18:31:35 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9089 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264574AbSIVWbe>; Sun, 22 Sep 2002 18:31:34 -0400
Date: Sun, 22 Sep 2002 17:36:25 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <Pine.LNX.4.44.0209221648180.338-100000@serv>
Message-ID: <Pine.LNX.4.44.0209221727290.11808-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Roman Zippel wrote:

> > I have been working on integrating lkc with kbuild.
> > Here is the result.
> 
> Thanks, nice work. :)

Yup, I improved things a bit further.

> > Rules.make
> > - Added infrastructure to support host-ccprogs, in other words
> >   support tools written (partly) in c++.
> 
> There are all compiled with gcc instead of g++, are you sure that will ok
> with all supported gcc versions?

I fixed that.

> > scripts/lkc/Makefile*
> > - As kbuild does not distingush between individual objects,
> >   used for a given target, but (try to) build them all, I have
> >   found a solution where I create one Makefile for each executable.
> >   I could not see a clean way to integrate this in kbuild, and finally
> >   decided that in this special case a number of Makefiles did not
> >   hurt too much.
> 
> Here I thought about using "ifeq ($(MAKECMDGOALS),...)" to keep them in a
> single file. Did you try something like this?

That's now handled without obvious hacks.

> > flex/bison
> > - Prepared for "_shipped" files.
> >   Rename lex.zconf.c to lex.zconf.c_shipped etc. in the version
> >   reday to go in the kernel.
> 
> This works quite well for users, but it's very annoying for the developer.
> Kai, any chances to use md5sum for this at some point, e.g. with a helper
> script like this:
> 
> set -e
> src=$1
> dst=$2
> shift 2
> 
> test -f $dst && tail -1 $dst | sed 's,/\* \(.*\) \*/,\1,' | md5sum -c && touch $dst && exit 0
> echo "$@"
> "$@"
> echo "/* $(md5sum $src) */" >> $dst

I'm not particularly fond of these md5sum hacks. I don't think it's all 
that annoying for the developer, either, it's basically just a
alias make="make LKC_GENPARSER=1"

(Of course, you'll have to update the _shipped files eventually, but there 
isn't really any way around that either way)

One might consider setting LKC_GENPARSER based on a test if bison/flex are 
in the path.

> Something else I'd like to have for later is the ability to compile
> $(sharedobjs) as a shared library and install it somewhere so it can be
> used by external programs.

Well, later ;)

--Kai

I created a combined patch with lkc-0.6, Sam's patch and my things on top
of current 2.5-bk (And I would strongly suggest to make further releases
like this, if people need to first figure out how to install and what to
run, they won't test lkc at all). As a result, it's fairly large, so I put
it on

	http://zephyr.physics.uiowa.edu/~kai/lkc/lkc-0.6-A

--Kai


