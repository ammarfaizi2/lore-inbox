Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVARJcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVARJcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 04:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVARJcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 04:32:01 -0500
Received: from colin2.muc.de ([193.149.48.15]:38918 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261203AbVARJb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 04:31:59 -0500
Date: 18 Jan 2005 10:31:58 +0100
Date: Tue, 18 Jan 2005 10:31:58 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Support compat_ioctl for block devices
Message-ID: <20050118093158.GB20002@muc.de>
References: <20050118075602.GD76018@muc.de> <20050118091927.GA24768@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118091927.GA24768@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:19:27AM +0000, Christoph Hellwig wrote:
> > +long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
> > +{
> > +	struct block_device *bdev = file->f_dentry->d_inode->i_bdev;
> > +	struct gendisk *disk = bdev->bd_disk;
> > +	int ret = -ENOIOCTLCMD;
> > +	if (disk->fops->compat_ioctl) {
> > +		lock_kernel();
> > +		ret = disk->fops->compat_ioctl(file, cmd, arg);
> > +		unlock_kernel();
> > +	}
> > +	return ret;
> > +}
> 
>  - please don't introduce a new API with the BKL held.

Nope, I'm not going to audit zillions of low level functions for this.

>  - prototype isn't nice.  just passing the gendisk for block_device
>    should be enough.

No, it isn't, the compat handler needs cmd and arg, and file is useful
when you pass it to an existing ioctl handler.

-Andi
