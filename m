Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSHGB6T>; Tue, 6 Aug 2002 21:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSHGB6S>; Tue, 6 Aug 2002 21:58:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:3749 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S316906AbSHGB5b>;
	Tue, 6 Aug 2002 21:57:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] automatic module_init ordering 
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
In-reply-to: Your message of "Tue, 06 Aug 2002 20:57:00 +0200."
             <Pine.LNX.4.44.0208062031040.28515-100000@serv> 
Date: Wed, 07 Aug 2002 11:05:43 +1000
Message-Id: <20020807020259.4CAED417A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208062031040.28515-100000@serv> you write:
> Hi,
> 
> On Tue, 6 Aug 2002, Rusty Russell wrote:
> 
> > > - I use a separate initcall for the module initialization, that's the
> > > only way I can solve my IDE problems.
> >
> > That's horrible 8(  I think we need figure out why this is happening:
> > do you know?  What does it actually need?
> 
> I think pci initialization.
> 
> > I've updated my explicit core initcalls patch on top of your new one,
> > thanks!
> >
> > 	http://www.kernel.org/pub/linux/kernel/people/rusty/Misc/ordered-core-i
nitcalls.patch.2.5.30.gz
> 
> I'm not sure we should go this way. My main problem is that it only solves
> a single ordering problem - boot time ordering. What about suspend/wakeup?
> We have more of these ordering problems and driverfs is supposed to help
> with them, so I'd rather first would like to see how much we can fix this
> way.

suspend/wakeup is a device issue, solved well by devicefs.  This is
completely independent from the subtleties of initialization order in
the core kernel code: devices are not the problem.

Look at how many places have explicit initializers with #ifdef
CONFIG_XXX around them, because initialization order problems were too
hard before.  These can now be fixed as desired.

I really want *one* place where you can see what order things are
initalized.  If that means one big file with #ifdef's, fine.  But the
current approach of using link order, initializer levels and explicit
initializers is really hard to debug and modify.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
