Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTIIN4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTIIN4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:56:31 -0400
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264104AbTIIN4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:56:30 -0400
Date: Tue, 9 Sep 2003 09:56:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.53.0309090811060.2882@chaos>
Message-ID: <Pine.LNX.4.44L0.0309090952560.887-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Richard B. Johnson wrote:

> On Mon, 8 Sep 2003, Alan Stern wrote:
> 
> > > When your thread code starts up, execute
> > >                 init_rwsem(&current->mm->mmap_sem);
> > >
> > > ... This is in the thread's code, not the module init code.
> >
> > That doesn't work either; it also causes a segmentation violation.  As I
> > said before, current->mm is NULL.  It gets set that way by exit_mm() which
> > is called from daemonize().
> >
> > Alan Stern
> >
> 
> Gawd. I assumed you knew how to initialize a pointer. I just
> located the procedure used to initialize the semaphore.

Shucks, I know how to initialize a pointer.  I even know how to initialize
a read-write semaphore.  The problem here is not _doing_ the
initialization; it's what _value_ to use.  Kernel threads don't have a
userpace memory component, so naturally current->mm is NULL -- there's no
memory map for it to point to.  Without having a memory map, of course
there's no semaphore to initialize, since the semaphore is _part_ of the 
memory map structure.

Alan Stern

