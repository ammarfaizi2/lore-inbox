Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWCUB0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWCUB0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWCUB0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:26:03 -0500
Received: from fmr17.intel.com ([134.134.136.16]:231 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964791AbWCUB0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:26:01 -0500
Date: Mon, 20 Mar 2006 17:25:51 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, bryce@osdl.org
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060320172551.A16743@unix-os.sc.intel.com>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20060317141322.GB27325@in.ibm.com> <20060318060958.A31112@unix-os.sc.intel.com> <1142903285.11430.1.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1142903285.11430.1.camel@sli10-desk.sh.intel.com>; from shaohua.li@intel.com on Tue, Mar 21, 2006 at 09:08:05AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 09:08:05AM +0800, Shaohua Li wrote:
> > +
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	/*
> > +	 * We do warm boot only on cpus that had booted earlier
> > +	 * Otherwise cold boot is all handled from smp_boot_cpus().
> > +	 * cpu_callin_map is set during AP kickstart process. Its reset
> > +	 * when a cpu is taken offline from cpu_exit_clear().
> > +	 */
> > +	if (!cpu_isset(cpu, cpu_callin_map))
> > +		ret = __smp_prepare_cpu(cpu);
> Does this work for boot time? cpu_callin_map isn't set at boot time for
> APs.
> 
Yes,

I tested on a 2 way system and it booted fine. This is set durng the kickstart process
when smp_callin() is called after AP receives boot ipi.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
