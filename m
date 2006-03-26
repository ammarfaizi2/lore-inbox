Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWCZDcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWCZDcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 22:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCZDcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 22:32:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:5331 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751054AbWCZDcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 22:32:36 -0500
Date: Sun, 26 Mar 2006 09:02:19 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, suresh.b.siddha@intel.com,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
Message-ID: <20060326033219.GA12227@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060325082730.GA17011@in.ibm.com> <20060325180605.6e5bb4b9.akpm@osdl.org> <20060326024039.GA2998@in.ibm.com> <20060325184441.0f6ba5bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325184441.0f6ba5bc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 06:44:41PM -0800, Andrew Morton wrote:
> Well, when is this code called?  It would be at boot time, in which case
> the allocations will succeed (if not, the boot fails) or at cpu/node
> hot-add, in which case the appropriate response is to fail to bring up the
> new cpu/node.


Hmm ..dont follow you here. Are you saying the above is the current
behavior (say in 2.6.16-mm1)? AFAICS that is not true because 
arch_init_sched_domains (which handles both bootup & cpu hot-add cases) 
doesnt return any error back to its caller.

Also note that build_sched_domains can be called from CPUset code too
(partition_sched_domains) when we modify the exclusive property of a CPUset.

> It's better to send the administrator back to work out why we ran out of
> memory than to appear to have brought the new cpu/node online, only to have
> it run funny.
> 
> I think?

I don't know. Is load balancing an absolute critical feature that
without it system bootup and cpu hot-add should be failed? Also note
that we may be able to do partial load balancing (between threads of a
CPU) even when there is memory allocation failure.

Regarding giving administrator hints of allocation failure, the printks in 
build_sched_domain do give those hints.

> 
> > > build_sched_domains() should be static and __cpuinit, btw.
> > 
> > Ok ..Will take care of that in the next version of the patch.
> > 
> 
> umm, it's probably best to not bother.  I think Ashok is looking into all
> the memory we're presently wasting on non-cpu_hotplug builds.  There's
> quite a lot in there.

Ok ..Will let Ashok take care of adding __cpuinit prefix.

-- 
Regards,
vatsa
