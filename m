Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVARJTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVARJTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 04:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVARJTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 04:19:33 -0500
Received: from [213.146.154.40] ([213.146.154.40]:63210 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261198AbVARJTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 04:19:31 -0500
Date: Tue, 18 Jan 2005 09:19:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Support compat_ioctl for block devices
Message-ID: <20050118091927.GA24768@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050118075602.GD76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118075602.GD76018@muc.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
> +{
> +	struct block_device *bdev = file->f_dentry->d_inode->i_bdev;
> +	struct gendisk *disk = bdev->bd_disk;
> +	int ret = -ENOIOCTLCMD;
> +	if (disk->fops->compat_ioctl) {
> +		lock_kernel();
> +		ret = disk->fops->compat_ioctl(file, cmd, arg);
> +		unlock_kernel();
> +	}
> +	return ret;
> +}

 - please don't introduce a new API with the BKL held.
 - prototype isn't nice.  just passing the gendisk for block_device
   should be enough.

also this wants documentation in Documentation/filesystems/Locking
