Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265280AbUENNcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUENNcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbUENNcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:32:16 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:20490
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S265280AbUENN36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:29:58 -0400
Date: Fri, 14 May 2004 15:29:55 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: cramfs as initrd still fails in 2.4.27-pre2 [PATCH]
Message-ID: <20040514132955.GA6190@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been trying to use the cramfs to hold my initrd images and it works ok
in 2.6.6, but when testing it in 2.4.26 or 2.4.27rc2 I get this problem:

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2128 blocks [1 disk] into ram disk... done.
Freeing initrd memory: 2128k freed
cramfs: wrong magic

In Debian official kernel packages cramfs is being used as the initrd, so I
had a look at Debian's kernel patches and extracted this one that makes
initrd work for me in 2.4.26 and 2.4.27-pre2:

diff -urN kernel-source-2.4.26/fs/block_dev.c kernel-source-2.4.26-1/fs/block_dev.c
--- kernel-source-2.4.26/fs/block_dev.c	2003-06-14 00:51:37.000000000 +1000
+++ kernel-source-2.4.26-1/fs/block_dev.c	2003-06-01 20:43:53.000000000 +1000
@@ -95,7 +95,7 @@
 	sync_buffers(dev, 2);
 	blksize_size[MAJOR(dev)][MINOR(dev)] = size;
 	bdev->bd_inode->i_blkbits = blksize_bits(size);
-	kill_bdev(bdev);
+	invalidate_bdev(bdev, 1);
 	bdput(bdev);
 	return 0;
 }

I think this patch or some other fix should be applied.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
