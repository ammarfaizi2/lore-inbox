Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbSIUT2P>; Sat, 21 Sep 2002 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263627AbSIUT2O>; Sat, 21 Sep 2002 15:28:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3064 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263374AbSIUT2O>; Sat, 21 Sep 2002 15:28:14 -0400
Date: Sat, 21 Sep 2002 21:33:16 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: R.E.Wolff@BitWizard.nl
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix drivers/char/sx.c __FUNCTION__ breakage
Message-ID: <Pine.NEB.4.44.0209212128380.10334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

I got the following compile error in 2.5.37:

<--  snip  -->

...
  gcc -Wp,-MD,./.sx.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.37-
full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -I/home/bunk/linux/kernel-2.5/linux-2.5.37-full/arch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=sx   -c -o sx.o sx.c
sx.c: In function `sx_busy_wait_eq':
sx.c:521: called object is not a function
sx.c:521: parse error before string constant
...
make[2]: *** [sx.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.37-full/drivers/char'

<--  snip  -->

The following patch fixes it:

--- linux-2.5.37-full/drivers/char/sx.c.old	2002-09-21 21:15:08.000000000 +0200
+++ linux-2.5.37-full/drivers/char/sx.c	2002-09-21 21:23:23.000000000 +0200
@@ -405,11 +405,11 @@



-#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ "\n")
-#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  " __FUNCTION__ "\n")
+#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", __FUNCTION__)
+#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  %s\n", __FUNCTION__)

-#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ \
-                                  "(port %d)\n", port->line)
+#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s (port %d)\n", \
+                                  __FUNCTION__ , port->line)




cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


