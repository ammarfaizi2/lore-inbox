Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317894AbSGVXjl>; Mon, 22 Jul 2002 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSGVXjl>; Mon, 22 Jul 2002 19:39:41 -0400
Received: from pD9E23AF1.dip.t-dialin.net ([217.226.58.241]:24466 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317894AbSGVXjX>; Mon, 22 Jul 2002 19:39:23 -0400
Date: Mon, 22 Jul 2002 17:42:23 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] get export-objs ultimately right
Message-ID: <Pine.LNX.4.44.0207221741170.12875-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This corrects all the export-objs directives, respecting the needs of 
Russell King.

diff -Nur linux-2.5.27/arch/arm/mach-clps711x/Makefile thunder-2.5/arch/arm/mach-clps711x/Makefile
--- linux-2.5.27/arch/arm/mach-clps711x/Makefile	Sat Jul 20 13:12:26 2002
+++ thunder-2.5/arch/arm/mach-clps711x/Makefile	Mon Jul 22 06:19:53 2002
@@ -14,8 +14,6 @@
 obj-n			:=
 obj-			:=
 
-export-objs		:= leds-p720t.o
-
 obj-$(CONFIG_ARCH_AUTCPU12) += autcpu12.o
 obj-$(CONFIG_ARCH_CDB89712) += cdb89712.o
 obj-$(CONFIG_ARCH_CLEP7312) += clep7312.o
diff -Nur linux-2.5.27/arch/arm/mach-ftvpci/Makefile thunder-2.5/arch/arm/mach-ftvpci/Makefile
--- linux-2.5.27/arch/arm/mach-ftvpci/Makefile	Sat Jul 20 13:12:23 2002
+++ thunder-2.5/arch/arm/mach-ftvpci/Makefile	Mon Jul 22 06:20:41 2002
@@ -14,7 +14,7 @@
 obj-n			:=
 obj-			:=
 
-export-objs		:= 
+export-objs		:= leds.o
 
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_LEDS)	+= leds.o
diff -Nur linux-2.5.27/arch/arm/mach-integrator/Makefile thunder-2.5/arch/arm/mach-integrator/Makefile
--- linux-2.5.27/arch/arm/mach-integrator/Makefile	Sat Jul 20 13:12:18 2002
+++ thunder-2.5/arch/arm/mach-integrator/Makefile	Mon Jul 22 06:20:22 2002
@@ -14,8 +14,6 @@
 obj-n			:=
 obj-			:=
 
-export-objs		:= leds.o
-
 obj-$(CONFIG_LEDS)	+= leds.o
 obj-$(CONFIG_PCI)	+= pci_v3.o pci.o
 
diff -Nur linux-2.5.27/arch/arm/mach-pxa/Makefile thunder-2.5/arch/arm/mach-pxa/Makefile
--- linux-2.5.27/arch/arm/mach-pxa/Makefile	Sat Jul 20 13:11:21 2002
+++ thunder-2.5/arch/arm/mach-pxa/Makefile	Mon Jul 22 06:21:07 2002
@@ -12,7 +12,7 @@
 obj-n :=
 obj-  :=
 
-export-objs := generic.o irq.o dma.o sa1111.o
+export-objs := generic.o dma.o sa1111.o
 
 # Common support (must be linked before board specific support)
 obj-y += generic.o irq.o dma.o
diff -Nur linux-2.5.27/arch/arm/mach-sa1100/Makefile thunder-2.5/arch/arm/mach-sa1100/Makefile
--- linux-2.5.27/arch/arm/mach-sa1100/Makefile	Sat Jul 20 13:12:31 2002
+++ thunder-2.5/arch/arm/mach-sa1100/Makefile	Mon Jul 22 06:21:37 2002
@@ -11,8 +11,8 @@
 obj-  :=
 led-y := leds.o
 
-export-objs :=	dma.o generic.o irq.o pcipool.o sa1111.o sa1111-pcibuf.o \
-		usb_ctl.o usb_recv.o usb_send.o pm.o
+export-objs :=	dma.o generic.o pcipool.o sa1111.o sa1111-pcibuf.o pm.o \
+		usb_ctl.o usb_recv.o usb_send.o
 
 # This needs to be cleaned up.  We probably need to have SA1100
 # and SA1110 config symbols.
diff -Nur linux-2.5.27/arch/i386/kernel/Makefile thunder-2.5/arch/i386/kernel/Makefile
--- linux-2.5.27/arch/i386/kernel/Makefile	Sat Jul 20 13:11:10 2002
+++ thunder-2.5/arch/i386/kernel/Makefile	Mon Jul 22 06:21:58 2002
@@ -6,7 +6,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
+export-objs     := mca.o mtrr.o i386_ksyms.o time.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -Nur linux-2.5.27/arch/ia64/lib/Makefile thunder-2.5/arch/ia64/lib/Makefile
--- linux-2.5.27/arch/ia64/lib/Makefile	Sat Jul 20 13:12:23 2002
+++ thunder-2.5/arch/ia64/lib/Makefile	Mon Jul 22 06:22:15 2002
@@ -4,7 +4,7 @@
 
 L_TARGET = lib.a
 
-export-objs := io.o swiotlb.o
+export-objs := swiotlb.o
 
 obj-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o					\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o					\
diff -Nur linux-2.5.27/arch/ia64/sn/io/Makefile thunder-2.5/arch/ia64/sn/io/Makefile
--- linux-2.5.27/arch/ia64/sn/io/Makefile	Sat Jul 20 13:11:11 2002
+++ thunder-2.5/arch/ia64/sn/io/Makefile	Mon Jul 22 06:22:33 2002
@@ -18,7 +18,7 @@
 O_TARGET := sgiio.o
 
 ifeq ($(CONFIG_MODULES),y)
-export-objs = pciio.o hcl.o pci_dma.o
+export-objs = pciio.o hcl.o
 endif
 
 obj-y  := stubs.o sgi_if.o pciio.o xtalk.o xbow.o xswitch.o klgraph_hack.o \
diff -Nur linux-2.5.27/arch/m68k/amiga/Makefile thunder-2.5/arch/m68k/amiga/Makefile
--- linux-2.5.27/arch/m68k/amiga/Makefile	Sat Jul 20 13:12:31 2002
+++ thunder-2.5/arch/m68k/amiga/Makefile	Mon Jul 22 06:25:28 2002
@@ -9,8 +9,6 @@
 
 O_TARGET := amiga.o
 
-export-objs	:= amiga_ksyms.o
-
 obj-y		:= config.o amiints.o cia.o chipram.o amisound.o amiga_ksyms.o
 
 obj-$(CONFIG_AMIGA_PCMCIA)	+= pcmcia.o
diff -Nur linux-2.5.27/arch/m68k/hp300/Makefile thunder-2.5/arch/m68k/hp300/Makefile
--- linux-2.5.27/arch/m68k/hp300/Makefile	Sat Jul 20 13:11:07 2002
+++ thunder-2.5/arch/m68k/hp300/Makefile	Mon Jul 22 06:22:53 2002
@@ -9,8 +9,6 @@
 
 O_TARGET := hp300.o
 
-export-objs	:= ksyms.o
-
 obj-y		:= ksyms.o config.o ints.o time.o reboot.o
 
 obj-$(CONFIG_VT)	+= hil.o
diff -Nur linux-2.5.27/arch/m68k/sun3x/Makefile thunder-2.5/arch/m68k/sun3x/Makefile
--- linux-2.5.27/arch/m68k/sun3x/Makefile	Sat Jul 20 13:11:14 2002
+++ thunder-2.5/arch/m68k/sun3x/Makefile	Mon Jul 22 06:23:43 2002
@@ -7,7 +7,7 @@
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
-O_TARGET := sun3x.o
+O_TARGET := sun3x.o sun3x_ksyms.o
 
 obj-y		:= config.o time.o dvma.o prom.o
 
diff -Nur linux-2.5.27/arch/mips/au1000/common/Makefile thunder-2.5/arch/mips/au1000/common/Makefile
--- linux-2.5.27/arch/mips/au1000/common/Makefile	Sat Jul 20 13:12:24 2002
+++ thunder-2.5/arch/mips/au1000/common/Makefile	Mon Jul 22 06:24:07 2002
@@ -8,7 +8,7 @@
 
 O_TARGET := au1000.o
 
-obj-y := prom.o dbg_io.o int-handler.o irq.o puts.o time.o reset.o
+obj-y := prom.o dbg_io.o int-handler.o irq.o puts.o time.o reset.o serial.o
 
 obj-$(CONFIG_AU1000_UART) += serial.o             
 obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o             
diff -Nur linux-2.5.27/arch/mips/baget/Makefile thunder-2.5/arch/mips/baget/Makefile
--- linux-2.5.27/arch/mips/baget/Makefile	Sat Jul 20 13:12:32 2002
+++ thunder-2.5/arch/mips/baget/Makefile	Mon Jul 22 06:23:17 2002
@@ -5,7 +5,7 @@
 
 O_TARGET := baget.a
 
-export-objs		:= vacserial.o vacrtc.o
+export-objs		:= vacserial.o
 obj-y			:= baget.o print.o setup.o time.o irq.o bagetIRQ.o \
 			   reset.o wbflush.o
 obj-$(CONFIG_SERIAL)	+= vacserial.o
diff -Nur linux-2.5.27/arch/mips/kernel/Makefile thunder-2.5/arch/mips/kernel/Makefile
--- linux-2.5.27/arch/mips/kernel/Makefile	Sat Jul 20 13:11:15 2002
+++ thunder-2.5/arch/mips/kernel/Makefile	Mon Jul 22 06:25:12 2002
@@ -6,6 +6,7 @@
 
 O_TARGET	:= kernel.o
 EXTRA_TARGETS	:= head.o init_task.o
+export-objs	:= mips_ksyms.o
 
 obj-y				+= branch.o process.o signal.o entry.o \
 				   traps.o ptrace.o vm86.o ioport.o reset.o \
@@ -27,14 +28,12 @@
 obj-$(CONFIG_SMP)		+= smp.o
 
 # Old style irq support, going to die in 2.5.
-export-objs			+= old-irq.o
 obj-$(CONFIG_NEW_IRQ)		+= irq.o
 obj-$(CONFIG_ROTTEN_IRQ)	+= old-irq.o
 obj-$(CONFIG_I8259)		+= i8259.o
 
 # transition from old time.c to new time.c
 # some boards uses old-time.c, some use time.c, and some use their own ones
-export-objs			+= old-time.o time.o
 obj-$(CONFIG_OLD_TIME_C)	+= old-time.o
 obj-$(CONFIG_NEW_TIME_C)	+= time.o
 
diff -Nur linux-2.5.27/arch/ppc/8xx_io/Makefile thunder-2.5/arch/ppc/8xx_io/Makefile
--- linux-2.5.27/arch/ppc/8xx_io/Makefile	Sat Jul 20 13:11:17 2002
+++ thunder-2.5/arch/ppc/8xx_io/Makefile	Mon Jul 22 06:25:56 2002
@@ -11,6 +11,8 @@
 
 O_TARGET 		:= 8xx_io.o
 
+export-objs		:= fec.o
+
 obj-y			:= commproc.o uart.o
 
 obj-$(CONFIG_FEC_ENET)	+= fec.o
diff -Nur linux-2.5.27/arch/ppc64/kernel/Makefile thunder-2.5/arch/ppc64/kernel/Makefile
--- linux-2.5.27/arch/ppc64/kernel/Makefile	Sat Jul 20 13:12:26 2002
+++ thunder-2.5/arch/ppc64/kernel/Makefile	Mon Jul 22 06:26:52 2002
@@ -9,7 +9,7 @@
 O_TARGET	:= kernel.o
 EXTRA_TARGETS	:= $(KHEAD)
 
-export-objs         := ppc_ksyms.o setup.o
+export-objs         := ppc_ksyms.o
 
 obj-y               :=	ppc_ksyms.o setup.o entry.o traps.o irq.o idle.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
diff -Nur linux-2.5.27/arch/sh/kernel/Makefile thunder-2.5/arch/sh/kernel/Makefile
--- linux-2.5.27/arch/sh/kernel/Makefile	Sat Jul 20 13:11:24 2002
+++ thunder-2.5/arch/sh/kernel/Makefile	Mon Jul 22 06:28:39 2002
@@ -5,7 +5,8 @@
 O_TARGET	:= kernel.o
 EXTRA_TARGETS	:= head.o init_task.o
 
-export-objs	:= io.o io_generic.o io_hd64461.o setup_hd64461.o sh_ksyms.o
+export-objs	:= io.o io_generic.o io_hd64465.o setup_hd64465.o sh_ksyms.o \
+		   io_adx.o io_bigsur.o io_cat68701.o hd64465_gpio.o
 
 obj-y	:= process.o signal.o entry.o traps.o irq.o irq_ipr.o \
 	ptrace.o setup.o time.o sys_sh.o semaphore.o \
diff -Nur linux-2.5.27/arch/x86_64/kernel/Makefile thunder-2.5/arch/x86_64/kernel/Makefile
--- linux-2.5.27/arch/x86_64/kernel/Makefile	Sat Jul 20 13:11:10 2002
+++ thunder-2.5/arch/x86_64/kernel/Makefile	Mon Jul 22 06:29:04 2002
@@ -5,7 +5,7 @@
 O_TARGET	:= kernel.o
 EXTRA_TARGETS 	:= head.o head64.o init_task.o
 
-export-objs     := mtrr.o msr.o cpuid.o x8664_ksyms.o
+export-objs     := mtrr.o x8664_ksyms.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
diff -Nur linux-2.5.27/drivers/acorn/char/Makefile thunder-2.5/drivers/acorn/char/Makefile
--- linux-2.5.27/drivers/acorn/char/Makefile	Sat Jul 20 13:11:07 2002
+++ thunder-2.5/drivers/acorn/char/Makefile	Mon Jul 22 06:29:24 2002
@@ -3,8 +3,6 @@
 #
 
 # All the objects that export symbols.
-export-objs	:= mouse_rpc.o
-
 obj-arc		:= keyb_arc.o
 obj-rpc		:= keyb_ps2.o
 obj-clps7500	:= keyb_ps2.o defkeymap-acorn.o
diff -Nur linux-2.5.27/drivers/block/Makefile thunder-2.5/drivers/block/Makefile
--- linux-2.5.27/drivers/block/Makefile	Sat Jul 20 13:11:33 2002
+++ thunder-2.5/drivers/block/Makefile	Mon Jul 22 06:30:19 2002
@@ -8,7 +8,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o DAC960.o genhd.o block_ioctl.o
+export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o genhd.o \
+		   block_ioctl.o acsi.o
 
 obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o
 
diff -Nur linux-2.5.27/drivers/char/Makefile thunder-2.5/drivers/char/Makefile
--- linux-2.5.27/drivers/char/Makefile	Sat Jul 20 13:12:23 2002
+++ thunder-2.5/drivers/char/Makefile	Mon Jul 22 06:31:48 2002
@@ -12,10 +12,9 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
-			misc.o pty.o random.o selection.o serial.o \
-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
-			ip2main.o
+export-objs     :=	busmouse.o console.o keyboard.o sysrq.o ite_gpio.o \
+			misc.o random.o selection.o serial.o sonypi.o \
+			tty_io.o tty_ioctl.o generic_serial.o rtc.o ip2main.o
 
 KEYMAP   =defkeymap.o
 KEYBD    =pc_keyb.o
diff -Nur linux-2.5.27/drivers/char/ftape/lowlevel/Makefile thunder-2.5/drivers/char/ftape/lowlevel/Makefile
--- linux-2.5.27/drivers/char/ftape/lowlevel/Makefile	Sat Jul 20 13:11:12 2002
+++ thunder-2.5/drivers/char/ftape/lowlevel/Makefile	Mon Jul 22 06:30:42 2002
@@ -23,8 +23,6 @@
 #      driver for Linux.
 #
 
-export-objs := ftape_syms.o
-
 obj-$(CONFIG_FTAPE) += ftape.o
 
 ftape-objs := ftape-init.o fdc-io.o fdc-isr.o \
diff -Nur linux-2.5.27/drivers/char/ftape/zftape/Makefile thunder-2.5/drivers/char/ftape/zftape/Makefile
--- linux-2.5.27/drivers/char/ftape/zftape/Makefile	Sat Jul 20 13:11:30 2002
+++ thunder-2.5/drivers/char/ftape/zftape/Makefile	Mon Jul 22 06:30:53 2002
@@ -27,8 +27,6 @@
 # ZFT_OBSOLETE - enable the MTIOC_ZFTAPE_GETBLKSZ ioctl. You should
 #                leave this enabled for compatibility with taper.
 
-export-objs := zftape_syms.o
-
 obj-$(CONFIG_ZFTAPE) += zftape.o
 
 zftape-objs := zftape-rw.o zftape-ctl.o zftape-read.o \
diff -Nur linux-2.5.27/drivers/macintosh/Makefile thunder-2.5/drivers/macintosh/Makefile
--- linux-2.5.27/drivers/macintosh/Makefile	Sat Jul 20 13:11:12 2002
+++ thunder-2.5/drivers/macintosh/Makefile	Mon Jul 22 06:32:12 2002
@@ -4,7 +4,7 @@
 
 # Objects that export symbols.
 
-export-objs	:= adb.o rtc.o mac_hid.o via-pmu.o
+export-objs	:= adb.o mac_hid.o via-pmu.o
 
 # Object file lists.
 
diff -Nur linux-2.5.27/drivers/message/fusion/Makefile thunder-2.5/drivers/message/fusion/Makefile
--- linux-2.5.27/drivers/message/fusion/Makefile	Sat Jul 20 13:11:27 2002
+++ thunder-2.5/drivers/message/fusion/Makefile	Mon Jul 22 06:32:36 2002
@@ -43,7 +43,7 @@
 
 #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-} LSI_LOGIC
 
-export-objs	:= mptbase.o mptscsih.o mptlan.o mptctl.o isense.o
+export-objs	:= mptbase.o
 
 obj-$(CONFIG_FUSION)		+= mptbase.o mptscsih.o
 obj-$(CONFIG_FUSION_ISENSE)	+= isense.o
diff -Nur linux-2.5.27/drivers/message/i2o/Makefile thunder-2.5/drivers/message/i2o/Makefile
--- linux-2.5.27/drivers/message/i2o/Makefile	Sat Jul 20 13:11:09 2002
+++ thunder-2.5/drivers/message/i2o/Makefile	Mon Jul 22 06:32:54 2002
@@ -5,7 +5,7 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= i2o_pci.o i2o_core.o i2o_config.o i2o_block.o i2o_lan.o i2o_scsi.o i2o_proc.o
+export-objs	:= i2o_core.o
 
 obj-$(CONFIG_I2O_PCI)	+= i2o_pci.o
 obj-$(CONFIG_I2O)	+= i2o_core.o i2o_config.o
diff -Nur linux-2.5.27/drivers/net/wan/Makefile thunder-2.5/drivers/net/wan/Makefile
--- linux-2.5.27/drivers/net/wan/Makefile	Sat Jul 20 13:11:05 2002
+++ thunder-2.5/drivers/net/wan/Makefile	Mon Jul 22 06:33:08 2002
@@ -6,7 +6,7 @@
 #
 
 export-objs :=	z85230.o syncppp.o comx.o sdladrv.o cycx_drv.o hdlc_generic.o \
-		dlci.o pc300_drv.o
+		dlci.o
 
 wanpipe-y			:= sdlamain.o sdla_ft1.o
 wanpipe-$(CONFIG_WANPIPE_X25)	+= sdla_x25.o
diff -Nur linux-2.5.27/drivers/pcmcia/Makefile thunder-2.5/drivers/pcmcia/Makefile
--- linux-2.5.27/drivers/pcmcia/Makefile	Sat Jul 20 13:11:11 2002
+++ thunder-2.5/drivers/pcmcia/Makefile	Mon Jul 22 06:33:25 2002
@@ -2,7 +2,7 @@
 # Makefile for the kernel pcmcia subsystem (c/o David Hinds)
 #
 
-export-objs := ds.o cs.o yenta.o pci_socket.o
+export-objs := ds.o cs.o yenta.o
 
 obj-$(CONFIG_PCMCIA)			+= pcmcia_core.o ds.o
 ifeq ($(CONFIG_CARDBUS),y)
diff -Nur linux-2.5.27/drivers/s390/cio/Makefile thunder-2.5/drivers/s390/cio/Makefile
--- linux-2.5.27/drivers/s390/cio/Makefile	Sat Jul 20 13:11:03 2002
+++ thunder-2.5/drivers/s390/cio/Makefile	Mon Jul 22 06:33:52 2002
@@ -8,6 +8,6 @@
 obj-$(CONFIG_CHSC) += chsc.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
-export-objs += airq.o cio.o ioinfo.o misc.o requestirq.o s390io.o
+export-objs += airq.o cio.o ioinfo.o requestirq.o s390io.o
 
 include $(TOPDIR)/Rules.make
diff -Nur linux-2.5.27/drivers/sgi/char/Makefile thunder-2.5/drivers/sgi/char/Makefile
--- linux-2.5.27/drivers/sgi/char/Makefile	Sat Jul 20 13:11:05 2002
+++ thunder-2.5/drivers/sgi/char/Makefile	Mon Jul 22 06:34:15 2002
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-export-objs	:= newport.o shmiq.o sgicons.o usema.o
+export-objs	:= newport.o shmiq.o sgicons.o usema.o rrm.o
 obj-y		:= newport.o shmiq.o sgicons.o usema.o streamable.o
 
 obj-$(CONFIG_SGI_SERIAL)	+= sgiserial.o
diff -Nur linux-2.5.27/drivers/usb/class/Makefile thunder-2.5/drivers/usb/class/Makefile
--- linux-2.5.27/drivers/usb/class/Makefile	Sat Jul 20 13:11:17 2002
+++ thunder-2.5/drivers/usb/class/Makefile	Mon Jul 22 06:35:19 2002
@@ -3,11 +3,12 @@
 # (one step up from the misc category)
 #
 
+export-objs			:= usb-midi.o
+
 obj-$(CONFIG_USB_ACM)		+= cdc-acm.o
 obj-$(CONFIG_USB_AUDIO)		+= audio.o
 obj-$(CONFIG_USB_BLUETOOTH_TTY)	+= bluetty.o
 obj-$(CONFIG_USB_MIDI)		+= usb-midi.o
 obj-$(CONFIG_USB_PRINTER)	+= printer.o
-
 
 include $(TOPDIR)/Rules.make
diff -Nur linux-2.5.27/drivers/usb/core/Makefile thunder-2.5/drivers/usb/core/Makefile
--- linux-2.5.27/drivers/usb/core/Makefile	Sat Jul 20 13:12:30 2002
+++ thunder-2.5/drivers/usb/core/Makefile	Mon Jul 22 06:34:43 2002
@@ -2,7 +2,7 @@
 # Makefile for USB Core files and filesystem
 #
 
-export-objs	:= usb.o hcd.o hcd-pci.o urb.o message.o config.o file.o
+export-objs	:= usb.o hcd.o hcd-pci.o urb.o message.o file.o
 
 usbcore-objs	:= usb.o usb-debug.o hub.o hcd.o urb.o message.o \
 			config.o file.o
diff -Nur linux-2.5.27/drivers/usb/host/Makefile thunder-2.5/drivers/usb/host/Makefile
--- linux-2.5.27/drivers/usb/host/Makefile	Sat Jul 20 13:12:25 2002
+++ thunder-2.5/drivers/usb/host/Makefile	Mon Jul 22 06:35:32 2002
@@ -3,8 +3,6 @@
 # framework and drivers
 #
 
-export-objs := usb-ohci.o
-
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
 obj-$(CONFIG_USB_UHCI_HCD_ALT)	+= uhci-hcd.o
diff -Nur linux-2.5.27/drivers/video/aty/Makefile thunder-2.5/drivers/video/aty/Makefile
--- linux-2.5.27/drivers/video/aty/Makefile	Sat Jul 20 13:11:12 2002
+++ thunder-2.5/drivers/video/aty/Makefile	Mon Jul 22 06:35:56 2002
@@ -1,6 +1,3 @@
-
-export-objs    :=  atyfb_base.o mach64_accel.o
-
 obj-$(CONFIG_FB_ATY) += atyfb.o
 
 atyfb-y				:= atyfb_base.o mach64_accel.o
diff -Nur linux-2.5.27/fs/Makefile thunder-2.5/fs/Makefile
--- linux-2.5.27/fs/Makefile	Sat Jul 20 13:11:05 2002
+++ thunder-2.5/fs/Makefile	Mon Jul 22 06:36:26 2002
@@ -7,8 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o dquot.o \
-		mpage.o
+export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
diff -Nur linux-2.5.27/net/core/Makefile thunder-2.5/net/core/Makefile
--- linux-2.5.27/net/core/Makefile	Sat Jul 20 13:12:21 2002
+++ thunder-2.5/net/core/Makefile	Mon Jul 22 06:36:45 2002
@@ -2,7 +2,7 @@
 # Makefile for the Linux networking core.
 #
 
-export-objs := ext8022.o netfilter.o profile.o
+export-objs := ext8022.o
 
 obj-y := sock.o skbuff.o iovec.o datagram.o scm.o
 
diff -Nur linux-2.5.27/net/ipv4/Makefile thunder-2.5/net/ipv4/Makefile
--- linux-2.5.27/net/ipv4/Makefile	Sat Jul 20 13:11:11 2002
+++ thunder-2.5/net/ipv4/Makefile	Mon Jul 22 06:37:09 2002
@@ -2,8 +2,6 @@
 # Makefile for the Linux TCP/IP (INET) layer.
 #
 
-export-objs = ipip.o ip_gre.o
-
 obj-y     := utils.o route.o inetpeer.o proc.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 	     ip_output.o ip_sockglue.o \
diff -Nur linux-2.5.27/net/ipv4/netfilter/Makefile thunder-2.5/net/ipv4/netfilter/Makefile
--- linux-2.5.27/net/ipv4/netfilter/Makefile	Sat Jul 20 13:11:11 2002
+++ thunder-2.5/net/ipv4/netfilter/Makefile	Mon Jul 22 06:37:23 2002
@@ -2,7 +2,7 @@
 # Makefile for the netfilter modules on top of IPv4.
 #
 
-export-objs  := ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o \
+export-objs  := ip_conntrack_standalone.o ip_nat_standalone.o \
 		ip_tables.o arp_tables.o ip_conntrack_ftp.o \
 		ip_conntrack_irc.o
 
diff -Nur linux-2.5.27/net/ipx/Makefile thunder-2.5/net/ipx/Makefile
--- linux-2.5.27/net/ipx/Makefile	Sat Jul 20 13:11:10 2002
+++ thunder-2.5/net/ipx/Makefile	Mon Jul 22 06:37:35 2002
@@ -2,7 +2,7 @@
 # Makefile for the Linux IPX layer.
 #
 
-export-objs = af_ipx.o af_spx.o
+export-objs = af_ipx.o
 
 obj-$(CONFIG_IPX) += ipx.o
 
diff -Nur linux-2.5.27/net/netlink/Makefile thunder-2.5/net/netlink/Makefile
--- linux-2.5.27/net/netlink/Makefile	Sat Jul 20 13:11:14 2002
+++ thunder-2.5/net/netlink/Makefile	Mon Jul 22 06:37:51 2002
@@ -2,8 +2,6 @@
 # Makefile for the netlink driver.
 #
 
-export-objs := af_netlink.o
-
 obj-y  				:= af_netlink.o
 obj-$(CONFIG_NETLINK_DEV)	+= netlink_dev.o
 
diff -Nur linux-2.5.27/sound/core/Makefile thunder-2.5/sound/core/Makefile
--- linux-2.5.27/sound/core/Makefile	Sat Jul 20 13:11:09 2002
+++ thunder-2.5/sound/core/Makefile	Mon Jul 22 06:38:04 2002
@@ -3,7 +3,7 @@
 # Copyright (c) 1999,2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-export-objs  := sound.o pcm.o pcm_lib.o rawmidi.o timer.o rtctimer.o hwdep.o
+export-objs  := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o
 
 snd-objs     := sound.o init.o isadma.o memory.o info.o control.o misc.o \
                 device.o wrappers.o
diff -Nur linux-2.5.27/sound/core/seq/Makefile thunder-2.5/sound/core/seq/Makefile
--- linux-2.5.27/sound/core/seq/Makefile	Sat Jul 20 13:12:18 2002
+++ thunder-2.5/sound/core/seq/Makefile	Mon Jul 22 06:38:24 2002
@@ -8,7 +8,7 @@
   obj-$(CONFIG_SND_SEQUENCER) += oss/
 endif
 
-export-objs  := seq_device.o seq.o seq_ports.o seq_instr.o seq_midi_emul.o \
+export-objs  := seq_device.o seq.o seq_instr.o seq_midi_emul.o \
 		seq_midi_event.o seq_virmidi.o
 
 snd-seq-device-objs := seq_device.o
diff -Nur linux-2.5.27/sound/isa/sb/Makefile thunder-2.5/sound/isa/sb/Makefile
--- linux-2.5.27/sound/isa/sb/Makefile	Sat Jul 20 13:11:15 2002
+++ thunder-2.5/sound/isa/sb/Makefile	Mon Jul 22 06:38:42 2002
@@ -3,7 +3,7 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-export-objs  := emu8000.o emu8000_synth.o sb_common.o sb8_main.o sb16_main.o sb16_csp.o
+export-objs  := emu8000.o sb_common.o sb8_main.o sb16_main.o sb16_csp.o
 
 snd-sb-common-objs := sb_common.o sb_mixer.o
 snd-sb8-dsp-objs := sb8_main.o sb8_midi.o
diff -Nur linux-2.5.27/sound/oss/Makefile thunder-2.5/sound/oss/Makefile
--- linux-2.5.27/sound/oss/Makefile	Sat Jul 20 13:11:12 2002
+++ thunder-2.5/sound/oss/Makefile	Mon Jul 22 06:39:23 2002
@@ -6,10 +6,9 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs	:=  ad1848.o audio_syms.o midi_syms.o mpu401.o \
-		    msnd.o opl3.o sb_common.o sequencer_syms.o \
-		    sound_syms.o uart401.o	\
-		    nm256_audio.o ac97.o ac97_codec.o aci.o
+export-objs	:=  ad1848.o audio_syms.o midi_syms.o mpu401.o ac97_codec.o \
+		    msnd.o opl3.o sb_common.o sequencer_syms.o ac97.o aci.o \
+		    sound_syms.o uart401.o
 
 # Each configuration option enables a list of files.
 

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

