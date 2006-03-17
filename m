Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbWCQN76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWCQN76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWCQN76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:59:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:52104 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932720AbWCQN74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:59:56 -0500
Date: Fri, 17 Mar 2006 19:29:48 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>,
       bryce@osdl.org
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060317135948.GA27325@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317042154.A13530@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317042154.A13530@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 04:21:54AM -0800, Ashok Raj wrote:
> Should we add !cpu_present(cpu) check as well just to be consistent with checks 
> in cpu_up() ? Probably better if we can move smp_prepare_cpu() to within cpu_up()?
> 
> How does the attached patch look.

I think this is much better (except for a minot nit - see below).

[snip]

> @@ -49,7 +49,9 @@ void enable_nonboot_cpus(void)
>  
>  	printk("Thawing cpus ...\n");
>  	for_each_cpu_mask(cpu, frozen_cpus) {
> +		lock_cpu_hotplug();
>  		error = smp_prepare_cpu(cpu);
> +		unlock_cpu_hotplug();

Can we remove this smp_prepare_cpu call also (since it is being called
in cpu_up() now in your patch)?


-- 
Regards,
vatsa
