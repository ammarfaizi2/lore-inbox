Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUJ0FEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUJ0FEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUJ0FEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:04:41 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:47493 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261641AbUJ0FEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:04:39 -0400
Date: Wed, 27 Oct 2004 07:05:27 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027050527.GW14325@dualathlon.random>
References: <20041027044445.GV14325@dualathlon.random> <Pine.LNX.4.44.0410270049250.21548-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410270049250.21548-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:51:11AM -0400, Rik van Riel wrote:
> On Wed, 27 Oct 2004, Andrea Arcangeli wrote:
> 
> > what we'll happen is that we'll blindly free a few pages from each zone,
> > but then we'll be allowed to allocate the highmem pages, and not the
> > normal/dma pages. So after allocating the highmem pages we invoke kswapd
> > again and it frees again some highmem/normal/dma pages but we keep only
> > using the highmem ones.  So for a while we may be rolling over only the
> > highmem lru and ignoring all freed pages from the normal/dma zones.
> 
> This is not how the page allocator in 2.6 works.
> 
> It will not wake up kswapd until it is past the low
> watermark in all zones.

how else the page allocator should work if not waiting all zones to hit
the low+reserve watermarks? the page allocator works the same in 2.4
and 2.6, so I don't understand your point.

what changes is kswapd stop algorithm and the fact the lru is per-zone,
but I think I described correctly what happens in 2.6 kswapd-stop.
