Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUHLNA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUHLNA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268546AbUHLNA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:00:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40114 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268544AbUHLNAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:00:09 -0400
Date: Thu, 12 Aug 2004 07:58:56 -0500
From: Jack Steiner <steiner@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, mbligh@aracnet.com,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, jbarnes@sgi.com, sylvain.jeaugey@bull.net,
       djh@sgi.com, linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20040812125856.GA1956@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408071722.36705.efocht@hpce.nec.com> <2447730000.1091976606@[10.10.2.4]> <200408111140.14466.efocht@hpce.nec.com> <10920000.1092235770@[10.10.2.4]> <20040811105057.76f97ead.pj@sgi.com> <411A8BAD.1010008@watson.ibm.com> <20040812001522.07d30598.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812001522.07d30598.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:15:22AM -0700, Paul Jackson wrote:
> Shailabh wrote:
> > But when apps are being confined to a set of cpus *only* for purposes of 
> > getting a certain fraction of the total compute power, cpusets are not 
> > orthogonal in intent, not implementation, from a CKRM CPU class 
> > implementing hard limits.
> 
> So if someone wanted to constrain a group of tasks to using 50% of all
> the available CPU ticks on a 32 CPU system, they could either use a CKRM
> CPU class with a hard limit of 50%, or a cpuset that contained 16 CPUs.
> 
> Yes, for that purpose, except for NUMA placement (the cache affinity and
> memory latency you mention), these two approaches are similar in affect.

One other important attribute of a cpuset is that, used properly, cpusets
will guarantee exclusive use of a set of cpus for an application.

MPI jobs are frequently consist of a number of threads that communicate
via message passing interfaces. All threads need to be executing
at the same time. If a single thread loses a cpu, all threads stop making
forward progress and spin at a barrier.

Cpusets can eliminate the need for a gang scheduler.


> 
> So, yes, my absolute insistence that CKRM and cpusets are orthogonal is
> overstated.  Well, I could quibble that orthogonal doesn't imply disjoint.
> Whatever.
> 
> 
> > What's your opinion on the commonalities between the two interfaces 
> > pointed out in my previous mail ?
> 
> My apologies for not yet replying to your mail of a couple of days ago.
> It was valuable to me, and I've taken a bit of time to digest it.
> Meanwhile, newer stuff keeps overruning my reply.  Soon, hopefully.
> 
> 
> > Also, if CKRM were to move to the "each controller exports its own 
> > interface" model, how would this affect the discussion ?
> 
> I cannot speak for the discussion, only for myself.  I am clearly
> sensitive to the downsides of trying to integrate these interfaces.
> 
> Hopefully I can find the time tonight to study your earlier replies more
> closely, and better understand the potential benefits of such an
> integration.  So far, I don't see them.  I will do my best to keep my
> eyes and mind open.  Thanks especially to your posts, I have learned
> quite a bit about CKRM this week.
> 
> I will confess to a strong bias toward a minimum of abstraction at the
> kernel-user boundary, and towards providing a one-to-one map between the
> mechanisms and the interfaces a kernel provides.  Let the user level
> assemble the pieces as it will.  If combining interfaces (CKRM and
> cpuset) caused any unwarranted change in or obfuscation of the semantics
> provided by either, that would be unfortunate, in my view.
> 
> 
> > Do you think there's *any* merit to cpusets sharing the rcfs 
> > interface *if* the latter were to make the changes mentioned in earlier 
> > mail ?
> 
> Not yet, but I need to go back over your replies, and others, with this
> question more clearly in focus.
> 
> 
> > If not (and others agree), lets end this discussion and move on - both 
> > projects have enough to do ...
> 
> At least Martin does not yet agree, if I understand his posts.  But,
> yes, either way, we are close to where it is best to table this
> discussion, for the moment at least.
> 
> Thank-you for your constructive and enlightening comments so far.
> 
> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


