Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTDGNth (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDGNth (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:49:37 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61862 "EHLO
	dickson.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263437AbTDGNtg (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 09:49:36 -0400
Date: Mon, 7 Apr 2003 10:00:52 -0400
From: Steve Dickson <SteveD@RedHat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] mmap corruption
Message-ID: <20030407140052.GA1471@RedHat.com>
Reply-To: SteveD@RedHat.com
References: <3E8DDB13.9020009@RedHat.com> <shsistt7wip.fsf@charged.uio.no> <20030405164741.GA6450@RedHat.com> <16016.7633.982870.860147@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16016.7633.982870.860147@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 02:30:09PM +0200, Trond Myklebust wrote:
> >>>>> " " == Steve Dickson <SteveD@RedHat.com> writes:
>      > /*
>      > * Every time either npages or ncommit had a value and the file
>      > size is
>      > * immediately changed (with in a microsecond or two) by another
>      > * truncation, followed by a mmap read, the file would be
>      > 	   corrupted.
>      > 	 */
>      > 	if (NFS_I(inode)->npages || NFS_I(inode)->ncommit ||
>      > 	NFS_I(inode)->ndirty) {
>      > 		printk("nfs_notify_change: fid %Ld npages %d ncommit
>      > 		%d ndirty %d\n", NFS_FILEID(inode),
>      > 		NFS_I(inode)->npages, ncommit, NFS_I(inode)->ndirty);
>      > 	}
>      > }
> 
> My point is that nfs_wb_all() is supposed to ensure that
> NFS_I(inode)->ncommit, and/or NFS_I(inode)->ndirty are both
> zero. i.e. you can have pending reads (in which case
> NFS_I(inode)->npages != 0), but *no* pending writes.
> 
> Was this the case?

OK, I understand your point.  And Yes, ndirty and ncommit 
always seem to be zero when nfs_wb_all() returns. Only
when npages != 0 is when I get the corruption.

I didn't realize that npages != 0 meant there are only pending 
reads *not* pending writes... Thanks for that clarification....

SteveD.
