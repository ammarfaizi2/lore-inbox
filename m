Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWGCHCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWGCHCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWGCHCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:02:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24033 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750969AbWGCHCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:02:17 -0400
Date: Mon, 3 Jul 2006 08:57:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-ID: <20060703065735.GA19780@elte.hu>
References: <1151885928.24611.24.camel@localhost.localdomain> <20060702173527.cbdbf0e1.akpm@osdl.org> <1151908178.24611.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151908178.24611.39.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > btw, is this, from include/linux/irq.h:
> > 
> > /*
> >  * Please do not include this file in generic code.  There is currently
> >  * no requirement for any architecture to implement anything held
> >  * within this file.
> >  *
> >  * Thanks. --rmk
> >  */
> > 
> > still true?
> 
> I think what it means is that linux/irq.h must not be included in 
> drivers. drivers should include linux/interrupt.h instead.

Christoph has had ideas for cleanups in the irq-header-files area for a 
long time. My rough battleplan would be this:

- linux/interrupt.h should remain the highlevel driver API [which can be
  used by both physical (genirq or non-genirq) or virtual platforms].
  Only this file should be included by drivers.

- rename linux/irq.h to linux/irqchips.h, to make it less likely for
  drivers to include it accidentally.

- rename asm/irq.h to asm/irqchips.h

- most of linux/hardirq.h should merge into interrupt.h [the rest into
  linux/irqchips.h] and hardirq.h should be eliminated.

- merge asm/hardirq.h and asm/hw_irq.h into asm/irqchips.h.

Christoph, agreed?

	Ingo
