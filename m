Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSHGC1i>; Tue, 6 Aug 2002 22:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHGC1i>; Tue, 6 Aug 2002 22:27:38 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38793 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316682AbSHGC1h>; Tue, 6 Aug 2002 22:27:37 -0400
Date: Tue, 6 Aug 2002 21:28:58 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering 
In-Reply-To: <20020807020259.4CAED417A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208062117180.12314-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> Look at how many places have explicit initializers with #ifdef
> CONFIG_XXX around them, because initialization order problems were too
> hard before.  These can now be fixed as desired.
> 
> I really want *one* place where you can see what order things are
> initalized.  If that means one big file with #ifdef's, fine.  But the
> current approach of using link order, initializer levels and explicit
> initializers is really hard to debug and modify.

Since I'm still CC'ed, I thought I could add in my 2 cents, too ;)

I agree with Rusty, his ordered initcalls are really needed most at early 
points during the system initialization, way before device discovery and 
initialization. They allow for a lot of cleanup and clarification in that 
area, so I definitely think they should go in.

Those initcalls that only do pci_register_driver() and the like are
typically the module_init() functions and are taken care of by Roman's
patch. Also, inserting devices into the device tree and handling them can
only happen after the kernel knows about the drivers, which it only does
after the corresponding initcall has run. The place where to insert them
is however an entirely different story, and that's handled by the device
tree just fine.

--Kai



