Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291150AbSBGO5h>; Thu, 7 Feb 2002 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291151AbSBGO5Y>; Thu, 7 Feb 2002 09:57:24 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46597 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291150AbSBGO4o>;
	Thu, 7 Feb 2002 09:56:44 -0500
Date: Thu, 7 Feb 2002 12:56:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, <akpm@zip.com.au>, <bcrl@redhat.com>,
        Hugh Dickins <hugh@lrel.veritas.com>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0202071255500.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Hugh Dickins wrote:
> On Thu, 7 Feb 2002, Rik van Riel wrote:
> > On Thu, 7 Feb 2002, Hugh Dickins wrote:
> > >
> > > If this were a common case where many pages end up, yes, we'd
> > > need a separate special list; but it's a very rare case
> >
> > Think of a web or ftp server doing nothing but sendfile()
>
> Aren't the sendfile() pages in the page cache, and normally taken
> off LRU at the same time as removed from page cache, in shrink_cache?

You're right.

> I imagined (not yet tried) in shrink_cache, something like:

> 		if (unlikely(!page_count(page))) {
> 			page_cache_get(page);
> 			__lru_cache_del(page);
> 			page_cache_release(page);
> 			continue;
> 		}

I guess this should work.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

