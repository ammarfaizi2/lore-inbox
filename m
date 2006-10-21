Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992830AbWJUFiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992830AbWJUFiA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 01:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992832AbWJUFiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 01:38:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58567 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S2992830AbWJUFh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 01:37:59 -0400
Date: Fri, 20 Oct 2006 22:37:38 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: dino@in.ibm.com, nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061020223738.2919264e.pj@sgi.com>
In-Reply-To: <20061020161403.C8481@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020120005.61239317.pj@sgi.com>
	<20061020203016.GA26421@in.ibm.com>
	<20061020144153.b40b2cc9.pj@sgi.com>
	<20061020223553.GA14357@in.ibm.com>
	<20061020161403.C8481@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And whenever a child cpuset sets this use_cpus_exclusive flag, remove
> those set of child cpuset cpus from parent cpuset and also from the
> tasks which were running in the parent cpuset. We can probably  allow this
> to happen as long as parent cpuset has atleast one cpu.

Why are you seeking out obfuscated means and gratuitous entanglements
with cpuset semantics, in order to accomplish a straight forward end -
defining the sched domain partitioning?

If we are going to add or modify the meaning of per-cpuset flags in
order to determine sched domain partitioning, then we should do so in
the most straight forward way possible, which by all accounts seems to
be adding a 'sched_domain' flag to each cpuset, indicating whether it
delineates a sched domain partition.  The kernel would enforce a rule
that the CPUs in the cpusets so marked could not overlap.  The kernel
in return would promise not to split the CPUs in any cpuset so marked
into more than one sched domain partition, with the consequence that
the kernel would be able to load balance across all the CPUs contained
within any such partition.

Why do something less straightforward than that?

Meanwhile ...

If the existing cpuset semantics implied a real and useful partitioning
of the systems CPUs, as Nick had been figuring it did, then yes it
might make good sense to implicitly and automatically leverage this
cpuset partitioning when partitioning the sched domains.

But cpuset semantics, quite deliberately on my part, don't imply any
such system wide partitioning of CPUs.

So one of:
 1) we don't need sched domain partitioning after all, or
 2) this sched domain partitioning takes on a hierarchical nested shape
    that fits better with cpusets, or
 3) we provide a "transparent, simple and obvious" API to user space,
    so it can define the sched domain partitioning.

And in any case, we should first take a look at the rest of this sched
domain code, as I have been led to believe it provides some nice
opportunities for refinement, before we go fussing over the details of
any kernel-user API's it might need.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
