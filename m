Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSIKA4b>; Tue, 10 Sep 2002 20:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSIKA4b>; Tue, 10 Sep 2002 20:56:31 -0400
Received: from dsl-213-023-020-046.arcor-ip.net ([213.23.20.46]:11997 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318255AbSIKA4a>;
	Tue, 10 Sep 2002 20:56:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Wed, 11 Sep 2002 02:53:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu> <E17ovLv-0007JB-00@starship> <3D7E909A.512C23C1@digeo.com>
In-Reply-To: <3D7E909A.512C23C1@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ovlW-0007Jd-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 02:38, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > > ...
> > We do get
> > around to walking the ptes at file close I believe.  Is that not driven by
> > zap_page_range, which moves any orphaned pte dirty bits down into the struct
> > page?
> 
> Nope, close will just leave all the pages pte-dirty or PageDirty in
> memory.  truncate will nuke all the ptes and then the pagecache.
> 
> But the normal way in which pte-dirty pages find their way to the
> backing file is:
> 
> - page reclaim runs try_to_unmap or
> 
> - user runs msync().  (Which will only clean that mm's ptes!)
> 
> These will run set_page_dirty(), making the page visible to
> one of the many things which run writeback.

So we just quietly drop any dirty memory mapped to a file if the user doesn't
run msync?  Is that correct behaviour?  It sure sounds wrong.

-- 
Daniel
