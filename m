Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbUDGOQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDGOQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:16:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32992 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263617AbUDGOQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:16:32 -0400
Date: Wed, 7 Apr 2004 19:47:21 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040407141721.GA12876@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com> <407277AE.2050403@yahoo.com.au> <1081310073.5922.86.camel@bach> <20040407050111.GA10256@in.ibm.com> <1081315931.5922.151.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081315931.5922.151.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 03:32:12PM +1000, Rusty Russell wrote:
> But other tasks can do a getaffinity() on it and see the wrong affinity.
> Probably not a big issue.

hmm .. the fact that getaffinity reads the cpus_allowed mask w/o doing
lock_cpu_hotplug makes it already racy wrt setaffinity?

Maybe it needs to take CPU hotplug sem before it reads the mask?

> I agree with Ingo: it's clever, well done.  Minor nitpicks:
> 
> +void migrate_all_tasks(int cpu)
>  {
>         struct task_struct *tsk, *t;
>         int dest_cpu, src_cpu;
>         unsigned int node;
>  
> -       /* We're nailed to this CPU. */
> -       src_cpu = smp_processor_id();
> +       src_cpu = cpu;
> 
> Just make the parameter name "src_cpu"?

[snip]

> This comment's very big.  They don't need to know all the things we
> don't do.  I'd prefer:
> 
> 		/* Force idle task to run as soon as we yield: it should
> 		   immediately notice cpu is offline and die quickly. */

Sure, I will change as per your comments.

I would like to run my stress tests for longer time before I send it
for inclusion (i would be on vacation till next tuesday ..so maybe i will send
in the patch after that!)

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
