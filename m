Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbTCZKGN>; Wed, 26 Mar 2003 05:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbTCZKGN>; Wed, 26 Mar 2003 05:06:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15300 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261242AbTCZKGM>; Wed, 26 Mar 2003 05:06:12 -0500
Date: Wed, 26 Mar 2003 11:17:19 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.66: 3w-(censored).c doesn's compile
Message-ID: <20030326101719.GH24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 03:26:47PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.65 to v2.5.66
> ============================================
>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o clean up the mess someone merged into 3wxxx scsi
>...

This change broke the compilation:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/scsi/.3w-xxxx.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=3w_xxxx -DKBUILD_MODNAME=3w_xxxx -c -o 
drivers/scsi/3w-xxxx.o drivers/scsi/3w-xxxx.c
drivers/scsi/3w-xxxx.c: In function `tw_chrdev_ioctl':
drivers/scsi/3w-xxxx.c:680: request for member `magic' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `lock' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `babble' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `module' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `owner' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `oline' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `babble' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `lock' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `owner' in something not a structure or union
drivers/scsi/3w-xxxx.c:680: request for member `oline' in something not a structure or union
make[2]: *** [drivers/scsi/3w-xxxx.o] Error 1

<--  snip  -->


It seems something like the following was intended?


--- linux-2.5.66-notfull/drivers/scsi/3w-xxxx.c.old	2003-03-26 10:58:34.000000000 +0100
+++ linux-2.5.66-notfull/drivers/scsi/3w-xxxx.c	2003-03-26 11:06:33.000000000 +0100
@@ -677,7 +677,7 @@
 			dprintk(KERN_WARNING "3w-xxxx: tw_chrdev_ioctl(): caught TW_AEN_LISTEN.\n");
 			memset(tw_ioctl->data_buffer, 0, tw_ioctl->data_buffer_length);
 
-			spin_lock_irqsave(&tw_dev->host->host_lock, flags);
+			spin_lock_irqsave(&tw_dev->tw_lock, flags);
 			if (tw_dev->aen_head == tw_dev->aen_tail) {
 				tw_aen_code = TW_AEN_QUEUE_EMPTY;
 			} else {



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

