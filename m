Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWA1BpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWA1BpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbWA1BpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:45:23 -0500
Received: from fmr21.intel.com ([143.183.121.13]:63946 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422783AbWA1BpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:45:22 -0500
Date: Fri, 27 Jan 2006 17:45:12 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rohit.seth@intel.com, asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060127174512.A6229@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com> <200601270542.12404.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200601270542.12404.ak@suse.de>; from ak@suse.de on Fri, Jan 27, 2006 at 05:42:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 05:42:11AM +0100, Andi Kleen wrote:
> On Thursday 26 January 2006 10:51, Siddha, Suresh B wrote:
> 
> With this patch does the new distance checking code in the scheduler 
> from Ingo automatically discover all the relevant distances?

Yes.

> 
> > +#ifdef CONFIG_SMP
> > +	unsigned int cpu = (c == &boot_cpu_data) ? 0 : (c - cpu_data);
> > +#endif
> 
> Wouldn't it be better to just put that information into the cpuinfo_x86?
> We're having too many per CPU arrays already.


> Actually it would be better to pass this information in some other way
> to smpboot.c than to add more and more arrays like this.  It's only
> needed for the current CPU, because for the others the information
> is in cpu_llc_shared_map

In smpboot.c we require the llc id of current CPU and all other online cpus.
I will put cpu_llc_shared_map info into cpuinfo_x86 (in future with power
savings sched policy, it will be used whenever someone changes sched policy)
And will make cpu_llc_id[] as __cpuinitdata.

> 
> Perhaps SMP boot up should pass around a pointer to temporary data like this?
> Or discover it in smpboot.c with a function call?
> 
> > -#ifdef CONFIG_SCHED_SMT
> > +#if defined(CONFIG_SCHED_SMT)
> >  		sd = &per_cpu(cpu_domains, i);
> > +#elif defined(CONFIG_SCHED_MC)
> 
> elif? What happens where there are both shared caches and SMT? 

Lowest domain the cpu gets attached to it is SMT domain.

thanks,
suresh
