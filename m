Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVLBWwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVLBWwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVLBWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:52:06 -0500
Received: from serv01.siteground.net ([70.85.91.68]:32487 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750946AbVLBWwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:52:05 -0500
Date: Fri, 2 Dec 2005 14:51:56 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, shai@scalex86.org
Subject: Re: [discuss] Re: [patch 1/3] x86_64: Node local PDA -- early cpu_to_node
Message-ID: <20051202225156.GC3727@localhost.localdomain>
References: <20051202081028.GA5312@localhost.localdomain> <20051202114349.GL997@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202114349.GL997@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 12:43:49PM +0100, Andi Kleen wrote:
> > +#ifdef CONFIG_ACPI_NUMA
> > + 	/*
> > + 	 * Setup cpu_to_node using the SRAT lapcis & ACPI MADT table
> > + 	 * info.
> > + 	 */
> > + 	for (i = 0; i < NR_CPUS; i++)
> > + 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
> > +#endif
> 
> This should be in a separate function in srat.c. 

OK,

> 
> And are you sure it will work with k8topology.c. Doesn't look like
> that to me.

I don't have a K8 box yet :(, so I cannot confirm either ways.  
But I thought newer opterons need to use  ACPI_NUMA instead...

<Kconfig quote>
config K8_NUMA
       bool "Old style AMD Opteron NUMA detection"
       depends on NUMA
       default y
       help
         Enable K8 NUMA node topology detection.  You should say Y here if
         you have a multi processor AMD K8 system. This uses an old
         method to read the NUMA configurtion directly from the builtin
         Northbridge of Opteron. It is recommended to use X86_64_ACPI_NUMA
         instead, which also takes priority if both are compiled in.
</quote>

Even if K8 detection is used, cpu_pda will have memory allocated from node0
which is not different from the current state.  So this patch helps Opterons
and EM64t boxes which use ACPI_NUMA, right?  Also the newer opteron boxes
and em64t NUMA boxes can now get node local memory for static per-cpu areas.

Thanks,
Kiran


