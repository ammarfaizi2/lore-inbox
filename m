Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbTIAWkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTIAWkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:40:42 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:19917 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263308AbTIAWkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:40:40 -0400
Date: Tue, 2 Sep 2003 00:40:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Cc: rmk@arm.linux.org.uk
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901224018.GA470@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz> <20030901233023.F22682@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901233023.F22682@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Please don't - that means undoing all the work I've put in to make
> > > ARM work again, and I don't have time to play silly games like this.
> > 
> > Okay, so Patrick broke ARM and you fixed it. But he also broke i386 and
> > x86-64; and it is not at all clear that his "newer" version is better
> > than the old one. [Really, what's the advantage? AFAICS it is more
> > complicated and less flexible, putting "suspend" method to bus as
> > oppossed to device].
> 
> I don't think PCI device support broke - Pat seems to have fixed up
> all that fairly nicely, so the driver model change should be
> transparent.

As far as I can test, yes, at least UHCI looks broken :-(. It is true
that calling convention at PCI level did not change.

> The main advantage from a driver writers point of view is the disposal
> of the "level" argument.  (Doesn't really affect x86, PCI drivers never
> had visibility of this.)

Yes, "level" is gone, instead we have very ugly
-EAGAIN-means-call-me-with-interrupts-disabled hack.

> However, I'll let the PPC people justify the real reason for the driver
> model change, since it was /their/ requirement that caused it, and I'm
> not going to fight their battles for them.  (although I seem to be doing
> exactly that while wasting my time here.)

I noticed something going on, but it seem to me one more "struct bus"
would have solved that...
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
