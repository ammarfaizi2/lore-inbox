Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTI2Vkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTI2Vki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:40:38 -0400
Received: from nevyn.them.org ([66.93.172.17]:34946 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262374AbTI2VkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:40:25 -0400
Date: Mon, 29 Sep 2003 17:40:12 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant.
Message-ID: <20030929214012.GA12688@nevyn.them.org>
Mail-Followup-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Arjan van de Ven <arjanv@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Brian Gerst <bgerst@didntduck.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org> <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz> <20030929202604.GA23344@nevyn.them.org> <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:36:06PM +0200, Mikulas Patocka wrote:
> 
> 
> On Mon, 29 Sep 2003, Daniel Jacobowitz wrote:
> 
> > On Mon, Sep 29, 2003 at 10:20:45PM +0200, Mikulas Patocka wrote:
> > > > > > Use machine_check_vector in the entry code instead.
> > > > >
> > > > > This is wrong. You just lost the "asmlinkage" thing, which means that it
> > > > > breaks when asmlinkage matters.
> > > > >
> > > > > And yes, asmlinkage _can_ matter, even on x86. It disasbles regparm, for
> > > > > one thing, so it makes a huge difference if the kernel is compiled with
> > > > > -mregparm=3 (which used to work, and which I'd love to do, but gcc has
> > > > > often been a tad fragile).
> > > >
> > > > gcc 3.2 and later are supposed to be ok (eg during 3.2 development a
> > > > long standing bug with regparm was fixed and now is believed to work)...
> > > > since our makefiles check gcc version already... this can be made gcc
> > > > version dependent as well for sure..
> > >
> > > They are still buggy. gcc 3.3.1 miscompiles itself with -mregparm=3
> > > (without -O or -O2 it works). (I am too lazy to spend several days trying
> > > to find exactly which function in gcc was miscompiled, maybe I do it one
> > > day). gcc 2.95.3 compiles gcc 3.3.1 with -mregparm=3 -O2 correctly.
> > > gcc 3.4 doesn't seem to be better.
> > >
> > > gcc 2.7.2.3 has totally broken -mregparm=3, even quite simple programs
> > > fail.
> >
> > You can't build GCC with -mregparm=3.  It changes the interface to
> > system functions.  So unless your libc happened to be built with
> > -mregparm=3, and extensively hacked to expect arguments in registers to
> > the assembly stubs, it can't work.
> 
> Of course I linked it with libc compiled with regparm=3.

Did you also hack all the syscall wrappers and hand-coded assembly
routines?  For instance, mmap won't work.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
