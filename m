Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293495AbSCEQ5l>; Tue, 5 Mar 2002 11:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293483AbSCEQ5c>; Tue, 5 Mar 2002 11:57:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:62725 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293495AbSCEQ50>; Tue, 5 Mar 2002 11:57:26 -0500
Date: Tue, 5 Mar 2002 13:57:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: arjan@fenrus.demon.nl, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305161032.F20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Andrea Arcangeli wrote:

> > Suppose that (1) we are low on memory in ZONE_NORMAL and
> > (2) we have enough free memory in ZONE_HIGHMEM and (3) the
> > memory in ZONE_NORMAL is for a large part taken by buffer
> > heads belonging to pages in ZONE_HIGHMEM.
> >
> > In that case, none of the VMs will bother freeing the buffer
> > heads associated with the highmem pages and kswapd will have
>
> wrong, classzone will do that, both for NORMAL and HIGHMEM allocations.

Let me explain it to you again:

1) ZONE_NORMAL + ZONE_DMA is low on free memory

2) the memory is taken by buffer heads, these
   buffer heads belong to pagecache pages that
   live in highmem

3) the highmem zone has enough free memory


As you probably know, shrink_caches() has the following line
of code to make sure it won't try to free highmem pages:

                if (!memclass(page->zone, classzone))
                        continue;

Of course, this line of code also means it will not take
away the buffer heads from highmem pages, so the ZONE_NORMAL
and ZONE_DMA memory USED BY THE BUFFER HEADS will not be
freed.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

