Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSJYT4Y>; Fri, 25 Oct 2002 15:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJYT4X>; Fri, 25 Oct 2002 15:56:23 -0400
Received: from bozo.vmware.com ([65.113.40.131]:1032 "EHLO mailout1.vmware.com")
	by vger.kernel.org with ESMTP id <S261566AbSJYT4W>;
	Fri, 25 Oct 2002 15:56:22 -0400
Date: Fri, 25 Oct 2002 13:03:18 -0700
From: chrisl@vmware.com
To: Robert Love <rml@tech9.net>
Cc: Dave Jones <davej@codemonkey.org.uk>, akpm@digeo.com,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] How to get number of physical CPU in linux from user space?
Message-ID: <20021025200318.GE1397@vmware.com>
References: <F2DBA543B89AD51184B600508B68D4000EA170E9@fmsmsx103.fm.intel.com> <1035572950.1501.3429.camel@phantasy> <20021025191356.GA11189@suse.de> <1035573689.730.3473.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035573689.730.3473.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool. That will work for me.

Thanks

Chris

On Fri, Oct 25, 2002 at 03:21:28PM -0400, Robert Love wrote:
> On Fri, 2002-10-25 at 15:13, Dave Jones wrote:
> 
> > Should this be wrapped in a if (cpu_has_ht(c)) { }  ?
> > Seems silly to be displaying HT information on non-HT CPUs.
> 
> I am neutral, but is fine with me. It is just "cpu_has_ht", btw.
> 
> Take two...
> 
> This displays the physical processor id and number of siblings of each
> processor in /proc/cpuinfo.
> 
> 	Robert Love
> 
>  .proc.c.swp |binary
>  proc.c      |    7 +++++++
>  2 files changed, 7 insertions(+)
> 
> diff -urN linux-2.5.44/arch/i386/kernel/cpu/proc.c linux/arch/i386/kernel/cpu/proc.c
> --- linux-2.5.44/arch/i386/kernel/cpu/proc.c	2002-10-19 00:02:29.000000000 -0400
> +++ linux/arch/i386/kernel/cpu/proc.c	2002-10-25 15:18:03.000000000 -0400
> @@ -17,6 +17,7 @@
>  	 * applications want to get the raw CPUID data, they should access
>  	 * /dev/cpu/<cpu_nr>/cpuid instead.
>  	 */
> +	extern int phys_proc_id[NR_CPUS];
>  	static char *x86_cap_flags[] = {
>  		/* Intel-defined */
>  	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
> @@ -74,6 +75,12 @@
>  	/* Cache size */
>  	if (c->x86_cache_size >= 0)
>  		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
> +#ifdef CONFIG_SMP
> +	if (cpu_has_ht) {
> +		seq_printf(m, "physical processor ID\t: %d\n", phys_proc_id[n]);
> +		seq_printf(m, "number of siblings\t: %d\n", smp_num_siblings);
> +	}
> +#endif
>  	
>  	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
>  	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
> 


