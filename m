Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268270AbTBYTNe>; Tue, 25 Feb 2003 14:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268272AbTBYTNe>; Tue, 25 Feb 2003 14:13:34 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38596 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268270AbTBYTNa>; Tue, 25 Feb 2003 14:13:30 -0500
Date: Tue, 25 Feb 2003 20:23:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Ed Okerson <eokerson@quicknet.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compilation of drivers/telephony/ixj.c
Message-ID: <20030225192339.GR7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile error in 2.5.63:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/telephony/.ixj.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=ixj -DKBUILD_MODNAME=ixj -c -o drivers/telephony/ixj.o 
drivers/telephony/ixj.c
drivers/telephony/ixj.c: In function `ixj_probe_isapnp':
drivers/telephony/ixj.c:7720: too many arguments to function 
`pnp_activate_dev'
...
make[2]: *** [drivers/telephony/ixj.o] Error 1

<--  snip  -->


The following patch fixes it:


--- linux-2.5.63-notfull/drivers/telephony/ixj.c.old	2003-02-25 19:22:34.000000000 +0100
+++ linux-2.5.63-notfull/drivers/telephony/ixj.c	2003-02-25 19:23:01.000000000 +0100
@@ -7717,7 +7717,7 @@
 				printk("pnp attach failed %d \n", result);
 				break;
 			}
-			if (pnp_activate_dev(dev, NULL) < 0) {
+			if (pnp_activate_dev(dev) < 0) {
 				printk("pnp activate failed (out of resources?)\n");
 				pnp_device_detach(dev);
 				return -ENOMEM;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

