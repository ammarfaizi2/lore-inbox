Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbSJaLMA>; Thu, 31 Oct 2002 06:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbSJaLMA>; Thu, 31 Oct 2002 06:12:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25565 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264830AbSJaLL6>; Thu, 31 Oct 2002 06:11:58 -0500
Date: Thu, 31 Oct 2002 12:18:20 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210311214210.10655-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.44 to v2.5.45
> ============================================
>...
> Alexander Viro <viro@math.psu.edu>:
>...
>   o ps2esdi
>...


This patch changed the parameters of ps2esdi_readwrite but didn't change
the function prototype resulting in the following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/block/.ps2esdi.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=ps2esdi   -c -o
drivers/block/ps2esdi.o drivers/block/ps2esdi.c
...
drivers/block/ps2esdi.c:566: conflicting types for `ps2esdi_readwrite'
drivers/block/ps2esdi.c:77: previous declaration of `ps2esdi_readwrite'
make[2]: *** [drivers/block/ps2esdi.o] Error 1

<--  snip   -->


The fix is simple:


--- linux-2.5.45-full/drivers/block/ps2esdi.c.old	2002-10-31 11:42:27.000000000 +0100
+++ linux-2.5.45-full/drivers/block/ps2esdi.c	2002-10-31 12:11:50.000000000 +0100
@@ -74,7 +74,7 @@

 static void do_ps2esdi_request(request_queue_t * q);

-static void ps2esdi_readwrite(int cmd, u_char drive, u_int block, u_int count);
+static void ps2esdi_readwrite(int cmd, struct request *req);

 static void ps2esdi_fill_cmd_block(u_short * cmd_blk, u_short cmd,
 u_short cyl, u_short head, u_short sector, u_short length, u_char drive);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


