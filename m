Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTBPLSd>; Sun, 16 Feb 2003 06:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTBPLSd>; Sun, 16 Feb 2003 06:18:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22998 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266356AbTBPLSb>; Sun, 16 Feb 2003 06:18:31 -0500
Date: Sun, 16 Feb 2003 12:28:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] isdn_net_lib.c must include isdn_concap.h
Message-ID: <20030216112823.GB20159@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_ISDN_X25 enabled I got the following compile error in 
isdn_net_lib.c in 2.5.61:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/isdn/i4l/.isdn_net_lib.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=isdn_net_lib -DKBUILD_MODNAME=isdn -c -o 
drivers/isdn/i4l/isdn_net_lib.o drivers/isdn/i4l/isdn_net_lib.c
...
drivers/isdn/i4l/isdn_net_lib.c: In function `isdn_net_lib_init':
drivers/isdn/i4l/isdn_net_lib.c:2330: `isdn_x25_ops' undeclared (first 
use in this function)
drivers/isdn/i4l/isdn_net_lib.c:2330: (Each undeclared identifier is 
reported only once
drivers/isdn/i4l/isdn_net_lib.c:2330: for each function it appears in.)
make[3]: *** [drivers/isdn/i4l/isdn_net_lib.o] Error 1

<--  snip  -->

The following patch solved it for me:

--- linux-2.5.61-full/drivers/isdn/i4l/isdn_net_lib.c.old	2003-02-16 12:22:56.000000000 +0100
+++ linux-2.5.61-full/drivers/isdn/i4l/isdn_net_lib.c	2003-02-16 12:24:39.000000000 +0100
@@ -58,6 +58,7 @@
 #include "isdn_net.h"
 #include "isdn_ppp.h"
 #include "isdn_ciscohdlck.h"
+#include "isdn_concap.h"
 
 #define ISDN_NET_TX_TIMEOUT (20*HZ) 
 


cu
Adrian


