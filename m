Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132867AbRDDRtt>; Wed, 4 Apr 2001 13:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132869AbRDDRtj>; Wed, 4 Apr 2001 13:49:39 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:15713 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132867AbRDDRtY>; Wed, 4 Apr 2001 13:49:24 -0400
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200104041749.KAA74097@google.engr.sgi.com>
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 4 Apr 2001 10:49:04 -0700 (PDT)
Cc: mingo@elte.hu (Ingo Molnar), frankeh@us.ibm.com (Hubertus Franke),
        mkravetz@sequent.com (Mike Kravetz),
        fabio@chromium.com (Fabio Riccardi),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
In-Reply-To: <20010404191604.O20911@athlon.random> from "Andrea Arcangeli" at Apr 04, 2001 07:16:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> It helps by keeping the task in the same node if it cannot keep it in
> the same cpu anymore.
> 
> Assume task A is sleeping and it last run on cpu 8 node 2. It gets a wakeup
> and it gets running and for some reason cpu 8 is busy and there are other
> cpus idle in the system. Now with the current scheduler it can be moved in any
> cpu in the system, with the numa sched applied we will try to first reschedule
> it in the idles cpus of node 2 for example. The per-node runqueue are mainly
> necessary to implement the heuristic.
>

Yes. But this is not the best solution, if I can add on to the example
and make some assumptions.

Imagine that most of the program's memory is on node 1, it was scheduled
on node 2 cpu 8 momentarily (maybe because kswapd ran on node 1, other
higher priority processes took over other cpus on node 1, etc). 

Then, your patch will try to keep the process on node 2, which is not
neccessarily the best solution. Of course, as I mentioned before, if
you have a node local cache on node 2, that cache might have been warmed
enough to make scheduling on node 2 a good option. 

I am not saying there is a wrong or right answer, there are so many
possibilities, everything probably works and breaks under different
circumstances. 

Btw, while we are swapping patches, the patch at

	http://oss.sgi.com/projects/numa/download/sched242.patch

tries to implement per-arch scheduling. The current scheduler behavior
is smp_arch_goodness() and smp_pick_cpu(), but the patch allows the
possibility for a specific platform to change that to something else. 

Linus has seen this patch, and agrees to it in principle. He does not
consider this 2.4 material though. Of course, I am completely open to
Ingo (or someone else) coming up with a different way of providing the
same freedom to arch specific code.

Kanoj
