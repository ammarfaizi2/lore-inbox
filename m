Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319469AbSILVdb>; Thu, 12 Sep 2002 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319472AbSILVdb>; Thu, 12 Sep 2002 17:33:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:61127 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319469AbSILVda>;
	Thu, 12 Sep 2002 17:33:30 -0400
Message-ID: <3D810942.3F1E91F6@digeo.com>
Date: Thu, 12 Sep 2002 14:38:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu> <15744.37092.812502.970281@charged.uio.no> <3D80DB32.4BF9D644@digeo.com> <E17pbJd-0007l2-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 21:38:13.0115 (UTC) FILETIME=[B23B1CB0:01C25AA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> > Is it not possible to co-opt a user process to perform the
> > invalidation?  Just
> >
> >       inode->is_kaput = 1;
> >
> > in rpciod?
> 
> There must be a way.  The key thing the VM needs to provide, and doesn't
> now, is a function callable by the rpciod that will report to the caller
> whether it was able to complete the invalidation without blocking.  (I
> think I'm just rephrasing someone's earlier suggestion here.)
> 
> I'm now thinking in general terms about how to concoct a mechanism
> that lets rpciod retry the invalidation later, for all those that turn
> out to be blocking.  For example, rpciod could just keep a list of
> all pending invalidates and retry each inode on the list every time
> it has nothing to do.  This is crude and n-squarish, but it would
> work.  Maybe it's efficient enough for the time being.  At least it's
> correct, which would be a step forward.

rpciod is the wrong process to be performing this operation.  I'd suggest
the userspace process which wants to read the directory be used for this.
 
> Did you have some specific mechanism in mind?
> 

Testing mapping->nrpages will tell you if the invalidation was successful.
