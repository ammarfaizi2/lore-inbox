Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSIEUgC>; Thu, 5 Sep 2002 16:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSIEUgC>; Thu, 5 Sep 2002 16:36:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2824 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318256AbSIEUgB>; Thu, 5 Sep 2002 16:36:01 -0400
Message-ID: <3D77C0A7.F74A89D0@zip.com.au>
Date: Thu, 05 Sep 2002 13:37:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77BB7C.5F20939F@zip.com.au> <15735.48664.951983.418842@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > It's a bit worrisome if NFS is dependent upon successful
>      > pagecache takedown in invalidate_inode_pages.
> 
> Why? We don't use all that buffer crap, so in principle
> invalidate_inode_page() is only supposed to fail for us if
> 
>   - page is locked (i.e. new read in progress or something like that)
>   - page is refcounted (by something like mmap()).

    - someone took a temporary ref on the page.

    Possibly it is the deferred LRU addition code.  Try running
    lru_add_drain() before invalidate_inode_pages().
 
> neither of which should be the case here.

Probably, it worked OK with the global locking because nobody was taking
a temp ref against those pages.

Please tell me exactly what semantics NFS needs in there.  Does
truncate_inode_pages() do the wrong thing?
