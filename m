Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVDCWbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVDCWbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVDCWbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 18:31:38 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56739 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261919AbVDCWb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 18:31:29 -0400
Date: Sun, 3 Apr 2005 15:30:56 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403153056.0ad6ee8e.pj@engr.sgi.com>
In-Reply-To: <20050403150102.GA25442@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403150102.GA25442@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> if_ there is a significant hierarchy between CPUs it
> should be represented via a matching sched-domains hierarchy,

Agreed.

I'll see how the sched domains hierarchy looks on a bigger SN2 systems.

If the CPU hierarchy is not reflected in the sched-domain hierarchy any
better there, then I will look to involve the "SN2 sched domain
hierarchy experts" in improving SN2 the sched-domain hierarchy.

Ok - that works.  Your patch of yesterday provides just the tool
I need to measure this.  Cool.

> i'll first try the bottom-up approach to speed up detection (getting to
> the hump is very fast most of the time).

Good.

> then we can let the arch override the cpu_distance() method

I'm not aware we need that, yet anyway.  First I should see if
the SN2 sched_domains need improving.  Take a shot at doing it
'the right way' before we go inventing overrides.  I suspect
you agree.

> the migration cost matrix we can later use to tune all the other 
> sched-domains balancing related tunables as well

That comes close to my actual motivation here.  I hope to expose a
"cpu_distance" such as based on this cost matrix, to userland.

We already expose the SLIT table node distances (using SN2 specific
/proc files today, others are working on an arch-neutral mechanism).

As we push more cores and hyperthreads into a single package on one end,
and more complex numa topologies on the other end, this becomes
increasingly interesting to NUMA aware user software.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
