Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132810AbRDDQkH>; Wed, 4 Apr 2001 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132817AbRDDQj6>; Wed, 4 Apr 2001 12:39:58 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:62062 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132810AbRDDQjq>; Wed, 4 Apr 2001 12:39:46 -0400
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200104041639.JAA78761@google.engr.sgi.com>
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: mingo@elte.hu
Date: Wed, 4 Apr 2001 09:39:23 -0700 (PDT)
Cc: frankeh@us.ibm.com (Hubertus Franke), mkravetz@sequent.com (Mike Kravetz),
        fabio@chromium.com (Fabio Riccardi),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.30.0104041527190.5382-100000@elte.hu> from "Ingo Molnar" at Apr 04, 2001 03:34:22 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Wed, 4 Apr 2001, Hubertus Franke wrote:
> 
> > Another point to raise is that the current scheduler does a exhaustive
> > search for the "best" task to run. It touches every process in the
> > runqueue. this is ok if the runqueue length is limited to a very small
> > multiple of the #cpus. [...]
> 
> indeed. The current scheduler handles UP and SMP systems, up to 32
> (perhaps 64) CPUs efficiently. Agressively NUMA systems need a different
> approach anyway in many other subsystems too, Kanoj is doing some
> scheduler work in that area.

Actually, not _much_ work has been done in this area. Alongwith a bunch
of other people, I have some ideas about what needs to be done. For 
example, for NUMA, we need to try hard to schedule a thread on the 
node that has most of its memory (for no reason other than to decrease
memory latency). Independently, some NUMA machines build in multilevel 
caches and local snoops that also means that specific processors on
the same node as the last_processor are also good candidates to run 
the process next.

To handle a single layer of shared caches, I have tried certain simple
things, mostly as hacks, but am not pleased with the results yet. More
testing needed.

Kanoj

> 
> but the original claim was that the scheduling of thousands of runnable
> processes (which is not equal to having thousands of sleeping processes)
> must perform well - which is a completely different issue.
> 
> 	Ingo
> 
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech
> 

