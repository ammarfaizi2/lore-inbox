Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSK1AOa>; Wed, 27 Nov 2002 19:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSK1AOa>; Wed, 27 Nov 2002 19:14:30 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29688 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264956AbSK1AO3>; Wed, 27 Nov 2002 19:14:29 -0500
Date: Thu, 28 Nov 2002 01:21:47 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc4-ac1
Message-ID: <20021128002147.GS21307@fs.tum.de>
References: <200211261901.gAQJ13T11036@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211261901.gAQJ13T11036@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__  -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full-ac/include -Wal
l -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -I.  -nostdinc -iwithprefix
include -DKBUILD_BASENAME=mptlan  -c -o mptlan.o mptlan.c
In file included from mptlan.c:75:
mptlan.h:23: parse error
mptlan.h:26: linux/workqueue.h: No such file or directory
make[3]: *** [mptlan.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full-ac/drivers/message/fusion'

<--  snip  -->


The fix is simple:


--- linux-2.4.19-full-ac/drivers/message/fusion/mptlan.h.old	2002-11-28 01:17:01.000000000 +0100
+++ linux-2.4.19-full-ac/drivers/message/fusion/mptlan.h	2002-11-28 01:17:28.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
 #include <linux/spinlock.h>
+#include <linux/version.h>
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,41)
 #include <linux/tqueue.h>
 #else



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

