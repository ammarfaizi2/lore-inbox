Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSHGLPG>; Wed, 7 Aug 2002 07:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHGLPG>; Wed, 7 Aug 2002 07:15:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:50899 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S318076AbSHGLPE>;
	Wed, 7 Aug 2002 07:15:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] automatic module_init ordering 
In-reply-to: Your message of "Wed, 07 Aug 2002 12:40:22 +0200."
             <Pine.LNX.4.44.0208071208210.28515-100000@serv> 
Date: Wed, 07 Aug 2002 21:10:59 +1000
Message-Id: <20020807112033.00F0E4536@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208071208210.28515-100000@serv> you write:
> Hi,
> 
> On Wed, 7 Aug 2002, Rusty Russell wrote:
> 
> > suspend/wakeup is a device issue, solved well by devicefs.  This is
> > completely independent from the subtleties of initialization order in
> > the core kernel code: devices are not the problem.
> 
> If you see the pci code as a bus device driver, it becomes a problem. I
> looked at the remaining initcalls in my kernel and most of them are for
> pci. I think pci is rather abusing the initcall system.
> I have that idea that pci (like other buses) could become a "normal"
> driver module (one will probably never compile it as a module, but one
> could at least manage it like one).
> So if we integrate the bus initalizations into the device initializations,
> there isn't much left of the current initcalls.

Yes, that's a very astute observation about PCI.  But we will still
have the hard ones left, like the initcalls which want to be called
before SMP, or two-sided registration mechanisms (anything which has
registration of servers and clients) still requires ordering.

> > I really want *one* place where you can see what order things are
> > initalized.  If that means one big file with #ifdef's, fine.  But the
> > current approach of using link order, initializer levels and explicit
> > initializers is really hard to debug and modify.
> 
> I agree that it's currently a mess, maybe your solution is the better in
> the short term to make the dependencies explicit, I'm not sure about that.
> My idea is to handle as much as possible over the module/driver
> initialization mechanisms and leave initcalls as special cases.

The best thing about the explicit initcalls is that they document
everything they are relying on, so they can be replaced.  At the
moment it's very hard to see how to replace an initcall (does it rely
on link order for example).

I don't think we can complete the conversion before 2.6, so I think we
need both.  If explicit core initcalls become v. rare, great!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
