Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278324AbRJSHJ7>; Fri, 19 Oct 2001 03:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278326AbRJSHJu>; Fri, 19 Oct 2001 03:09:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29142 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278324AbRJSHJh>; Fri, 19 Oct 2001 03:09:37 -0400
Date: Fri, 19 Oct 2001 12:44:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: rml@tech9.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5aa1
Message-ID: <20011019124437.A14799@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1003470485.913.13.camel@phantasy> Robert Love wrote:
> On Fri, 2001-10-19 at 00:19, Andrea Arcangeli wrote:
>> Only in 2.4.13pre3aa1: 00_files_struct_rcu-2.4.10-04-1
>> Only in 2.4.13pre5aa1: 00_files_struct_rcu-2.4.10-04-2

> I want to point out to preempt-kernel users that RCU is not
> preempt-safe. The implicit locking assumed from per-CPU data structures
> is defeated by preemptibility.

> (Actually, FWIW, I think I can think of ways to make RCU preemptible but
> it would involve changing the write-side quiescent code for the case
> where the pointers were carried over the task switches.  Probably not
> worth it.) 

I agree. Differentiating between context switches that do or don't
carry over pointers requires several additional complications
that are probably not worth it at this moment.


> This is not to say RCU is worthless with a preemptible kernel, but that
> we need to make it safe (and then make sure it is still a performance
> advantage, but I don't think this would add much overhead).  Note this
> is clean, simply wrapping the read code in non-preemption statements.

Yes. The lookup of data protected by RCU should be done with preemption
disabled.

preempt_disable();
traverse linked list or such things protected by RCU.
preempt_enable();

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
