Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSBGMe5>; Thu, 7 Feb 2002 07:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287616AbSBGMer>; Thu, 7 Feb 2002 07:34:47 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30220 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287645AbSBGMei>;
	Thu, 7 Feb 2002 07:34:38 -0500
Date: Thu, 7 Feb 2002 10:34:20 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>,
        <hugh@veritas.com>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C6227B7.37BFA2EC@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0202071033130.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Andrew Morton wrote:

> I feel that presence on the lru list should contribute to
> page->count.  It seems a bit weird and kludgy that this
> is not so.
>
> If we were to do this then would this not fix networking's
> problem?  The skb free wouldn't release the page - it would
> be left on the LRU with ->count == 1 and kswapd would reap it.

Actually, at this point we _know_ page->list.{prev,next} are
NULL.

We can use this to add the pages to a special list, from where
__alloc_pages() and kswapd can move them to the free list, in
process context.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

