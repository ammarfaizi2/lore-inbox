Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264736AbSJ3QqW>; Wed, 30 Oct 2002 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264738AbSJ3QqW>; Wed, 30 Oct 2002 11:46:22 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:23548 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264736AbSJ3QqV>;
	Wed, 30 Oct 2002 11:46:21 -0500
Date: Wed, 30 Oct 2002 17:52:39 +0100 (MET)
Message-Id: <200210301652.g9UGqdc11582@vervain.sonytel.be>
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

--- linux-2.5.x-bk-20021030/drivers/ide/ide.c	Wed Sep 18 10:36:42 2002
+++ linux-m68k-2.5.x/drivers/ide/ide.c	Wed Sep 18 10:48:17 2002
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
