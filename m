Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSHGKha>; Wed, 7 Aug 2002 06:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318160AbSHGKha>; Wed, 7 Aug 2002 06:37:30 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:45574 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318210AbSHGKh3>; Wed, 7 Aug 2002 06:37:29 -0400
Date: Wed, 7 Aug 2002 12:40:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering 
In-Reply-To: <20020807020259.4CAED417A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208071208210.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Aug 2002, Rusty Russell wrote:

> > I'm not sure we should go this way. My main problem is that it only solves
> > a single ordering problem - boot time ordering. What about suspend/wakeup?
> > We have more of these ordering problems and driverfs is supposed to help
> > with them, so I'd rather first would like to see how much we can fix this
> > way.
>
> suspend/wakeup is a device issue, solved well by devicefs.  This is
> completely independent from the subtleties of initialization order in
> the core kernel code: devices are not the problem.

If you see the pci code as a bus device driver, it becomes a problem. I
looked at the remaining initcalls in my kernel and most of them are for
pci. I think pci is rather abusing the initcall system.
I have that idea that pci (like other buses) could become a "normal"
driver module (one will probably never compile it as a module, but one
could at least manage it like one).
So if we integrate the bus initalizations into the device initializations,
there isn't much left of the current initcalls.

> Look at how many places have explicit initializers with #ifdef
> CONFIG_XXX around them, because initialization order problems were too
> hard before.  These can now be fixed as desired.
>
> I really want *one* place where you can see what order things are
> initalized.  If that means one big file with #ifdef's, fine.  But the
> current approach of using link order, initializer levels and explicit
> initializers is really hard to debug and modify.

I agree that it's currently a mess, maybe your solution is the better in
the short term to make the dependencies explicit, I'm not sure about that.
My idea is to handle as much as possible over the module/driver
initialization mechanisms and leave initcalls as special cases.

bye, Roman

