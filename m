Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCBT22>; Fri, 2 Mar 2001 14:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCBT2S>; Fri, 2 Mar 2001 14:28:18 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:55559
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129440AbRCBT2C>; Fri, 2 Mar 2001 14:28:02 -0500
Date: Fri, 2 Mar 2001 11:25:49 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Chris Mason <mason@suse.com>
cc: Steve Lord <lord@sgi.com>, Jeremy Hansen <jeremy@xxedgexx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 
In-Reply-To: <383290000.983560664@tiny>
Message-ID: <Pine.LNX.4.10.10103021125030.3663-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I now have to create TCQ for ATA becasue I am not going to lose again
now that I am winning ;-)

On Fri, 2 Mar 2001, Chris Mason wrote:

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
> 
> For why ide is beating scsi in this benchmark...make sure tagged queueing
> is on (or increase the queue length?).  For the xlog.c test posted, I would
> expect scsi to get faster than ide as the size of the write increases.
> 
> -chris
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

