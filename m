Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFTKXk>; Thu, 20 Jun 2002 06:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSFTKXj>; Thu, 20 Jun 2002 06:23:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51147 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313416AbSFTKXi>; Thu, 20 Jun 2002 06:23:38 -0400
Date: Thu, 20 Jun 2002 12:23:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jaroslav Kysela <perex@suse.cz>, <alsa-devel@alsa-project.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compilation of ad1848_lib.c
Message-ID: <Pine.NEB.4.44.0206201220430.22563-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile error in 2.5.23:

<--  snip  -->

...
  gcc -Wp,-MD,./.ad1848_lib.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux
-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=ad1848_lib   -c -o
ad1848_lib.o ad1848_lib.c
ad1848_lib.c:1171: parse error before `alsa_ad1848_init'
ad1848_lib.c:1172: warning: return-type defaults to `int'
ad1848_lib.c:1176: parse error before `alsa_ad1848_exit'
ad1848_lib.c:1177: warning: return-type defaults to `int'
ad1848_lib.c: In function `alsa_ad1848_exit':
ad1848_lib.c:1178: warning: control reaches end of non-void function
ad1848_lib.c: At top level:
ad1848_lib.c:1181: parse error before `module_exit'
ad1848_lib.c:1182: parse error at end of input
make[3]: *** [ad1848_lib.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23/sound/isa/ad1848'

<--  snip  -->


The problem is that linux/init.h is needed for __init.

The fix is simple:


--- sound/isa/ad1848/ad1848_lib.c.old	Thu Jun 20 12:03:47 2002
+++ sound/isa/ad1848/ad1848_lib.c	Thu Jun 20 12:04:15 2002
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

