Return-Path: <linux-kernel-owner+w=401wt.eu-S1030279AbWL3FTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWL3FTw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 00:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWL3FTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 00:19:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:51904 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030279AbWL3FTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 00:19:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FAcW28KkrBK/jUUqG/7m4Hx6ggU/YT9x5d8kLdrFz4sy6LlshzfdCbfPLWsiBfD6lLMV8chNcYQZLmvW+4O0gWN/OWR8YP9SNjbyv/g124wa/59TRDgI7fa8sleWmbRcBCNQrEyOXoIH6GaM3SBd5aHL5/6RzRVLwxsyI2/3+pc=
Message-ID: <2e59e6970612292119o38d96583ie245cb140adaafba@mail.gmail.com>
Date: Fri, 29 Dec 2006 23:19:49 -0600
From: "* *" <richardvoigt@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1H0Uq5-0003Fo-1W@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was this patch tested?

On 12/29/06, Theodore Ts'o <tytso@mit.edu> wrote:
> Print messages resulting from sysrq-m with a KERN_INFO instead of the
> default KERN_WARNING priority
>
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
>
> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c      2006-12-25 09:21:54.000000000 -0500
> +++ linux-2.6/mm/page_alloc.c   2006-12-29 17:19:11.000000000 -0500
> @@ -1505,7 +1505,7 @@
>  static inline void show_node(struct zone *zone)
>  {
>         if (NUMA_BUILD)
> -               printk("Node %d ", zone_to_nid(zone));
> +               printk(KERN_INFO, "Node %d ", zone_to_nid(zone));

Here there is a comma after KERN_INFO, which does not occur elsewhere.

>  }
>
>  void si_meminfo(struct sysinfo *val)
> @@ -1566,8 +1566,8 @@
>
>                         pageset = zone_pcp(zone, cpu);
>
> -                       printk("CPU %4d: Hot: hi:%5d, btch:%4d usd:%4d   "
> -                              "Cold: hi:%5d, btch:%4d usd:%4d\n",
> +                       printk(KERN_INFO "CPU %4d: Hot: hi:%5d, btch:%4d "
> +                              "usd:%4d   Cold: hi:%5d, btch:%4d usd:%4d\n",
>                                cpu, pageset->pcp[0].high,
>                                pageset->pcp[0].batch, pageset->pcp[0].count,
>                                pageset->pcp[1].high, pageset->pcp[1].batch,
> @@ -1577,7 +1577,7 @@
>
>         get_zone_counts(&active, &inactive, &free);
>
> -       printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
> +       printk(KERN_INFO "Active:%lu inactive:%lu dirty:%lu writeback:%lu "
>                 "unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
>                 active,
>                 inactive,
> @@ -1619,7 +1619,7 @@
>                         zone->pages_scanned,
>                         (zone->all_unreclaimable ? "yes" : "no")
>                         );
> -               printk("lowmem_reserve[]:");
> +               printk(KERN_INFO "lowmem_reserve[]:");
>                 for (i = 0; i < MAX_NR_ZONES; i++)
>                         printk(" %lu", zone->lowmem_reserve[i]);
>                 printk("\n");
> @@ -1875,7 +1875,7 @@
>                 /* cpuset refresh routine should be here */
>         }
>         vm_total_pages = nr_free_pagecache_pages();
> -       printk("Built %i zonelists.  Total pages: %ld\n",
> +       printk(KERN_INFO "Built %i zonelists.  Total pages: %ld\n",
>                         num_online_nodes(), vm_total_pages);
>  }
>
> Index: linux-2.6/mm/swap_state.c
> ===================================================================
> --- linux-2.6.orig/mm/swap_state.c      2006-07-04 18:38:19.000000000 -0400
> +++ linux-2.6/mm/swap_state.c   2006-12-29 17:18:42.000000000 -0500
> @@ -57,12 +57,14 @@
>
>  void show_swap_cache_info(void)
>  {
> -       printk("Swap cache: add %lu, delete %lu, find %lu/%lu, race %lu+%lu\n",
> +       printk(KERN_INFO "Swap cache: add %lu, delete %lu, find %lu/%lu, race %lu+%lu\n",
>                 swap_cache_info.add_total, swap_cache_info.del_total,
>                 swap_cache_info.find_success, swap_cache_info.find_total,
>                 swap_cache_info.noent_race, swap_cache_info.exist_race);
> -       printk("Free swap  = %lukB\n", nr_swap_pages << (PAGE_SHIFT - 10));
> -       printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
> +       printk(KERN_INFO "Free swap  = %lukB\n",
> +              nr_swap_pages << (PAGE_SHIFT - 10));
> +       printk(KERN_INFO "Total swap = %lukB\n",
> +              total_swap_pages << (PAGE_SHIFT - 10));
>  }
>
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
