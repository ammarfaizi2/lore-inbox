Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUFDIU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUFDIU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 04:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUFDIU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 04:20:57 -0400
Received: from holomorphy.com ([207.189.100.168]:1188 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265781AbUFDIUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 04:20:35 -0400
Date: Fri, 4 Jun 2004 01:19:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604081906.GR21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
	Ashok Raj <ashok.raj@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Simon Derr <Simon.Derr@bull.net>
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603101010.4b15734a.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:10:10AM -0700, Paul Jackson wrote:
> +static inline void __cpu_set(int cpu, volatile cpumask_t *dstp)
> +{
> +	set_bit(cpu, dstp->bits);
> +}

Hungarian notation?


On Thu, Jun 03, 2004 at 10:10:10AM -0700, Paul Jackson wrote:
> +#if NR_CPUS > 1
> +#define num_online_cpus()    cpus_weight(cpu_online_map)
> +#define num_possible_cpus()  cpus_weight(cpu_possible_map)
> +#define num_present_cpus()   cpus_weight(cpu_present_map)
> +#define cpu_online(cpu)      cpu_isset((cpu), cpu_online_map)
> +#define cpu_possible(cpu)    cpu_isset((cpu), cpu_possible_map)
> +#define cpu_present(cpu)     cpu_isset((cpu), cpu_present_map)
> +#else
> +#define num_online_cpus()    1
> +#define num_possible_cpus()  1
> +#define num_present_cpus()   1
> +#define cpu_online(cpu)      ((cpu) == 0)
> +#define cpu_possible(cpu)    ((cpu) == 0)
> +#define cpu_present(cpu)     ((cpu) == 0)
> +#endif

#ifdef'ing it anyway?


On Thu, Jun 03, 2004 at 10:10:10AM -0700, Paul Jackson wrote:
> @@ -1206,9 +1207,10 @@
>  {
>  	struct ino_bucket *bp = ivector_table + (long)data;
>  	struct irqaction *ap = bp->irq_info;
> -	cpumask_t mask = get_smpaff_in_irqaction(ap);
> +	cpumask_t mask;
>  	int len;
>  
> +	cpus_addr(mask)[0] = get_smpaff_in_irqaction(ap);
>  	if (cpus_empty(mask))
>  		mask = cpu_online_map;

This is an improvement?


-- wli
