Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSA2XCe>; Tue, 29 Jan 2002 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSA2XCW>; Tue, 29 Jan 2002 18:02:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6660 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286263AbSA2XB5>;
	Tue, 29 Jan 2002 18:01:57 -0500
Date: Tue, 29 Jan 2002 21:01:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201291402270.1533-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201292059440.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:
> On Tue, 29 Jan 2002, David S. Miller wrote:
> >
> > I like the changes too, but I'd like to see some numbers
> > as well.
>
> Absolutely. Even something as simplistic as "lmbench file re-read" changed
> by 0.1% or something. I definitely believe in the scalability part (as
> long as the different processes don't all touch the same mapping all the
> time), so I'm more interested in the "what is the impact of the hash chain
> lookup/walk vs the radix tree walk" kinds of numbers.

There's another nice advantage to the radix tree.

We can let oracle shared memory segments use 4 MB pages,
but still use the normal page cache code to look up the
pages.

With a radix tree there is no overhead in using different
page sizes since we'll just run into them in the tree.

(as opposed to the horrors of trying a hash lookup with
multiple page orders)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

