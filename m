Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265549AbSKAAx7>; Thu, 31 Oct 2002 19:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265550AbSKAAx7>; Thu, 31 Oct 2002 19:53:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33249 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265549AbSKAAx6>;
	Thu, 31 Oct 2002 19:53:58 -0500
Date: Thu, 31 Oct 2002 20:00:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Bob Miller <rem@osdl.org>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.45] Export blkdev_ioctl for raw block driver.
In-Reply-To: <20021031174622.A1185@doc.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210311954210.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Bob Miller wrote:

> On Thu, Oct 31, 2002 at 05:20:07PM -0800, Bob Miller wrote:
> > On Thu, Oct 31, 2002 at 07:11:19PM -0500, Alexander Viro wrote:
> 
> Stuff deleted...
> 
> > > Why not use ioctl_by_bdev() in the first place?  (and yes, it's very likely
> > > my fault - I hadn't realized that raw.c went modular at some point).
> > Didn't know about ioctl_by_bdev()... I'll make a patch that converts
> > the raw driver to call it instead of blkdev_ioctl().
 
Looks OK.

<OT, teasing>

vi -c'/blkdev_ioctl/s/blk.*NULL/ioctl_by_bdev(bdev/|x' drivers/char/raw.c

would be a bit more concise than thing below, wouldn't it?

</OT>

 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.869   -> 1.870  
> #	  drivers/char/raw.c	1.23    -> 1.24   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/10/31	rem@doc.pdx.osdl.net	1.870
> # Changed raw driver to call ioctl_by_bdev() instead of
> # blkdev_ioctl() so that it will build as a module.
> # --------------------------------------------
> #
> diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
> --- a/drivers/char/raw.c	Thu Oct 31 17:34:56 2002
> +++ b/drivers/char/raw.c	Thu Oct 31 17:34:56 2002
> @@ -95,7 +95,7 @@
>  {
>  	struct block_device *bdev = filp->private_data;
>  
> -	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
> +	return ioctl_by_bdev(bdev, command, arg);
>  }
>  
>  /*
> -- 
> Bob Miller					Email: rem@osdl.org
> Open Source Development Lab			Phone: 503.626.2455 Ext. 17
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

