Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWITUXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWITUXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWITUXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:23:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16259 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750746AbWITUXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:23:05 -0400
Date: Wed, 20 Sep 2006 22:14:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060920201450.GA22482@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <1158783590.29177.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158783590.29177.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> What about the !PREEMPT_RT case.. It still wouldn't disable interrupts 
> in the below..
>
> -       local_irq_save(flags);
>         if (up->port.sysrq) {
>                 /* serial8250_handle_port() already took the lock */
>                 locked = 0;
>         } else if (oops_in_progress) {
> -               locked = spin_trylock(&up->port.lock);
> +               locked = spin_trylock_irqsave(&up->port.lock, flags);
>         } else
> -               spin_lock(&up->port.lock);
> +               spin_lock_irqsave(&up->port.lock, flags);

_irqsave disables interrupts, always did.

	Ingo
