Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSKRN7c>; Mon, 18 Nov 2002 08:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSKRN7b>; Mon, 18 Nov 2002 08:59:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10964 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262648AbSKRN7a>; Mon, 18 Nov 2002 08:59:30 -0500
Date: Mon, 18 Nov 2002 15:06:27 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] don't include non-existant NCR53c406a.h
Message-ID: <20021118140626.GF11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch I sent in the mail below is still needed in 2.5.48.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Tue, 12 Nov 2002 00:32:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
    Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.47

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
