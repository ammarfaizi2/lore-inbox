Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTIIMM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTIIMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:12:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55680 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264088AbTIIMLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:11:51 -0400
Date: Tue, 9 Sep 2003 08:13:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Stern <stern@rowland.harvard.edu>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.44L0.0309081635360.641-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.53.0309090811060.2882@chaos>
References: <Pine.LNX.4.44L0.0309081635360.641-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Alan Stern wrote:

> On Mon, 8 Sep 2003, Richard B. Johnson wrote:
>
> > On Mon, 8 Sep 2003, Alan Stern wrote:
> >
> > > I tried doing that, but it caused a segmentation violation.  The trouble
> > > was this line near the start of fs/direct_io.c:dio_refill_pages()
> > >
> > > 	down_read(&current->mm->mmap_sem);
> > >
> > > Unfortunately, in a kernel thread (which is where my code runs)
> > > current->mm is NULL.
> > >
> > > Can anybody offer additional advice?  How about a way to invalidate all
> > > the page cache entries that contain a page from the file?
> > >
> > > Alan Stern
> >
> > When your thread code starts up, execute
> >                 init_rwsem(&current->mm->mmap_sem);
> >
> > ... This is in the thread's code, not the module init code.
>
> That doesn't work either; it also causes a segmentation violation.  As I
> said before, current->mm is NULL.  It gets set that way by exit_mm() which
> is called from daemonize().
>
> Alan Stern
>

Gawd. I assumed you knew how to initialize a pointer. I just
located the procedure used to initialize the semaphore.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


