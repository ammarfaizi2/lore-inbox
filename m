Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSG2XxE>; Mon, 29 Jul 2002 19:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSG2XxE>; Mon, 29 Jul 2002 19:53:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54662 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318141AbSG2XxD>;
	Mon, 29 Jul 2002 19:53:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] automatic initcalls 
In-reply-to: Your message of "Sun, 28 Jul 2002 14:18:28 +0200."
             <Pine.LNX.4.44.0207281358070.28515-100000@serv> 
Date: Tue, 30 Jul 2002 09:46:15 +1000
Message-Id: <20020729235746.2FD3C427D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207281358070.28515-100000@serv> you write:
> Hi,
> 
> On Sun, 28 Jul 2002, Rusty Russell wrote:
> 
> > > - I only look at modules which contain an initcall
> > > - I only order initcalls of level 6 and 7
> >
> > You don't seem to handle the ordering of initcalls within a module
> > though: see net/ipv4/netfilter/ip_conntrack.o for an example of
> > multiple inits which would be much better as separate initcalls.
> 
> Actually I'm most interested in ordering "module_init()" and you can have
> only one of them per module or how do you want to implement multiple
> initcalls per module?

Sorry, you are right.  That was a brain fart.

> > Especially since you don't cover any of the really interesting cases.
> > Maybe if you could slowly extend it to cover the rest?  (Hah, I
> > know!).
> 
> I wouldn't mind if the remaining initcalls are converted to explicit
> dependencies, but it's possible to sort automatically everything that can
> be built as modules.

Yes, I think we should do this: merge the two together.  You seem to
be in a coding frenzy: want to do the first cut?

I'll probably change my initdepends section format to make it shorter
and easier to parse.  But that change should be independent.

> > > +init/generated-initcalls.c: .allinit.defs
> > > +	set -e; echo '#include <linux/init.h>' > $@; \
> > > +	sed -n < $< "s,^T ,,p" | sort > .defined.all; \
> >
> > I think you mean something like:
> >
> > 	sed -n "s,^T ,,p" < $<
> 
> Isn't that the same?

Argh, not my day, clearly.  Let's pretend I didn't send that mail,
shall we?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
