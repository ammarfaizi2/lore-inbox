Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUA3T7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUA3T7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:59:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6085 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264246AbUA3T7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:59:53 -0500
Date: Fri, 30 Jan 2004 20:59:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Hartmann <jhartmann@precisioninsight.com>, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix a agpgart_be.c compile warning
Message-ID: <20040130195945.GR3004@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warning in 2.4.25-pre8:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_be  -c -o agpgart_be.o 
agpgart_be.c
...
agpgart_be.c:5647:17: warning: extra tokens at end of #undef directive
...

<--  snip  -->

The following patch fixes this issue:

--- linux-2.4.25-pre8-full/drivers/char/agp/agpgart_be.c.old	2004-01-30 20:55:15.000000000 +0100
+++ linux-2.4.25-pre8-full/drivers/char/agp/agpgart_be.c	2004-01-30 20:55:53.000000000 +0100
@@ -5644,7 +5644,7 @@
 #define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr) - \
 	GET_PAGE_DIR_OFF(agp_bridge.gart_bus_addr))
 #define GET_GATT_OFF(addr) ((addr & 0x003ff000) >> 12)
-#undef  GET_GATT(addr)
+#undef  GET_GATT
 #define GET_GATT(addr) (ati_generic_private.gatt_pages[\
 	GET_PAGE_DIR_IDX(addr)]->remapped)
 


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

