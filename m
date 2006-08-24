Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWHXFZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWHXFZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWHXFZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 01:25:04 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:29873 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030295AbWHXFZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 01:25:02 -0400
Message-ID: <44ED382B.9080601@bigpond.net.au>
Date: Thu, 24 Aug 2006 15:24:59 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: rparedes@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: SMP Affinity and nice
References: <38798.127.0.0.1.1156346673.squirrel@forexproject.com> <44ECC09A.7090909@nortel.com>
In-Reply-To: <44ECC09A.7090909@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 24 Aug 2006 05:25:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Rich Paredes wrote:
> 
>> So since cpumax5 has a lower nice value and thus a higher priority (25 in
>> this case), shouldn't it be given it's own cpu.   If I give cpumax5 a 
>> nice
>> value of -20, it does start using it's own cpu.
>>
>> My explanation would be that since the scheduler tries to limit cpu
>> affinity, the nice value of 0 isn't enough to get the scheduler to move
>> this process to another processors run queue.  I could be totally wrong
>> here though.
> 
> I think you are correct.  The load balancer doesn't think that this is 
> enough of an imbalance to go through the effort of swapping two 
> processes around.

The kernel in use (2.6.5) doesn't take nice into account during load 
balancing and just allocates the 5 tasks among the 4 CPUs in a way that 
tries to give each CPU the same number of tasks.  It also tries not to 
move tasks around too much so when it has found a solution that 
satisfies that criterion it leaves the tasks there.

5 tasks among 4 CPUs means 1 task each for 3 of the CPUs and 2 tasks for 
the other CPU.  As nice isn't taken into account it is purely down to 
chance whether or not the high priority task ends up being one of those 
that gets a CPU to itself or has to share with another task.  Some 
elementary probability theory should enable the probability of a "good" 
outcome (i.e. the high priority task not having to share) to be calculated.

This is an example of the type of situation that the smpnice patches 
were designed to handle.  They take nice into account and should ensure 
that the high priority does get a CPU to itself in this scenario.  They 
are scheduled for release in the 2.6.18 kernel.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
