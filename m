Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUJAXj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUJAXj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJAXjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:39:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:10436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266352AbUJAXjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:39:00 -0400
Date: Fri, 1 Oct 2004 16:41:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>, ckrm-tech@lists.sourceforge.net
Cc: pj@sgi.com, efocht@hpce.nec.com, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041001164118.45b75e17.akpm@osdl.org>
In-Reply-To: <411685D6.5040405@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul, I'm having second thoughts regarding a cpusets merge.  Having gone
back and re-read the cpusets-vs-CKRM thread from mid-August, I am quite
unconvinced that we should proceed with two orthogonal resource
management/partitioning schemes.

And CKRM is much more general than the cpu/memsets code, and hence it
should be possible to realize your end-users requirements using an
appropriately modified CKRM, and a suitable controller.

I'd view the difficulty of implementing this as a test of the wisdom of
CKRM's design, actually.

The clearest statement of the end-user cpu and memory partitioning
requirement is this, from Paul:

> Cpusets - Static Isolation:
> 
>     The essential purpose of cpusets is to support isolating large,
>     long-running, multinode compute bound HPC (high performance
>     computing) applications or relatively independent service jobs,
>     on dedicated sets of processor and memory nodes.
>     
>     The (unobtainable) ideal of cpusets is to provide perfect
>     isolation, for such jobs as:
> 
>      1) Massive compute jobs that might run hours or days, on dozens
> 	or hundreds of processors, consuming gigabytes or terabytes
> 	of main memory.  These jobs are often highly parallel, and
> 	carefully sized and placed to obtain maximum performance
> 	on NUMA hardware, where memory placement and bandwidth is
> 	critical.
> 
>      2) Independent services for which dedicated compute resources
>         have been purchased or allocated, in units of one or more
> 	CPUs and Memory Nodes, such as a web server and a DBMS
> 	sharing a large system, but staying out of each others way.
> 
>     The essential new construct of cpusets is the set of dedicated
>     compute resources - some processors and memory.  These sets have
>     names, permissions, an exclusion property, and can be subdivided
>     into subsets.
> 
>     The cpuset file system models a hierarchy of 'virtual computers',
>     which hierarchy will be deeper on larger systems.
> 
>     The average lifespan of a cpuset used for (1) above is probably
>     between hours and days, based on the job lifespan, though a couple
>     of system cpusets will remain in place as long as the system is
>     running.  The cpusets in (2) above might have a longer lifespan;
>     you'd have to ask Simon Derr of Bull about that.
> 

Now, even that is not a very good end-user requirement because it does
prejudge the way in which the requirement's solution should be implemented.
 Users don't require that their NUMA machines "model a hierarchy of
'virtual computers'".  Users require that their NUMA machines implement
some particular behaviour for their work mix.  What is that behaviour?

For example, I am unable to determine from the above whether the users
would be 90% satisfied with some close-enough ruleset which was implemented
with even the existing CKRM cpu and memory governors.

So anyway, I want to reopen this discussion, and throw a huge spanner in
your works, sorry.

I would ask the CKRM team to tell us whether there has been any progress in
this area, whether they feel that they have a good understanding of the end
user requirement, and to sketch out a design with which CKRM could satisfy
that requirement.

Thanks.
