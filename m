Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVEGNpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVEGNpr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbVEGNpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:45:46 -0400
Received: from mail.suse.de ([195.135.220.2]:61362 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263141AbVEGNpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:45:11 -0400
Date: Sat, 7 May 2005 15:45:07 +0200
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: [2.6 patch] unexport phys_proc_id and cpu_core_id
Message-ID: <20050507134507.GB30158@wotan.suse.de>
References: <20050506211913.GO3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506211913.GO3590@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 11:19:14PM +0200, Adrian Bunk wrote:
> Back in January, Andi Kleen added EXPORT_SYMBOL(phys_proc_id), stating:
>   This is needed for the powernow k8 driver to manage AMD dual core 
>   systems.
> 
> This EXPORT_SYMBOL was never used.
> 
> I asked him on 13 Mar 2005 whether it's really required, but he didn't 
> answer to my email.

It is superceeded now with cpu_core_map[]/cpu_core_id[]
> 
> 2.6.12-rc3 adds cpu_core_id with a similarly unused 
> EXPORT_SYMBOL(cpu_core_id).
> 
> It's OK to export symbols when these exports are required, but unless 
> someone can explain why they are required now, they should be removed 
> before 2.6.12 and then re-added when they are actually used.

The dual powernowk8 driver really uses them, although the merging 
process seems to be a bit slow.

Andrew, please don't apply the patch.

-Andi

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  arch/i386/kernel/smpboot.c   |    2 --
>  arch/x86_64/kernel/smpboot.c |    2 --
>  2 files changed, 4 deletions(-)
> 
> --- linux-2.6.12-rc3-mm3-full/arch/i386/kernel/smpboot.c.old	2005-05-06 22:58:29.000000000 +0200
> +++ linux-2.6.12-rc3-mm3-full/arch/i386/kernel/smpboot.c	2005-05-06 22:58:47.000000000 +0200
> @@ -67,12 +67,10 @@
>  /* Package ID of each logical CPU */
>  int phys_proc_id[NR_CPUS] __cacheline_aligned_mostly_readonly =
>  			{[0 ... NR_CPUS-1] = BAD_APICID};
> -EXPORT_SYMBOL(phys_proc_id);
>  
>  /* Core ID of each logical CPU */
>  int cpu_core_id[NR_CPUS] __cacheline_aligned_mostly_readonly =
>  			{[0 ... NR_CPUS-1] = BAD_APICID};
> -EXPORT_SYMBOL(cpu_core_id);
>  
>  cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned_mostly_readonly;
>  cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned_mostly_readonly;
> --- linux-2.6.12-rc3-mm3-full/arch/x86_64/kernel/smpboot.c.old	2005-05-06 22:59:01.000000000 +0200
> +++ linux-2.6.12-rc3-mm3-full/arch/x86_64/kernel/smpboot.c	2005-05-06 22:59:12.000000000 +0200
> @@ -67,8 +67,6 @@
>  /* Package ID of each logical CPU */
>  u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
>  u8 cpu_core_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
> -EXPORT_SYMBOL(phys_proc_id);
> -EXPORT_SYMBOL(cpu_core_id);
>  
>  /* Bitmask of currently online CPUs */
>  cpumask_t cpu_online_map;
> 
