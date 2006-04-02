Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWDBEy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWDBEy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 23:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWDBEy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 23:54:56 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:22402 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750801AbWDBEy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 23:54:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jxx058RbideqRjHyhHGs9+SYQDeBvMlFYhx7ma3eeS51V0InoJeVdTbpS+YgyT9vmxBBRNU4Ax9jCSfoUwxQ52GBwgzu5P2/sNfzeNZKk9MyqAZjZpcNus9M0xVVK1r9JZwHR2Q64h48LvDrxMOdCtTzY/TGVtAIKlCEHjkkTsM=  ;
Message-ID: <442F2B52.6000205@yahoo.com.au>
Date: Sun, 02 Apr 2006 11:39:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures
 dynamically
References: <20060401185644.GC25971@in.ibm.com>
In-Reply-To: <20060401185644.GC25971@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Srivatsa Vaddagiri wrote:
>  /*
> @@ -6113,6 +6125,10 @@ next_sg:
>  static int build_sched_domains(const cpumask_t *cpu_map)
>  {
>  	int i;
> +	struct sched_group *sched_group_phys = NULL;
> +#ifdef CONFIG_SCHED_MC
> +	struct sched_group *sched_group_core = NULL;
> +#endif
>  #ifdef CONFIG_NUMA
>  	struct sched_group **sched_group_nodes = NULL;
>  	struct sched_group *sched_group_allnodes = NULL;
> @@ -6171,6 +6187,18 @@ static int build_sched_domains(const cpu
>  		cpus_and(sd->span, sd->span, *cpu_map);
>  #endif
>  
> +		if (!sched_group_phys) {
> +			sched_group_phys
> +				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
> +					  GFP_KERNEL);
> +			if (!sched_group_phys) {
> +				printk (KERN_WARNING "Can not alloc phys sched"
> +						     "group\n");
> +				goto error;
> +			}
> +			sched_group_phys_bycpu[i] = sched_group_phys;
> +		}

Doesn't the last assignment have to be outside the if statement?

Hmm.. this design seems like the best way to go for now. Suresh?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
