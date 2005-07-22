Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVGVE2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVGVE2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVGVE2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:28:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35258 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261918AbVGVE2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:28:41 -0400
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-reply-to: Your message of Thu, 21 Jul 2005 23:59:09 EDT.
             <42E06F0D.8020503@watson.ibm.com> 
Date: Thu, 21 Jul 2005 21:27:45 -0700
Message-Id: <E1Dvp8T-0007wp-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry - I didn't see Mark's original comment, so I'm replying to
a reply which I did get.  ;-)

On Thu, 21 Jul 2005 23:59:09 EDT, Shailabh Nagar wrote:
> Mark Hahn wrote:
> >>I suspect that the main problem is that this patch is not a mainstream
> >>kernel feature that will gain multiple uses, but rather provides
> >>support for a specific vendor middleware product used by that
> >>vendor and a few closely allied vendors.  If it were smaller or
> >>less intrusive, such as a driver, this would not be a big problem.
> >>That's not the case.
> > 
> > 
> > yes, that's the crux.  CKRM is all about resolving conflicting resource 
> > demands in a multi-user, multi-server, multi-purpose machine.  this is a 
> > huge undertaking, and I'd argue that it's completely inappropriate for 
> > *most* servers.  that is, computers are generally so damn cheap that 
> > the clear trend is towards dedicating a machine to a specific purpose, 
> > rather than running eg, shell/MUA/MTA/FS/DB/etc all on a single machine.  
 
This is a big NAK - if computers are so damn cheap, why is virtualization
and consolidation such a big deal?  Well, the answer is actually that
floor space, heat, and power are also continuing to be very important
in the overall equation.  And, buying machines which are dedicated but
often 80-99% idle occasionally bothers people who are concerned about
wasting planetary resources for no good reason.  Yeah, we can stamp out
thousands of metal boxes, but if just a couple can do the same work,
well, let's consolidate.  Less wasted metal, less wasted heat, less
wasted power, less air conditioning, wow, we are now part of the
eco-computing movement!  ;-)

> > this is *directly* in conflict with certain prominent products, such as 
> > the Altix and various less-prominent Linux-based mainframes.  they're all
> > about partitioning/virtualization - the big-iron aesthetic of splitting up 
> > a single machine.  note that it's not just about "big", since cluster-based 
> > approaches can clearly scale far past big-iron, and are in effect statically
> > partitioned.  yes, buying a hideously expensive single box, and then chopping 
> > it into little pieces is more than a little bizarre, and is mainly based
> > on a couple assumptions:

Well, yeah IBM has been doing this virtualization & partitioning stuff
for ages at lots of different levels for lots of reasons.  If we are
in such direct conflict with Altix, aren't we also in conflict with our
own lines of business which do the same thing?  But, well, we aren't
in conflict - this is a complementary part of our overall capabilities.

> > 	- that clusters are hard.  really, they aren't.  they are not 
> > 	necessarily higher-maintenance, can be far more robust, usually
> > 	do cost less.  just about the only bad thing about clusters is 
> > 	that they tend to be somewhat larger in size.

This is orthogonal to clusters.  Or, well, we are even using CKRM today
is some grid/cluster style applications.  But that has no bearing on
whether or not clusters is useful.

> > 	- that partitioning actually makes sense.  the appeal is that if 
> > 	you have a partition to yourself, you can only hurt yourself.
> > 	but it also follows that burstiness in resource demand cannot be 
> > 	overlapped without either constantly tuning the partitions or 
> > 	infringing on the guarantee.
 
Well, if you don't think it makes sense, don't buy one.  And stay away
from Xen, VMware, VirtualIron, PowerPC/pSeries hardware, Mainframes,
Altix, IA64 platforms, Intel VT, AMD Pacifica, and, well, anyone else
that is working to support virtualization, which is one key level of
partitioning.

I'm sorry but I'm not buying your argument here at all - it just has
no relationship to what's going on at the user side as near as I can
tell.

> > CKRM is one of those things that could be done to Linux, and will benefit a
> > few, but which will almost certainly hurt *most* of the community.
> > 
> > let me say that the CKRM design is actually quite good.  the issue is whether 
> > the extensive hooks it requires can be done (at all) in a way which does 
> > not disporportionately hurt maintainability or efficiency.
 
Can you be more clear on how this will hurt *most* of the community?
CKRM when not in use is not in any way intrusive.  Can you take a look
at the patch again and point out the "extensive" hooks for me?  I've
looked at "all" of them and I have trouble calling a couple of callbacks
"extensive hooks".

> > CKRM requires hooks into every resource-allocation decision fastpath:
> > 	- if CKRM is not CONFIG, the only overhead is software maintenance.
> > 	- if CKRM is CONFIG but not loaded, the overhead is a pointer check.
> > 	- if CKRM is CONFIG and loaded, the overhead is a pointer check
> > 	and a nontrivial callback.

You left out a case here:  CKRM is CONFIG and loaded and classes are
defined.

In all of the cases that you mentioned, if there are no classes
defined, the overhead is still unmeasurable for any real workload.
Refer to the archives referenced earlier where Nish did some performance
measurements/comparisons.  If you think there are real workloads where
this is non-trivial, can you run, measure, and point out the cost?  Also,
do this with and without classes defined.  I think that without classes
defined, you'll be hard pressed to find a real workload that shows any
statistically significant performance impact.

> > but really, this is only for CKRM-enforced limits.  CKRM really wants to
> > change behavior in a more "weighted" way, not just causing an
> > allocation/fork/packet to fail.  a really meaningful CKRM needs to 
> > be tightly integrated into each resource manager - effecting each scheduler
> > (process, memory, IO, net).  I don't really see how full-on CKRM can be 
> > compiled out, unless these schedulers are made fully pluggable.
 
Well, loadable modules make sense for some items - what cost there is
(which is still often small) is born only by the users that use that
specific portion of CKRM.  But not everything is likely to be a loadable
module, e.g. the memory controller and the CPU scheduler components
are a bit tougher.  And yes, we are concerned about performance on big
and small machines, so that is always a concern with CKRM as well as
with any patches in any subsystem.

> > finally, I observe that pluggable, class-based resource _limits_ could 
> > probably be done without callbacks and potentially with low overhead.
> > but mere limits doesn't meet CKRM's goal of flexible, wide-spread resource 
> > partitioning within a large, shared machine.

CKRM's goal is to do simple workload management both on laptops and
on servers.  I'm not opposed to doing a few things overly simply as long
as we get some basic capability.  And we can refine with experience.  I'm
definitly not looking to make CKRM any more complex than it has to
be, and yet I also want it to be useful on a laptop, small single CPU
machine, as well as larger servers.

gerrit
