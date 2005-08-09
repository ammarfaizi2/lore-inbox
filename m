Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVHIOEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVHIOEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVHIOEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:04:16 -0400
Received: from fsmlabs.com ([168.103.115.128]:16098 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932544AbVHIOEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:04:15 -0400
Date: Tue, 9 Aug 2005 08:10:08 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alexander Nyberg <alexn@telia.com>
cc: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHECK_IRQ_PER_CPU() to avoid dead code in __do_IRQ()
In-Reply-To: <20050808111936.GA1393@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508090808250.28588@montezuma.fsmlabs.com>
References: <200508081250.05673.annabellesgarden@yahoo.de>
 <20050808111936.GA1393@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Alexander Nyberg wrote:

> > IRQ_PER_CPU is not used by all architectures.
> > This patch introduces the macros
> > ARCH_HAS_IRQ_PER_CPU and CHECK_IRQ_PER_CPU() to avoid the generation of
> > dead code in __do_IRQ().
> > 
> > ARCH_HAS_IRQ_PER_CPU is defined by architectures using
> > IRQ_PER_CPU in their
> >         include/asm_ARCH/irq.h
> > file.
> > 
> > Through grepping the tree I found the following
> > architectures currently use IRQ_PER_CPU:
> > 
> >         cris, ia64, ppc, ppc64 and parisc. 
> > 
> 
> There are many places where one could replace run-time tests with 
> #ifdef's but it makes reading more difficult (and in longer terms
> maintainence). Have you benchmarked any workload that benefits 
> from this?

I doubt you'd be able to collect convincing benchmark data, but skipping a 
branch (possibly mispredicted) is worth it IMO.
