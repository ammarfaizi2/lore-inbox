Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319316AbSHNWHn>; Wed, 14 Aug 2002 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319319AbSHNWHn>; Wed, 14 Aug 2002 18:07:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24271 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319316AbSHNWHm>; Wed, 14 Aug 2002 18:07:42 -0400
Date: Thu, 15 Aug 2002 00:11:29 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
In-Reply-To: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208142359070.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Alan Cox wrote:

>...
> Linux 2.4.20-pre2-ac1
>...
> o	Clean up locking a little in ps2esdi		(me)
> 	| This driver needs much love and attention
>...

It doesn't compile:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.19-full-nohotplug/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=ps2esdi  -c
-o ps2esdi.o ps2esdi.c
ps2esdi.c: In function `ps2esdi_readwrite':
ps2esdi.c:583: `io_request_irq' undeclared (first use in this function)
ps2esdi.c:583: (Each undeclared identifier is reported only once
ps2esdi.c:583: for each function it appears in.)
make[3]: *** [ps2esdi.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full-nohotplug/drivers/block'

<--  snip  -->


It seems the following was intended?


--- drivers/block/ps2esdi.c.old	2002-08-15 00:01:33.000000000 +0200
+++ drivers/block/ps2esdi.c	2002-08-15 00:02:52.000000000 +0200
@@ -580,10 +580,10 @@
 	     cylinder, head, sector,
 	     CURRENT->current_nr_sectors, drive);

-	spin_unlock_irq(&io_request_irq);
+	spin_unlock_irq(&io_request_lock);
 	/* send the command block to the controller */
 	err = ps2esdi_out_cmd_blk(cmd_blk);
-	spin_lock_irq(&io_request_irq);
+	spin_lock_irq(&io_request_lock);

 	if (err) {
 		printk(KERN_ERR "%s: Controller failed\n", DEVICE_NAME);


cu
Adrian


