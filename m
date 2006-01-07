Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWAGSAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWAGSAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbWAGSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:00:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750872AbWAGSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:00:40 -0500
Date: Sat, 7 Jan 2006 19:00:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       linux-m68k@vger.kernel.org
Subject: [-mm patch] drivers/block/amiflop.c: fix compilation
Message-ID: <20060107180038.GL3774@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add-block_device_operationsgetgeo-block-device-method.patch causes the 
following compile error:

<--  snip  -->

...
  CC      drivers/block/amiflop.o
drivers/block/amiflop.c: In function `fd_getgeo':
drivers/block/amiflop.c:1431: warning: implicit declaration of function `minor'
...
  LD      .tmp_vmlinux1
...
drivers/built-in.o(.text+0x215cc): In function `fd_getgeo':
: undefined reference to `minor'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-m68k/drivers/block/amiflop.c.old	2006-01-07 18:22:21.000000000 +0100
+++ linux-2.6.15-mm2-m68k/drivers/block/amiflop.c	2006-01-07 18:22:30.000000000 +0100
@@ -1428,7 +1428,7 @@
 
 static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	int drive = minor(bdev->bd_dev) & 3;
+	int drive = MINOR(bdev->bd_dev) & 3;
 
 	geo->heads = unit[drive].type->heads;
 	geo->sectors = unit[drive].dtype->sects * unit[drive].type->sect_mult;

