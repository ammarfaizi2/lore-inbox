Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932967AbWFWJds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbWFWJds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932970AbWFWJds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:33:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31697 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932967AbWFWJdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:33:47 -0400
Date: Fri, 23 Jun 2006 11:28:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 21/61] lock validator: lockdep: add local_irq_enable_in_hardirq() API.
Message-ID: <20060623092852.GB4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212452.GU3155@elte.hu> <20060529183428.0d12052e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183428.0d12052e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 29 May 2006 23:24:52 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > introduce local_irq_enable_in_hardirq() API. It is currently
> > aliased to local_irq_enable(), hence has no functional effects.
> > 
> > This API will be used by lockdep, but even without lockdep
> > this will better document places in the kernel where a hardirq
> > context enables hardirqs.
> 
> If we expect people to use this then we'd best whack a comment over 
> it.

ok, i've improved the comment in trace_irqflags.h.

> Also, trace_irqflags.h doesn't seem an appropriate place for it to 
> live.

seems like the most practical place for it. Previously we had no central 
include file for irq-flags APIs (they used to be included from 
asm/system.h and other random per-arch places) - trace_irqflags.h has 
become the central file now. Should i rename it to irqflags.h perhaps, 
to not tie it to tracing? We have some deprecated irq-flags ops in 
interrupt.h, maybe this all belongs there. (although i think it's 
cleaner to have linux/include/irqflags.h and include it from 
interrupt.h)

	Ingo
