Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVJZQtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVJZQtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJZQtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:49:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34259 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964826AbVJZQtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:49:04 -0400
Date: Wed, 26 Oct 2005 09:48:32 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Magnus Damm <magnus.damm@gmail.com>,
       Paul Jackson <pj@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 3/5] Swap Migration V4: migrate_pages() function
In-Reply-To: <1130310934.1226.29.camel@localhost>
Message-ID: <Pine.LNX.4.62.0510260948060.12433@schroedinger.engr.sgi.com>
References: <20051025193023.6828.89649.sendpatchset@schroedinger.engr.sgi.com>
  <20051025193039.6828.74991.sendpatchset@schroedinger.engr.sgi.com>
 <1130310934.1226.29.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Dave Hansen wrote:

> Why is this #ifdef needed?  PageSwapCache() is #defined to 0 when !
> CONFIG_SWAP.

Right.

Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-10-26 09:46:20.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-10-26 09:47:33.000000000 -0700
@@ -387,7 +387,6 @@ static inline int remove_mapping(struct 
 	if (unlikely(PageDirty(page)))
 		goto cannot_free;
 
-#ifdef CONFIG_SWAP
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		add_to_swapped_list(swap.val);
@@ -397,7 +396,6 @@ static inline int remove_mapping(struct 
 		__put_page(page);	/* The pagecache ref */
 		return 1;
 	}
-#endif /* CONFIG_SWAP */
 
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);

