Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLRXbO>; Mon, 18 Dec 2000 18:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131247AbQLRXbE>; Mon, 18 Dec 2000 18:31:04 -0500
Received: from aeon.tvd.be ([195.162.196.20]:56419 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S129849AbQLRXav>;
	Mon, 18 Dec 2000 18:30:51 -0500
Date: Tue, 19 Dec 2000 00:00:22 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test13-pre3 m68k Makefiles
Message-ID: <Pine.LNX.4.05.10012182358460.4722-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch updates the Makefiles used by Linux/m68k to the new Makefile syntax.
Additionally I fixed a bug in arch/ppc/amiga/Makefile (for APUS).

--- linux-2.4.0-test13-pre3/Makefile	Mon Dec 18 12:34:22 2000
+++ linux-m68k-test13-pre3/Makefile	Mon Dec 18 12:40:50 2000
@@ -159,7 +159,7 @@
 DRIVERS-$(CONFIG_PCMCIA_CHRDEV) += drivers/char/pcmcia/pcmcia_char.o
 DRIVERS-$(CONFIG_DIO) += drivers/dio/dio.a
 DRIVERS-$(CONFIG_SBUS) += drivers/sbus/sbus_all.o
-DRIVERS-$(CONFIG_ZORRO) += drivers/zorro/zorro.a
+DRIVERS-$(CONFIG_ZORRO) += drivers/zorro/driver.o
 DRIVERS-$(CONFIG_FC4) += drivers/fc4/fc4.a
 DRIVERS-$(CONFIG_ALL_PPC) += drivers/macintosh/macintosh.o
 DRIVERS-$(CONFIG_MAC) += drivers/macintosh/macintosh.o
--- linux-2.4.0-test13-pre3/arch/m68k/amiga/Makefile	Thu Jul 30 20:08:19 1998
+++ linux-m68k-test13-pre3/arch/m68k/amiga/Makefile	Mon Dec 18 12:53:58 2000
@@ -8,11 +8,11 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := amiga.o
-O_OBJS   := config.o amiints.o cia.o chipram.o amisound.o
-OX_OBJS  := amiga_ksyms.o
 
-ifdef CONFIG_AMIGA_PCMCIA
-O_OBJS := $(O_OBJS) pcmcia.o
-endif
+export-objs	:= amiga_ksyms.o
+
+obj-y		:= config.o amiints.o cia.o chipram.o amisound.o amiga_ksyms.o
+
+obj-$(CONFIG_AMIGA_PCMCIA)	+= pcmcia.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/apollo/Makefile	Tue Feb  8 11:04:33 2000
+++ linux-m68k-test13-pre3/arch/m68k/apollo/Makefile	Mon Dec 18 12:57:03 2000
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := apollo.o
-O_OBJS   := config.o dn_ints.o dma.o \
 
+obj-y		:= config.o dn_ints.o dma.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/atari/Makefile	Tue Feb  8 11:04:33 2000
+++ linux-m68k-test13-pre3/arch/m68k/atari/Makefile	Mon Dec 18 12:54:27 2000
@@ -8,14 +8,14 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := atari.o
-O_OBJS	 := config.o time.o debug.o atakeyb.o ataints.o stdma.o atasound.o \
-            joystick.o stram.o
-OX_OBJS  := atari_ksyms.o
+
+export-objs	:= atari_ksyms.o
+
+obj-y		:= config.o time.o debug.o atakeyb.o ataints.o stdma.o \
+			atasound.o joystick.o stram.o atari_ksyms.o
 
 ifdef CONFIG_PCI
-ifdef CONFIG_HADES
-O_OBJS += hades-pci.o
-endif
+obj-$(CONFIG_HADES)	+= hades-pci.o
 endif
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/bvme6000/Makefile	Sat Jun 13 22:14:31 1998
+++ linux-m68k-test13-pre3/arch/m68k/bvme6000/Makefile	Mon Dec 18 12:54:32 2000
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := bvme6000.o
-O_OBJS   := config.o bvmeints.o rtc.o
-#OX_OBJS = ksyms.o
+
+obj-y		:= config.o bvmeints.o rtc.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/hp300/Makefile	Wed Sep  2 18:39:18 1998
+++ linux-m68k-test13-pre3/arch/m68k/hp300/Makefile	Mon Dec 18 12:54:43 2000
@@ -8,10 +8,11 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := hp300.o
-O_OBJS	 := ksyms.o config.o ints.o time.o reboot.o
 
-ifdef CONFIG_VT
-O_OBJS += hil.o
-endif
+export-objs	:= ksyms.o
+
+obj-y		:= ksyms.o config.o ints.o time.o reboot.o
+
+obj-$(CONFIG_VT)	+= hil.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/kernel/Makefile	Thu Apr 13 21:17:11 2000
+++ linux-m68k-test13-pre3/arch/m68k/kernel/Makefile	Mon Dec 18 12:54:58 2000
@@ -17,13 +17,13 @@
 endif 
 
 O_TARGET := kernel.o
-O_OBJS := entry.o process.o traps.o ints.o signal.o ptrace.o \
-	  sys_m68k.o time.o semaphore.o
-OX_OBJS := setup.o m68k_ksyms.o
 
-ifdef CONFIG_PCI
-O_OBJS += bios32.o
-endif
+export-objs	:= setup.o m68k_ksyms.o
+
+obj-y		:= entry.o process.o traps.o ints.o signal.o ptrace.o \
+			sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
+
+obj-$(CONFIG_PCI)	+= bios32.o
 
 head.o: head.S m68k_defs.h
 
--- linux-2.4.0-test13-pre3/arch/m68k/lib/Makefile	Thu Dec 14 12:14:15 2000
+++ linux-m68k-test13-pre3/arch/m68k/lib/Makefile	Mon Dec 18 12:55:09 2000
@@ -6,6 +6,8 @@
 	$(CC) $(AFLAGS) -traditional -c $< -o $@
 
 L_TARGET = lib.a
-L_OBJS  = ashrdi3.o lshrdi3.o checksum.o memcpy.o memcmp.o memset.o semaphore.o muldi3.o
+
+obj-y		:= ashrdi3.o lshrdi3.o checksum.o memcpy.o memcmp.o memset.o \
+		    semaphore.o muldi3.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/mac/Makefile	Tue Feb 15 21:49:28 2000
+++ linux-m68k-test13-pre3/arch/m68k/mac/Makefile	Mon Dec 18 12:55:22 2000
@@ -8,8 +8,10 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := mac.o
-OX_OBJS  := mac_ksyms.o
-O_OBJS	 := config.o bootparse.o macints.o iop.o via.o oss.o psc.o \
-		baboon.o macboing.o debug.o misc.o
+
+export-objs	:= mac_ksyms.o
+
+obj-y		:= config.o bootparse.o macints.o iop.o via.o oss.o psc.o \
+			baboon.o macboing.o debug.o misc.o mac_ksyms.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/math-emu/Makefile	Thu Apr 13 21:17:11 2000
+++ linux-m68k-test13-pre3/arch/m68k/math-emu/Makefile	Mon Dec 18 12:55:30 2000
@@ -13,7 +13,8 @@
 #EXTRA_CFLAGS=-DFPU_EMU_DEBUG
 
 O_TARGET := mathemu.o
-O_OBJS := fp_entry.o fp_scan.o fp_util.o fp_move.o fp_movem.o \
-	  fp_cond.o fp_arith.o fp_log.o fp_trig.o
+
+obj-y		:= fp_entry.o fp_scan.o fp_util.o fp_move.o fp_movem.o \
+			fp_cond.o fp_arith.o fp_log.o fp_trig.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/mm/Makefile	Sun Sep 12 20:31:52 1999
+++ linux-m68k-test13-pre3/arch/m68k/mm/Makefile	Mon Dec 18 12:55:39 2000
@@ -8,12 +8,13 @@
 # Note 2! The CFLAGS definition is now in the main makefile...
 
 O_TARGET := mm.o
-O_OBJS	 := init.o fault.o extable.o hwtest.o
+
+obj-y		:= init.o fault.o extable.o hwtest.o
 
 ifndef CONFIG_SUN3
-O_OBJS 	 += kmap.o memory.o motorola.o
+obj-y		+= kmap.o memory.o motorola.o
 else
-O_OBJS	 += sun3mmu.o
+obj-y		+= sun3mmu.o
 endif
 
 
--- linux-2.4.0-test13-pre3/arch/m68k/mvme147/Makefile	Tue May 11 18:57:14 1999
+++ linux-m68k-test13-pre3/arch/m68k/mvme147/Makefile	Mon Dec 18 12:55:45 2000
@@ -7,8 +7,8 @@
 #
 
 O_TARGET := mvme147.o
-O_OBJS   := config.o 147ints.o
 
+obj-y		:= config.o 147ints.o
 
 include $(TOPDIR)/Rules.make
 
--- linux-2.4.0-test13-pre3/arch/m68k/mvme16x/Makefile	Tue Feb  8 11:04:34 2000
+++ linux-m68k-test13-pre3/arch/m68k/mvme16x/Makefile	Mon Dec 18 12:55:51 2000
@@ -8,7 +8,9 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := mvme16x.o
-O_OBJS   := config.o 16xints.o rtc.o
-OX_OBJS  := mvme16x_ksyms.o
+
+export-objs	:= mvme16x_ksyms.o
+
+obj-y		:= config.o 16xints.o rtc.o mvme16x_ksyms.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/q40/Makefile	Tue May 11 18:57:14 1999
+++ linux-m68k-test13-pre3/arch/m68k/q40/Makefile	Mon Dec 18 12:55:56 2000
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := q40.o
-O_OBJS   := config.o q40ints.o 
 
+obj-y		:= config.o q40ints.o 
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/sun3/Makefile	Thu Apr 13 21:17:11 2000
+++ linux-m68k-test13-pre3/arch/m68k/sun3/Makefile	Mon Dec 18 12:56:08 2000
@@ -11,7 +11,10 @@
 	$(CC) $(AFLAGS) -traditional -Wa,-m68020 -c $< -o $*.o
 
 O_TARGET := sun3.o 
-O_OBJS   := config.o idprom.o mmu_emu.o sun3ints.o leds.o dvma.o sbus.o intersil.o
-OX_OBJS  := sun3_ksyms.o
+
+export-objs	:= sun3_ksyms.o
+
+obj-y		:= config.o idprom.o mmu_emu.o sun3ints.o leds.o dvma.o \
+			sbus.o intersil.o sun3_ksyms.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/m68k/sun3x/Makefile	Tue May 11 18:57:14 1999
+++ linux-m68k-test13-pre3/arch/m68k/sun3x/Makefile	Mon Dec 18 12:56:12 2000
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := sun3x.o
-O_OBJS   := config.o time.o dvma.o sbus.o
-OX_OBJS  := 
+
+obj-y		:= config.o time.o dvma.o sbus.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/ppc/amiga/Makefile	Mon Dec 18 12:34:22 2000
+++ linux-m68k-test13-pre3/arch/ppc/amiga/Makefile	Mon Dec 18 12:56:23 2000
@@ -9,9 +9,11 @@
 
 O_TARGET := amiga.o
 
-obj-y		:= config.o amiints.o cia.o time.o bootinfo.o amisound.o chipram.o
 export-objs	:= amiga_ksyms.o
 
-objs-$(CONFIG_AMIGA_PCMCIA)	+= pcmia.o
+obj-y		:= config.o amiints.o cia.o time.o bootinfo.o amisound.o \
+			chipram.o amiga_ksyms.o
+
+obj-$(CONFIG_AMIGA_PCMCIA) += pcmia.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/drivers/sbus/Makefile	Mon Dec 18 12:34:33 2000
+++ linux-m68k-test13-pre3/drivers/sbus/Makefile	Mon Dec 18 12:42:24 2000
@@ -8,7 +8,9 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := sbus_all.o
+ifneq ($(ARCH),m68k)
 obj-y    := sbus.o dvma.o
+endif
 
 subdir-y += char
 subdir-m += char
--- linux-2.4.0-test13-pre3/drivers/zorro/Makefile	Mon Nov  6 15:46:01 2000
+++ linux-m68k-test13-pre3/drivers/zorro/Makefile	Mon Dec 18 12:56:53 2000
@@ -9,18 +9,12 @@
 # parent makefile.
 #
 
-L_TARGET := zorro.a
+O_TARGET := driver.o
 
-# Nasty trick as we need to link files with no references from the outside.
-O_TARGET := zorro_core.o
-L_OBJS   := zorro_core.o
-OX_OBJS   := zorro.o
+export-objs		:= zorro.o
 
-ifdef CONFIG_PROC_FS
-O_OBJS   += proc.o
-endif
-
-L_OBJS   += names.o
+obj-$(CONFIG_ZORRO)	+= zorro.o names.o
+obj-$(CONFIG_PROC_FS)	+= proc.o
 
 include $(TOPDIR)/Rules.make
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
