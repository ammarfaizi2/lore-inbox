Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129424AbRCBT1h>; Fri, 2 Mar 2001 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCBT11>; Fri, 2 Mar 2001 14:27:27 -0500
Received: from [38.204.212.32] ([38.204.212.32]:43978 "HELO srv2.ecropolis.com")
	by vger.kernel.org with SMTP id <S129424AbRCBT1R>;
	Fri, 2 Mar 2001 14:27:17 -0500
Date: Fri, 2 Mar 2001 14:27:08 -0500 (EST)
From: Jeremy Hansen <jeremy@xxedgexx.com>
X-X-Sender: <jeremy@srv2.ecropolis.com>
To: Steve Lord <lord@sgi.com>
cc: Chris Mason <mason@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's 
In-Reply-To: <200103021925.f22JPPU02085@jen.americas.sgi.com>
Message-ID: <Pine.LNX.4.33L2.0103021426250.21780-100000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Steve Lord wrote:

> >
> >
> > On Friday, March 02, 2001 12:39:01 PM -0600 Steve Lord <lord@sgi.com> wrote:
> >
> > [ file_fsync syncs all dirty buffers on the FS ]
> > >
> > > So it looks like fsync is going to cost more for bigger devices. Given the
> > > O_SYNC changes Stephen Tweedie did, couldnt fsync look more like this:
> > >
> > >	 down(&inode->i_sem);
> > >         filemap_fdatasync(ip->i_mapping);
> > >         fsync_inode_buffers(ip);
> > >         filemap_fdatawait(ip->i_mapping);
> > >	 up(&inode->i_sem);
> > >
> >
> > reiserfs might need to trigger a commit on fsync, so the fs specific fsync
> > op needs to be called.  But, you should not need to call file_fsync in the
> > XFS fsync call (check out ext2's)
>
>
> Right, this was just a generic example, the fsync_inode_buffers would be in
> the filesystem specific fsync callout - this was more of a logical
> example of what ext2 could do. XFS does completely different stuff in there
> anyway.
>
> >
> > For why ide is beating scsi in this benchmark...make sure tagged queueing
> > is on (or increase the queue length?).  For the xlog.c test posted, I would
> > expect scsi to get faster than ide as the size of the write increases.
>
> I think the issue is the call being used now is going to get slower the
> larger the device is, just from the point of view of how many buffers it
> has to scan.

Well, I tried making the device smaller, creating just a 9gig partition on
the raid array and this made no different in the xlog results.

-jeremy

> >
> > -chris
>
> Steve
>
>
>

-- 
this is my sig.

