Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUHMNtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUHMNtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHMNtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:49:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19887 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265305AbUHMNtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:49:36 -0400
Date: Fri, 13 Aug 2004 15:51:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813135109.GA20638@elte.hu>
References: <2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it> <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813121800.GA68967@muc.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> > > > yeah - kallsyms_lookup does a linear search over thousands of symbols. 
> > > > Especially since /proc/latency_trace uses it too it would be worthwile
> > > > to implement some sort of binary searching.
> > > 
> > > Or just stick some cond_sched()s in there. It was designed to be slow,
> > > but there are no locking issues.
> > 
> > the speedup would be important: even on a 2GHz box reading 10,000 trace
> > entries takes a couple of seconds.
> 
> That's because you're abusing it - it was never designed to process
> that much data.

i'm not abusing it. Linear searching of 20 thousand symbols is a gross
first-approximation algorithm no matter what. Yes, most users of the
symbols dont care about performance. And i'm not complaining at all, i'm
just pointing out the reason why e.g. printing a simple stack backtrace
can take milliseconds.

> With binary search you would need to backward search to find the stem
> for the stem compression. It's probably doable, but would be a bit
> ugly I guess.

yeah. Maybe someone will find the time to improve the algorithm. But
it's not a highprio thing.

	Ingo
