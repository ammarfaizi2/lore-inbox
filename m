Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUHMMSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUHMMSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUHMMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:18:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:16134 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265022AbUHMMSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:18:01 -0400
Date: 13 Aug 2004 14:18:00 +0200
Date: Fri, 13 Aug 2004 14:18:00 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813121800.GA68967@muc.de>
References: <2mkTt-BZ-11@gated-at.bofh.it> <2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it> <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813121502.GA18860@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 02:15:02PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@muc.de> wrote:
> 
> > >> Interesting results.  One of the problems is kallsyms_lookup,
> > >> triggered by the printks:
> > >
> > > yeah - kallsyms_lookup does a linear search over thousands of symbols. 
> > > Especially since /proc/latency_trace uses it too it would be worthwile
> > > to implement some sort of binary searching.
> > 
> > Or just stick some cond_sched()s in there. It was designed to be slow,
> > but there are no locking issues.
> 
> the speedup would be important: even on a 2GHz box reading 10,000 trace
> entries takes a couple of seconds.

That's because you're abusing it - it was never designed to process
that much data.

With binary search you would need to backward search to find the stem for the 
stem compression. It's probably doable, but would be a bit ugly I guess.

-Andi
