Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSIJQ7j>; Tue, 10 Sep 2002 12:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSIJQ7j>; Tue, 10 Sep 2002 12:59:39 -0400
Received: from dsl-213-023-020-046.arcor-ip.net ([213.23.20.46]:39634 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316683AbSIJQ7i>;
	Tue, 10 Sep 2002 12:59:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 10 Sep 2002 18:57:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, trond.myklebust@fys.uio.no,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E17natE-0006OB-00@starship> <E17oWsf-0006vQ-00@starship> <3D7D2175.53BFE81D@digeo.com>
In-Reply-To: <3D7D2175.53BFE81D@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ooJx-0007EG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 00:32, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > > > void invalidate_inode_pages(struct inode *inode)
> > > > {
> > > >         truncate_inode_pages(mapping, 0);
> > > > }
> > > >
> > > > Is it any harder than that?
> > >
> > > Pretty much - need to leave i_size where it was.
> > 
> > This doesn't touch i_size.
> 
> Sorry - I was thinking vmtruncate(). truncate_inode_pages() would
> result in all the mmapped pages becoming out-of-date anonymous
> memory.  NFS needs to take down the pagetables so that processes
> which are mmapping the file which changed on the server will take
> a major fault and read a fresh copy.  I believe.

Oh, um.  Yes, we need the additional pte zapping behaviour of 
vmtruncate_list.  It doesn't look particularly hard to produce a
variant of vmtruncation that does (doesn't do) what you suggest.
Let's see how the discussion goes with the NFS crowd.

-- 
Daniel
