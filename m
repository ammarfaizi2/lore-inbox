Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262946AbTCSITd>; Wed, 19 Mar 2003 03:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbTCSITd>; Wed, 19 Mar 2003 03:19:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22241 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262946AbTCSITb>; Wed, 19 Mar 2003 03:19:31 -0500
Date: Wed, 19 Mar 2003 09:30:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.65-mjb1: lkcd: fix dump_fmt.c for !CONFIG_SMP
Message-ID: <20030319083025.GA23258@fs.tum.de>
References: <8230000.1047975763@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8230000.1047975763@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 12:22:43AM -0800, Martin J. Bligh wrote:
>...
> lkcd						LKCD team
> 	Linux kernel crash dump support
>...

I got the following compile error for !CONFIG_SMP:

<--  snip  -->

...
  gcc-2.95 -Wp,-MD,drivers/dump/.dump_fmt.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=dump_fmt -DKBUILD_MODNAME=dump 
-c -o drivers/dump/dump_fmt.o drivers/dump/dump_fmt.c
drivers/dump/dump_fmt.c:171: macro `__dump_save_other_cpus' used without args
make[2]: *** [drivers/dump/dump_fmt.o] Error 1

<--  snip  -->


Trivial fix:


--- linux-2.5.65-mjb1/include/linux/dump.h~	2003-03-18 17:09:59.000000000 +0100
+++ linux-2.5.65-mjb1/include/linux/dump.h	2003-03-19 09:24:43.000000000 +0100
@@ -343,7 +343,7 @@
 #ifdef CONFIG_SMP
 extern void 	__dump_save_other_cpus(void);
 #else
-#define 	__dump_save_other_cpus(void)
+#define 	__dump_save_other_cpus()
 #endif
 
 #endif /* __KERNEL__ */


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

