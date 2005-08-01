Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVHAVdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVHAVdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVHAV2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:28:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2470 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261289AbVHAV2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:28:03 -0400
Date: Mon, 1 Aug 2005 23:28:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luca Falavigna <dktrkranz@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED declaration
Message-ID: <20050801212833.GA23948@elte.hu>
References: <42EE4D27.8060500@gmail.com> <1122922658.6759.22.camel@localhost.localdomain> <20050801210324.GA21087@elte.hu> <1122931497.6759.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122931497.6759.47.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2005-08-01 at 23:03 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > -	struct semaphore stop;
> > > +	struct compat_semaphore stop;
> > 
> > i think it's policy->lock that is the issue here?
> > 
> 
> I was looking at Luca's original message where he showed the bug of 
> -- drivers/char/watchdog/cpu5wdt.c: "cpu5wdt: Unknown symbol
> there_is_no_init_MUTEX_LOCKED_for_RT_semaphores") --
> Looking into this file the only init_MUTEX_LOCKED that I found was 
> 
> static int __devinit cpu5wdt_init(void)
> {
> 	unsigned int val;
> 	int err;
> 
> [...]
> 
> 	/* watchdog reboot? */
> 	val = inb(port + CPU5WDT_STATUS_REG);
> 	val = (val >> 2) & 1;
> 	if ( !val )
> 		printk(KERN_INFO PFX "sorry, was my fault\n");
> 
> 	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
> 	cpu5wdt_device.queue = 0;
> 
> 	clear_bit(0, &cpu5wdt_device.inuse);
> 
> 
> 
> Here I see that cpu5wdt_device.stop is being initialized with 
> init_MUTEX_LOCKED, so that is what I went to fix.  I even added the 
> driver to my config and compiled it before sending it in.  I don't 
> have the device, but the driver compiled :-)

ok - the fix is in -52-10.

	Ingo
