Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRK1VWO>; Wed, 28 Nov 2001 16:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRK1VWF>; Wed, 28 Nov 2001 16:22:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:19982 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280495AbRK1VVs>; Wed, 28 Nov 2001 16:21:48 -0500
Date: Wed, 28 Nov 2001 18:04:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C05533D.98DCE6D1@zip.com.au>
Message-ID: <Pine.LNX.4.21.0111281802280.15737-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001, Andrew Morton wrote:

> Andreas Dilger wrote:
> > 
> > On Nov 28, 2001  12:31 -0800, Andrew Morton wrote:
> > > write-cluster.patch
> > >       ext2 metadata prereading and various other hacks which
> > >       prevent writes from stumbling over reads, and thus ruining
> > >       write clustering.  This patch is in the early prototype stage
> > 
> > Shouldn't the ext2_inode_preread() code use "ll_rw_block(READ_AHEAD,...)"
> > just to be proper?
> > 
> 
> Yes, especially now the request queues are shorter than they have
> historically been.  READA also needs to be propagated through the
> pagecache readhead, which may prove tricky.
> 
> But so little code is actually using READA at this stage that I didn't
> bother - I first need to go through those paths and make sure that they
> are in fact complete, working and useful...

I've done some experiments in the past which have shown that doing this
will cause us to almost _never_ do readahead on IO intensive workloads,
which ended up decreasing performance instead increasing it.

Please make sure to extensively test the propagation of READA through the
pagecache when you do so... 

