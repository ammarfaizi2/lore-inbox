Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbTGHXSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267927AbTGHXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:18:32 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:10952 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267928AbTGHXSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:18:24 -0400
Date: Wed, 9 Jul 2003 01:32:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@infradead.org>, vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
Message-ID: <20030708233247.GA140@elf.ucw.cz>
References: <20030624101017.GD159@elf.ucw.cz> <Pine.LNX.4.44.0307082359160.32323-100000@phoenix.infradead.org> <20030708231419.GA619@elf.ucw.cz> <20030709002322.D13083@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709002322.D13083@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This needs to be migrated to the new power management code.
> > 
> > What exactly should it do? Suspend machine? Then it needs to do
> > equivalent of "echo 3 > /proc/acpi/sleep", but I do not think we have
> > generic interface for that...
> 
> It looks like it was intended to call an old version of the suspend
> code on ARM devices - probably the power button on the iPAQ.
> 
> The correct function (in the ARM tree) is now called "suspend()" and
> deals with suspending the devices and then whatever is needed to cause
> the CPU to go into deep sleep - ie, the user visible "power off"
> state.

So perhaps we need to add machine_suspend_ram() and
machine_suspend_disk() to reboot.h? We *do* want to have some generic
interface...

> Absolutely nothing to do with swsusp I'm afraid. 8)

That's okay, I'm doing suspend-to-RAM, too.
								Pavel

> > > > ===================================================================
> > > > --- linux.orig/drivers/input/power.c	2003-06-24 11:54:39.000000000 +0200
> > > > +++ linux/drivers/input/power.c	2003-04-18 16:19:02.000000000 +0200
> > > > @@ -45,9 +45,7 @@
> > > >  static int suspend_button_pushed = 0;
> > > >  static void suspend_button_task_handler(void *data)
> > > >  {
> > > > -        //extern void pm_do_suspend(void);
> > > >          udelay(200); /* debounce */
> > > > -        //pm_do_suspend();
> > > >          suspend_button_pushed = 0;
> > > >  }
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
