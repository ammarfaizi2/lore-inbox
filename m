Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWBJC7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWBJC7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 21:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWBJC7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 21:59:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751019AbWBJC7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 21:59:51 -0500
Date: Thu, 9 Feb 2006 18:58:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: dm-devel@redhat.com, lcm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support HDIO_GETGEO on device-mapper volumes
Message-Id: <20060209185855.6643dcce.akpm@osdl.org>
In-Reply-To: <43EBEDD0.60608@us.ibm.com>
References: <43EBEDD0.60608@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Darrick J. Wong" <djwong@us.ibm.com> wrote:
>
> The attached patch implements a simple ioctl handler that supplies a 
> compatible geometry when HDIO_GETGEO is called against a device-mapper 
> device.

block_device_operations now has a standalone `getgeo' method.

> ...
> +static int dm_blk_ioctl(struct inode * inode, struct file * filp,
> +			unsigned int cmd, unsigned long arg)
> +{
> +	struct block_device *bdev = inode->i_bdev;
> +	struct hd_geometry __user *loc = (void __user *)arg;
> +	struct mapped_device *md;
> +	int diskinfo[4];
> +
> +	if (cmd == HDIO_GETGEO) {
> +		if (!arg)
> +			return -EINVAL;

I don't think we need that check?  The -EFAULT should suffice.
