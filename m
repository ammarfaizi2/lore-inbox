Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265231AbSJRQoQ>; Fri, 18 Oct 2002 12:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSJRQoQ>; Fri, 18 Oct 2002 12:44:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16347 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265226AbSJRQoP>; Fri, 18 Oct 2002 12:44:15 -0400
Date: Fri, 18 Oct 2002 18:50:10 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Patrick van de Lageweg <patrick@bitwizard.nl>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] don't #include tqueue.h in rio_linux.c
Message-ID: <Pine.NEB.4.44.0210181846250.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compilation of rio_linux.c fails in 2.5.43 with the following error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/char/rio/.rio_linux.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=rio_linux   -c -o
drivers/char/rio/rio_linux.o drivers/char/rio/rio_linux.c
drivers/char/rio/rio_linux.c:56: linux/tqueue.h: No such file or directory
make[3]: *** [drivers/char/rio/rio_linux.o] Error 1

<--  snip  -->


With the following patch that removes the #include <linux/tqueue.h> it
compiles without errors or warnings:


--- linux-2.5.43-full/drivers/char/rio/rio_linux.c.old	2002-10-18 18:42:26.000000000 +0200
+++ linux-2.5.43-full/drivers/char/rio/rio_linux.c	2002-10-18 18:42:44.000000000 +0200
@@ -53,7 +53,6 @@
 #include <linux/fcntl.h>
 #include <linux/major.h>
 #include <linux/delay.h>
-#include <linux/tqueue.h>
 #include <linux/version.h>
 #include <linux/pci.h>
 #include <linux/slab.h>


cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed



