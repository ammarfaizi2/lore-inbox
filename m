Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272423AbRIKMRi>; Tue, 11 Sep 2001 08:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272427AbRIKMRS>; Tue, 11 Sep 2001 08:17:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53450 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272423AbRIKMRJ>; Tue, 11 Sep 2001 08:17:09 -0400
Date: Tue, 11 Sep 2001 17:52:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org, Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911175227.A2199@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010911135735.T715@athlon.random> you wrote:
> On Tue, Sep 11, 2001 at 05:23:01PM +0530, Dipankar Sarma wrote:
>> In article <20010911131238.N715@athlon.random> you wrote:
>> > many thanks. At the moment my biggest concern is about the need of
>> > call_rcu not to be starved by RT threads (keventd can be starved so then
>> > it won't matter if krcud is RT because we won't start using it).
>> 
>> > Andrea
>> 
>> I think we can avoid keventd altogether by using a periodic timer (say 10ms)
>> to check for completion of an RC update. The timer may be active
>> only if only if there is any RCU going on in the system - that way
>> we still don't have any impact on the rest of the kernel.

> the timer can a have bigger latency than keventd calling wait_for_rcu
> so it should be a loss in a stright bench with light load, but OTOH we
> only care about getting those callbacks executed eventually and the
> advantage I can see is that the timer cannot get starved.

> Andrea

What kind of timer latencies are we talking about ? I would not be
too concerned if the RCU timers execute in 40ms instead of requested
10ms. The question is are there situations where they can get delayed
by minutes ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
