Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSIDBhQ>; Tue, 3 Sep 2002 21:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSIDBhP>; Tue, 3 Sep 2002 21:37:15 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:44551 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318757AbSIDBhP>; Tue, 3 Sep 2002 21:37:15 -0400
Message-ID: <3D7563C0.99EE8843@zip.com.au>
Date: Tue, 03 Sep 2002 18:37:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
References: <3D7437AC.74EAE22B@zip.com.au> <20020904004028.GS888@holomorphy.com> <3D755E2D.7A6D55C6@zip.com.au> <20020904011503.GT888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> > Calling kmem_cache_reap() after running the pruners will fix that up.
> 
> # grep ext3_inode_cache /proc/slabinfo
> ext3_inode_cache   18917  87012    448 7686 9668    1
> ...
> ext3_inode_cache:     8098KB    38052KB   21.28
> 
> Looks like a persistent gap from here.

OK, thanks.  We need to reap those pages up-front rather than waiting
for them to come to the tail of the LRU.

What on earth is going on with kmem_cache_reap?  Am I missing
something, or is that thing 700% overdesigned?  Why not just
free the darn pages in kmem_cache_free_one()?  Maybe hang onto
a few pages for cache warmth, but heck.
