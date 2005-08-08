Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVHHQX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVHHQX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVHHQX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:23:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:49571 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932101AbVHHQXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:23:25 -0400
Date: Mon, 8 Aug 2005 17:23:21 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to reclaim inode pages on demand
In-Reply-To: <20050808160838.GB17978@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0508081715250.26013@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
 <20050808160838.GB17978@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Jörn Engel wrote:

> On Mon, 8 August 2005 16:52:52 +0100, Mel Gorman wrote:
> >
> > I am working on a direct reclaim strategy to free up large blocks of
> > contiguous pages. The part I have is working fine, but I am finding a
> > hundreds of pages that are being used for inodes that I need to reclaim. I
> > tried purging the inode lists using a variation of prune_icache() but it
> > is not working out.
> >
> > Given a struct page, that one knows is an inode, can anyone suggest the
> > best way to find the inode using it and free it?
>
> A struct page ain't an inode.  So I'm assuming you mean something like
> "giving a struct page that is known to be part of the inode slab
> cache".
>

I explained this badly.

Inodes have access to an address_space via inode->i_data. This
address_space is used to allocate pages from functions like
page_cache_alloc() or grab_cache_page(). It is these pages that are the
problem, not the slab pages holding the inode structures. The question is
how these pages can be directly reclaimed. Does anyone have suggestions?


-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
