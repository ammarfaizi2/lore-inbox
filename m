Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFTHcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFTHcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFTHcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:32:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261266AbVFTHb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:31:59 -0400
Date: Mon, 20 Jun 2005 00:31:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, mason@suse.de
Subject: Re: [patch 1/2] vm early reclaim orphaned pages (take 2)
Message-Id: <20050620003137.32163b67.akpm@osdl.org>
In-Reply-To: <1119252194.6240.22.camel@npiggin-nld.site>
References: <1118978590.5261.4.camel@npiggin-nld.site>
	<1119252194.6240.22.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  How about this?
>

It might be good, it's hard to tell.

Performance testing is needed.

>  --- linux-2.6.orig/mm/swap.c	2004-12-25 08:34:31.000000000 +1100
>  +++ linux-2.6/mm/swap.c	2005-06-20 17:20:28.216728238 +1000
>  @@ -87,7 +87,7 @@
>   	spin_lock_irqsave(&zone->lru_lock, flags);
>   	if (PageLRU(page) && !PageActive(page)) {
>   		list_del(&page->lru);
>  -		list_add_tail(&page->lru, &zone->inactive_list);
>  +		list_move_tail(&page->lru, &zone->inactive_list);
>   		inc_page_state(pgrotated);
>   	}
>   	if (!test_clear_page_writeback(page))
>  @@ -97,6 +97,32 @@
>   }

Correctness testing is needed too ;)
