Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUHTT5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUHTT5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUHTT5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:57:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46022 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268042AbUHTT5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:57:32 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm3
Date: Fri, 20 Aug 2004 15:56:10 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org>
In-Reply-To: <20040820115541.3e68c5be.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201556.10806.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 2:55 pm, Andrew Morton wrote:
> > Here's the output part way through a kernbench run:
>
> (This doesn't sound like the sort of workload which people would buy an
> Altix for?)

No, but other people are working on that stuff (e.g. Christoph's page faulting 
code).  That said, good multiuser performance is important on big boxes too.

> > 27081955 ia64_pal_call_static                     141051.8490
> > 3175264 ia64_load_scratch_fpregs                 49613.5000
> > 3166434 ia64_save_scratch_fpregs                 49475.5312
>
> What do the above three mean?

ia64_pal_call_static is part of the idle path.  Puts the CPU into low power 
state.  The save and restore fp regs I think are due to the fact that integer 
multiply uses fp regs, David?  They're also preserved across PROM calls, but 
we shouldn't be preserving them unless necessary.

> > 1603765 ia64_spinlock_contention                 16705.8854
>
> That's 0.04% of total non-idle CPU time.  This seems wrong.

The time between resetting the profiling buffer and collecting the profile was 
small, and was before kernbench had started 2048 threads, so most of the CPUs 
were idle.  I can do a longer run now that the profiling stuff seems to work.

Thanks,
Jesse
