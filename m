Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVBXBEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVBXBEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVBXBEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:04:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28888 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261778AbVBXBDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:03:49 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <421D1171.7070506@yahoo.com.au>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <1109190614.3126.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>
	 <421D1171.7070506@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 20:03:44 -0500
Message-Id: <1109207024.4516.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 10:27 +1100, Nick Piggin wrote: 
> Hugh Dickins wrote:
> > On Wed, 23 Feb 2005, Lee Revell wrote:
> > 
> >>>>Thanks, your patch fixes the copy_pte_range latency.
> >>
> >>clear_page_range is also problematic.
> > 
> > 
> > Yes, I saw that from your other traces too.  I know there are plans
> > to improve clear_page_range during 2.6.12, but I didn't realize that
> > it had become very much worse than its antecedent clear_page_tables,
> > and I don't see missing latency fixes for that.  Nick's the expert.
> > 
> 
> I wouldn't have thought it should have become worse, latency
> wise. What is actually happening is that the lower level freeing
> functions are being called more often. But this should result in
> the work being spread out more, if anything. Rather than in the
> old system things would tend to be batched up into bigger chunks
> (typically at exit() time).
> 
> If you are using i386 with 2-level page tables (no highmem), then
> the behaviour should be more or less identical. Odd.

IIRC last time I really tested this a few months ago, the worst case
latency on that machine was about 150us.  Currently its 422us from the
same clear_page_range code path.

On my Athlon XP the clear_page_range latency is not showing up at all,
and the worst delay so far is only 35us, most of which is the timer
interrupt IOW that machine is showing the best achievable latency (with
PREEMPT_DESKTOP).  The machine seeing 422 us latencies in
clear_page_range is a 600Mhz C3, which is known to be a FSB limited
architecture.

Lee 

