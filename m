Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263559AbTIHTnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbTIHTnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:43:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263559AbTIHTnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:43:09 -0400
Date: Mon, 8 Sep 2003 15:42:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Stern <stern@rowland.harvard.edu>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.44L0.0309081512150.665-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.53.0309081539560.366@chaos>
References: <Pine.LNX.4.44L0.0309081512150.665-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Alan Stern wrote:

> On Fri, 5 Sep 2003, Andreas Dilger wrote:
>
> > On Sep 05, 2003  13:46 -0400, Alan Stern wrote:
> > > My kernel module for Linux-2.6 needs to be able to verify that the media
> > > on which a file resides actually is readable.  How can I do that?
> > >
> > > It would certainly suffice to use the normal VFS read routines, if there
> > > was some way to force the system to actually read from the device rather
> > > than just returning data already in the cache.  So I guess it would be
> > > enough to perform an fdatasync for the file and then invalidate the file's
> > > cache entries.  How does one invalidate a file's cache entries?  Does
> > > filemap_flush() perform both these operations for you?
> >
> > If you open the file with O_DIRECT, it should read/write directly on the
> > disk, and it will also invalidate any existing cache for the read/written
> > area.
>
> I tried doing that, but it caused a segmentation violation.  The trouble
> was this line near the start of fs/direct_io.c:dio_refill_pages()
>
> 	down_read(&current->mm->mmap_sem);
>
> Unfortunately, in a kernel thread (which is where my code runs)
> current->mm is NULL.
>
> Can anybody offer additional advice?  How about a way to invalidate all
> the page cache entries that contain a page from the file?
>
> Alan Stern

When your thread code starts up, execute
                init_rwsem(&current->mm->mmap_sem);

... This is in the thread's code, not the module init code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


