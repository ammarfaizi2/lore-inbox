Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVE0GhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVE0GhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVE0GhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:37:15 -0400
Received: from fmr23.intel.com ([143.183.121.15]:60825 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261686AbVE0GhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:37:07 -0400
Date: Thu, 26 May 2005 23:36:59 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       shaohua.li@intel.com, ashok.raj@intel.com
Subject: Re: [Patch] x86: fix smp_num_siblings on buggy BIOSes
Message-ID: <20050526233658.A28476@unix-os.sc.intel.com>
References: <20050525173456.A11038@unix-os.sc.intel.com> <20050526221737.7fc42984.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050526221737.7fc42984.akpm@osdl.org>; from akpm@osdl.org on Thu, May 26, 2005 at 10:17:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 10:17:37PM -0700, Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >
> > Appended patch will fix 'smp_num_siblings' value on the systems with
> > buggy bios, which sets number of siblings to '2' even when HT is disabled.
> > (more details are at http://bugzilla.kernel.org/show_bug.cgi?id=4359)
> > 
> > I am planning to do more cleanup in this area (like moving smp_num_siblings 
> > to per cpuinfo) shortly.
> > 
> > But meanwhile, please pickup this patch for 2.6.12.
> > 
> > Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> > Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > 
> > --- linux-2.6.12-rc5/arch/i386/kernel/smpboot.c~	2005-05-25 16:47:56.462416368 -0700
> > +++ linux-2.6.12-rc5/arch/i386/kernel/smpboot.c	2005-05-25 16:48:14.556665624 -0700
> > @@ -1074,8 +1074,10 @@
> >  			cpu_set(cpu, cpu_sibling_map[cpu]);
> >  		}
> >  
> > -		if (siblings != smp_num_siblings)
> > +		if (siblings != smp_num_siblings) {
> >  			printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, cpu, smp_num_siblings);
> > +			smp_num_siblings = siblings;
> > +		}
> >  
> >  		if (c->x86_num_cores > 1) {
> >  			for (i = 0; i < NR_CPUS; i++) {
> 
> OK, but be aware that -mm's sibling-map-initializing-rework.patch
> cheerfully deletes all the surrounding code.  So -mm will not have this
> fix.
> 
> There's a completely loony amount of x86 stuff in -mm.

Thanks for this info. I will send a fix for -mm also.

BTW, when do you plan to integrate x86 cpu hotplug patches to mainline?
Depending on that I will plan my "smp_num_siblings" global cleanup.

thanks,
suresh
