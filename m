Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312336AbSCZO0g>; Tue, 26 Mar 2002 09:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312334AbSCZO0R>; Tue, 26 Mar 2002 09:26:17 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:44399 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S312336AbSCZO0P>;
	Tue, 26 Mar 2002 09:26:15 -0500
Date: Tue, 26 Mar 2002 14:30:49 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: <linux-kernel@vger.kernel.org>
Subject: initrd and BLKFLSBUF
Message-ID: <Pine.LNX.4.33.0203261427340.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is blockdev --flushbufs supposed to work on /dev/ram0 if it was loaded as
initrd ramdisk? I unmount it and try to free the memory but hit this
EBUSY in drivers/block/rd.c:rd_ioctl():

                        /* special: we want to release the ramdisk memory,
                           it's not like with the other blockdevices where
                           this ioctl only flushes away the buffer cache. */
                        if ((atomic_read(&inode->i_bdev->bd_openers) > 2))
                                return -EBUSY;

The kernel is 2.4.9 but this code is almost the same in 2.4.18. So, who is
this opener that keeps the inode->i_bdev->bd_openers too high?

Regards,
Tigran

