Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319363AbSH2VTv>; Thu, 29 Aug 2002 17:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319373AbSH2VTv>; Thu, 29 Aug 2002 17:19:51 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:34834 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319363AbSH2VTu>; Thu, 29 Aug 2002 17:19:50 -0400
Message-ID: <3D6E9084.820B2608@zip.com.au>
Date: Thu, 29 Aug 2002 14:22:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] low-latency zap_page_range()
References: <3D6E8B7F.8D5D20D8@zip.com.au> <1030655532.12110.2691.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-08-29 at 17:00, Andrew Morton wrote:
> 
> > That's an interesting point.  page_table_lock is one of those locks
> > which is occasionally held for ages, and frequently held for a short
> > time.
> 
> Since latency is a direct function of lock held times in the preemptible
> kernel, and I am seeing disgusting zap_page_range() latencies, the lock
> is held a long time.
> 
> So we know it is held forever and a day... but is there contention?

I'm sure there is, but nobody has measured the right workload.

Two CLONE_MM threads, one running mmap()/munmap(), the other trying
to fault in some pages.  I'm sure someone has some vital application
which does exactly this.  They always do :(
