Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbRE3O0p>; Wed, 30 May 2001 10:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262809AbRE3O0f>; Wed, 30 May 2001 10:26:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55143 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262810AbRE3O0V>; Wed, 30 May 2001 10:26:21 -0400
Date: Wed, 30 May 2001 16:26:07 +0200
From: andrea@e-mind.com
To: Mark Hemment <markhe@veritas.com>
Cc: Jens Axboe <axboe@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530162607.D1408@athlon.random>
In-Reply-To: <20010530115538.B15089@suse.de> <Pine.LNX.4.21.0105301113550.7153-100000@alloc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301113550.7153-100000@alloc>; from markhe@veritas.com on Wed, May 30, 2001 at 11:59:50AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 11:59:50AM +0100, Mark Hemment wrote:
> 	Now, when HIGHMEM allocations come in (for page cache pages), they
> 	skip the HIGH zone and use the NORMAL zone (as it now has plenty
> 	of free pages) - the code at the top of __alloc_pages(), which
> 	checks against ->pages_low.

btw, I think such heuristic is horribly broken ;), the highmem zone
simply needs to be balanced if it is under the pages_low mark, just
skipping it and falling back into the normal zone that happens to be
above the low mark is the wrong thing to do.

>   Also, the problem isn't as bad as it first looks - HIGHMEM page-cache
> pages do get "recycled" (reclaimed), but there is a slight imbalance.

there will always be some imbalance unless all allocations would be
capable of highmem (which will never happen). The only thing we can do
is to optimize the zone usage so we won't run out of normal pages unless
there was a good reason. Once we run out of normal pages we'll simply
return NULL and the reserved pool of highmem bounces will be used
instead (other callers will behave differently).

Andrea
