Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288611AbSBGMph>; Thu, 7 Feb 2002 07:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287751AbSBGMp1>; Thu, 7 Feb 2002 07:45:27 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13325 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287710AbSBGMpI>;
	Thu, 7 Feb 2002 07:45:08 -0500
Date: Thu, 7 Feb 2002 10:44:49 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <akpm@zip.com.au>, <bcrl@redhat.com>, <hugh@veritas.com>,
        <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <20020207.043744.93473658.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0202071043351.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, David S. Miller wrote:
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Thu, 7 Feb 2002 10:34:20 -0200 (BRST)
>
>    Actually, at this point we _know_ page->list.{prev,next} are
>    NULL.
>
>    We can use this to add the pages to a special list, from where
>    __alloc_pages() and kswapd can move them to the free list, in
>    process context.
>
> I don't think there should be any special logic on how to free a page
> outside of the page allocator itself.  Certainly this kind of stuff
> doesn't belong in the networking.
>
> Pages can be freed from arbitrary contexts, and the page allocator
> should be the part the knows how to deal with it.
>
> Maybe I don't understand and you're really suggesting something else.

The mechanism to do what I described above should of course be
in __free_pages_ok().

if (PageLRU(page)) {
	if (in_interrupt()) {
		add_page_to_special_list(page);
		return;
	} else
		lru_cache_del(page);
}


Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

