Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbRDDRDV>; Wed, 4 Apr 2001 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132849AbRDDRDK>; Wed, 4 Apr 2001 13:03:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53499 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132853AbRDDRDD>;
	Wed, 4 Apr 2001 13:03:03 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF5E9EE337.4E94D8F7-ON85256A24.005D15F8@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 13:03:32 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 01:02:12 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kanoj, our cpu-pooling + loadbalancing allows you to do that.
The system adminstrator can specify at runtime through a
/proc filesystem interface the cpu-pool-size, whether loadbalacing
should take place.
We can put limiting to the local cpu-set during reschedule_idle
back into the code, to make it complete and compatible with
the approach that Andrea has taken.
This way, one can fully isolate or combine cpu-sets.

here is the code for the pooling.
http://lse.sourceforge.net/scheduling/LB/2.4.1-MQpool

loadbalancing and /proc system combined in this module.
http://lse.sourceforge.net/scheduling/LB/loadbalance.c

a writeup explaining this concept is available under
http://lse.sourceforge.net/scheduling/LB/poolMQ.html

Prerequisite is the MQ scheduler...
http://lse.sourceforge.net/scheduling/2.4.1.mq1-sched

We need to update these for 2.4.3 .... (coming)

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Kanoj Sarcar <kanoj@google.engr.sgi.com>@lists.sourceforge.net on
04/04/2001 12:50:58 PM

Sent by:  lse-tech-admin@lists.sourceforge.net


To:   andrea@suse.de (Andrea Arcangeli)
cc:   mingo@elte.hu (Ingo Molnar), Hubertus Franke/Watson/IBM@IBMUS,
      mkravetz@sequent.com (Mike Kravetz), fabio@chromium.com (Fabio
      Riccardi), linux-kernel@vger.kernel.org (Linux Kernel List),
      lse-tech@lists.sourceforge.net
Subject:  Re: [Lse-tech] Re: a quest for a better scheduler



>
> I didn't seen anything from Kanoj but I did something myself for the
wildfire:
>
>
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa1/10_numa-sched-1

>
> this is mostly an userspace issue, not really intended as a kernel
optimization
> (however it's also partly a kernel optimization). Basically it splits the
load
> of the numa machine into per-node load, there can be unbalanced load
across the
> nodes but fairness is guaranteed inside each node. It's not extremely
well
> tested but benchmarks were ok and it is at least certainly stable.
>

Just a quick comment. Andrea, unless your machine has some hardware
that imply pernode runqueues will help (nodelevel caches etc), I fail
to understand how this is helping you ... here's a simple theory though.
If your system is lightly loaded, your pernode queues are actually
implementing some sort of affinity, making sure processes stick to
cpus on nodes where they have allocated most of their memory on. I am
not sure what the situation will be under huge loads though.

As I have mentioned to some people before, percpu/pernode/percpuset/global
runqueues probably all have their advantages and disadvantages, and their
own sweet spots. Wouldn't it be really neat if a system administrator
or performance expert could pick and choose what scheduler behavior he
wants, based on how the system is going to be used?

Kanoj

_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/lse-tech



