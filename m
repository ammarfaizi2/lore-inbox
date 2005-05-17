Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVEQE5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVEQE5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVEQE5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:57:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58779 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261735AbVEQE5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:57:30 -0400
Date: Tue, 17 May 2005 05:57:48 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] Fix root hole in raw device
Message-ID: <20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk>
References: <11163046682662@kroah.com> <11163046681444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11163046681444@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 09:37:48PM -0700, Greg KH wrote:
> @@ -122,7 +122,7 @@
>  {
>  	struct block_device *bdev = filp->private_data;
>  
> -	return ioctl_by_bdev(bdev, command, arg);
> +	return blkdev_ioctl(bdev->bd_inode, filp, command, arg);
>  }

That is not quite correct.  You are passing very odd filp to ->ioctl()...
Old variant gave NULL, which is also not too nice, though.
