Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTBYOBn>; Tue, 25 Feb 2003 09:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267771AbTBYOBn>; Tue, 25 Feb 2003 09:01:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21714 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267765AbTBYOBm>; Tue, 25 Feb 2003 09:01:42 -0500
Date: Tue, 25 Feb 2003 15:11:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: vandrove@vc.cvut.cz
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [2.5 patch] fix the compilation of radio-sf16fmi.c
Message-ID: <20030225141151.GM7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/radio/radio-sf16fmi.c doesn't compile in 2.5.63:

<--  snip  -->

  gcc -Wp,-MD,drivers/media/radio/.radio-sf16fmi.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=k6 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=radio_sf16fmi -DKBUILD_MODNAME=radio_sf16fmi -c -o 
drivers/media/radio/radio-sf16fmi.o drivers/media/radio/radio-sf16fmi.c
drivers/media/radio/radio-sf16fmi.c: In function `isapnp_fmi_probe':
drivers/media/radio/radio-sf16fmi.c:265: too many arguments to function 
`pnp_activate_dev'
make[3]: *** [drivers/media/radio/radio-sf16fmi.o] Error 1

<--  snip  -->


It seems the following is needed:


--- linux-2.5.63-notfull/drivers/media/radio/radio-sf16fmi.c.old	2003-02-25 15:00:50.000000000 +0100
+++ linux-2.5.63-notfull/drivers/media/radio/radio-sf16fmi.c	2003-02-25 15:01:42.000000000 +0100
@@ -262,7 +262,7 @@
 		return -ENODEV;
 	if (pnp_device_attach(dev) < 0)
 		return -EAGAIN;
-	if (pnp_activate_dev(dev, NULL) < 0) {
+	if (pnp_activate_dev(dev) < 0) {
 		printk ("radio-sf16fmi: PnP configure failed (out of resources?)\n");
 		pnp_device_detach(dev);
 		return -ENOMEM;


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

