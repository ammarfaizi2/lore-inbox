Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTEAWDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTEAWDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:03:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20443 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262707AbTEAWDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:03:40 -0400
Date: Fri, 2 May 2003 00:15:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix miropcm20-rds.c compilation
Message-ID: <20030501221551.GQ21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of #include <linux/devfs_fs_kernel.h> broke the compilation 
of drivers/media/radio/miropcm20-rds.c.old in 2.5.68-bk11:

<--  snip  -->

...
  gcc-2.95 -Wp,-MD,drivers/media/radio/.miropcm20-rds.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=miropcm20_rds 
-DKBUILD_MODNAME=miropcm20_rds -c -o drivers/media/radio/miropcm20-rds.o 
drivers/media/radio/miropcm20-rds.c
drivers/media/radio/miropcm20-rds.c:23: warning: `struct inode' declared 
inside parameter list
drivers/media/radio/miropcm20-rds.c:23: warning: its scope is only this 
definition or declaration, which is probably not what you want.
drivers/media/radio/miropcm20-rds.c:38: warning: `struct inode' declared 
inside parameter list
drivers/media/radio/miropcm20-rds.c:106: variable `rds_fops' has 
initializer but incomplete type
drivers/media/radio/miropcm20-rds.c:107: unknown field `owner' specified 
in initializer
drivers/media/radio/miropcm20-rds.c:107: warning: excess elements in 
struct initializer
drivers/media/radio/miropcm20-rds.c:107: warning: (near initialization 
for `rds_fops')
drivers/media/radio/miropcm20-rds.c:108: unknown field `read' specified 
in initializer
drivers/media/radio/miropcm20-rds.c:108: warning: excess elements in 
struct initializer
drivers/media/radio/miropcm20-rds.c:108: warning: (near initialization 
for `rds_fops')
drivers/media/radio/miropcm20-rds.c:109: unknown field `open' specified 
in initializer
drivers/media/radio/miropcm20-rds.c:109: warning: excess elements in 
struct initializer
drivers/media/radio/miropcm20-rds.c:109: warning: (near initialization 
for `rds_fops')
drivers/media/radio/miropcm20-rds.c:110: unknown field `release' 
specified in initializer
drivers/media/radio/miropcm20-rds.c:111: warning: excess elements in 
struct initializer
drivers/media/radio/miropcm20-rds.c:111: warning: (near initialization 
for `rds_fops')
make[3]: *** [drivers/media/radio/miropcm20-rds.o] Error 1

<--  snip  -->

The fix is simple:

--- linux-2.5.68-bk11/drivers/media/radio/miropcm20-rds.c.old	2003-05-02 00:07:45.000000000 +0200
+++ linux-2.5.68-bk11/drivers/media/radio/miropcm20-rds.c	2003-05-02 00:11:01.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
+#include <linux/fs.h>
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

