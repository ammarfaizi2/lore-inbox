Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSJ1Ugl>; Mon, 28 Oct 2002 15:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJ1Ugl>; Mon, 28 Oct 2002 15:36:41 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:64332 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261339AbSJ1Ugl>; Mon, 28 Oct 2002 15:36:41 -0500
Date: Sat, 28 Sep 2002 22:42:11 +0200
Message-Id: <200209282042.g8SKgB81001275@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IDE lock fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k IDE lock fixes:
  - Kill warning: ide_{get,release}_lock() can be real routines only if
    IDE_ARCH_LOCK is defined, the same is true for ide_intr_lock
  - Use the correct lock for ide_{get,release}_lock()

--- linux-2.5.44/drivers/ide/ide.c	Wed Sep 18 10:36:42 2002
+++ linux-m68k-2.5.44/drivers/ide/ide.c	Wed Sep 18 10:48:17 2002
@@ -181,13 +181,13 @@
 
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
 
-#if defined(__mc68000__) || defined(CONFIG_APUS)
+#ifdef IDE_ARCH_LOCK
 /*
  * ide_lock is used by the Atari code to obtain access to the IDE interrupt,
  * which is shared between several drivers.
  */
 static int	ide_intr_lock;
-#endif /* __mc68000__ || CONFIG_APUS */
+#endif /* IDE_ARCH_LOCK */
 
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;
@@ -1097,7 +1097,7 @@
 				 */
 
 				/* for atari only */
-				ide_release_lock(&ide_lock);
+				ide_release_lock(&ide_intr_lock);
 				hwgroup->busy = 0;
 			}
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

