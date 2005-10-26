Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVJZHQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVJZHQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVJZHQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:16:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:15763 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932572AbVJZHQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:16:28 -0400
Subject: Re: [PATCH 3/5] Swap Migration V4: migrate_pages() function
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Magnus Damm <magnus.damm@gmail.com>,
       Paul Jackson <pj@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20051025193039.6828.74991.sendpatchset@schroedinger.engr.sgi.com>
References: <20051025193023.6828.89649.sendpatchset@schroedinger.engr.sgi.com>
	 <20051025193039.6828.74991.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 09:15:34 +0200
Message-Id: <1130310934.1226.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 12:30 -0700, Christoph Lameter wrote:
> 
> +#ifdef CONFIG_SWAP
> +       if (PageSwapCache(page)) {
> +               swp_entry_t swap = { .val = page_private(page) };
> +               add_to_swapped_list(swap.val);
> +               __delete_from_swap_cache(page);
> +               write_unlock_irq(&mapping->tree_lock);
> +               swap_free(swap);
> +               __put_page(page);       /* The pagecache ref */
> +               return 1;
> +       }
> +#endif /* CONFIG_SWAP */

Why is this #ifdef needed?  PageSwapCache() is #defined to 0 when !
CONFIG_SWAP.

-- Dave

