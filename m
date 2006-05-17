Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWEQIcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWEQIcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWEQIcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:32:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:5784 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751042AbWEQIcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:32:46 -0400
Date: Wed, 17 May 2006 10:32:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch 01/50] genirq: cleanup: merge irq_affinity[] into irq_desc[]
Message-ID: <20060517083210.GA26456@elte.hu>
References: <20060517001323.GB12877@elte.hu> <20060517055650.GA19785@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517055650.GA19785@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> > +++ linux-genirq.q/arch/powerpc/platforms/pseries/xics.c
> > @@ -238,7 +238,7 @@ static int get_irq_server(unsigned int i
> >  {
> >  	unsigned int server;
> >  	/* For the moment only implement delivery to all cpus or one cpu */
> > -	cpumask_t cpumask = irq_affinity[irq];
> > +	cpumask_t cpumask = irq_desc[irq].affinity;
> >  	cpumask_t tmp = CPU_MASK_NONE;
> >  
> >  	if (!distribute_irqs)
> 
> Assigned unconditionally - outside CONFIG_SMP as I read the code but..

> > +#ifdef CONFIG_SMP
> > +	cpumask_t affinity;
> > +#endif

> But defined only for SMP. Looks wrong at first look.

but the original array was under SMP too:

 --- linux-genirq.q.orig/kernel/irq/manage.c
 +++ linux-genirq.q/kernel/irq/manage.c
 @@ -16,8 +16,6 @@

  #ifdef CONFIG_SMP

 -cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };

so if then this is a powerpc bug. (probably pseries is rarely built 
without SMP support)

	Ingo
