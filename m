Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319318AbSILXz7>; Thu, 12 Sep 2002 19:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319340AbSILXz7>; Thu, 12 Sep 2002 19:55:59 -0400
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:49034 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319318AbSILXz6>;
	Thu, 12 Sep 2002 19:55:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Fri, 13 Sep 2002 01:53:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209122022080.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209122022080.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pdlk-0007mo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 01:23, Rik van Riel wrote:
> On Thu, 12 Sep 2002, Andrew Morton wrote:
> > Rik van Riel wrote:
> 
> > > invalidate_page(struct page * page) {
> 
> > That's the bottom-up approach.  The top-down (vmtruncate) approach
> > would also work, if the locking is suitable.
> 
> The top-down approach will almost certainly be most efficient when
> invalidating a large chunk of a file (truncate, large file locks)
> while the bottom-up approach is probably more efficient when the
> system invalidates very few pages (small file lock, cluster file
> system mmap() support).

The bottom-up approach is the one we want to use when we'd otherwise
skip a page in invalidate_inode_pages.  This is the rare case.  On the
face of it, this works out very well.  Just have to think about
interactions now - I don't see any, but I haven't really gone hunting
yet.

-- 
Daniel
