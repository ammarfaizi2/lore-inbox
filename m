Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTDIAFG (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTDIAFG (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:05:06 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:34673 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id S262629AbTDIAFE (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:05:04 -0400
Date: Tue, 8 Apr 2003 20:16:13 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.67] trivial compile fix for sound/oss/mad16.c
Message-ID: <Pine.LNX.4.53.0304082013440.2109@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch below fixes following compile breakage:

  gcc -Wp,-MD,sound/oss/.mad16.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=mad16 -DKBUILD_MODNAME=mad16 -c -o 
sound/oss/.tmp_mad16.o sound/oss/mad16.c
sound/oss/mad16.c: In function `wss_init':
sound/oss/mad16.c:322: warning: `__check_region' is deprecated (declared 
at include/linux/ioport.h:113)
sound/oss/mad16.c: In function `probe_mad16':
sound/oss/mad16.c:541: parse error before "else"
sound/oss/mad16.c:604: parse error before "else"
make[2]: *** [sound/oss/mad16.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2


John Kim

diff -Nau linux-2.5.67/sound/oss/mad16.c linux-2.5.67-new/sound/oss/mad16.c
--- linux-2.5.67/sound/oss/mad16.c	2003-04-07 13:32:18.000000000 -0400
+++ linux-2.5.67-new/sound/oss/mad16.c	2003-04-08 16:59:01.000000000 -0400
@@ -537,7 +537,7 @@
 
 	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x = %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x = %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x = %02x\n", i-0x80, mad_read(i)));
 	}
@@ -600,7 +600,7 @@
 
 	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x after init = %02x\n", i-0x80, mad_read(i)));
 	}
