Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263650AbTCVROf>; Sat, 22 Mar 2003 12:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263646AbTCVROf>; Sat, 22 Mar 2003 12:14:35 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:56103 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S263380AbTCVROd>; Sat, 22 Mar 2003 12:14:33 -0500
Date: Sat, 22 Mar 2003 12:24:07 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH 2.5.65-bk3] compile fix for drivers/media/dvb/dvb-core/dvbdev.c
Message-ID: <Pine.LNX.4.53.0303221217380.10913@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch below fixes following compile breakage:

  gcc -Wp,-MD,drivers/media/dvb/dvb-core/.dvbdev.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=dvbdev -DKBUILD_MODNAME=dvb_core -c -o 
drivers/media/dvb/dvb-core/.tmp_dvbdev.o 
drivers/media/dvb/dvb-core/dvbdev.c
drivers/media/dvb/dvb-core/dvbdev.c:114:2: #endif without #if
make[4]: *** [drivers/media/dvb/dvb-core/dvbdev.o] Error 1
make[3]: *** [drivers/media/dvb/dvb-core] Error 2
make[2]: *** [drivers/media/dvb] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

John Kim



diff -Nau linux-2.5.65-bk3/drivers/media/dvb/dvb-core/dvbdev.c 
linux-2.5.65-bk3-new/drivers/media/dvb/dvb-core/dvbdev.c
--- linux-2.5.65-bk3/drivers/media/dvb/dvb-core/dvbdev.c	2003-03-22 08:21:27.000000000 -0500
+++ linux-2.5.65-bk3-new/drivers/media/dvb/dvb-core/dvbdev.c	2003-03-22 12:14:58.000000000 -0500
@@ -111,8 +111,6 @@
 	.owner =	THIS_MODULE,
 	.open =		dvb_device_open,
 };
-#endif /* CONFIG_DVB_DEVFS_ONLY */
-
 
 
 int dvb_generic_open(struct inode *inode, struct file *file)
