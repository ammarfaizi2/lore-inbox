Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269640AbUICMFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269640AbUICMFT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbUICMFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:05:19 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57575 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269640AbUICMEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:04:49 -0400
Date: Fri, 3 Sep 2004 08:09:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][6/8] Arch agnostic completely out of line locks / arm
In-Reply-To: <20040903100456.A7535@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0409030808280.4481@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021237000.4481@montezuma.fsmlabs.com>
 <20040903100456.A7535@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Russell King wrote:

> On Thu, Sep 02, 2004 at 08:02:55PM -0400, Zwane Mwaikambo wrote:
> > --- linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c	26 Aug 2004 13:13:04 -0000	1.1.1.1
> > +++ linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c	2 Sep 2004 15:51:37 -0000
> > @@ -52,6 +52,18 @@ EXPORT_SYMBOL(rtc_lock);
> >  /* change this if you have some constant time drift */
> >  #define USECS_PER_JIFFY	(1000000/HZ)
> >
> > +#ifdef CONFIG_SMP
> > +unsigned long profile_pc(struct pt_regs *regs)
> > +{
> > +	unsigned long pc = instruction_pointer(regs);
> > +
> > +	if (pc >= (unsigned long)&__lock_text_start &&
> > +	    pc <= (unsigned long)&__lock_text_end)
> > +		return regs->ARM_lr;
> > +	return pc;
> > +}
> > +EXPORT_SYMBOL(profile_pc);
> > +#endif
>
> Looks good apart from this.  There's no guarantee that LR will be the
> return address inside one of these lock functions - indeed the compiler
> may have saved it onto the stack and decided to use the register for
> something else.
>
> Your best bet is to look at the get_wchan() code which walks the stack
> frames (if present.)

Thanks, i'll change it in the followup.

	Zwane

