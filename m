Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUGWVxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUGWVxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267847AbUGWVxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:53:18 -0400
Received: from fmr05.intel.com ([134.134.136.6]:35751 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266397AbUGWVxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:53:16 -0400
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] consolidate sched domains
Date: Fri, 23 Jul 2004 14:50:46 -0700
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <41008386.9060009@yahoo.com.au> <20040723153022.GA16563@sgi.com>
In-Reply-To: <20040723153022.GA16563@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2gYABj4f5vlndSJ"
Message-Id: <200407231450.47070.suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 23 Jul 2004 21:51:35.0321 (UTC) FILETIME=[39480890:01C470FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_2gYABj4f5vlndSJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 23 July 2004 08:30, Dimitri Sivanich wrote:
> On Fri, Jul 23, 2004 at 01:18:30PM +1000, Nick Piggin wrote:
> > The attached patch is against 2.6.8-rc1-mm1. Tested on SMP, UP and SMP+HT
> > here and it seems to be OK.
> >
> > I have included the cpu_sibling_map for ppc64, although Anton said he did
> > have an implementation floating around which he would probably prefer,
> > but I'll let him deal with that.
>
> Do other architectures need to define their own cpu_sibling_maps, or am I
> missing something that would define that for IA64 and others?

Nick means, all the architectures which use CONFIG_SCHED_SMT needs to define 
cpu_sibling_map.

Nick, aren't you missing the attached fix in your patch?

thanks,
suresh

--Boundary-00=_2gYABj4f5vlndSJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cpu_power-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpu_power-fix.patch"

--- linux-2.6.8-rc1/kernel/sched.c~	2004-07-23 13:19:48.000000000 -0700
+++ linux-2.6.8-rc1/kernel/sched.c	2004-07-23 13:34:49.000000000 -0700
@@ -3845,6 +3845,8 @@
 		sd->groups->cpu_power = power;
 
 #ifdef CONFIG_NUMA
+		if (i != first_cpu(sd->groups->cpumask))
+			continue;
 		sd = &per_cpu(node_domains, i);
 		sd->groups->cpu_power += power;
 #endif

--Boundary-00=_2gYABj4f5vlndSJ--
