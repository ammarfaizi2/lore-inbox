Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263560AbTIHTWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTIHTWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:22:08 -0400
Received: from ida.rowland.org ([192.131.102.52]:1284 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263562AbTIHTWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:22:04 -0400
Date: Mon, 8 Sep 2003 15:22:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <20030905121522.B30448@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44L0.0309081512150.665-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Andreas Dilger wrote:

> On Sep 05, 2003  13:46 -0400, Alan Stern wrote:
> > My kernel module for Linux-2.6 needs to be able to verify that the media 
> > on which a file resides actually is readable.  How can I do that?
> > 
> > It would certainly suffice to use the normal VFS read routines, if there
> > was some way to force the system to actually read from the device rather
> > than just returning data already in the cache.  So I guess it would be 
> > enough to perform an fdatasync for the file and then invalidate the file's 
> > cache entries.  How does one invalidate a file's cache entries?  Does 
> > filemap_flush() perform both these operations for you?
> 
> If you open the file with O_DIRECT, it should read/write directly on the
> disk, and it will also invalidate any existing cache for the read/written
> area.

I tried doing that, but it caused a segmentation violation.  The trouble 
was this line near the start of fs/direct_io.c:dio_refill_pages()

	down_read(&current->mm->mmap_sem);

Unfortunately, in a kernel thread (which is where my code runs)  
current->mm is NULL.

Can anybody offer additional advice?  How about a way to invalidate all 
the page cache entries that contain a page from the file?

Alan Stern

