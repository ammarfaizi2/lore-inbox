Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWCZCkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWCZCkt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWCZCkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:40:49 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:19130 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751322AbWCZCks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:40:48 -0500
Date: Sun, 26 Mar 2006 08:10:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, suresh.b.siddha@intel.com,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
Message-ID: <20060326024039.GA2998@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060325082730.GA17011@in.ibm.com> <20060325180605.6e5bb4b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325180605.6e5bb4b9.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 06:06:05PM -0800, Andrew Morton wrote:
> This is rather ugly, sorry.

That was about my reaction too when I was going thr'
build_sched_domains()!

> So if the kmalloc failed we'll try to limp along without load balancing?

Not exactly. We will still load balance at lower domains (between
threads of a CPU & between CPUs of a node) that dont require any memory
allocation.

> I think it would be better to free any thus-far allocated memory and to
> fail the whole thing.

This would result in absolutely no load balancing (even for domain
levels which didnt need any memory allocation - like at threads-of-a-cpu
level). Is that acceptable?

> Returning void from build_sched_domains was wrong.

If we decide to return an error, then it has to be percolated all the
way down (for ex: update_cpu_domains should now have to return an error
too if partition_sched_domains returns an error)?

> build_sched_domains() should be static and __cpuinit, btw.

Ok ..Will take care of that in the next version of the patch.

And thanks for the response to the patch!

-- 
Regards,
vatsa
