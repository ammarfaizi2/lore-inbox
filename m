Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTDIACh (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTDIACh (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:02:37 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:28785 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id S262627AbTDIACd (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:02:33 -0400
Date: Tue, 8 Apr 2003 20:13:41 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.67] trivial compile fix for sound/isa/sb/sb16.c
Message-ID: <Pine.LNX.4.53.0304082008130.2109@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch below fixes following compile breakage:

  gcc -Wp,-MD,sound/isa/sb/.sbawe.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=sbawe -DKBUILD_MODNAME=snd_sbawe -c -o 
sound/isa/sb/.tmp_sbawe.o sound/isa/sb/sbawe.c
In file included from sound/isa/sb/sbawe.c:2:
sound/isa/sb/sb16.c: In function `snd_card_sb16_pnp':
sound/isa/sb/sb16.c:334: structure has no member named `resource'
make[3]: *** [sound/isa/sb/sbawe.o] Error 1
make[2]: *** [sound/isa/sb] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2


John Kim

diff -Nau linux-2.5.67/sound/isa/sb/sb16.c linux-2.5.67-new/sound/isa/sb/sb16.c
--- linux-2.5.67/sound/isa/sb/sb16.c	2003-04-07 13:32:23.000000000 -0400
+++ linux-2.5.67-new/sound/isa/sb/sb16.c	2003-04-08 20:05:25.000000000 -0400
@@ -331,7 +331,7 @@
 			goto __wt_error; 
 		} 
 		awe_port[dev] = pnp_port_start(pdev, 0);
-		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
+		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pnp_port_start(pdev, 0));
 	} else {
 __wt_error:
 		if (pdev) {

