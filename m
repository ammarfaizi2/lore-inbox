Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTKMRRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTKMRRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:17:09 -0500
Received: from services3.virtu.nl ([217.114.97.6]:4507 "EHLO
	services3.virtu.nl") by vger.kernel.org with ESMTP id S264355AbTKMRQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:16:53 -0500
Message-Id: <5.1.0.14.2.20031113180820.026e6ba0@services3.virtu.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Nov 2003 18:13:45 +0100
To: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
From: Remco van Mook <remco@virtu.nl>
Subject: Re: 2.4 odd behaviour of ramdisk + cramfs
In-Reply-To: <E1AKKos-0000Ix-T4@rhn.tartu-labor>
References: <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Virtu-MailScanner-VirusCheck: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Meelis,

thank you ! This patch works for me.

Does it have any side effects or might I suggest that this one is merged 
into the mainstream kernel ?

Cheers,

Remco van Mook

At 18:59 13-11-2003 +0200, Meelis Roos wrote:
>RvM> Running it once causes the mount to fail with 'cramfs: wrong magic' -
>
>Debian kernel has a patch to help cramfs initrd's work. The symptoms
>wothout the patch are very similar. This is the patch, extracted from
>Debian kernel-source package:
>
>diff -urN linux-2.4.22.orig/fs/block_dev.c linux-2.4.22/fs/block_dev.c
>--- linux-2.4.22.orig/fs/block_dev.c     2003-06-01 13:06:32.000000000 +1000
>+++ linux-2.4.22/fs/block_dev.c  2003-06-01 20:43:53.000000000 +1000
>@@ -95,7 +95,7 @@
>         sync_buffers(dev, 2);
>         blksize_size[MAJOR(dev)][MINOR(dev)] = size;
>         bdev->bd_inode->i_blkbits = blksize_bits(size);
>-       kill_bdev(bdev);
>+       invalidate_bdev(bdev, 1);
>         bdput(bdev);
>         return 0;
>  }
>
>--
>Meelis Roos (mroos@linux.ee)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

