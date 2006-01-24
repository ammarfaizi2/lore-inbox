Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWAXJRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWAXJRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWAXJRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:17:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37058 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030418AbWAXJRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:17:50 -0500
Date: Tue, 24 Jan 2006 01:17:31 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124091730.GA31204@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1138089139.2771.78.camel@mindpipe> <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe> <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138090527.2771.91.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 03:15:27AM -0500, Lee Revell wrote:
> On Tue, 2006-01-24 at 09:13 +0100, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > On Tue, 2006-01-24 at 09:01 +0100, Ingo Molnar wrote:
> > > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > > 
> > > > > On Tue, 2006-01-24 at 08:56 +0100, Ingo Molnar wrote:
> > > > > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > > > > 
> > > > > > > I ported the latency tracer to 2.6.16 and got this 13ms latency within 
> > > > > > > a few hours.  This is a regression from 2.6.15.
> > > > > > > 
> > > > > > > It appears that RCU can invoke ipv4_dst_destroy thousands of times in 
> > > > > > > a single batch.
> > > > > > 
> > > > > > could you try the PREEMPT_RCU patch below?
> > > > > 
> > > > > Sure.  If it works do you see this making it in 2.6.16?  Otherwise we 
> > > > > still would have a regression...
> > > > 
> > > > nope, that likely wont make v2.6.16, which is frozen already.
> > > > 
> > > 
> > > How about just lowering maxbatch to 1000?
> > 
> > does that fix the latency for you? I think "maxbatch=1000" should work 
> > as a boot parameter too.
> > 
> 
> Have not tested yet but it appears that will reduce it substantially:
> 
> $ grep "dst_destroy (dst_rcu_free)" /proc/latency_trace | wc -l
> 3027
> 
> This implies the latency would be reduced to ~4ms, still not great but
> it will be overshadowed by rt_run_flush/rt_garbage_collect.

The other patch to try would be Dipankar Sarma's patch at:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113657112726596&w=2

This patch was primarily designed to reduce memory overhead, but given
that it tends to reduce batch size, it should also reduce latency.

							Thanx, Paul
