Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272506AbTGZOlO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTGZOfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:04 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:48478 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272509AbTGZOcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:35 -0400
Date: Sat, 26 Jul 2003 16:51:38 +0200
Message-Id: <200307261451.h6QEpcSG002298@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k floppy warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k floppy: Kill warnings when compiling a multi-platform kernel

--- linux-2.6.x/include/asm-m68k/floppy.h	Sat Mar  2 15:09:54 2002
+++ linux-m68k-2.6.x/include/asm-m68k/floppy.h	Fri Jun  6 18:49:51 2003
@@ -72,6 +72,7 @@
 		return inb_p(port);
 	else if(MACH_IS_SUN3X)
 		return sun3x_82072_fd_inb(port);
+	return 0;
 }
 
 static __inline__ void fd_outb(unsigned char value, int port)
@@ -88,9 +89,9 @@
 	if(MACH_IS_Q40)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
 						   "floppy", floppy_hardint);
-	else if(MACH_IS_SUN3X) 
+	else if(MACH_IS_SUN3X)
 		return sun3xflop_request_irq();
-	
+	return -ENXIO;
 }
 
 static void fd_free_irq(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
