Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312499AbSDDACB>; Wed, 3 Apr 2002 19:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312503AbSDDABw>; Wed, 3 Apr 2002 19:01:52 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:17284 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312499AbSDDABo>; Wed, 3 Apr 2002 19:01:44 -0500
Date: Wed, 3 Apr 2002 16:58:01 -0700
Message-Id: <200204032358.g33Nw1S13759@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Craig Christophel <merlin@transgeek.com>
Subject: Re: [PATCH] shift BKL out of notify_change
In-Reply-To: <3CAB8BB4.8040400@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen writes:
> My patch adds a semaphore to the inode structure, removes the BKL from 
> notify_change(), and shifts the BKL into the individual filesystems' 
> setattr() functions.  I doubt that many of them actually need it, but I 
> figure the FS maintainers can remove it.  The BKL use in notify_change() 
> is replaced by the semaphore i_attr_lock.
[...]
> diff -ur linux-2.5.7-clean/fs/devfs/base.c linux/fs/devfs/base.c
> --- linux-2.5.7-clean/fs/devfs/base.c	Tue Apr  2 10:43:19 2002
> +++ linux/fs/devfs/base.c	Wed Apr  3 13:49:11 2002
> @@ -2507,17 +2507,22 @@
>  
>  static int devfs_notify_change (struct dentry *dentry, struct iattr *iattr)
>  {
> -    int retval;
> +    int retval=0;
>      struct devfs_entry *de;
>      struct inode *inode = dentry->d_inode;
> -    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
> +    struct fs_info efs_info = inode->i_sb-nu.generic_sbp;

What on earth is this change? Some kind of cut-and-paste error?

> +    lock_kernel();

The BKL isn't needed in this function, so please don't add it. I'd
just have to remove it again.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
