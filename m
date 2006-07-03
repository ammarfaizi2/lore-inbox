Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWGCG1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWGCG1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGCG1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:27:13 -0400
Received: from www.osadl.org ([213.239.205.134]:23228 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750785AbWGCG1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:27:13 -0400
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mingo@elte.hu, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060702173527.cbdbf0e1.akpm@osdl.org>
References: <1151885928.24611.24.camel@localhost.localdomain>
	 <20060702173527.cbdbf0e1.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 08:29:38 +0200
Message-Id: <1151908178.24611.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 17:35 -0700, Andrew Morton wrote:
> >  
> >  #ifdef CONFIG_GENERIC_HARDIRQS
> >  
> > +#ifndef handle_dynamic_tick
> > +# define handle_dynamic_tick(a)		do { } while (0)
> > +#endif
> > +
> >  #ifdef CONFIG_SMP
> >  static inline void set_native_irq_info(int irq, cpumask_t mask)
> >  {
> 
> This is not exactly a thing of beauty either.  It's much cleaner to use
> __attribute__((weak)), but that will add an empty call-return to everyone's
> interrupts.
> 
> The requirement "if you implement this then you must do so as a macro" is a
> bit regrettable.  The ARCH_HAS_HANDLE_DYNAMIC_TICK approach would eliminate
> that requirement.

This quirk should go away once we come around to generalize and
consolidate the dyntick stuff.

> btw, is this, from include/linux/irq.h:
> 
> /*
>  * Please do not include this file in generic code.  There is currently
>  * no requirement for any architecture to implement anything held
>  * within this file.
>  *
>  * Thanks. --rmk
>  */
> 
> still true?

I think what it means is that linux/irq.h must not be included in
drivers. drivers should include linux/interrupt.h instead.

	tglx


