Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319639AbSIMNIu>; Fri, 13 Sep 2002 09:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319640AbSIMNIu>; Fri, 13 Sep 2002 09:08:50 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:53901 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319639AbSIMNIt>;
	Fri, 13 Sep 2002 09:08:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Fri, 13 Sep 2002 06:52:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209121926310.1857-100000@imladris.surriel.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17piRs-00086z-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 06:19, I wrote:
> And we need a locked_page_cache_release->free_locked_page.

Hmm, maybe not.  We should be able to unlock the page just after
removing it from the page cache.

By the way, the wait_on_page in lock_page is where we finally get
around for waiting on those locked pages we couldn't get rid of
in invalidate_inode_pages; what we have done here is shifted the
wait from rpciod to normal users, which is exactly what we want.

-- 
Daniel
