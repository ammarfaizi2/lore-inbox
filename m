Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVELRMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVELRMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 13:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVELRMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 13:12:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:4494 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262078AbVELRMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 13:12:07 -0400
Date: Thu, 12 May 2005 22:42:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050512171251.GA21656@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115913679.20909.31.camel@mindpipe> <20050512161636.GA15653@atomide.com> <200505120928.55476.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505120928.55476.jesse.barnes@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 09:28:55AM -0700, Jesse Barnes wrote:
> Seems like we could schedule timer interrupts based solely on add_timer 
> type stuff; the scheduler could use it if necessary for load balancing 
> (along with fork/exec based balancing perhaps) on large machines where 
> load imbalances hurt throughput a lot.  But on small systems if all 

Even if we were to go for this tickless design, the fundamental question
remains: who wakes up the (sleeping) idle CPU upon a imbalance? Does some other
(busy) CPU wake it up (which makes the implementation complex) or the idle CPU 
checks imbalance itself at periodic intervals (which restricts the amount of
time a idle CPU may sleep).

> your processes were blocked, you'd just go to sleep indefinitely and 
> save a bit of power and avoid unnecessary overhead.
> 
> I haven't looked at the lastest tickless patches, so I'm not sure if my 
> claims of simplicity are overblown, but especially as multiprocessor 
> systems become more and more common it just seems wasteful to wakeup 
> all the CPUs every so often only to have them find that they have 
> nothing to do.

I guess George's experience in implementing tickless systems is that
it is more of an overhead for a general purpose OS like Linux. George?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
