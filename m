Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUJOQqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUJOQqC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUJOQqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:46:01 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:17600 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268207AbUJOQpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:45:40 -0400
Date: Fri, 15 Oct 2004 09:40:39 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Sven Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       arnd.heursch@unibw-muenchen.de
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041015164039.GA1265@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041011215420.GA19796@elte.hu> <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com> <20041012055029.GB1479@elte.hu> <20041014050905.GA6927@in.ibm.com> <20041014071810.GB9729@elte.hu> <20041015145915.GA1266@us.ibm.com> <20041015154542.GA8257@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015154542.GA8257@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 05:45:42PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > One caution (which you are no doubt already aware of) -- if an RCU
> > algorithm that reads (rcu_read_lock()/rcu_read_unlock()) in process
> > context and updates in softirq/bh/irq context, you can see deadlocks.
> 
> yeah - but in the PREEMPT_REALTIME kernel there are simply no irq or
> softirq contexts in process contexts - everything is a task. So
> everything can (and does) block.

OK, am probably confused, but I thought that the whole point of your
PREEMPT_REALTIME implementation of rcu_read_lock_rt() was to enable
preemption in the RCU read-side critical section.  If this is indeed
the case, then it looks to me like code that would run in softirq/bh/irq
context in a kernel compiled non-PREEMPT_REALTIME could now run during
the time that a code path running under rcu_read_lock_rt() was preempted.

If so, then the kernel can end up freeing a data item that the preempted
RCU read-side critical section is still referencing.

OK, so what am I missing here?

						Thanx, Paul
