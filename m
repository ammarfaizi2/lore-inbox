Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWC0VSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWC0VSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWC0VSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:18:50 -0500
Received: from fmr23.intel.com ([143.183.121.15]:35554 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751458AbWC0VSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:18:49 -0500
Date: Mon, 27 Mar 2006 13:18:26 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       pj@sgi.com, hawkes@sgi.com, Dinakar Guniguntala <dino@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups dynamically
Message-ID: <20060327131826.A12364@unix-os.sc.intel.com>
References: <20060325082804.GB17011@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060325082804.GB17011@in.ibm.com>; from vatsa@in.ibm.com on Sat, Mar 25, 2006 at 01:58:04PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 01:58:04PM +0530, Srivatsa Vaddagiri wrote:
> +		if (!sched_group_phys && !alloc_phys_failed) {
> +			sched_group_phys
> +				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
> +					  GFP_KERNEL);
> +			if (!sched_group_phys) {
> +				printk (KERN_WARNING
> +				"Can not alloc phys sched group\n");
> +				alloc_phys_failed = 1;
> +			}
> +			sched_group_phys_bycpu[i] = sched_group_phys;
> +		}

We can move this allocation outside the for loop and avoid the complexities
of alloc_phys_failed, alloc_core_failed..

thanks,
suresh
