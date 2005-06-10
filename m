Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVFJPR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVFJPR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVFJPR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:17:26 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:29125 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262484AbVFJPRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:17:21 -0400
Date: Fri, 10 Jun 2005 08:17:07 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050610151707.GB7858@atomide.com>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com> <20050610091515.GH4173@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610091515.GH4173@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050610 02:15]:
> Hi!
> 
> > > > +#define NS_TICK_LEN		((1 * 1000000000)/HZ)
> > > > +#define DYN_TICK_MIN_SKIP	2
> > > > +
> > > > +#ifdef CONFIG_NO_IDLE_HZ
> > > > +
> > > > +extern unsigned long dyn_tick_reprogram_timer(void);
> > > > +
> > > > +#else
> > > > +
> > > > +#define arch_has_safe_halt()		0
> > > > +#define dyn_tick_reprogram_timer()	{}
> > > 
> > > do {} while (0)
> > > 
> > > , else you are preparing trap for someone.
> > 
> > Can you please explain what the difference between these two are?
> > Some compiler version specific thing?
> 
> It took me quite some remembering. Problem is that with your macros,
> someone can write
> 
> 	dyn_tick_reprogram_timer()
> 	printk();
> 
> [notice missing ; at first line], and still get it compile. If you
> replace {} with do {} while (0), he'll get compile error as he should.

Thanks for clarifying, I'll change it.

Tony
