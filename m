Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTGHXIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTGHXIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:08:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64272 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265440AbTGHXIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:08:53 -0400
Date: Wed, 9 Jul 2003 00:23:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>, vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
Message-ID: <20030709002322.D13083@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	James Simmons <jsimmons@infradead.org>, vojtech@suse.cz,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030624101017.GD159@elf.ucw.cz> <Pine.LNX.4.44.0307082359160.32323-100000@phoenix.infradead.org> <20030708231419.GA619@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708231419.GA619@elf.ucw.cz>; from pavel@suse.cz on Wed, Jul 09, 2003 at 01:14:19AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 01:14:19AM +0200, Pavel Machek wrote:
> > This needs to be migrated to the new power management code.
> 
> What exactly should it do? Suspend machine? Then it needs to do
> equivalent of "echo 3 > /proc/acpi/sleep", but I do not think we have
> generic interface for that...

It looks like it was intended to call an old version of the suspend
code on ARM devices - probably the power button on the iPAQ.

The correct function (in the ARM tree) is now called "suspend()" and
deals with suspending the devices and then whatever is needed to cause
the CPU to go into deep sleep - ie, the user visible "power off" state.

Absolutely nothing to do with swsusp I'm afraid. 8)

> > > ===================================================================
> > > --- linux.orig/drivers/input/power.c	2003-06-24 11:54:39.000000000 +0200
> > > +++ linux/drivers/input/power.c	2003-04-18 16:19:02.000000000 +0200
> > > @@ -45,9 +45,7 @@
> > >  static int suspend_button_pushed = 0;
> > >  static void suspend_button_task_handler(void *data)
> > >  {
> > > -        //extern void pm_do_suspend(void);
> > >          udelay(200); /* debounce */
> > > -        //pm_do_suspend();
> > >          suspend_button_pushed = 0;
> > >  }

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

