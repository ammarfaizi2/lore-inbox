Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbSKKQq3>; Mon, 11 Nov 2002 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSKKQq3>; Mon, 11 Nov 2002 11:46:29 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:37088 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265786AbSKKQq2>;
	Mon, 11 Nov 2002 11:46:28 -0500
Date: Mon, 11 Nov 2002 17:52:30 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andre M. Hedrick" <andre@linux-ide.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE out*() confusing argument names
Message-ID: <Pine.GSO.4.21.0211111749060.21501-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix confusing arguments in the IDE access routines. The first arguments of the
out*() routines are not addresses but values.

BTW, I find it funny that the ide_mm_out*() routines are less confusing ;-)

--- linux-2.5.47/drivers/ide/ide-iops.c	Mon Oct  7 22:04:22 2002
+++ linux-m68k-2.5.47/drivers/ide/ide-iops.c	Mon Nov 11 15:02:43 2002
@@ -57,14 +57,14 @@
 	insl(port, addr, count);
 }
 
-static void ide_outb (u8 addr, ide_ioreg_t port)
+static void ide_outb (u8 value, ide_ioreg_t port)
 {
-	outb(addr, port);
+	outb(value, port);
 }
 
-static void ide_outw (u16 addr, ide_ioreg_t port)
+static void ide_outw (u16 value, ide_ioreg_t port)
 {
-	outw(addr, port);
+	outw(value, port);
 }
 
 static void ide_outsw (ide_ioreg_t port, void *addr, u32 count)
@@ -72,9 +72,9 @@
 	outsw(port, addr, count);
 }
 
-static void ide_outl (u32 addr, ide_ioreg_t port)
+static void ide_outl (u32 value, ide_ioreg_t port)
 {
-	outl(addr, port);
+	outl(value, port);
 }
 
 static void ide_outsl (ide_ioreg_t port, void *addr, u32 count)
--- linux-2.5.47/drivers/ide/pci/siimage.h	Mon Oct  7 22:04:23 2002
+++ linux-m68k-2.5.47/drivers/ide/pci/siimage.h	Mon Nov 11 15:03:59 2002
@@ -62,14 +62,14 @@
 //	while (count--) { *(u32 *)addr = readl(port); addr += 4; }
 }
 
-inline void sii_outb (u8 addr, u32 port)
+inline void sii_outb (u8 value, u32 port)
 {
-	writeb(addr, port);
+	writeb(value, port);
 }
 
-inline void sii_outw (u16 addr, u32 port)
+inline void sii_outw (u16 value, u32 port)
 {
-	writew(addr, port);
+	writew(value, port);
 }
 
 inline void sii_outsw (u32 port, void *addr, u32 count)
@@ -77,9 +77,9 @@
 	while (count--) { writew(*(u16 *)addr, port); addr += 2; }
 }
 
-inline void sii_outl (u32 addr, u32 port)
+inline void sii_outl (u32 value, u32 port)
 {
-	writel(addr, port);
+	writel(value, port);
 }
 
 inline void sii_outsl (u32 port, void *addr, u32 count)
--- linux-2.5.47/include/linux/ide.h	Mon Nov 11 10:19:43 2002
+++ linux-m68k-2.5.47/include/linux/ide.h	Mon Nov 11 15:03:04 2002
@@ -299,9 +299,9 @@
 
 typedef struct ide_io_ops_s {
 	/* insert io operations here! */
-	void (*OUTB)(u8 addr, ide_ioreg_t port);
-	void (*OUTW)(u16 addr, ide_ioreg_t port);
-	void (*OUTL)(u32 addr, ide_ioreg_t port);
+	void (*OUTB)(u8 value, ide_ioreg_t port);
+	void (*OUTW)(u16 value, ide_ioreg_t port);
+	void (*OUTL)(u32 value, ide_ioreg_t port);
 	void (*OUTSW)(ide_ioreg_t port, void *addr, u32 count);
 	void (*OUTSL)(ide_ioreg_t port, void *addr, u32 count);
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

