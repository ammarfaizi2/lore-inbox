Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSBGN1t>; Thu, 7 Feb 2002 08:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBGN13>; Thu, 7 Feb 2002 08:27:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:8720 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289159AbSBGN1Y>;
	Thu, 7 Feb 2002 08:27:24 -0500
Date: Thu, 7 Feb 2002 11:27:09 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, <akpm@zip.com.au>, <bcrl@redhat.com>,
        Hugh Dickins <hugh@lrel.veritas.com>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.21.0202071303330.1117-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Hugh Dickins wrote:

> > if (PageLRU(page)) {
> > 	if (in_interrupt()) {
> > 		add_page_to_special_list(page);
> > 		return;
> > 	} else
> > 		lru_cache_del(page);
> > }
>
> If this were a common case where many pages end up, yes, we'd
> need a separate special list; but it's a very rare case

Think of a web or ftp server doing nothing but sendfile()

> I was proposing we revert to distinguishing page_cache_release
> from put_page, page_cache_release doing the lru_cache_del; and
> I'd like to add my in_interrupt() BUG() there for now, just as
> a sanity check.  You are proposing that we keep the current,
> post-Ben, structure of doing it in __free_pages_ok if possible.

So how exactly would pages be freed ?

You still need to do the check of whether the page can
be freed somewhere.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

