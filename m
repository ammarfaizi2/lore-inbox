Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVLBXCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVLBXCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVLBXCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:02:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:13034 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751041AbVLBXCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:02:08 -0500
Date: Sat, 3 Dec 2005 00:02:06 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [discuss] Re: [patch 1/3] x86_64: Node local PDA -- early cpu_to_node
Message-ID: <20051202230206.GF9766@wotan.suse.de>
References: <20051202081028.GA5312@localhost.localdomain> <20051202114349.GL997@wotan.suse.de> <20051202225156.GC3727@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202225156.GC3727@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 02:51:56PM -0800, Ravikiran G Thirumalai wrote:
> On Fri, Dec 02, 2005 at 12:43:49PM +0100, Andi Kleen wrote:
> > > +#ifdef CONFIG_ACPI_NUMA
> > > + 	/*
> > > + 	 * Setup cpu_to_node using the SRAT lapcis & ACPI MADT table
> > > + 	 * info.
> > > + 	 */
> > > + 	for (i = 0; i < NR_CPUS; i++)
> > > + 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
> > > +#endif
> > 
> > This should be in a separate function in srat.c. 
> 
> OK,
> 
> > 
> > And are you sure it will work with k8topology.c. Doesn't look like
> > that to me.
> 
> I don't have a K8 box yet :(, so I cannot confirm either ways.  
> But I thought newer opterons need to use  ACPI_NUMA instead...

k8topology still needs to work - e.g. for LinuxBios and users which use
acpi=off and as a fallback for broken SRAT tables. You can't break it right now.

> 
> <Kconfig quote>
> config K8_NUMA
>        bool "Old style AMD Opteron NUMA detection"
>        depends on NUMA
>        default y
>        help
>          Enable K8 NUMA node topology detection.  You should say Y here if
>          you have a multi processor AMD K8 system. This uses an old
>          method to read the NUMA configurtion directly from the builtin
>          Northbridge of Opteron. It is recommended to use X86_64_ACPI_NUMA
>          instead, which also takes priority if both are compiled in.
> </quote>
> 
> Even if K8 detection is used, cpu_pda will have memory allocated from node0
> which is not different from the current state.  So this patch helps Opterons
> and EM64t boxes which use ACPI_NUMA, right?  Also the newer opteron boxes
> and em64t NUMA boxes can now get node local memory for static per-cpu areas.

Hmm good point. However i would prefer if there was no performance regression
between the two options. However i guess it can be kept like this now.
Just make sure to comment it well.

-Andi

