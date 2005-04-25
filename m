Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVDYLhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVDYLhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVDYLhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:37:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46216 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262590AbVDYLhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:37:04 -0400
Date: Mon, 25 Apr 2005 17:23:21 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050425115321.GA3944@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com> <20050419093438.GB3963@in.ibm.com> <20050419102348.118005c1.pj@sgi.com> <20050420071606.GA3931@in.ibm.com> <20050420120946.145a5973.pj@sgi.com> <20050421162738.GA4200@in.ibm.com> <20050423153059.0ab5fdc2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423153059.0ab5fdc2.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 03:30:59PM -0700, Paul Jackson wrote:
> The top cpuset holds the kernel threads that are pinned to a particular
> cpu or node.  It's not right that their cpusets cpus_allowed is empty,
> which is what I guess the "0" in the cpus_allowed column above means.
> (Even if the "0" means CPU 0, that still conflicts with kernel threads
> on CPUs 1-7.)

Yes, I meant cpus_allowed is empty

> 
> We might get away with it on cpus, because we don't change the tasks
> cpus_allowed to match the cpusets cpus_allowed (we don't call
> set_cpus_allowed, from kernel/cpuset.c) _except_ when someone rebinds
> that task to its cpuset by writing its pid into the cpuset tasks file.
> So for as long as no one tries to rebind the per-cpu or per-node
> kernel threads, no one will notice that they in a cpuset with an
> empty cpus_allowed.

True.

>  4) There are some tasks that _do_ require to run on the same cpus as
>     the tasks you would assign to isolated cpusets.  These kernel threads,
>     such as for example the migration and ksoftirqd threads, must be setup
>     well before user code is run that can configure job specific isolated
>     cpusets, so these tasks need a cpuset to run in that can be created
>     during the system boot, before init (pid == 1) starts up.  This cpuset
>     is the top cpuset.

And those processes (kernel threads) will continue to run on their cpus

> 
> I don't understand why what's there now isn't sufficient.  I don't see
> that this patch provides any capability that you can't get just by
> properly placing tasks in cpusets that have the desired cpus and nodes.
> This patch leaves the per-cpu kernel threads with no cpuset that allows
> what they need, and it complicates the semantics of things, in ways that
> I still don't entirely understand.

You are forgetting the fact that the scheduler is still load balancing
across all CPUs and tries to pull tasks only to find that the task's
cpus_allowed mask prevents it from being moved

> 
> You don't need to isolate a set of cpus; you need to isolate a set of
> processes.  So long as you can create non-overlapping cpusets, and
> assign processes to them, I don't see where it matters that you cannot
> prohibit the creation of overlapping cpusets, or in the case of the top
> cpuset, why it matters that you cannot _disallow_ allowed cpus
> or memory nodes in existing cpusets.
> 

I am working on a minimalistic design right now and will get back in
a day or two

	-Dinakar
