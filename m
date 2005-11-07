Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVKGAQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVKGAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 19:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVKGAQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 19:16:26 -0500
Received: from gold.veritas.com ([143.127.12.110]:19760 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932379AbVKGAQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 19:16:26 -0500
Date: Mon, 7 Nov 2005 00:15:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
In-Reply-To: <20051106160008.28822bbd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511070006570.30418@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
 <20051106112838.0d524f65.akpm@osdl.org> <Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
 <20051106151326.63cf16bd.akpm@osdl.org> <Pine.LNX.4.61.0511062348240.29944@goblin.wat.veritas.com>
 <20051106160008.28822bbd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Nov 2005 00:16:25.0550 (UTC) FILETIME=[7D9FFEE0:01C5E330]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > Suppress split ptlock on arches which may use one page for multiple page
> >  tables.  Reconsider what better to do (particularly on ppc64) later on.
> 
> But why is that a problem per-se?  A few "pagetable pages" will share the
> same lock.  Deadlocky when we take two pagetable locks?

Good point, it may not be as disastrous as I was imagining.  Certainly
deadlocky in copy_page_range and mremap move at present, but that can
be easily surmounted.  However, there is the slab lru issue too: if it's
convenient for an arch to use slab cache, I'd prefer not to make life
difficult for them.  I'll come back to this but not tonight.

Hugh
