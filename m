Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291223AbSAaSjK>; Thu, 31 Jan 2002 13:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291224AbSAaSjA>; Thu, 31 Jan 2002 13:39:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6665 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291223AbSAaSir>;
	Thu, 31 Jan 2002 13:38:47 -0500
Date: Thu, 31 Jan 2002 16:38:25 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201311031180.1637-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201311635290.32634-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Linus Torvalds wrote:

> > Also there must be some significant memory overhead that can be
> > triggered with a certain layout of pages, in some configuration it
> > should take much more ram than the hashtable if I understood well how it
> > works.
>
> Considering that the radix tree can _remove_ 8 bytes per "struct
> page", I suspect you potentially win more memory than you lose.

Actually, since the page cache hash table is also 8 bytes
per page, the radix trees effectively remove 16 bytes per
struct page.

Also, Momchil's radix trees are only as deep as needed
for each file, so most files should have very shallow
radix trees.

Combine these two facts with min_readahead and you'll
see that the memory consumption for radix trees should
be pretty decent.

It's still a question whether we'll want to use 128 as
the branch factor or another number ... but I'm sure
somebody will figure that out (and it can be changed
later, it's just one define).

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

