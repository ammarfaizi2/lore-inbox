Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWDNQs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWDNQs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWDNQs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:48:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48769 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751279AbWDNQsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:48:55 -0400
Date: Fri, 14 Apr 2006 09:48:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, KAMEZAWA Hiroyuki wrote:

> I just compiled this patch (because I cannot use NUMA now.)

I can give this a spin later today.
> 
> BTW, why MAX_SWAPFILES_SHIFT==5 now ? required by some arch ?

No idea.

> +/* write protected page under migration*/
> +#define SWP_TYPE_MIGRATION_WP	(MAX_SWAPFILES - 1)
> +/* write enabled migration type */
> +#define SWP_TYPE_MIGRATION_WE	(MAX_SWAPFILES)

Could we call this SWP_TYPE_MIGRATION_READ / WRITE?

> +	pte = pte_mkold(mk_pte(new, vma->vm_page_prot));
> +	if (is_migration_entry_we(entry)) {
is_write_migration_entry?

> +		pte = pte_mkwrite(pte);
> +	}

No {} needed.

> -			entry = make_migration_entry(page);
> +			if (pte_write(pteval))
> +				entry = make_migration_entry(page, 1);
> +			else
> +				entry = make_migration_entry(page, 0);
>  		}

entry = make_migration_entry(page, pte_write(pteval))

?
