Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275722AbSIUTs7>; Sat, 21 Sep 2002 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275934AbSIUTs7>; Sat, 21 Sep 2002 15:48:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57591 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S275722AbSIUTs6>; Sat, 21 Sep 2002 15:48:58 -0400
Date: Sat, 21 Sep 2002 21:54:01 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: R.E.Wolff@BitWizard.nl
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix drivers/char/generic_serial.c __FUNCTION__ breakage
Message-ID: <Pine.NEB.4.44.0209212151210.10334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

I got the following compile error in 2.5.37:

<--  snip  -->

...
  gcc -Wp,-MD,./.generic_serial.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.37-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.37-full/arch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=generic_serial   -c -o
generic_serial.o generic_serial.c
generic_serial.c: In function `gs_put_char':
generic_serial.c:67: called object is not a function
generic_serial.c:67: parse error before string constant
...
make[2]: *** [generic_serial.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.37-full/drivers/char'

<--  snip  -->

The following patch fixes it:

--- linux-2.5.37-full/drivers/char/generic_serial.c.old	2002-09-21 21:33:46.000000000 +0200
+++ linux-2.5.37-full/drivers/char/generic_serial.c	2002-09-21 21:34:43.000000000 +0200
@@ -41,8 +41,8 @@
 #define gs_dprintk(f, str...) /* nothing */
 #endif

-#define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter " __FUNCTION__ "\n")
-#define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  " __FUNCTION__ "\n")
+#define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter %s\n", __FUNCTION__)
+#define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  %s\n", __FUNCTION__)

 #if NEW_WRITE_LOCKING
 #define DECL      /* Nothing */


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



