Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265655AbUF2JMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUF2JMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUF2JMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 05:12:18 -0400
Received: from gprs214-172.eurotel.cz ([160.218.214.172]:42883 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265655AbUF2JMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 05:12:16 -0400
Date: Tue, 29 Jun 2004 11:08:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Next step of smp support & fix device suspending
Message-ID: <20040629090823.GE7215@elf.ucw.cz>
References: <20040625115529.GA764@elf.ucw.cz> <Pine.LNX.4.50.0406280809540.20762-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0406280809540.20762-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This introduces functions for stopping all-but-boot-cpus, which will
> > be needed for smp suspend, and fixes level for calling driver model:
> > there's no D4 power level, only D3 (means device off), and tg3 driver
> > actually cares. Ugh and one useless mdelay killed, and
> > freeze_processes() now BUGS() if its not compiled in. [We can probably
> > just remove it for non-CONFIG_PM case in future]. It is bad idea to
> > pretend success, and nobody should ever call it in !CONFIG_PM case
> > anyway. Please apply,
> 
> Nice, just a couple of questions...

Thanks.

> > -	device_power_down(4);
> > +	device_power_down(3);
> 
> There are defined values in include/linux/device.h. You should be using
> those, instead of the magic constants (even if the magic constants
> actually make sense as the power states :).

Ugh, I have not figured which magic constants should I use. Should
that be SUSPEND_POWER_DOWN?

> >  	PRINTK( "Waiting for DMAs to settle down...\n");
> >  	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
> >  			   Do it with disabled interrupts for best effect. That way, if some
> 
> On a related note, can we kill this piece of code? It's not clear that
> it's necessary. If it is, it begs for a more systematic way of achieving
> the goal.

Ok, killed, I'll propagate it if there are no problems.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
