Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCRMzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCRMzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 07:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCRMzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 07:55:10 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:18185 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261556AbVCRMzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 07:55:04 -0500
Date: Fri, 18 Mar 2005 04:56:41 -0800
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: mingo@elte.hu, dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org,
       torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318125641.GA5107@nietzsche.lynx.com>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 04:20:26PM -0800, Paul E. McKenney wrote:
> 5. Scalability -and- Realtime Response.
...

> 	void
> 	rcu_read_lock(void)
> 	{
> 		preempt_disable();
> 		if (current->rcu_read_lock_nesting++ == 0) {
> 			current->rcu_read_lock_ptr =
> 				&__get_cpu_var(rcu_data).lock;
> 			read_lock(current->rcu_read_lock_ptr);
> 		}
> 		preempt_enable();
> 	}

Ok, here's a rather unsure question...

Uh, is that a sleep violation if that is exclusively held since it
can block within an atomic critical section (deadlock) ?

bill


