Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTDHTxR (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDHTxR (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:53:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10736 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261692AbTDHTxP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 15:53:15 -0400
Date: Tue, 8 Apr 2003 22:04:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.67-ac1: fix compile error in mtdblock.c
Message-ID: <20030408200445.GM5046@fs.tum.de>
References: <200304081359.h38DxGi08829@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304081359.h38DxGi08829@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DEVFS_FS enabled compilation of 2.5.67-ac1 fails as follows:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/mtd/.mtdblock.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=mtdblock -DKBUILD_MODNAME=mtdblock -c -o 
drivers/mtd/mtdblock.o drivers/mtd/mtdblock.c
drivers/mtd/mtdblock.c: In function `mtd_notify_add':
drivers/mtd/mtdblock.c:531: `name' undeclared (first use in this function)
drivers/mtd/mtdblock.c:531: (Each undeclared identifier is reported only once
drivers/mtd/mtdblock.c:531: for each function it appears in.)
make[2]: *** [drivers/mtd/mtdblock.o] Error 1

<--  snip  -->


Please _remove_ the following patch from -ac:


--- linux-2.5.67/drivers/mtd/mtdblock.c	2003-04-08 00:37:36.000000000 +0100
+++ linux-2.5.67-ac1/drivers/mtd/mtdblock.c	2003-04-08 14:15:14.000000000 +0100
@@ -523,7 +523,6 @@
 static void mtd_notify_add(struct mtd_info* mtd)
 {
 	struct gendisk *disk;
-        char name[16];
 
         if (!mtd || mtd->type == MTD_ABSENT)
                 return;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

