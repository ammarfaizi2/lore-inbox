Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTLSXI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 18:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTLSXI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 18:08:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26354 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263680AbTLSXIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 18:08:46 -0500
Date: Sat, 20 Dec 2003 00:08:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Romain Lievin <roms@lpg.ticalc.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix a compile warning in tipar.c (fwd)
Message-ID: <20031219230838.GZ12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch forwarded below still applies and compiles against 
2.4.24-pre1.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sun, 3 Aug 2003 12:58:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Romain Lievin <roms@lpg.ticalc.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in tipar.c

I got the following compile warning in 2.4.22-pre10:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include -
Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=tipar  -c -o tipar.o tipar.c
tipar.c:76:1: warning: "minor" redefined
In file included from 
/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include/linux/fs.h:16,
                 from 
/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include/linux/capability.h:17,
                 from 
/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include/linux/binfmts.h:5,
                 from 
/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include/linux/sched.h:9,
                 from tipar.c:49:
/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include/linux/kdev_t.h:81:1:
 warning: this is the location of the previous definition
...

<--  snip  -->

The minor #define was added to kdev_t.h in 2.4.18-pre4. The following
patch adjusts tipar.c accordingly. Besides this, it changes the kernel
version chack from a private macro to use the KERNEL_VERSION in kernel.h.

--- linux-2.4.22-pre10-full/drivers/char/tipar.c.old	2003-08-02 22:52:49.000000000 +0200
+++ linux-2.4.22-pre10-full/drivers/char/tipar.c	2003-08-02 22:57:57.000000000 +0200
@@ -71,9 +71,11 @@
 #define DRIVER_DESC    "Device driver for TI/PC parallel link cables"
 #define DRIVER_LICENSE "GPL"
 
-#define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
-#if LINUX_VERSION_CODE < VERSION(2,5,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
 # define minor(x) MINOR(x)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 # define need_resched() (current->need_resched)
 #endif
 



I've tested the compilation with 2.4.22-pre10.

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

