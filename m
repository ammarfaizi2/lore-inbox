Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUFKQZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUFKQZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUFKQUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:20:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14233 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264154AbUFKQQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:19 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [3/12]
Date: Fri, 11 Jun 2004 17:52:22 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111752.22552.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: ide-proc fix for m68k

From: Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, 29 May 2004, Linus Torvalds wrote:
> Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
> ============================================
>
> Alexander Viro:
>   o sparse: ide-proc.c fixes

This change causes 2 warnings (unused variables `val' and `reg') on m68k
and APUS.  However, the reason why this code was commented out is gone.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-proc.c |   22 ----------------------
 1 files changed, 22 deletions(-)

diff -puN drivers/ide/ide-proc.c~ide_proc_m68k drivers/ide/ide-proc.c
--- linux-2.6.7-rc3/drivers/ide/ide-proc.c~ide_proc_m68k	2004-06-11 15:47:31.554647472 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-proc.c	2004-06-11 15:48:21.319082128 +0200
@@ -233,27 +233,6 @@ static int proc_ide_write_config(struct 
 			}
 #endif	/* CONFIG_BLK_DEV_IDEPCI */
 		} else {	/* not pci */
-#if !defined(__mc68000__) && !defined(CONFIG_APUS)
-
-/*
-* Geert Uytterhoeven
-*
-* unless you can explain me what it really does.
-* On m68k, we don't have outw() and outl() yet,
-* and I need a good reason to implement it.
-* 
-* BTW, IMHO the main remaining portability problem with the IDE driver 
-* is that it mixes IO (ioport) and MMIO (iomem) access on different platforms.
-* 
-* I think all accesses should be done using
-* 
-*     ide_in[bwl](ide_device_instance, offset)
-*     ide_out[bwl](ide_device_instance, value, offset)
-* 
-* so the architecture specific code can #define ide_{in,out}[bwl] to the
-* appropriate function.
-* 
-*/
 			switch (r->size) {
 				case 1:	hwif->OUTB(val, reg);
 					break;
@@ -262,7 +241,6 @@ static int proc_ide_write_config(struct 
 				case 4:	hwif->OUTL(val, reg);
 					break;
 			}
-#endif /* !__mc68000__ && !CONFIG_APUS */
 		}
 	}
 	spin_unlock_irqrestore(&ide_lock, flags);

_

