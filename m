Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTDEKKR (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 05:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbTDEKKR (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 05:10:17 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3292 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261994AbTDEKKQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 05:10:16 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 5 Apr 2003 12:21:47 +0200 (MEST)
Message-Id: <UTC200304051021.h35ALlZ23902.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] compilation fix for 2.4.21-pre7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ide/idedriver.o: In function `init_dma_generic':
drivers/ide/idedriver.o(.text+0x2d): undefined reference to `ide_setup_dma'
drivers/ide/idedriver.o: In function `ide_hwif_setup_dma':
drivers/ide/idedriver.o(.text+0x13a25): undefined reference to `ide_setup_dma'
make: *** [vmlinux] Error 1

is fixed by

diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Sat Apr  5 10:19:55 2003
+++ b/include/linux/ide.h	Sat Apr  5 11:01:58 2003
@@ -1717,6 +1717,7 @@
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #else
+static inline void ide_setup_dma(ide_hwif_t *x, unsigned long y, unsigned int z) {;}
 static inline void ide_release_dma(ide_hwif_t *x) {;}
 #endif
 

