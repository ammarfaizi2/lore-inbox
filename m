Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVCRPyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVCRPyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVCRPyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:54:18 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54004 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261654AbVCRPyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:54:12 -0500
Date: Fri, 18 Mar 2005 07:54:18 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: mingo@elte.hu, dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org,
       torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318155418.GC1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050318002026.GA2693@us.ibm.com> <20050318125641.GA5107@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318125641.GA5107@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 04:56:41AM -0800, Bill Huey wrote:
> On Thu, Mar 17, 2005 at 04:20:26PM -0800, Paul E. McKenney wrote:
> > 5. Scalability -and- Realtime Response.
> ...
> 
> > 	void
> > 	rcu_read_lock(void)
> > 	{
> > 		preempt_disable();
> > 		if (current->rcu_read_lock_nesting++ == 0) {
> > 			current->rcu_read_lock_ptr =
> > 				&__get_cpu_var(rcu_data).lock;
> > 			read_lock(current->rcu_read_lock_ptr);
> > 		}
> > 		preempt_enable();
> > 	}
> 
> Ok, here's a rather unsure question...
> 
> Uh, is that a sleep violation if that is exclusively held since it
> can block within an atomic critical section (deadlock) ?

Hey, I wasn't joking when I said that I probably got something wrong!  ;-)

My current thought is that the preempt_disable()/preempt_enable() can
be dropped entirely.  Messes up any tool that browses through
->rcu_read_lock_nesting, but don't see any other problem.  Yet, anyway!

						Thanx, Paul
