Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWJWTul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWJWTul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWJWTul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:50:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:59581 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932129AbWJWTuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:50:32 -0400
Date: Tue, 24 Oct 2006 01:20:11 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-ID: <20061023195011.GB1542@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com> <20061020210422.GA29870@in.ibm.com> <20061022201824.267525c9.pj@sgi.com> <453C4E22.9000308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453C4E22.9000308@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 03:07:46PM +1000, Nick Piggin wrote:
> Paul Jackson wrote:
> >Dinakar wrote:
> >
> >>IMO this patch addresses just one of the requirements for partitionable
> >>sched domains
> >Correct - this particular patch was just addressing one of these.
> >
> >Nick raised the reasonable concern that this patch was adding something
> >to cpusets that was not especially related to cpusets.
> 
> Did you send resend the patch to remove sched-domain partitioning?
> After clearing up my confusion, IMO that is needed and could probably
> go into 2.6.19.
> 
> >So I will not be sending this patch to Andrew for *-mm.
> >
> >There are further opportunities for improvements in some of this code,
> >which my colleague Christoph Lameter may be taking an interest in.
> >Ideally kernel-user API's for isolating and partitioning sched domains
> >would arise from that work, though I don't know if we can wait that
> >long.
> 
> The sched-domains code is all there and just ready to be used. IMO
> using the cpusets API (or a slight extension thereof) would be the
> best idea if we're going to use any explicit interface at all.

Ok I am getting lost in all of the mails here, so let me try to summaize

The existing cpuset code that partitioned sched domains at the
back of a exclusive cpuset has one major problem. Administrators
will find that tasks assigned to top level cpusets, that contain
child cpusets that are exclusive, can no longer be rebalanced across
the entire cpus_allowed mask.
This as far as I can tell is the only problem with the current code.
So I dont see why we need a major rewrite that involves a complete change
in the approach to the dynamic sched domain implementation.

I really think all we need is to have a new flag (say sched_domain)
that can be used by the admin to create a sched domain. Since this is
in addition to the cpu_exclusive flag, the admin realizes that the tasks
associated with the parent cpuset may need to be moved around to better
reflect the cpus that will actually run on. Thats it.

Can somebody tell me why this approach is not good enough ?

I am testing this patch currently and will post it shortly for review

	-Dinakar

> 
> A cool option would be to determine the partitions according to the
> disjoint set of unions of cpus_allowed masks of all tasks. I see this
> getting computationally expensive though, probably O(tasks*CPUs)... I
> guess that isn't too bad.
> 
> Might be better than a userspace interface.
> 
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 
