Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbUJ0Evg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUJ0Evg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUJ0Eve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:51:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261635AbUJ0EvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:51:15 -0400
Date: Wed, 27 Oct 2004 00:51:11 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: lowmem_reserve (replaces protection)
In-Reply-To: <20041027044445.GV14325@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410270049250.21548-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andrea Arcangeli wrote:

> what we'll happen is that we'll blindly free a few pages from each zone,
> but then we'll be allowed to allocate the highmem pages, and not the
> normal/dma pages. So after allocating the highmem pages we invoke kswapd
> again and it frees again some highmem/normal/dma pages but we keep only
> using the highmem ones.  So for a while we may be rolling over only the
> highmem lru and ignoring all freed pages from the normal/dma zones.

This is not how the page allocator in 2.6 works.

It will not wake up kswapd until it is past the low
watermark in all zones.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

