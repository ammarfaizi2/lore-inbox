Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291077AbSAaN6x>; Thu, 31 Jan 2002 08:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291076AbSAaN6n>; Thu, 31 Jan 2002 08:58:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12807 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291081AbSAaN6i>;
	Thu, 31 Jan 2002 08:58:38 -0500
Date: Thu, 31 Jan 2002 11:58:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020131033345.X1309@athlon.random>
Message-ID: <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Andrea Arcangeli wrote:

> So I wouldn't merge it, at least until some math is done for the memory
> consumation with 500k inodes with only 1 page in them each, and on the
> number of heights/levels that must be walked during the tree lookup,
> during a access at offset 10G (or worst case in general [biggest
> height]) of an inode with 10G just allocated in pagecache.

Ummm, I don't see how this worst case is any more realistic
as the worst case for the hash table (where all pages live
in very few hash buckets and we have really deep chains).

People just don't go around caching a single page each for
all of their 10 GB files and even if they _wanted to_ they
couldn't because of the readahead code.

I suspect that for large files we'll always have around
min_readahead logically contiguous pages cached, if not more.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

