Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVKAImJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVKAImJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVKAImC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:42:02 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:58254
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S965060AbVKAIlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:41:53 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 3/5] Swap Migration V5: migrate_pages() function
Date: Tue, 1 Nov 2005 02:06:23 -0600
User-Agent: KMail/1.8
Cc: torvalds@osdl.org, akpm@osdl.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com> <20051101031254.12488.18612.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051101031254.12488.18612.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010206.24800.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 21:12, Christoph Lameter wrote:
> Page migration support in vmscan.c

This has no #ifdef SWAP:

> + if (PageSwapCache(page)) {
> +  swp_entry_t swap = { .val = page_private(page) };
> +  add_to_swapped_list(swap.val);
> +  __delete_from_swap_cache(page);
> +  write_unlock_irq(&mapping->tree_lock);
> +  swap_free(swap);
> +  __put_page(page); /* The pagecache ref */
> +  return 1;
> + }

But what you removed did:

> -#ifdef CONFIG_SWAP
> -  if (PageSwapCache(page)) {
> -   swp_entry_t swap = { .val = page_private(page) };
> -   add_to_swapped_list(swap.val);
> -   __delete_from_swap_cache(page);
> -   write_unlock_irq(&mapping->tree_lock);
> -   swap_free(swap);
> -   __put_page(page); /* The pagecache ref */
> -   goto free_it;
> -  }
> -#endif /* CONFIG_SWAP */

What happens if you build without swap?

Rob
