Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317241AbSEXSAl>; Fri, 24 May 2002 14:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317237AbSEXSAk>; Fri, 24 May 2002 14:00:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64401 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317238AbSEXSAg>;
	Fri, 24 May 2002 14:00:36 -0400
Date: Fri, 24 May 2002 14:00:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524175522.GD15703@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241356590.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:

> so why don't you also left a negative directory floating around, so you
> know if you creat a file with such name you don't need to ->loopup the
> lowlevel fs but you only need to destroy the negative directory and all
> its leafs in-core-dcache? If you did the negative effect would become
> more obvious, the d_unhash hides it except for the spooling workloads.
 
-ENOPARSE

> of kmem_cache_reap, so we are as efficient as possible, but we don't
> risk throwing away very useful cache, for more dubious caching effects
> after an unlink/create-failure that currently have the side effect of
> throwing away tons of worthwhile positive pagecache (and even triggering
> swap false positives) in some workloads.

I might buy that argument if we didn't also leave around _unreferenced_
inodes for minutes in the icache.  And _that_ is much stronger source of
memory pressure, so if you want to balance the thing you need to start
there.

