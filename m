Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVBQPAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVBQPAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVBQO6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:58:55 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:27327 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261410AbVBQO5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:57:38 -0500
Date: Thu, 17 Feb 2005 09:57:33 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@kihontech.com
To: Ingo Molnar <mingo@elte.hu>
cc: "David S. Miller" <davem@davemloft.net>, mgross@linux.intel.com,
       linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
In-Reply-To: <20050217075212.GA21621@elte.hu>
Message-ID: <Pine.LNX.4.58.0502170944500.14536@localhost.localdomain>
References: <200502141240.14355.mgross@linux.intel.com>
 <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu>
 <200502151006.44809.mgross@linux.intel.com> <20050216051645.GB15197@elte.hu>
 <20050216081143.50d0a9d6.davem@davemloft.net> <20050217075212.GA21621@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Feb 2005, Ingo Molnar wrote:
> as long as it stays on a single CPU, could we allow softirq contexts to
> preempt each other? I.e. we'd keep the per-CPU assumption (that is fair
> and needed for performance anyway), but we'd allow NET_TX to preempt
> NET_RX and vice versa. Would this corrupt the rx/tx queues? (i suspect
> it would.)
>
> (anyway, by adding an explicit no-preempt section around the 'take
> current rx queue private, then process it' on PREEMPT_RT it could be
> made safe. I'm wondering whether there are any other deeper assumptions
> about atomic separation of softirq contexts.)
>

Ingo,

Wouldn't this cause a longer latency in these sections. I understand
that turning preemption off doesn't stop interrupts that are not
threaded, but especially on a UP, this would cause higher latencies for
high priority processes when a lower priority process is heavy on network
traffic.

As I mentioned earlier, what would it take to be able to group
softirq threads that should not preempt each other, but still keep
preemption available for other threads?

Actually, I guess I need to ask, what do you intend on doing to prioritize
the softirq?  Are you going to make a separate thread for each tasklet?
Once I see what you're doing, I'll make something up to help handle this
problem.

-- Steve

