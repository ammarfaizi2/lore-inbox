Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSHLN2Q>; Mon, 12 Aug 2002 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317997AbSHLN2Q>; Mon, 12 Aug 2002 09:28:16 -0400
Received: from holomorphy.com ([66.224.33.161]:58538 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317994AbSHLN2P>;
	Mon, 12 Aug 2002 09:28:15 -0400
Date: Mon, 12 Aug 2002 06:29:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/21] deferred and batched addition of faulted-in pages to the LRU
Message-ID: <20020812132938.GL15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D5614B2.EFD25A8D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D5614B2.EFD25A8D@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:39:30AM -0700, Andrew Morton wrote:
>  	pagevec_init(&pvec);
>  
> +	lru_add_drain();
>  	spin_lock_irq(&_pagemap_lru_lock);
>  	while (max_scan > 0 && nr_pages > 0) {
>  		struct page *page;
> @@ -380,6 +381,7 @@ static /* inline */ void refill_inactive
>  	struct page *page;
>  	struct pagevec pvec;
>  
> +	lru_add_drain();
>  	spin_lock_irq(&_pagemap_lru_lock);
>  	while (nr_pages && !list_empty(&active_list)) {
>  		page = list_entry(active_list.prev, struct page, lru);


Looks to me like it could be advantageous to perform the draining while
already under the lock. But the gains from this and the other changes are
already so vast it seems like it could have at most a minor effect.

Cheers,
Bill
