Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUBJQMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUBJQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:12:35 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7394 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265971AbUBJQM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:12:28 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.3-rc2
Date: Tue, 10 Feb 2004 17:17:14 +0100
User-Agent: KMail/1.5.3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org> <Pine.GSO.4.58.0402101352320.2261@waterleaf.sonytel.be> <200402101558.59344.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402101558.59344.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402101717.14934.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It fails with `unterminated `#if' conditional'.

Please pass me brown paper bag...

[PATCH] fix build for CONFIG_BLK_DEV_IDEDMA=n

"fix duplication of DMA {black,white}list in icside.c" patch broke it.

Noticed by Geert Uytterhoeven <geert@linux-m68k.org>.

 linux-2.6.3-rc2-root/include/linux/ide.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN include/linux/ide.h~ide_release_dma_fix include/linux/ide.h
--- linux-2.6.3-rc2/include/linux/ide.h~ide_release_dma_fix	2004-02-10 16:30:48.085986376 +0100
+++ linux-2.6.3-rc2-root/include/linux/ide.h	2004-02-10 16:35:38.959766840 +0100
@@ -1626,6 +1626,7 @@ extern int __ide_dma_count(ide_drive_t *
 extern int __ide_dma_verbose(ide_drive_t *);
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
 extern int __ide_dma_queued_on(ide_drive_t *drive);
@@ -1634,13 +1635,12 @@ extern ide_startstop_t __ide_dma_queued_
 extern ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive);
 extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
 #endif
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 
-#else
+#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
 static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif
 
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);

_

