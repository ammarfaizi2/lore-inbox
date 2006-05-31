Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWEaVqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWEaVqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWEaVqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:46:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:17816 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965181AbWEaVqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:46:43 -0400
Subject: Re: [patch, -rc5-mm1] genirq: add chip->eoi(), fastack -> fasteoi
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060531213002.GB3174@elte.hu>
References: <1149040361.766.10.camel@localhost.localdomain>
	 <1149064735.20582.85.camel@localhost.localdomain>
	 <1149066718.766.51.camel@localhost.localdomain>
	 <20060531101925.GA27637@elte.hu>
	 <1149110637.29764.9.camel@localhost.localdomain>
	 <20060531213002.GB3174@elte.hu>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 07:46:20 +1000
Message-Id: <1149111980.29764.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 23:30 +0200, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Hrm... ok. Not sure I agree with adding one more callback but it 
> > doesn't matter much.
> > 
> > Thing is, end() isn't used anymore at all now. Thus it's just 
> > basically renaming end() to eoi() except that end() is still there for 
> > whoever uses __do_IRQ() and ... handle_percpu_irq(). Doesn't make that 
> > much sense to me. So I suppose you should also change 
> > handle_percpu_irq() to use eoi() then and consider end() to be 
> > "legacy" (to be used only by __do_IRQ) ?
> 
> ok, that works with me. I did not want to reuse ->end() just to have a 
> clean migration path. ->eoi() is in fact quite descriptive as well, so 
> i'm not worried about the name.

Ok, I'll send a patch changing percpu to also use eoi() later from work
unless you beat me to it.

> > > sounds like a plan? The patch below works fine for me.
> > 
> > The patch is _almost_ right to me :) I don't need the
> > 
> > 	if (unlikely(desc->status & IRQ_DISABLED))
> >  		desc->chip->mask(irq);
> > 
> > At all. I suppose it won't harm, but it shouldn't be necessary for me 
> > and I'm not sure why it's necessary on IO_APIC neither (but then I 
> > don't know those very well).
> 
> hm, i dont think it's necessary either. I'll run a few experiments. 
> Thomas, do you remember why we have that masking there?

Ben.


