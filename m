Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRCBT0G>; Fri, 2 Mar 2001 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129424AbRCBTZ5>; Fri, 2 Mar 2001 14:25:57 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:54034 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129274AbRCBTZm>;
	Fri, 2 Mar 2001 14:25:42 -0500
Message-Id: <200103021925.f22JPPU02085@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: Steve Lord <lord@sgi.com>, Jeremy Hansen <jeremy@xxedgexx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Fri, 02 Mar 2001 14:17:44 EST." <383290000.983560664@tiny> 
Date: Fri, 02 Mar 2001 13:25:25 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Friday, March 02, 2001 12:39:01 PM -0600 Steve Lord <lord@sgi.com> wrote:
> 
> [ file_fsync syncs all dirty buffers on the FS ]
> > 
> > So it looks like fsync is going to cost more for bigger devices. Given the
> > O_SYNC changes Stephen Tweedie did, couldnt fsync look more like this:
> > 
> >	 down(&inode->i_sem);
> >         filemap_fdatasync(ip->i_mapping);
> >         fsync_inode_buffers(ip);
> >         filemap_fdatawait(ip->i_mapping);
> >	 up(&inode->i_sem);
> > 
> 
> reiserfs might need to trigger a commit on fsync, so the fs specific fsync
> op needs to be called.  But, you should not need to call file_fsync in the
> XFS fsync call (check out ext2's)


Right, this was just a generic example, the fsync_inode_buffers would be in
the filesystem specific fsync callout - this was more of a logical
example of what ext2 could do. XFS does completely different stuff in there
anyway. 

> 
> For why ide is beating scsi in this benchmark...make sure tagged queueing
> is on (or increase the queue length?).  For the xlog.c test posted, I would
> expect scsi to get faster than ide as the size of the write increases.

I think the issue is the call being used now is going to get slower the
larger the device is, just from the point of view of how many buffers it
has to scan.

> 
> -chris

Steve


