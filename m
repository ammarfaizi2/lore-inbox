Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUC3Fes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUC3Fes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:34:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18373 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263127AbUC3Feq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:34:46 -0500
Date: Tue, 30 Mar 2004 11:05:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>,
       rusty@au1.ibm.com
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330053515.GA4815@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random> <20040330050614.GA4669@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330050614.GA4669@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 10:36:14AM +0530, Srivatsa Vaddagiri wrote:
> kthread_stop does:
> 
> 	1. kthread_stop_info.k = k;
>         2. wake_up_process(k);
> 
> and if ksoftirqd were to do :
> 
> 	a. while (!kthread_should_stop()) {
>         b.         __set_current_state(TASK_INTERRUPTIBLE);
>         c.         schedule();
>            }
> 
> 
> There is a (narrow) possibility here that a) happens _after_ 1) as well as 
> b) _after_ 2).

hmm .. I meant a) happening _before_ 1) and b) happening _after_ 2) ..

> 
>         a. __set_current_state(TASK_INTERRUPTIBLE);
> 	b. while (!kthread_should_stop()) {
>         c.         schedule();
>         d.         __set_current_state(TASK_INTERRUPTIBLE);
>            }
> 
>         e. __set_current_state(TASK_RUNNING);
> 
> In this case, even if b) happens _after_ 1) and c) _after_ 2), 

Again I meant "even if b) happens _before_ 1) and c) _after_ 2) !!

> schedule simply returns immediately because task's state would have been set 
> to TASK_RUNNING by 2). It goes back to the kthread_should_stop() check and 
> exits!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
