Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262965AbTCSI3N>; Wed, 19 Mar 2003 03:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262968AbTCSI3N>; Wed, 19 Mar 2003 03:29:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11489 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262965AbTCSI3L>; Wed, 19 Mar 2003 03:29:11 -0500
Date: Wed, 19 Mar 2003 09:40:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.65-mjb1: lkcd: dump_filters.c needs asm/system.h
Message-ID: <20030319084005.GB23258@fs.tum.de>
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


<--  snip  -->

...
  gcc-2.95 -Wp,-MD,drivers/dump/.dump_filters.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=dump_filters 
-DKBUILD_MODNAME=dump -c -o drivers/dump/dump_filters.o 
drivers/dump/dump_filters.c
In file included from include/asm/pgtable.h:43,
                 from include/linux/bootmem.h:7,
                 from drivers/dump/dump_filters.c:24:
include/asm/pgtable-3level.h: In function `set_pte':
include/asm/pgtable-3level.h:49: warning: implicit declaration of 
function `smp_wmb'
include/asm/pgtable-3level.h: In function `ptep_get_and_clear':
include/asm/pgtable-3level.h:79: warning: implicit declaration of 
function `xchg'
...

<--   snip  -->


I don't know the correct fix, my solution was:


--- linux-2.5.65-mjb1/drivers/dump/dump_filters.c.old	2003-03-19 09:34:00.000000000 +0100
+++ linux-2.5.65-mjb1/drivers/dump/dump_filters.c	2003-03-19 09:36:46.000000000 +0100
@@ -21,6 +21,7 @@
  */
 
 #include <linux/kernel.h>
+#include <asm/system.h>
 #include <linux/bootmem.h>
 #include <linux/mm.h>
 #include <linux/slab.h>



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

