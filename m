Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267724AbUHPQQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbUHPQQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUHPQQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:16:32 -0400
Received: from pD9517D3C.dip.t-dialin.net ([217.81.125.60]:51592 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267756AbUHPQQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:16:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816153751.GA15573@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092662814.5082.2.camel@localhost> <1092665577.5362.12.camel@localhost>
	 <1092667804.5362.21.camel@localhost> <20040816145831.GA14195@elte.hu>
	 <1092669057.5362.31.camel@localhost>  <20040816153751.GA15573@elte.hu>
Content-Type: text/plain
Message-Id: <1092672875.5362.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 18:14:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> * Thomas Charbonnel <thomas@undata.org> wrote:
> 
> > > >  0.000ms (+0.000ms): do_IRQ (default_idle)
> > > >  0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
> > > >  0.459ms (+0.459ms): generic_redirect_hardirq (do_IRQ)
> > > >  0.459ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
> > > >  0.459ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
> > > 
> > > > It definitely looks like the kernel is interrupted by some interrupt
> > > > source not covered by the patch.
> > > 
> > > the only possibility is SMM, which is not handled by Linux. (but by the
> > > BIOS.) Otherwise we track everything - including NMIs.
> 
> > This would confirm the hypothesis of a buggy BIOS, I'm afraid.
> 
> there are still other (and more likely) possible reasons like a bug in
> the latency tracer. (Or a broken TSC - albeit this is less likely.)
> 

I don't think the latency tracer is involved. I think this is the same
phenomenon as the regular latency spikes I reported earlier.
At some point I thought of a clock issue, indeed, so I switched to
pmtmr, but this is broken with voluntary preempt (I think it relates to
the sched_clock code when not using TSC -> precision of the reported
preempt threshold violations was 1ms). Worth mentioning is that the
latency spikes interval was the same even if I compiled cpufreq in and
switched the processor speed at runtime.

> can you reproduce this phenomenon at will? Does it go away if you turn 
> ACPI/APM off (both in the kernel and in the BIOS).

I can't turn PM off in the BIOS, but turning ACPI off in the kernel
suppresses the problem.

>  Does it go away if 
> you use idle=poll?
> 

I don't think so (the spikes where still here when you first merged
wli's preempt timing patch and forced idle=poll).

So basically I think the spikes are BIOS related, they've been detected
so far by the alsa xrun_debug mechanism, by the latency-test suite, and
now by the latency tracer, which shows that they're not linked to any
particular code section.

Thomas


