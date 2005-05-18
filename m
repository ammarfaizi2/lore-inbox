Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVERJUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVERJUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVERJTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:19:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50140 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262135AbVERJTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:19:16 -0400
Date: Wed, 18 May 2005 14:59:03 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: ntl@pobox.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050518092903.GA3969@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050511134235.5cecf85c.pj@sgi.com> <20050511135850.3df60a9f.pj@sgi.com> <20050513192331.2244ada9.pj@sgi.com> <20050514121434.GK3614@otto> <20050514100417.5083262d.pj@sgi.com> <20050514104429.7dc92c85.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514104429.7dc92c85.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 10:44:29AM -0700, Paul Jackson wrote:
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> diff -Naurp 2.6.12-rc1-mm4.orig/Documentation/cpusets.txt 2.6.12-rc1-mm4/Documentation/cpusets.txt
> --- 2.6.12-rc1-mm4.orig/Documentation/cpusets.txt	2005-05-14 10:20:27.000000000 -0700
> +++ 2.6.12-rc1-mm4/Documentation/cpusets.txt	2005-05-14 10:24:13.000000000 -0700
> @@ -252,8 +252,7 @@ in a tasks processor placement.
>  There is an exception to the above.  If hotplug funtionality is used
>  to remove all the CPUs that are currently assigned to a cpuset,
>  then the kernel will automatically update the cpus_allowed of all
> -tasks attached to CPUs in that cpuset with the online CPUs of the
> -nearest parent cpuset that still has some CPUs online.  When memory
> +tasks attached to CPUs in that cpuset to allow all CPUs.  When memory
>  hotplug functionality for removing Memory Nodes is available, a
>  similar exception is expected to apply there as well.  In general,
>  the kernel prefers to violate cpuset placement, over starving a task
> diff -Naurp 2.6.12-rc1-mm4.orig/kernel/sched.c 2.6.12-rc1-mm4/kernel/sched.c
> --- 2.6.12-rc1-mm4.orig/kernel/sched.c	2005-05-13 18:39:54.000000000 -0700
> +++ 2.6.12-rc1-mm4/kernel/sched.c	2005-05-14 09:06:29.000000000 -0700
> @@ -4301,7 +4301,7 @@ static void move_task_off_dead_cpu(int d
>  
>  	/* No more Mr. Nice Guy. */
>  	if (dest_cpu == NR_CPUS) {
> -		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
> +		cpus_setall(tsk->cpus_allowed);
>  		dest_cpu = any_online_cpu(tsk->cpus_allowed);
>  
>  		/*
> 


This patch is fine by me. (Vatsa is on a vacation, so maybe Nathan can ack it?)
Andrew this resolves the oops I had reported earlier in the thread.

	Acked-by: Dinakar Guniguntala <dino@in.ibm.com>

