Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbTCDKKD>; Tue, 4 Mar 2003 05:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269355AbTCDKKC>; Tue, 4 Mar 2003 05:10:02 -0500
Received: from hera.cwi.nl ([192.16.191.8]:13450 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269354AbTCDKKB>;
	Tue, 4 Mar 2003 05:10:01 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 4 Mar 2003 11:20:29 +0100 (MET)
Message-Id: <UTC200303041020.h24AKTA23975.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH?] ide_setup_dma undefined
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If one compiles 2.4.21-pre5 without CONFIG_BLK_DEV_IDEDMA_PCI
the compilation fails with undefined ide_setup_dma().
And indeed, ide_setup_dma is called in ide_hwif_setup_dma
in setup-pci.c.

One of the ways to make the kernel compile with this config is

--- ../../linux-2.4.21-pre5/linux/include/linux/ide.h	Tue Mar  4 02:25:12 2003
+++ include/linux/ide.h	Tue Mar  4 11:07:32 2003
@@ -1719,6 +1719,7 @@
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #else
+static inline void ide_setup_dma(ide_hwif_t *x, unsigned long y, unsigned int z) {;}
 static inline void ide_release_dma(ide_hwif_t *x) {;}
 #endif
 

Andries


[much larger changes might be appropriate]
