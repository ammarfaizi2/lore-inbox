Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932978AbWFWJwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbWFWJwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWFWJwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:52:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932978AbWFWJwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:52:54 -0400
Date: Fri, 23 Jun 2006 02:52:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 21/61] lock validator: lockdep: add
 local_irq_enable_in_hardirq() API.
Message-Id: <20060623025237.10ac3f68.akpm@osdl.org>
In-Reply-To: <20060623092852.GB4889@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212452.GU3155@elte.hu>
	<20060529183428.0d12052e.akpm@osdl.org>
	<20060623092852.GB4889@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 11:28:52 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Mon, 29 May 2006 23:24:52 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > introduce local_irq_enable_in_hardirq() API. It is currently
> > > aliased to local_irq_enable(), hence has no functional effects.
> > > 
> > > This API will be used by lockdep, but even without lockdep
> > > this will better document places in the kernel where a hardirq
> > > context enables hardirqs.
> > 
> > If we expect people to use this then we'd best whack a comment over 
> > it.
> 
> ok, i've improved the comment in trace_irqflags.h.
> 
> > Also, trace_irqflags.h doesn't seem an appropriate place for it to 
> > live.
> 
> seems like the most practical place for it. Previously we had no central 
> include file for irq-flags APIs (they used to be included from 
> asm/system.h and other random per-arch places) - trace_irqflags.h has 
> become the central file now. Should i rename it to irqflags.h perhaps, 
> to not tie it to tracing? We have some deprecated irq-flags ops in 
> interrupt.h, maybe this all belongs there. (although i think it's 
> cleaner to have linux/include/irqflags.h and include it from 
> interrupt.h)
> 

Yes, irqflags.h is nice.
