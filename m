Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSILSQ7>; Thu, 12 Sep 2002 14:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSILSQ7>; Thu, 12 Sep 2002 14:16:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:63936 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S316880AbSILSQ6>;
	Thu, 12 Sep 2002 14:16:58 -0400
Message-ID: <3D80DB32.4BF9D644@digeo.com>
Date: Thu, 12 Sep 2002 11:21:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Chuck Lever <cel@citi.umich.edu>, Daniel Phillips <phillips@arcor.de>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu> <15744.37092.812502.970281@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 18:21:40.0331 (UTC) FILETIME=[3D2F13B0:01C25A89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Chuck Lever <cel@citi.umich.edu> writes:
> 
>      > rpciod must never call a function that sleeps.  if this
>      > happens, the whole NFS client stops working until the function
>      > wakes up again.  this is not really bogus -- it is similar to
>      > restrictions placed on socket callbacks.
> 
> I'm in France at the moment, and am therefore not really able to
> follow up on this thread for the moment. I'll try to clarify the above
> though:
> 
> 2 reasons why rpciod cannot block:
> 
>   1) Doing so will slow down I/O for *all* NFS users.
>   2) There's a minefield of possible deadlock situations: waiting on a
>      locked page is the main no-no since rpciod itself is the process
>      that needs to complete the read I/O and unlock the page.
> 

Yes.  Both of these would indicate that rpciod is the wrong process
to be performing the invalidation.

Is it not possible to co-opt a user process to perform the
invalidation?  Just

	inode->is_kaput = 1;

in rpciod?
