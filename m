Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbTIHUgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTIHUgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:36:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:1540 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263634AbTIHUgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:36:49 -0400
Date: Mon, 8 Sep 2003 16:36:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.53.0309081539560.366@chaos>
Message-ID: <Pine.LNX.4.44L0.0309081635360.641-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Richard B. Johnson wrote:

> On Mon, 8 Sep 2003, Alan Stern wrote:
> 
> > I tried doing that, but it caused a segmentation violation.  The trouble
> > was this line near the start of fs/direct_io.c:dio_refill_pages()
> >
> > 	down_read(&current->mm->mmap_sem);
> >
> > Unfortunately, in a kernel thread (which is where my code runs)
> > current->mm is NULL.
> >
> > Can anybody offer additional advice?  How about a way to invalidate all
> > the page cache entries that contain a page from the file?
> >
> > Alan Stern
> 
> When your thread code starts up, execute
>                 init_rwsem(&current->mm->mmap_sem);
> 
> ... This is in the thread's code, not the module init code.

That doesn't work either; it also causes a segmentation violation.  As I 
said before, current->mm is NULL.  It gets set that way by exit_mm() which 
is called from daemonize().

Alan Stern

