Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbTCZI50>; Wed, 26 Mar 2003 03:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbTCZI50>; Wed, 26 Mar 2003 03:57:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33222 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261510AbTCZI5Y>; Wed, 26 Mar 2003 03:57:24 -0500
Date: Wed, 26 Mar 2003 10:08:29 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix the compilation of drivers/net/tokenring/tms380tr.c (fwd) (fwd)
Message-ID: <20030326090829.GE24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch in the mail forwarded below is still needed in 2.5.66.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date: Wed, 5 Mar 2003 21:34:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jochen Friedrich <jochen@scram.de>, trivial@rustcorp.com.au
Subject: [2.5 patch] fix the compilation of drivers/net/tokenring/tms380tr.c

Since 2.5.61 compilation of drivers/net/tokenring/tms380tr.c fails with 
the following error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/tokenring/.tms380tr.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=tms380tr -DKBUILD_MODNAME=tms380tr -c -o 
drivers/net/tokenring/tms380tr.o drivers/net/tokenring/tms380tr.c
drivers/net/tokenring/tms380tr.c: In function `tms380tr_open':
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c: In function `tms380tr_init_adapter':
drivers/net/tokenring/tms380tr.c:1461: warning: long unsigned int format, different type arg (arg3)
make[3]: *** [drivers/net/tokenring/tms380tr.o] Error 1

<--  snip  -->


The following patch by Jochen Friedrich fixes both the compile error and 
the warning:


--- linux-2.5.64-notfull/drivers/net/tokenring/tms380tr.c.old	2003-03-05 21:22:59.000000000 +0100
+++ linux-2.5.64-notfull/drivers/net/tokenring/tms380tr.c	2003-03-05 21:27:18.000000000 +0100
@@ -257,7 +257,7 @@
 	int err;
 	
 	/* init the spinlock */
-	spin_lock_init(tp->lock);
+	spin_lock_init(&tp->lock);
 
 	/* Reset the hardware here. Don't forget to set the station address. */
 
@@ -1458,7 +1458,7 @@
 	if(tms380tr_debug > 3)
 	{
 		printk(KERN_DEBUG "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-		printk(KERN_DEBUG "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+		printk(KERN_DEBUG "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + (long) tp->dmabuffer);
 		printk(KERN_DEBUG "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
 		printk(KERN_DEBUG "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
 	}




Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


----- End forwarded message -----

