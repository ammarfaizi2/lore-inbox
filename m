Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVG0Jvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVG0Jvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 05:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVG0Jvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 05:51:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26297 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262108AbVG0Ju7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 05:50:59 -0400
Date: Wed, 27 Jul 2005 11:50:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
Message-ID: <20050727095042.GD4270@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz> <20050727023754.6846f3a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727023754.6846f3a2.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds support for powering Zaurus's video up and down.
> 
> I assume you have a new toy ;)

Actually very old toy, but I decided to make it working with 2.6
kernel (needed for bluetooth). Which is not quite an easy task.

> >  PDA without
> > screen is kind of useless, so it is quite important... I'll have to
> > figure out how to really control the frontlight, because LCD without
> > that is quite hard to read.
> 
> signed-off-by?

Sorry, will add.

> > @@ -0,0 +1,156 @@
> > +/*
> > + * Backlight control code for Sharp Zaurus SL-5500
> > + *
> > + * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
> > + * GPL v2
> 
> Who is the maintainer for this stuff?

I guess I'll maintain in.

> > +static struct locomo_dev *locomolcd_dev = NULL;
> 
> bah.

Well, sa1100fb_lcd_power is not provide us with void * we could use,
and by definition you only have one frontlight in a PDA, so that
should be okay...

> > +void locomolcd_power(int on)
> > +{
> > +	int comadj = 118;
> > +	unsigned long flags;
> > +	
> > +	local_irq_save(flags);
> 
> What strange locking this driver uses.  It appears to be assuming
> uniprocessor, yes?

Yes, and I guess that's okay: collie is slightly old hardware, and
noone is going to retrofit second CPU to old PDA.

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
