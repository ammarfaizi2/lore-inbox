Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVCRP7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVCRP7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVCRP6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:58:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:6290 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261661AbVCRP5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:57:49 -0500
Date: Fri, 18 Mar 2005 07:57:53 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: mingo@elte.hu, dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org,
       torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318155753.GD1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050318002026.GA2693@us.ibm.com> <20050318125641.GA5107@nietzsche.lynx.com> <20050318131729.GB5107@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318131729.GB5107@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 05:17:29AM -0800, Bill Huey wrote:
> On Fri, Mar 18, 2005 at 04:56:41AM -0800, Bill Huey wrote:
> > On Thu, Mar 17, 2005 at 04:20:26PM -0800, Paul E. McKenney wrote:
> > > 5. Scalability -and- Realtime Response.
> > ...
> > 
> > > 	void
> > > 	rcu_read_lock(void)
> > > 	{
> > > 		preempt_disable();
> > > 		if (current->rcu_read_lock_nesting++ == 0) {
> > > 			current->rcu_read_lock_ptr =
> > > 				&__get_cpu_var(rcu_data).lock;
> > > 			read_lock(current->rcu_read_lock_ptr);
> > > 		}
> > > 		preempt_enable();
> > > 	}
> > 
> > Ok, here's a rather unsure question...
> > 
> > Uh, is that a sleep violation if that is exclusively held since it
> > can block within an atomic critical section (deadlock) ?
> 
> I'd like to note another problem. Mingo's current implementation of rt_mutex
> (super mutex for all blocking synchronization) is still missing reader counts
> and something like that would have to be implemented if you want to do priority
> inheritance over blocks.
> 
> This is going to throw a wrench into your implementation if you assume that.

If we need to do priority inheritance across the memory allocator, so
that high-priority tasks blocked waiting for memory pass their priority
on to RCU readers, agreed.  But I don't see any sign that real-time
preempt does this.

In absence of this, as Ingo noted, the fact that readers don't block
each other should make things be safe.  I think...

						Thanx, Paul
