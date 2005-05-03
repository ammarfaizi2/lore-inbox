Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVECOee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVECOee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVECObp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:31:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13529 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261619AbVECOag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:30:36 -0400
Date: Tue, 3 May 2005 20:14:16 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050503144416.GA3933@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050501190947.GA5204@in.ibm.com> <20050502110135.173cbdd7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502110135.173cbdd7.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 11:01:35AM -0700, Paul Jackson wrote:
> My current concerns include:
>  o Having it work on ia64 would facilitate my testing.

   I am working on making changes to ia64, should be ready pretty soon

>  o Does this patch ensure that isolated sched domains form
>       a partition (disjoint cover) of a systems CPUs?  Should it?

   With this patch the cpus of an exclusive cpuset form a sched domain.
   Since only exclusive cpusets can form a sched domain, this ensures
   that the cpus form a disjoint cover

>  o Does this change any documented semantics of cpusets?  I don't
>       see offhand that it does.  Perhaps that's good.  Perhaps
>       I missed something.

   No, all semantics continue to be the same as before


I have trimmed the requirements to do only the absolute minimal in
kernel space

1.  Partitioning of the system (both cpus and memory) to ensure
    dedicated resources are available for application use.
    This has to be done through user space with the help of the
    existing cpuset infrastructure and no additional changes are
    required to be done in the kernel

2.  Remove unnecessary scheduler load balancing overhead in the
    partitions mentioned above
    a. Ensure that load balance code is aware of partitioning of cpus
       and load balance happens within these partitions and not
       across the entire system
    b. Provide for complete removal of load-balancing on a given
       partition of cpus

    This is necessary for a variety of workloads, including real-time,
    HPC and any mix of these workloads
    In the current patch, only 2(a) has been addressed.
    I intend to add support for 2(b) once the current patch is acceptable
    to everyone. I think this should not be a major change

3.  Support CPU hotplug is another requirement, though not a direct one


Hope this helps

	-Dinakar
