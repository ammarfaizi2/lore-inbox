Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSG1MPy>; Sun, 28 Jul 2002 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSG1MPy>; Sun, 28 Jul 2002 08:15:54 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:65294 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315760AbSG1MPx>; Sun, 28 Jul 2002 08:15:53 -0400
Date: Sun, 28 Jul 2002 14:18:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] automatic initcalls 
In-Reply-To: <20020728033359.7B2A2444C@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207281358070.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 28 Jul 2002, Rusty Russell wrote:

> > - I only look at modules which contain an initcall
> > - I only order initcalls of level 6 and 7
>
> You don't seem to handle the ordering of initcalls within a module
> though: see net/ipv4/netfilter/ip_conntrack.o for an example of
> multiple inits which would be much better as separate initcalls.

Actually I'm most interested in ordering "module_init()" and you can have
only one of them per module or how do you want to implement multiple
initcalls per module?

> Especially since you don't cover any of the really interesting cases.
> Maybe if you could slowly extend it to cover the rest?  (Hah, I
> know!).

I wouldn't mind if the remaining initcalls are converted to explicit
dependencies, but it's possible to sort automatically everything that can
be built as modules.

> > +init/generated-initcalls.c: .allinit.defs
> > +	set -e; echo '#include <linux/init.h>' > $@; \
> > +	sed -n < $< "s,^T ,,p" | sort > .defined.all; \
>
> I think you mean something like:
>
> 	sed -n "s,^T ,,p" < $<

Isn't that the same?

bye, Roman

