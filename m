Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSKKXZv>; Mon, 11 Nov 2002 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSKKXZv>; Mon, 11 Nov 2002 18:25:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4606 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264842AbSKKXZm>; Mon, 11 Nov 2002 18:25:42 -0500
Date: Tue, 12 Nov 2002 00:32:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.47
Message-ID: <20021111233223.GB15398@fs.tum.de>
References: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 07:46:06PM -0800, Linus Torvalds wrote:

>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o tidy the 53c406, kill off old header
>...

This patch removed the header file but not the #include in the .c file
resulting in the following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/scsi/.NCR53c406a.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=NCR53c406a   -c -o
drivers/scsi/NCR53c406a.o drivers/scsi/NCR53c406a.c
drivers/scsi/NCR53c406a.c:58: NCR53c406a.h: No such file or directory
...
make[2]: *** [drivers/scsi/NCR53c406a.o] Error 1

<--  snip  -->


The following simple fix is needed:

--- linux-2.5.47/drivers/scsi/NCR53c406a.c.old	2002-11-12 00:21:27.000000000 +0100
+++ linux-2.5.47/drivers/scsi/NCR53c406a.c	2002-11-12 00:21:51.000000000 +0100
@@ -55,7 +55,6 @@
 #include <linux/spinlock.h>
 #include "scsi.h"
 #include "hosts.h"
-#include "NCR53c406a.h"
 
 /* ============================================================= */
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

