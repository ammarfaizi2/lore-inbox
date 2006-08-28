Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWH1Pet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWH1Pet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWH1Pet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:34:49 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:65001 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1750709AbWH1Pes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:34:48 -0400
Date: Mon, 28 Aug 2006 08:24:28 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/18] 2.6.17.9 perfmon2 patch for review: PMU interruption support
Message-ID: <20060828152428.GE20394@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85wQc000420@frankl.hpl.hp.com> <20060823154057.4d6d444b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823154057.4d6d444b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I am slowly going through your excellent feedback and I am making
the changes suggested. I will reply to all your questions.

On Wed, Aug 23, 2006 at 03:40:57PM -0700, Andrew Morton wrote:
> On Wed, 23 Aug 2006 01:05:58 -0700
> Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:
> 
> > ...
> >
> > +irqreturn_t pfm_interrupt_handler(int irq, void *arg, struct pt_regs *regs)
> > +{
> > +	u64 start_cycles, total_cycles;
> > +
> > +	get_cpu();
> > +
> > +	start_cycles = pfm_arch_get_itc();
> > +
> > +	__pfm_interrupt_handler(regs);
> > +
> > +	total_cycles = pfm_arch_get_itc();
> > +
> > +	__get_cpu_var(pfm_stats).pfm_ovfl_intr_cycles += total_cycles - start_cycles;
> > +
> > +	put_cpu_no_resched();
> > +	return IRQ_HANDLED;
> > +}
> 
> If this code is only ever called from interrupt context then I suspect the
> get_cpu() is not needed.  __get_cpu_var() requires that preemption be
> disabled (so we cannot wander over to a different CPU midway) but IRQ
> code doesn't get preempted.

Yes, this function is ONLY called on PMU interrupt. I will remove the useless
get_cpu()/put_cpu() code then.

Thanks.

-- 

-Stephane
