Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268209AbTBYRjk>; Tue, 25 Feb 2003 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268211AbTBYRjk>; Tue, 25 Feb 2003 12:39:40 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8905 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268209AbTBYRjg>; Tue, 25 Feb 2003 12:39:36 -0500
Date: Tue, 25 Feb 2003 18:49:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compilation of g_NCR5380.c
Message-ID: <20030225174945.GP7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.63 I get the following compile error in drivers/scsi/g_NCR5380.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/scsi/.g_NCR5380.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=g_NCR5380 -DKBUILD_MODNAME=g_NCR5380 -c -o 
drivers/scsi/g_NCR5380.o drivers/scsi/g_NCR5380.c
drivers/scsi/g_NCR5380.c: In function `generic_NCR5380_detect':
drivers/scsi/g_NCR5380.c:326: too many arguments to function 
`pnp_activate_dev'
...
make[2]: *** [drivers/scsi/g_NCR5380.o] Error 1

<--  snip  -->


The following patch fixes it:


--- linux-2.5.63-notfull/drivers/scsi/g_NCR5380.c.old	2003-02-25 18:33:38.000000000 +0100
+++ linux-2.5.63-notfull/drivers/scsi/g_NCR5380.c	2003-02-25 18:33:55.000000000 +0100
@@ -323,7 +323,7 @@
 				printk(KERN_ERR "dtc436e probe: attach failed\n");
 				continue;
 			}
-			if (pnp_activate_dev(dev, NULL) < 0) {
+			if (pnp_activate_dev(dev) < 0) {
 				printk(KERN_ERR "dtc436e probe: activate failed\n");
 				pnp_device_detach(dev);
 				continue;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

