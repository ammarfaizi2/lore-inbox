Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280760AbRKSWph>; Mon, 19 Nov 2001 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRKSWpR>; Mon, 19 Nov 2001 17:45:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62215 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280762AbRKSWpM>; Mon, 19 Nov 2001 17:45:12 -0500
Date: Mon, 19 Nov 2001 14:40:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33L.0111191945060.1491-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111191437370.8727-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Rik van Riel wrote:
>
> I wonder if the following scenario is possible:

Hmm.. It looks valid, but for the fact that the page lock is held. So
there's no way truncate_list_pages() can call "remove_inode_page()" on the
page, regardless of whether the page is on the LRU list or not.

That said, it might be cleaner to move the "lru_cache_add(page);" up to
before adding the page into the page cache - that way we add a new
invariant that just says "all pages in the page cache are on the LRU
list", which could be used for a few extra sanity checks, for example.

		Linus

