Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUJGRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUJGRNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUJGRMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:12:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25482 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267487AbUJGRCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:02:05 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC PATCH] scheduler: Dynamic sched_domains
Date: Thu, 7 Oct 2004 10:01:07 -0700
User-Agent: KMail/1.7
Cc: colpatch@us.ibm.com, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
References: <1097110266.4907.187.camel@arrakis> <4164A664.9040005@yahoo.com.au>
In-Reply-To: <4164A664.9040005@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410071001.07516.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 6, 2004 7:13 pm, Nick Piggin wrote:
> Hmm, what was my word for them... yeah, disjoint. We can do that now,
> see isolcpus= for a subset of the functionality you want (doing larger
> exclusive sets would probably just require we run the setup code once
> for each exclusive set we want to build).

Yeah, and unfortunately since I added the code for overlapping domains w/o 
adding a top level domain at the same time, we have disjoint domains by 
default on large systems.

> Also, how will you do overlapping domains that SGI want to do (see
> arch/ia64/kernel/domain.c in -mm kernels)?
>
> node2 wants to balance between node0, node1, itself, node3, node4.
> node4 wants to balance between node2, node3, itself, node5, node6.
> etc.
>
> I think your lists will get tangled, no?

Yeah, but overlapping domains aren't a requirement.  In fact, making the 
scheduling domains dynamically configurable is probably a *much* better 
route, since I doubt that some default overlap setup will be optimal for many 
workloads (that doesn't mean we shouldn't have good defaults though).  Being 
able to configure the rebalance and tick rates of the various domains would 
also be a good thing (the defaults could be keyed off of the number of CPUs 
and/or nodes in the domain).

Thanks,
Jesse
