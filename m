Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWJWEvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWJWEvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWJWEvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:51:38 -0400
Received: from mga07.intel.com ([143.182.124.22]:48218 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751490AbWJWEvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:51:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="134539968:sNHT19714303"
Date: Sun, 22 Oct 2006 21:31:05 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, dino@in.ibm.com,
       nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061022213052.A2526@unix-os.sc.intel.com>
References: <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <4538F34A.7070703@yahoo.com.au> <20061020120005.61239317.pj@sgi.com> <20061020203016.GA26421@in.ibm.com> <20061020144153.b40b2cc9.pj@sgi.com> <20061020223553.GA14357@in.ibm.com> <20061020161403.C8481@unix-os.sc.intel.com> <20061020223738.2919264e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061020223738.2919264e.pj@sgi.com>; from pj@sgi.com on Fri, Oct 20, 2006 at 10:37:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 10:37:38PM -0700, Paul Jackson wrote:
> > And whenever a child cpuset sets this use_cpus_exclusive flag, remove
> > those set of child cpuset cpus from parent cpuset and also from the
> > tasks which were running in the parent cpuset. We can probably  allow this
> > to happen as long as parent cpuset has atleast one cpu.
> 
> Why are you seeking out obfuscated means and gratuitous entanglements
> with cpuset semantics, in order to accomplish a straight forward end -
> defining the sched domain partitioning?
> 
> If we are going to add or modify the meaning of per-cpuset flags in
> order to determine sched domain partitioning, then we should do so in
> the most straight forward way possible, which by all accounts seems to
> be adding a 'sched_domain' flag to each cpuset, indicating whether it
> delineates a sched domain partition.  The kernel would enforce a rule
> that the CPUs in the cpusets so marked could not overlap.  The kernel
> in return would promise not to split the CPUs in any cpuset so marked
> into more than one sched domain partition, with the consequence that
> the kernel would be able to load balance across all the CPUs contained
> within any such partition.
> 
> Why do something less straightforward than that?

Ok. I went to implementation details(and ended up less straight forward..) but
my main intention was to say that we need to retain some sort of hierarchical 
shape too, while creating these domain partitions.

Like for example, a big system can be divided into different groups of
cpus for each department in an organisation. And internally based
on the needs, each department can divide its pool of cpus into sub groups
and allocates to much smaller group. And based on the sub group creation/
deletion, cpus will move from department to subgroups and viceversa.

users probably want both flat and hierarchical partitions. And in this
partition mechanism, we should never allow cpus being present in more than one
partition.

thanks,
suresh
