Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTHWMXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTHWMWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:22:13 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:12524 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263956AbTHWMWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:22:04 -0400
Date: Sat, 23 Aug 2003 14:21:51 +0200 (MEST)
Message-Id: <200308231221.h7NCLp0m017908@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: [PATCH] 2.6.0-test4 PowerMac IDE breakage
Cc: linux-kernel@vger.kernel.org, linuxppc-devel@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerMac's IDE driver got broken in 2.6.0-test4:

  ppc-unknown-linux-gcc -Wp,-MD,drivers/ide/ppc/.pmac.o.d -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -D__KERNEL__ -Iinclude -Iarch/ppc -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include  -Idrivers/ide  -DKBUILD_BASENAME=pmac -DKBUILD_MODNAME=pmac -c -o drivers/ide/ppc/pmac.o drivers/ide/ppc/pmac.c
drivers/ide/ppc/pmac.c: In function `pmac_ide_build_sglist':
drivers/ide/ppc/pmac.c:945: warning: passing arg 1 of `blk_rq_map_sg' from incompatible pointer type

Fixed by the patch below.

/Mikael

diff -ruN linux-2.6.0-test4/drivers/ide/ppc/pmac.c linux-2.6.0-test4.ide-pmac-fix/drivers/ide/ppc/pmac.c
--- linux-2.6.0-test4/drivers/ide/ppc/pmac.c	2003-08-23 12:46:26.000000000 +0200
+++ linux-2.6.0-test4.ide-pmac-fix/drivers/ide/ppc/pmac.c	2003-08-23 13:04:32.000000000 +0200
@@ -942,7 +942,7 @@
 	if (hwif->sg_dma_active)
 		BUG();
 		
-	nents = blk_rq_map_sg(&drive->queue, rq, sg);
+	nents = blk_rq_map_sg(drive->queue, rq, sg);
 		
 	if (rq_data_dir(rq) == READ)
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
