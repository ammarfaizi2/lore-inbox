Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFAJOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFAJOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFAJOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:14:24 -0400
Received: from ozlabs.org ([203.10.76.45]:64713 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261347AbVFAJOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:14:14 -0400
Date: Wed, 1 Jun 2005 19:09:42 +1000
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add page_state info to show_mem
Message-ID: <20050601090942.GF9193@krispykreme>
References: <375690000.1117584499@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375690000.1117584499@flay>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> This helps a lot when debugging out of memory stuff - useful especially
> to see if all the memory is sucked into slab, etc.

I was going to add this to ppc64 but I noticed that except for HIGHMEM bits 
it all looks the same :) Perhaps show_mem should end up somewhere
common.

Anton

> diff -purN -X /home/mbligh/.diff.exclude 2.6.11/arch/i386/mm/pgtable.c 2.6.11-show_mem_slab/arch/i386/mm/pgtable.c
> --- 2.6.11/arch/i386/mm/pgtable.c	2005-03-02 02:59:09.000000000 -0800
> +++ 2.6.11-show_mem_slab/arch/i386/mm/pgtable.c	2005-05-31 15:58:36.000000000 -0700
> @@ -30,6 +30,7 @@ void show_mem(void)
>  	struct page *page;
>  	pg_data_t *pgdat;
>  	unsigned long i;
> +	struct page_state ps;
>  
>  	printk("Mem-info:\n");
>  	show_free_areas();
> @@ -53,6 +54,13 @@ void show_mem(void)
>  	printk("%d reserved pages\n",reserved);
>  	printk("%d pages shared\n",shared);
>  	printk("%d pages swap cached\n",cached);
> +
> +	get_page_state(&ps);
> +	printk("%d pages dirty\n", ps.nr_dirty);
> +	printk("%d pages writeback\n", ps.nr_writeback);
> +	printk("%d pages mapped\n", ps.nr_mapped);
> +	printk("%d pages slab\n", ps.nr_slab);
> +	printk("%d pages pagetables\n", ps.nr_page_table_pages);
>  }
>  
>  /*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
