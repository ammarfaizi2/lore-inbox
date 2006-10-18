Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161218AbWJRRt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161218AbWJRRt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161244AbWJRRt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:49:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:35041 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161218AbWJRRt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:49:28 -0400
Date: Wed, 18 Oct 2006 23:19:25 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Paul Menage <menage@google.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Rohit Seth <rohitseth@google.com>, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-ID: <20061018174925.GB7885@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:03:51PM -0700, Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> I should get agreement from the other folks who care about the
> interaction of cpusets and sched domains before submitting this
> to Andrew for staging in *-mm.
> 
> In particular, I remain unsure of myself around the sched domain
> code, and could use some feedback from someone with more of a
> clue on whether I broke something here.
> 
> =======
> 
> I have long regretted hanging the ability to use cpusets to
> define dynamic scheduler domains off the 'cpu_exclusive' flag
> of cpusets.

I seem to recollect having this very discussion before and
we had agreed that backing up a cpu_exclusive cpuset with a 
sched domain was an optimization rather than overloading the 
cpu_exclusive flag and I dont think it has changed since then.

> 
> It sort of made sense, in that one wants to avoid overlapping
> sched domains to some extent.  However it conflicts with other
> uses and meanings of the cpu_exclusive flag.  In particular,
> a job manager cannot have an inactive job in a cpuset that
> overlaps an active job, and mark the active job as defining a
> sched domain.

Sorry I dont understand this at all. Particularly marking 
an active job as a sched domain (I am yet to read all of the
mails in this thread, so please bear with me if you have
answered this elsewhere)

The only additional thing that happens once a cpuset has a 
sched domain associated with it would that the rebalance code
running on cpus not part of this cpuset would now not pull
tasks from the exclusive cpuset. How is that bad in any way ??


> 
> In the interests of maintaining compatibility with the
> existing interface, we should not remove this overloading of
> the cpu_exclusive flag.  But we can add a new flag to define
> sched domains, and a second flag to activate this first flag.

[snip]

IMO this change is counter intuitive and pointless

	-Dinakar

