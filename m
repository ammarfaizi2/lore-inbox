Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUFFXWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUFFXWe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUFFXWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:22:34 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:12009 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263656AbUFFXWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 19:22:32 -0400
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
	implementation
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: wli@holomorphy.com, mikpe@csd.uu.se,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040606051657.3c9b44d3.pj@sgi.com>
References: <16576.16748.771295.988065@alkaid.it.uu.se>
	 <20040604093712.GU21007@holomorphy.com>
	 <16576.17673.548349.36588@alkaid.it.uu.se>
	 <20040604095929.GX21007@holomorphy.com>
	 <16576.23059.490262.610771@alkaid.it.uu.se>
	 <20040604112744.GZ21007@holomorphy.com>
	 <20040604113252.GA21007@holomorphy.com>
	 <20040604092316.3ab91e36.pj@sgi.com>
	 <20040604162853.GB21007@holomorphy.com>
	 <20040604104756.472fd542.pj@sgi.com>
	 <20040604181233.GF21007@holomorphy.com> <1086487651.11454.19.camel@bach>
	 <20040606051657.3c9b44d3.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086564057.18634.29.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 09:20:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 22:16, Paul Jackson wrote:
> Rusty wrote:
> > Yes, NR_CPUS needs to get to userspace somehow sanely if we want to fix
> > this in general.
> 
> Are you saying that NR_CPUS is needed, or just the number of longs in a
> cpumask (sizeof (cpumask_t), essentially)?

You're right.  Three things are required.

1) Access to cpu_online_map (currently usually intuited from
/proc/cpuinfo)
2) Notification of cpu add/remove (currently via /sbin/hotplug)
3) Minimum size of cpumask_t (currently hardcoded, could be detected by
looping).

Although we don't, in general, know the size of long (think i386 binary
on x86_64), in practice if you always round NR_CPUS up to 64-bits you
can get #3.

> I am a firm believer in passing the minimum essential information across
> major boundaries.  Passing too much creates maintaince problems, and
> encourages misuse of information, resulting in bogus user code.

In this case, though, the early example programs for setaffinity all
used "unsigned long mask; sys_sched_setaffinity(...&mask,
sizeof(mask))", which was both simple and wrong.  Similarly, getaffinity
users who didn't zero the mask before handing it to the kernel.

Oh well,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

