Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTEKK0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbTEKKZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:25:02 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:47408 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261249AbTEKKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:40 -0400
Date: Sun, 11 May 2003 12:31:01 +0200
Message-Id: <200305111031.h4BAV159019688@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k kill ide_ioreg_t
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k IDE: kill ide_ioreg_t and q40ide_ioreg_t

--- linux-2.5.x/include/asm-m68k/hdreg.h	Thu May 13 20:00:09 1999
+++ linux-m68k-2.5.x/include/asm-m68k/hdreg.h	Sun Mar 30 23:01:52 2003
@@ -7,7 +7,5 @@
 #ifndef _M68K_HDREG_H
 #define _M68K_HDREG_H
 
-typedef unsigned int   q40ide_ioreg_t;
-typedef unsigned char * ide_ioreg_t;
 
 #endif /* _M68K_HDREG_H */
--- linux-2.5.x/include/asm-m68k/ide.h	Thu Mar 27 10:58:22 2003
+++ linux-m68k-2.5.x/include/asm-m68k/ide.h	Wed Feb 26 14:03:24 2003
@@ -51,12 +51,12 @@
 #endif
 
 
-static __inline__ int ide_default_irq(ide_ioreg_t base)
+static __inline__ int ide_default_irq(unsigned long base)
 {
 	  return 0;
 }
 
-static __inline__ ide_ioreg_t ide_default_io_base(int index)
+static __inline__ unsigned long ide_default_io_base(int index)
 {
           return 0;
 }
@@ -66,7 +66,9 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static __inline__ void ide_init_hwif_ports(hw_regs_t *hw,
+					   unsigned long data_port,
+					   unsigned long ctrl_port, int *irq)
 {
 	if (data_port || ctrl_port)
 		printk("ide_init_hwif_ports: must not be called\n");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
