Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318034AbSG2Ar7>; Sun, 28 Jul 2002 20:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSG2Ar7>; Sun, 28 Jul 2002 20:47:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318034AbSG2Ar6>;
	Sun, 28 Jul 2002 20:47:58 -0400
Message-ID: <3D449388.7CE9A47A@zip.com.au>
Date: Sun, 28 Jul 2002 17:59:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <3D448D38.D156C249@zip.com.au> <Pine.LNX.4.44.0207281733370.8208-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, Andrew Morton wrote:
> >
> > OK.  This means that put_page() against userspace-mapped pages
> > is to be avoided.
> 
> Yes. I think we've gotten most of it, and I just fixed the
> access_process_vm() thing in my tree.

OK.  Please do the smbfs one as well.  That's an outright
race with truncate now.  Because we took the lru_cache_del()
out of truncate_complete_page() in the rmap merge. 

And we took the lru_cache_del() out of truncate_complete_page()
because, err, I forget.  There was a situation in which the page
could still be mapped into process pagetables, and the lru_cache_del()
would have left it unswappable until process exit.

Rik, can you remember the exact scenario?

-
