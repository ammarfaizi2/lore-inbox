Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSFUIaN>; Fri, 21 Jun 2002 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSFUIaM>; Fri, 21 Jun 2002 04:30:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:16372 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316465AbSFUIaM>; Fri, 21 Jun 2002 04:30:12 -0400
Date: Fri, 21 Jun 2002 10:30:09 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] i2o_proc.c mneeds tqueue.h
Message-ID: <Pine.NEB.4.44.0206210932530.22563-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below is needed in 2.5.24-dj1 (and most likely also in 2.5.24)
to fix the following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,./.i2o_proc.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2
.5.24-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=i2o_proc   -c -o i2o_proc.o i2o_proc.c
In file included from i2o_proc.c:55:
i2o_lan.h:139: field `i2o_batch_send_task' has incomplete type
make[3]: *** [i2o_proc.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.24-full/drivers/message/i2o'

<--  snip  -->


--- drivers/message/i2o/i2o_proc.c.old	Fri Jun 21 09:23:14 2002
+++ drivers/message/i2o/i2o_proc.c	Fri Jun 21 09:24:18 2002
@@ -47,6 +47,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
+#include <linux/tqueue.h>

 #include <asm/io.h>
 #include <asm/uaccess.h>

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


