Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311900AbSC0LLT>; Wed, 27 Mar 2002 06:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312550AbSC0LK7>; Wed, 27 Mar 2002 06:10:59 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:9357 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311900AbSC0LKu>;
	Wed, 27 Mar 2002 06:10:50 -0500
Date: Wed, 27 Mar 2002 11:15:32 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: <linux-kernel@vger.kernel.org>
Subject: Re: initrd and BLKFLSBUF
In-Reply-To: <Pine.LNX.4.33.0203261427340.1089-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0203271112330.1796-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

amazing that people start adding complications (all that "bdev" filesystem
stuff in recent kernels) without first getting the basics right -- the
bd_openers accounting doesn't seem to be correct.

On Tue, 26 Mar 2002, Tigran Aivazian wrote:

> Hello,
>
> Is blockdev --flushbufs supposed to work on /dev/ram0 if it was loaded as
> initrd ramdisk? I unmount it and try to free the memory but hit this
> EBUSY in drivers/block/rd.c:rd_ioctl():
>
>                         /* special: we want to release the ramdisk memory,
>                            it's not like with the other blockdevices where
>                            this ioctl only flushes away the buffer cache. */
>                         if ((atomic_read(&inode->i_bdev->bd_openers) > 2))
>                                 return -EBUSY;
>
> The kernel is 2.4.9 but this code is almost the same in 2.4.18. So, who is
> this opener that keeps the inode->i_bdev->bd_openers too high?
>
> Regards,
> Tigran
>
>

