Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbTIETVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbTIETUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:20:41 -0400
Received: from ida.rowland.org ([192.131.102.52]:20228 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265830AbTIETQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:16:24 -0400
Date: Fri, 5 Sep 2003 15:16:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.53.0309051435230.23800@chaos>
Message-ID: <Pine.LNX.4.44L0.0309051510170.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Richard B. Johnson wrote:

> On Fri, 5 Sep 2003, Alan Stern wrote:
> 
> > My kernel module for Linux-2.6 needs to be able to verify that the media
> > on which a file resides actually is readable.  How can I do that?
> >
> > It would certainly suffice to use the normal VFS read routines, if there
> > was some way to force the system to actually read from the device rather
> > than just returning data already in the cache.  So I guess it would be
> > enough to perform an fdatasync for the file and then invalidate the file's
> > cache entries.  How does one invalidate a file's cache entries?  Does
> > filemap_flush() perform both these operations for you?
> >
> > TIA,
> >
> > Alan Stern
> 
> Force a read() before some write data was flushed to the disk??

No, no!  Force a read() _after_ all the dirty buffers are flushed to the 
disk.

> Well, if you insist, just do a raw read of the device after
> you find the inode, then offset, that your data is on. You
> can walk the same fs structure(s) as the active file-system
> to get all meta-data information.

I assume you're kidding... :-)

> ...but... The most current data is probably in the kernel
> buffers. I don't think you really want what you are asking
> for.

No, I _do_ want exactly what I asked for.  Actually, I would really like a 
bit more: to ask the disk drive to read from its media rather than its 
cache.  But I'll settle for bypassing the O/S's cache.

>  If you did a fdatasync(), you get the current data your
> process wrote to go to the disk.

Not if there is a bad sector that causes a read error.

>  However, there may be
> other writers. This, too, may not be what you want.

I'm assuming there aren't other writers.  It doesn't really matter if 
there are.  I don't care _what_ data is on the disk; I just want to know 
that it is _readable_ without getting hardware errors.

>  Also,
> Just because the data was queued to go to a (SCSI) disk,
> doesn't mean it actually got to the platters.

Yes.  It's an imperfect world.

Alan Stern

