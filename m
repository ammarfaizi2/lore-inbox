Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUC2WZC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUC2WZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:25:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11683 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263154AbUC2WY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:24:56 -0500
Date: Mon, 29 Mar 2004 23:24:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
    fix
In-Reply-To: <20040329124027.36335d93.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0403292312170.19944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Andrew Morton wrote:
> 
> hmm, yes, we have pages which satisfy PageSwapCache(), but which are not
> actually in swapcache.
> 
> How about we use the normal pagecache APIs for this?
> 
> +	add_to_page_cache(page, &swapper_space, entry.val, GFP_NOIO);
>...  
> +	remove_from_page_cache(page);

Much nicer, and it'll probably appear to work: but (also untested)
I bet you'll need an additional page_cache_release(page) - damn,
looks like hugetlbfs has found a use for that tiresome asymmetry.

Hugh

