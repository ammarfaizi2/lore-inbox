Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291687AbSBALFX>; Fri, 1 Feb 2002 06:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291690AbSBALFO>; Fri, 1 Feb 2002 06:05:14 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30481 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291687AbSBALFK>;
	Fri, 1 Feb 2002 06:05:10 -0500
Date: Fri, 1 Feb 2002 09:04:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <E16WReX-0003gt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202010903380.17106-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Alan Cox wrote:

> > the prefetch engine will have to restart every 4kB, so we would want to
> > use 16MB pages if possible.
> >
> > How would we allocate large pages? Would there be a boot option to
> > reserve an area of RAM for large pages only?
>
> If you have an rmap all you have to do is to avoid smearing kernel objects
> around lots of 16Mb page sets. If need be you can then get a 16Mb page
> back just by shuffling user pages.
>
> It does make the performance analysis much more interesting though.

Actually, I suspect that for most workloads the amount of
large pages vs. the amount of small pages should be fairly
static.

In that case we can just reclaim an old large page from
the inactive_clean list whenever we want to allocate a new
one.

As for not putting kernel objects everywhere, this comes
naturally with HIGHMEM ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

