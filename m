Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbTCSMQn>; Wed, 19 Mar 2003 07:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262987AbTCSMQn>; Wed, 19 Mar 2003 07:16:43 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:9863 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262981AbTCSMQm>;
	Wed, 19 Mar 2003 07:16:42 -0500
Date: Wed, 19 Mar 2003 13:27:43 +0100 (MET)
Message-Id: <200303191227.h2JCRht00898@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] IDE_ARCH_ACK_INTR duplicate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide_ack_intr is defined in asm-*/ide.h, if IDE_ARCH_ACK_INTR is set.

--- linux-2.5.x/include/linux/ide.h	Tue Feb 25 10:21:55 2003
+++ linux-m68k-2.5.x/include/linux/ide.h	Wed Feb 26 12:09:13 2003
@@ -341,10 +341,7 @@
 #include <asm/ide.h>
 
 /* Currently only m68k, apus and m8xx need it */
-#ifdef IDE_ARCH_ACK_INTR
-extern int ide_irq_lock;
-# define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
-#else
+#ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
