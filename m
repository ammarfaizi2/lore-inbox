Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVBQQVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVBQQVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVBQQVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:21:50 -0500
Received: from fmr18.intel.com ([134.134.136.17]:7868 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261154AbVBQQVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:21:47 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: rostedt@kihontech.com, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Date: Thu, 17 Feb 2005 08:14:42 -0800
User-Agent: KMail/1.5.4
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Mark_H_Johnson@raytheon.com
References: <200502141240.14355.mgross@linux.intel.com> <20050217075212.GA21621@elte.hu> <Pine.LNX.4.58.0502170944500.14536@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0502170944500.14536@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170814.42903.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 February 2005 06:57, Steven Rostedt wrote:
> On Thu, 17 Feb 2005, Ingo Molnar wrote:
> > as long as it stays on a single CPU, could we allow softirq contexts to
> > preempt each other? I.e. we'd keep the per-CPU assumption (that is fair
> > and needed for performance anyway), but we'd allow NET_TX to preempt
> > NET_RX and vice versa. Would this corrupt the rx/tx queues? (i suspect
> > it would.)
> >
> > (anyway, by adding an explicit no-preempt section around the 'take
> > current rx queue private, then process it' on PREEMPT_RT it could be
> > made safe. I'm wondering whether there are any other deeper assumptions
> > about atomic separation of softirq contexts.)
>
> Ingo,
>
> Wouldn't this cause a longer latency in these sections. I understand
> that turning preemption off doesn't stop interrupts that are not
> threaded, but especially on a UP, this would cause higher latencies for
> high priority processes when a lower priority process is heavy on network
> traffic.
>
> As I mentioned earlier, what would it take to be able to group
> softirq threads that should not preempt each other, but still keep
> preemption available for other threads?

It would only take the creationt of multiple softIRQd threads per CPU.  Just 
keep net_rx and net_tx in the same work queue.


>
> Actually, I guess I need to ask, what do you intend on doing to prioritize
> the softirq?  Are you going to make a separate thread for each tasklet?
> Once I see what you're doing, I'll make something up to help handle this
> problem.
>
> -- Steve

