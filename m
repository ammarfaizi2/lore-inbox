Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTE3HwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 03:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTE3HwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 03:52:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36292 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263339AbTE3HwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 03:52:18 -0400
Date: Fri, 30 May 2003 10:05:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, mtd@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.70-mm2: `__raw_{read,write}ll' undefinded references
Message-ID: <20030530080533.GN5643@fs.tum.de>
References: <20030529012914.2c315dad.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/mtd/maps/map_funcs.o
drivers/mtd/maps/map_funcs.c: In function `simple_map_read64':
drivers/mtd/maps/map_funcs.c:38: warning: implicit declaration of 
function `__raw_readll'
drivers/mtd/maps/map_funcs.c: In function `simple_map_write64':
drivers/mtd/maps/map_funcs.c:65: warning: implicit declaration of 
function `__raw_writell'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x669e8e): In function `simple_map_read64':
: undefined reference to `__raw_readll'
drivers/built-in.o(.text+0x669f74): In function `simple_map_write64':
: undefined reference to `__raw_writell'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The fix is simple:


--- linux-2.5.70-mm2/drivers/mtd/maps/map_funcs.c.old	2003-05-30 09:47:04.000000000 +0200
+++ linux-2.5.70-mm2/drivers/mtd/maps/map_funcs.c	2003-05-30 09:47:49.000000000 +0200
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 
 #include <linux/mtd/map.h>
+#include <linux/mtd/cfi.h>
 
 static u8 simple_map_read8(struct map_info *map, unsigned long ofs)
 {



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

