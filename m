Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263743AbSJGXgA>; Mon, 7 Oct 2002 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbSJGXgA>; Mon, 7 Oct 2002 19:36:00 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:20624 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263743AbSJGXf5>;
	Mon, 7 Oct 2002 19:35:57 -0400
Subject: Re: [RFC] Simple NUMA scheduler patch
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200210051834.31031.efocht@ess.nec.de>
References: <200210021954.39358.efocht@ess.nec.de>
	<953763699.1033565134@[10.10.2.3]>  <200210051834.31031.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Oct 2002 16:37:24 -0700
Message-Id: <1034033845.1280.514.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 15:32, Erich Focht wrote:
> Hi Martin & Michael,
> 
> thanks for the mails and the results.

You are most welcome.  Thanks for the work on your scheduler and
numa_test.  I want to acknowledge that much of the work that
I have done on my scheduler patch has been inspired by work that
you have already done, and in a few cases taken directly from it.

> It would probably save some time if we reuse parts of the code which
> is already there (as with sched_migrate_task). I'd like to mention that
> the node affine scheduler is already in production use at several HPC
> sites and thus pretty well tested. The performance degradation you've
> hit on NUMAQ must be specific to the architecture and doesn't hit Azusa
> that much (we just don't see that). I think that could result from
> the idle tasks having homenode 0, this should be fixed in sched_init. 
> I'll post some numbers comparing O(1), pooling scheduler, node affine
> scheduler and RSS based affinity in a separate email. That should help
> to decide on the direction we should move. 

One other piece to factor in is the workload characteristics - I'm
guessing that Azusa is beng used more for scientific workloads which
tend to be a bit more static and consumes large memory bandwidth.
 
> No, we shouldn't aim too hard. The histeresys introduced by the 25%
> imbalance necessary to start load balancing (as in Ingo's scheduler)
> is enough to protect us from the bouncing. But when running a small
> number of tasks you'd like to get the best performance out of the machine.
> For me that means the maximum memory bandwidth available for each task,
> which you only get if you distribute the tasks equally among the nodes.

Depends on the type of job.  Some actually benefit from being on the
same node as other tasks as locality is more important than bandwidth.
I am seeing some of this - when I get better distribution of load across
nodes, performance goes down for sdet and kernbench.

> For large number of tasks you will always have good balance across the
> nodes, the O(1) scheduler already inforces that.

Yes, the main shortcoming in this case is that it has nothing to keep
a task on the same node.  That is one of the two main goals I'm 
targeting.  (The other being to select the best cpu/node to begin
with so that there will be no need to move a task off node.)

> Best regards,
> Erich
> 

I plan to post another version of my patch in the next day or so along
with numa_test and kernbench results.  I've made a few mods that have
significantly helped the distribution across nodes, but need to buy back
some performance that is lost by the distribution.
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

