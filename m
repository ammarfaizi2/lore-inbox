Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUJHGAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUJHGAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJHGAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:00:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:30673 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267435AbUJHGAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:00:42 -0400
Date: Fri, 08 Oct 2004 14:55:16 +0900 (JST)
Message-Id: <20041008.145516.26538192.t-kochi@bq.jp.nec.com>
To: jbarnes@engr.sgi.com
Cc: nickpiggin@yahoo.com.au, colpatch@us.ibm.com, pj@sgi.com,
       mbligh@aracnet.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       simon.derr@bull.net, frankeh@watson.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] scheduler: Dynamic sched_domains
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <200410071001.07516.jbarnes@engr.sgi.com>
References: <1097110266.4907.187.camel@arrakis>
	<4164A664.9040005@yahoo.com.au>
	<200410071001.07516.jbarnes@engr.sgi.com>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: [Lse-tech] Re: [RFC PATCH] scheduler: Dynamic sched_domains
Date: Thu, 7 Oct 2004 10:01:07 -0700

> On Wednesday, October 6, 2004 7:13 pm, Nick Piggin wrote:
> > Hmm, what was my word for them... yeah, disjoint. We can do that now,
> > see isolcpus= for a subset of the functionality you want (doing larger
> > exclusive sets would probably just require we run the setup code once
> > for each exclusive set we want to build).
> 
> Yeah, and unfortunately since I added the code for overlapping domains w/o 
> adding a top level domain at the same time, we have disjoint domains by 
> default on large systems.

Yup, if SD_NODES_PER_DOMAIN is set to 4, our 32-way TX-7 have 
two disjoint domains ;(
(though the current default is 6 for ia64...)

I think the default configuration of the scheduler domains should be
as identical to its real hardware topology as possible, and should
modify the default only when necessary (e.g. for Altix).

Right now with the sched domain scheduler, we have to setup the 
domain hierarcy only at boot time statically, which makes it harder to
find the optimal domain topology/parameter.  The dynamic patch
makes it easier to modify the default configuration.

If the scheduler gains more dynamic configurability like what Jesse
said, it adds more flexibility for runtime optimization and seems
a way to go.  I'm not sure runtime configurability of domain topology
is necessary for all users, but it's extremely useful for developers.

I'll look into the Matt's patch further.

> > Also, how will you do overlapping domains that SGI want to do (see
> > arch/ia64/kernel/domain.c in -mm kernels)?
> >
> > node2 wants to balance between node0, node1, itself, node3, node4.
> > node4 wants to balance between node2, node3, itself, node5, node6.
> > etc.
> >
> > I think your lists will get tangled, no?
> 
> Yeah, but overlapping domains aren't a requirement.  In fact, making the 
> scheduling domains dynamically configurable is probably a *much* better 
> route, since I doubt that some default overlap setup will be optimal for many 
> workloads (that doesn't mean we shouldn't have good defaults though).  Being 
> able to configure the rebalance and tick rates of the various domains would 
> also be a good thing (the defaults could be keyed off of the number of CPUs 
> and/or nodes in the domain).

---
Takayoshi Kochi
