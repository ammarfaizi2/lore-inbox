Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbSIWUyr>; Mon, 23 Sep 2002 16:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSIWUyq>; Mon, 23 Sep 2002 16:54:46 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:39094 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261417AbSIWUyl>;
	Mon, 23 Sep 2002 16:54:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: trond.myklebust@fys.uio.no, Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Mon, 23 Sep 2002 22:49:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D811A6C.C73FEC37@digeo.com> <3D8F6409.D45AA848@digeo.com> <15759.31838.68147.725840@charged.uio.no>
In-Reply-To: <15759.31838.68147.725840@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ta9C-0003bo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 22:41, Trond Myklebust wrote:
> >>>>> " " == Andrew Morton <akpm@digeo.com> writes:
> 
>      > Would it be possible to mark the inode as "needs invalidation",
>      > and make user processes check that flag once they have i_sem?
> 
> Not good enough unless you add those checks at the VFS/MM level.

Please see Rik's suggestion and my followups where we are talking about
handling this in the MM.

> Think
> for instance about mmap() where the filesystem is usually not involved
> once a pagein has occurred.
> 
>      > Do we really need to invalidate individual pages, or is it
>      > real-life acceptable to invalidate the whole mapping?
> 
> Invalidating the mapping is certainly a good alternative if it can be
> done cleanly.

But invalidate_inode_pages is (usually) just trying to do exactly that.
It doesn't work.  Anyway, what if you have a 2 gig file with 1 meg
mmaped/locked/whatever by a database?

> Note that in doing so, we do not want to invalidate any reads or
> writes that may have been already scheduled. The existing mapping
> still would need to hang around long enough to permit them to
> complete.

With the mechanism I described above, that would just work.  The fault
path would do lock_page, thus waiting for the IO to complete.

-- 
Daniel
