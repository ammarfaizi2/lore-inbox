Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbRCBTTQ>; Fri, 2 Mar 2001 14:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRCBTTG>; Fri, 2 Mar 2001 14:19:06 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:3335 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129434AbRCBTTC>; Fri, 2 Mar 2001 14:19:02 -0500
Date: Fri, 02 Mar 2001 14:17:44 -0500
From: Chris Mason <mason@suse.com>
To: Steve Lord <lord@sgi.com>, Jeremy Hansen <jeremy@xxedgexx.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 
Message-ID: <383290000.983560664@tiny>
In-Reply-To: <200103021839.f22Id1F32697@jen.americas.sgi.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, March 02, 2001 12:39:01 PM -0600 Steve Lord <lord@sgi.com> wrote:

[ file_fsync syncs all dirty buffers on the FS ]
> 
> So it looks like fsync is going to cost more for bigger devices. Given the
> O_SYNC changes Stephen Tweedie did, couldnt fsync look more like this:
> 
>	 down(&inode->i_sem);
>         filemap_fdatasync(ip->i_mapping);
>         fsync_inode_buffers(ip);
>         filemap_fdatawait(ip->i_mapping);
>	 up(&inode->i_sem);
> 

reiserfs might need to trigger a commit on fsync, so the fs specific fsync
op needs to be called.  But, you should not need to call file_fsync in the
XFS fsync call (check out ext2's)

For why ide is beating scsi in this benchmark...make sure tagged queueing
is on (or increase the queue length?).  For the xlog.c test posted, I would
expect scsi to get faster than ide as the size of the write increases.

-chris

