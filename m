Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSIWSxy>; Mon, 23 Sep 2002 14:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSIWSxU>; Mon, 23 Sep 2002 14:53:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:50313 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261368AbSIWSwK>;
	Mon, 23 Sep 2002 14:52:10 -0400
Message-ID: <3D8F6409.D45AA848@digeo.com>
Date: Mon, 23 Sep 2002 11:57:13 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D811A6C.C73FEC37@digeo.com> <15759.17258.990642.379366@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 18:57:13.0669 (UTC) FILETIME=[074BDF50:01C26333]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@digeo.com> writes:
> 
>      > Look, idunnoigiveup.  Like scsi and USB, NFS is a black hole
>      > where akpms fear to tread.  I think I'll sulk until someone
>      > explains why this work has to be performed in the context of a
>      > process which cannot do it.
> 
> I'd be happy to move that work out of the RPC callbacks if you could
> point out which other processes actually can do it.

Well it has to be a new thread, or user processes.

Would it be possible to mark the inode as "needs invalidation",
and make user processes check that flag once they have i_sem?

> The main problem is that the VFS/MM has no way of relabelling pages as
> being invalid or no longer up to date: I once proposed simply clearing
> PG_uptodate on those pages which cannot be cleared by
> invalidate_inode_pages(), but this was not to Linus' taste.

Yes, clearing PageUptodate without holding the page lock is
pretty scary.

Do we really need to invalidate individual pages, or is it real-life
acceptable to invalidate the whole mapping?

Doing an NFS-special invalidate function is not a problem, btw - my
current invalidate_inode_pages() is just 25 lines.  It's merely a
matter of working out what it should do ;)
