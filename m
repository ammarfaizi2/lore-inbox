Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSFDMlF>; Tue, 4 Jun 2002 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSFDMlE>; Tue, 4 Jun 2002 08:41:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:15573 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316601AbSFDMlD>; Tue, 4 Jun 2002 08:41:03 -0400
Date: Tue, 4 Jun 2002 14:41:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: linux-kernel@vger.kernel.org
Subject: sis_main.c compile error in 2.4.19-pre10
Message-ID: <Pine.NEB.4.44.0206041329370.8847-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

compiling sis_main.c failed for me in sis_main.c with the following error:

<-- snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/i
nclude -DKBUILD_BASENAME=sis_main  -c -o sis_main.o sis_main.c
sis_main.c: In function `sisfb_init':
sis_main.c:3273: structure has no member named `mtrr'
sis_main.c:3276: structure has no member named `mtrr'
make[4]: *** [sis_main.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-full/drivers/video/sis'

<--  snip  -->


It seems the following patch that from 2.4.19-pre9-ac3 is needed?


--- linux.19pre9/include/linux/sisfb.h	Wed May 29 14:44:43 2002
+++ linux.19pre9-ac3/include/linux/sisfb.h	Thu May  9 22:40:52 2002
@@ -89,6 +90,7 @@
 	unsigned long mmio_base;
 	char  *mmio_vbase;
 	unsigned long vga_base;
+	unsigned long mtrr;

 	int    video_bpp;
 	int    video_width;

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


