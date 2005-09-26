Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVIZGPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVIZGPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIZGPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:15:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbVIZGPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:15:09 -0400
Date: Sun, 25 Sep 2005 23:14:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] mm: zap_pte_range dont dirty anon
Message-Id: <20050925231424.6c08bc8a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0509260659370.8065@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0509251649100.3490@goblin.wat.veritas.com>
	<20050925152630.75560571.akpm@osdl.org>
	<Pine.LNX.4.61.0509260659370.8065@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> > What is the page is (for example) clean swapcache, having been recently
>  > faulted in.  If this pte indicates that this process has modified the page
>  > and we don't run set_page_dirty(), the page could be reclaimed and the
>  > change is lost.
> 
>  Absolutely.  But either the page is unique to this mm, shared only with
>  swapcache: in which case we're about to do a free_swap_cache on it (that
>  may be delayed in actually freeing the swap because of not getting page
>  lock, presumably because vmscan just got to it, but no matter), and we
>  don't care at all that the page no longer represents what's on swap disk.
> 
>  Or, the page is shared with another mm.  But it's an anonymous page
>  (a private page), so it's shared via fork, and COW applies to it.

	mmap(MAP_ANONYMOUS|MAP_SHARED)
	fork()
	swapout
	swapin
	swapoff

Now we have two mm's sharing a clean, non-cowable, non-swapcache anonymous
page, no?
