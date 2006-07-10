Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWGJJci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWGJJci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWGJJci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:32:38 -0400
Received: from www.osadl.org ([213.239.205.134]:25283 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932290AbWGJJch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:32:37 -0400
Subject: Re: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need
	refcounting too
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
In-Reply-To: <20060710085849.GA6016@elte.hu>
References: <200607091458.52298.david-b@pacbell.net>
	 <20060710085849.GA6016@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 10 Jul 2006 11:32:34 +0200
Message-Id: <1152523954.30929.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 10:58 +0200, Ingo Molnar wrote:
> * David Brownell <david-b@pacbell.net> wrote:
> 
> > It's not just "normal" mode operation that needs refcounting for the 
> > {en,dis}able_irq() calls ... "wakeup" mode calls need it too, for the 
> > very same reasons.
> > 
> > This patch adds that refcounting.  I expect that some ARM drivers will 
> > be triggering the new warning, but this call isn't yet widely used. 
> > (Which is probably why the bug has lingered this long...)
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

  Acked-by: Thomas Gleixner <tglx@linutronix.de>

> we should also add disable_irq_wake() / enable_irq_wake() APIs and start 
> migrating most ARM users over to the new APIs, agreed? That makes the 
> APIs more symmetric and the code more readable too.

see linux/interrupt.h:

/* IRQ wakeup (PM) control: */
extern int set_irq_wake(unsigned int  irq, unsigned int on);

static inline int enable_irq_wake(unsigned int irq)
{
        return set_irq_wake(irq, 1);
}

static inline int disable_irq_wake(unsigned int irq)
{
        return set_irq_wake(irq, 0);
}

It's already there and ARM uses those functions :)

	tglx


