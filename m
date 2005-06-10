Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVFJJPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVFJJPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVFJJPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:15:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11211 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262327AbVFJJPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:15:33 -0400
Date: Fri, 10 Jun 2005 11:15:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050610091515.GH4173@elf.ucw.cz>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610041706.GC18103@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +#define NS_TICK_LEN		((1 * 1000000000)/HZ)
> > > +#define DYN_TICK_MIN_SKIP	2
> > > +
> > > +#ifdef CONFIG_NO_IDLE_HZ
> > > +
> > > +extern unsigned long dyn_tick_reprogram_timer(void);
> > > +
> > > +#else
> > > +
> > > +#define arch_has_safe_halt()		0
> > > +#define dyn_tick_reprogram_timer()	{}
> > 
> > do {} while (0)
> > 
> > , else you are preparing trap for someone.
> 
> Can you please explain what the difference between these two are?
> Some compiler version specific thing?

It took me quite some remembering. Problem is that with your macros,
someone can write

	dyn_tick_reprogram_timer()
	printk();

[notice missing ; at first line], and still get it compile. If you
replace {} with do {} while (0), he'll get compile error as he should.

> > > Index: linux-dev/kernel/dyn-tick.c
> > > ===================================================================
> > > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > > +++ linux-dev/kernel/dyn-tick.c	2005-06-02 10:37:12.000000000 -0700
> > > @@ -0,0 +1,235 @@
> > > +/*
> > > + * linux/arch/i386/kernel/dyn-tick.c
> > > + *
> > > + * Beginnings of generic dynamic tick timer support
> > > + *
> > > + * Copyright (C) 2004 Nokia Corporation
> > > + * Written by Tony Lindgen <tony@atomide.com> and
> > > + * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
> > > + *
> > 
> > Heh, you work for Nokia? Can I get one of those nokia 770 toys? I
> > should have 100 euros somewhere here :-).
> 
> Yes, we did dyntick originally for ARM OMAP and 770. I don't think
> I have any power who Nokia will be giving the discount developer
> 770's for though :) I think you have to apply on some webpage...

Thanks for the info (and for the ARM work).
								Pavel 
