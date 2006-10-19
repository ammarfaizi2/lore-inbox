Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWJSGBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWJSGBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWJSGBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:01:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30130 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030304AbWJSGBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:01:08 -0400
Date: Wed, 18 Oct 2006 23:00:55 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: suresh.b.siddha@intel.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, rohitseth@google.com,
       dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061018230055.9ede1e16.pj@sgi.com>
In-Reply-To: <20061018174925.GB7885@in.ibm.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061018174925.GB7885@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It sort of made sense, in that one wants to avoid overlapping
> > sched domains to some extent.  However it conflicts with other
> > uses and meanings of the cpu_exclusive flag.  In particular,
> > a job manager cannot have an inactive job in a cpuset that
> > overlaps an active job, and mark the active job as defining a
> > sched domain.
> 
> Sorry I dont understand this at all. Particularly marking 
> an active job as a sched domain (I am yet to read all of the
> mails in this thread, so please bear with me if you have
> answered this elsewhere)
> 
> The only additional thing that happens once a cpuset has a 
> sched domain associated with it would that the rebalance code
> running on cpus not part of this cpuset would now not pull
> tasks from the exclusive cpuset. How is that bad in any way ??


The reason that an active job could not be made a sched domain when
its cpus overlapped an inactive job is that the cpu_exclusive rules
forbid any cpu_exclusive cpuset overlapping any sibling cpuset.

However ... this is basically just confirming for me my suspicion
that the Cpuset folks don't grok Sched Domains, and vice versa.

Time to remove this linkage between them that no one really understands
from both sides, and that apparently is broken and not safely usable.

Once I catch up on todays email, I will send out a patch to remove
this code linking cpuset cpu_exclusive to sched domains, replacing
it with a much simpler mechanism allowing for runtime control of
the cpu_isolated_map

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
