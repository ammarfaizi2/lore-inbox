Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318975AbSIIWb0>; Mon, 9 Sep 2002 18:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318973AbSIIW2o>; Mon, 9 Sep 2002 18:28:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:44501 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318968AbSIIW2D>;
	Mon, 9 Sep 2002 18:28:03 -0400
Message-ID: <3D7D2175.53BFE81D@digeo.com>
Date: Mon, 09 Sep 2002 15:32:21 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Rik van Riel <riel@conectiva.com.br>, trond.myklebust@fys.uio.no,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <E17natE-0006OB-00@starship> <E17oWKH-0006uw-00@starship> <3D7D1AB4.B465ABE8@digeo.com> <E17oWsf-0006vQ-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 22:32:36.0955 (UTC) FILETIME=[CC6452B0:01C25850]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> > > void invalidate_inode_pages(struct inode *inode)
> > > {
> > >         truncate_inode_pages(mapping, 0);
> > > }
> > >
> > > Is it any harder than that?
> >
> > Pretty much - need to leave i_size where it was.
> 
> This doesn't touch i_size.

Sorry - I was thinking vmtruncate(). truncate_inode_pages() would
result in all the mmapped pages becoming out-of-date anonymous
memory.  NFS needs to take down the pagetables so that processes
which are mmapping the file which changed on the server will take
a major fault and read a fresh copy.  I believe.
