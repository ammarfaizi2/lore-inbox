Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271905AbRIIFcl>; Sun, 9 Sep 2001 01:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271907AbRIIFcW>; Sun, 9 Sep 2001 01:32:22 -0400
Received: from kiln.isn.net ([198.167.161.1]:9072 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S271905AbRIIFcD>;
	Sun, 9 Sep 2001 01:32:03 -0400
Message-ID: <3B9AFE8A.3E093476@isn.net>
Date: Sun, 09 Sep 2001 02:30:50 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: 2.4.10-pre5/pre6
In-Reply-To: <3B99A8C2.56E88CE3@isn.net> <m2lmjq7yuv.fsf@ppro.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aar:/lib/modules/2.4.10-pre6#
Pre5 problems cured but,
dhinds pcmcia-cs-3.1.29 gives:
 depmod -ae
depmod: *** Unresolved symbols in
/lib/modules/2.4.10-pre6/kernel/drivers/scsi/sd_mod.o
depmod:         del_gendisk
depmod:         add_gendisk

This patch is still needed for pre6
Peter Osterlund wrote:

> This patch seems to work:
> 
> --- linux/drivers/block/rd.c.orig       Sat Sep  8 11:58:19 2001
> +++ linux/drivers/block/rd.c    Sat Sep  8 12:21:50 2001
> @@ -259,7 +259,7 @@
>                         /* special: we want to release the ramdisk memory,
>                            it's not like with the other blockdevices where
>                            this ioctl only flushes away the buffer cache. */
> -                       if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
> +                       if ((atomic_read(&rd_bdev[minor]->bd_openers) > 2))
>                                 return -EBUSY;
>                         destroy_buffers(inode->i_rdev);
>                         rd_blocksizes[minor] = 0;
> @@ -372,7 +372,7 @@
>                 struct block_device *bdev = rd_bdev[i];
>                 rd_bdev[i] = NULL;
>                 if (bdev) {
> -                       blkdev_put(bdev);
> +                       blkdev_put(bdev, BDEV_FILE);
>                         bdput(bdev);
>                 }
>                 destroy_buffers(MKDEV(MAJOR_NR, i));
> 
> --
> Peter Österlund             petero2@telia.com
> Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
> S-128 66 Sköndal            +46 8 942647
> Sweden
