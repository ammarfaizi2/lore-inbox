Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSIGPvQ>; Sat, 7 Sep 2002 11:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSIGPvQ>; Sat, 7 Sep 2002 11:51:16 -0400
Received: from packet.digeo.com ([12.110.80.53]:25481 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318248AbSIGPvP>;
	Sat, 7 Sep 2002 11:51:15 -0400
Message-ID: <3D7A24D2.DF572685@digeo.com>
Date: Sat, 07 Sep 2002 09:09:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel@digeo.com, Phillips@digeo.com
CC: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77D879.7F7A3385@zip.com.au> <15735.64356.246705.392224@charged.uio.no> <3D780027.13A5B3B@zip.com.au> <E17nb5V-0006OJ-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2002 15:55:49.0302 (UTC) FILETIME=[09194560:01C25687]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> > That might work.  It's a bit of a hassle that ->releasepage() must
> > be nonblocking, but generally it just wants to grab locks, decrement
> > refcounts and free things.
> 
> Err.  I really really wonder why the vfs is not supposed to know
> about these goings on, to the extent of being able to take care of
> them itself.

->releasepage() was originally added for ext3, which has additional
ordering constraints, and has additional references to the page's
blocks.

reiserfs has a releasepage in 2.5.  XFS has a ->releasepage.
