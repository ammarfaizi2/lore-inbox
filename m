Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319467AbSIGJ5E>; Sat, 7 Sep 2002 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319468AbSIGJ5E>; Sat, 7 Sep 2002 05:57:04 -0400
Received: from dsl-213-023-038-028.arcor-ip.net ([213.23.38.28]:24247 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319467AbSIGJ5E>;
	Sat, 7 Sep 2002 05:57:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, trond.myklebust@fys.uio.no
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Sat, 7 Sep 2002 10:37:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D77D879.7F7A3385@zip.com.au> <15735.64356.246705.392224@charged.uio.no> <3D780027.13A5B3B@zip.com.au>
In-Reply-To: <3D780027.13A5B3B@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17nb5V-0006OJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 03:08, Andrew Morton wrote:
> Should we be forcibly unmapping the pages from pagetables?  That would
> result in them being faulted in again, and re-read.

There's no conceptual difficulty if it's a truncate.  For NFS, maybe
the thing to do is hold ->sem long enough to do whatever dark magic
NFS needs?

> That might work.  It's a bit of a hassle that ->releasepage() must
> be nonblocking, but generally it just wants to grab locks, decrement
> refcounts and free things.

Err.  I really really wonder why the vfs is not supposed to know
about these goings on, to the extent of being able to take care of
them itself.

-- 
Daniel
