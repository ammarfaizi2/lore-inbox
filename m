Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290782AbSBFUNb>; Wed, 6 Feb 2002 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290783AbSBFUNW>; Wed, 6 Feb 2002 15:13:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21540 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290782AbSBFUNO>; Wed, 6 Feb 2002 15:13:14 -0500
Date: Wed, 6 Feb 2002 20:15:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C618863.DA7AC3B9@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202061958100.2009-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Andrew Morton wrote:
> Hugh Dickins wrote:
> > 
> > Sorry, no solution, but maybe another oops in __free_pages_ok might help?
> 
> What problem are you trying to solve?

Amidst all the prune_dcache and other kswapd oopses reported
(which I'd love to solve, but still can't work out), there have
been a couple in shrink_cache itself, where the page from the
inactive_list is not marked as on LRU, or is marked as Active;
and also I think a couple in rmqueue, where the free page is
found to be on LRU.

Some of those may have been memtest86ed out of contention since,
and some may have been on SMP and so not candidates; but it did
just occur to me that we'd like to be sure nothing is messing
with the LRU at interrupt time, hence the patch.  Which of
course solves nothing, but might shed some light.

Sorry for being mysterious!

Hugh

