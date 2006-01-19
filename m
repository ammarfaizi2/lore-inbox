Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWASHfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWASHfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWASHfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:35:22 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48063 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161251AbWASHfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:35:21 -0500
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in
	exit_mmap->free_pgtables
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601190717180.6003@goblin.wat.veritas.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1137634961.626.2.camel@mindpipe>
	 <Pine.LNX.4.61.0601190717180.6003@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 02:35:18 -0500
Message-Id: <1137656119.4736.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 07:29 +0000, Hugh Dickins wrote:
> On Wed, 18 Jan 2006, Lee Revell wrote:
> > On Wed, 2005-12-28 at 22:59 +0000, Hugh Dickins wrote:
> > > 
> > > On my list to work on; but the TLB always needs great care, and this
> > > goes down into architectural divergences, with truncation of a mapped
> > > file adding further awkward constraints.  I imagine 2.6.16-rc1 is only
> > > a couple of weeks away, so it's unlikely to be fixed in 2.6.16 either.
> > 
> > Is this believed to be fixed in 2.6.16-rc1?
> 
> Not at all, I'm afraid.  Do you think I ought to try to persuade Linus
> and Andrew to take that ugly free_pgtables #ifdef CONFIG_PREEMPT patch
> in the interim before we've the proper latency fix there?  (I doubt the
> mmu_gather rewrite in 2.6.17 too, but perhaps a reasonable compromise.)

For the time being, this is overshadowed by long latencies (~8ms or so)
in rt_garbage_collect() and rt_run_flush().  Previously I was under the
impression those could be worked around by sysctl/proc tuning, but this
is not the case.

Until those are fixed I would say it's low priority.

Lee

