Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTJLNeV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 09:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJLNeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 09:34:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7655
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262357AbTJLNeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 09:34:20 -0400
Date: Sun, 12 Oct 2003 15:35:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Matt_Domsch@Dell.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-ID: <20031012133537.GO16013@velociraptor.random>
References: <20031011160318.GK16013@velociraptor.random> <Pine.LNX.4.44.0310121213080.4598-100000@localhost.localdomain> <20031012132132.GN16013@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012132132.GN16013@velociraptor.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 03:21:32PM +0200, Andrea Arcangeli wrote:
> +++ race/mm/swap.c	2003-10-12 15:02:54.000000000 +0200
> @@ -54,6 +54,19 @@ void activate_page(struct page * page)
>  /**
>   * lru_cache_add: add a page to the page lists
      ^ while porting the fix to UL I noticed this comment needs __ in
front of it, I'm not spamming the list with another full patch since it
makes no functional difference, this is an incremental:

--- race/mm/swap.c.~1~	2003-10-12 15:02:54.000000000 +0200
+++ race/mm/swap.c	2003-10-12 15:31:58.000000000 +0200
@@ -52,7 +52,7 @@ void activate_page(struct page * page)
 }
 
 /**
- * lru_cache_add: add a page to the page lists
+ * __lru_cache_add: add a page to the page lists
  * @page: the page to add
  *
  * This function is for when the caller already holds

I uploaded the full update here anyways:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.23pre7/anon-lru-race-better-fix-3

Andrea
