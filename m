Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290081AbSAWVKi>; Wed, 23 Jan 2002 16:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290102AbSAWVK2>; Wed, 23 Jan 2002 16:10:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:6885 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S290081AbSAWVKK>; Wed, 23 Jan 2002 16:10:10 -0500
Date: Wed, 23 Jan 2002 22:08:05 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: claus@momo.math.rwth-aachen.de
cc: linux-kernel@vger.kernel.org
Subject: [patch] remove a workaround for gcc-2.4.5
Message-ID: <Pine.NEB.4.44.0201232200370.14017-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claus-Justus,

the patch below removes a workaround for gcc-2.4.5.  Since a long time
passed since this compiler was supported the last time this could be IMHO
removed from the 2.2/2.4/2.5 kernels.

cu
Adrian


--- drivers/char/ftape/lowlevel/fdc-io.c.old	Wed Jan 23 21:59:13 2002
+++ drivers/char/ftape/lowlevel/fdc-io.c	Wed Jan 23 22:00:39 2002
@@ -928,18 +928,6 @@
 	set_dma_mode(fdc.dma, mode);
 	set_dma_addr(fdc.dma, virt_to_bus((void*)addr));
 	set_dma_count(fdc.dma, count);
-#ifdef GCC_2_4_5_BUG
-	/*  This seemingly stupid construction confuses the gcc-2.4.5
-	 *  code generator enough to create correct code.
-	 */
-	if (1) {
-		int i;
-
-		for (i = 0; i < 1; ++i) {
-			ftape_udelay(1);
-		}
-	}
-#endif
 	enable_dma(fdc.dma);
 }



