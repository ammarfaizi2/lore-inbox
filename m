Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTKMQ74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTKMQ74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:59:56 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:1284 "EHLO tartutest.cyber.ee")
	by vger.kernel.org with ESMTP id S264347AbTKMQ7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:59:55 -0500
From: Meelis Roos <mroos@linux.ee>
To: remco@virtu.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.4 odd behaviour of ramdisk + cramfs
In-Reply-To: <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.6.0-test9 (i686))
Message-Id: <E1AKKos-0000Ix-T4@rhn.tartu-labor>
Date: Thu, 13 Nov 2003 18:59:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RvM> Running it once causes the mount to fail with 'cramfs: wrong magic' - 

Debian kernel has a patch to help cramfs initrd's work. The symptoms
wothout the patch are very similar. This is the patch, extracted from
Debian kernel-source package:

diff -urN linux-2.4.22.orig/fs/block_dev.c linux-2.4.22/fs/block_dev.c
--- linux-2.4.22.orig/fs/block_dev.c     2003-06-01 13:06:32.000000000 +1000
+++ linux-2.4.22/fs/block_dev.c  2003-06-01 20:43:53.000000000 +1000
@@ -95,7 +95,7 @@
        sync_buffers(dev, 2);
        blksize_size[MAJOR(dev)][MINOR(dev)] = size;
        bdev->bd_inode->i_blkbits = blksize_bits(size);
-       kill_bdev(bdev);
+       invalidate_bdev(bdev, 1);
        bdput(bdev);
        return 0;
 }

-- 
Meelis Roos (mroos@linux.ee)
