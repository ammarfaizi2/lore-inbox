Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTBKUXp>; Tue, 11 Feb 2003 15:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTBKUXo>; Tue, 11 Feb 2003 15:23:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:51120 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266161AbTBKUXl>;
	Tue, 11 Feb 2003 15:23:41 -0500
Date: Tue, 11 Feb 2003 12:32:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] Extended attribute fixes, etc.
Message-Id: <20030211123223.1d95ad72.akpm@digeo.com>
In-Reply-To: <200302112018.58862.agruen@suse.de>
References: <200302112018.58862.agruen@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 20:33:23.0670 (UTC) FILETIME=[D2BAE760:01C2D20C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
>
> Hi Andrew,
> 
> here are five patches against 2.5.60. Each file contains a brief 
> description of what it does.
> 

Minor point:

> int
> ext3_xattr_set(struct inode *inode, int name_index, const char *name,
> 	       const void *value, size_t value_len, int flags)
> {
> 	handle_t *handle;
> 	int error;
> 
> 	lock_kernel();
> 	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
> 	if (IS_ERR(handle))
> 		error = PTR_ERR(handle);
> 	else
> 		error = ext3_xattr_set_handle(handle, inode, name_index, name,
> 					      value, value_len, flags);
> 	ext3_journal_stop(handle, inode);

ext3_journal_stop() can return an error code - most notable -EIO if it was a
synchronous transaction, or the filesystem has detected corruption.

> The third to fifth are all steps towards trusted extended attributes, 
> which are useful for privileged processes (mostly daemons). One use for 
> this is Hierarchical Storage Management, in which a user space daemon 
> stores online/offline information for files in trusted EA's, and the 
> kernel communicates requests to bring files online to that daemon. This 
> class of EA's will also find its way into XFS and ReiserFS, and 
> expectedly also into JFS in this form. (Trusted EAs are included in the 
> 2.4.19/2.4.20 patches as well.)

So is this new code actually functional yet?  As in: something in-kernel
using it?

If not, what is involved in completing the kernel side of trusted EA's?


