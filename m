Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSH1RFq>; Wed, 28 Aug 2002 13:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSH1RFq>; Wed, 28 Aug 2002 13:05:46 -0400
Received: from pD9E23990.dip.t-dialin.net ([217.226.57.144]:38338 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315748AbSH1RFf>; Wed, 28 Aug 2002 13:05:35 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing Lost <linux-kernel@vger.kernel.org>,
       Kai Germaschewsky <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH][2.5] Export symbols v5
X-Mailer: Lightweight Patch Manager
Message-ID: <20020828170846.9E0DE0@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Wed, 28 Aug 2002 17:08:46 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, this  time goes the correct  patch. I've sent  v4 previously, by
accident...

diff -Nurp linux-2.5.32/arch/arm/mach-clps711x/Makefile thunder-2.5/arch/arm/mach-clps711x/Makefile
--- linux-2.5.32/arch/arm/mach-clps711x/Makefile	Tue Aug 27 13:27:33 2002
+++ thunder-2.5/arch/arm/mach-clps711x/Makefile	Wed Aug 28 10:30:17 2002
@@ -14,8 +14,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-export-objs		:= leds-p720t.o
-
 obj-$(CONFIG_ARCH_AUTCPU12) += autcpu12.o
 obj-$(CONFIG_ARCH_CDB89712) += cdb89712.o
 obj-$(CONFIG_ARCH_CLEP7312) += clep7312.o
diff -Nurp linux-2.5.32/arch/arm/mach-ftvpci/Makefile thunder-2.5/arch/arm/mach-ftvpci/Makefile
--- linux-2.5.32/arch/arm/mach-ftvpci/Makefile	Tue Aug 27 13:27:32 2002
+++ thunder-2.5/arch/arm/mach-ftvpci/Makefile	Wed Aug 28 10:30:17 2002
@@ -14,7 +14,7 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-export-objs		:= 
+export-objs		:= leds.o
 
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_LEDS)	+= leds.o
diff -Nurp linux-2.5.32/arch/arm/mach-integrator/Makefile thunder-2.5/arch/arm/mach-integrator/Makefile
--- linux-2.5.32/arch/arm/mach-integrator/Makefile	Tue Aug 27 13:27:31 2002
+++ thunder-2.5/arch/arm/mach-integrator/Makefile	Wed Aug 28 10:30:17 2002
@@ -14,8 +14,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-export-objs		:= leds.o
-
 obj-$(CONFIG_LEDS)	+= leds.o
 obj-$(CONFIG_PCI)	+= pci_v3.o pci.o
 
diff -Nurp linux-2.5.32/arch/arm/mach-pxa/Makefile thunder-2.5/arch/arm/mach-pxa/Makefile
--- linux-2.5.32/arch/arm/mach-pxa/Makefile	Tue Aug 27 13:26:43 2002
+++ thunder-2.5/arch/arm/mach-pxa/Makefile	Wed Aug 28 10:30:17 2002
@@ -12,7 +12,7 @@ obj-m :=
 obj-n :=
 obj-  :=
 
-export-objs := generic.o irq.o dma.o sa1111.o
+export-objs := generic.o dma.o sa1111.o
 
 # Common support (must be linked before board specific support)
 obj-y += generic.o irq.o dma.o
diff -Nurp linux-2.5.32/arch/arm/mach-sa1100/Makefile thunder-2.5/arch/arm/mach-sa1100/Makefile
--- linux-2.5.32/arch/arm/mach-sa1100/Makefile	Tue Aug 27 13:27:34 2002
+++ thunder-2.5/arch/arm/mach-sa1100/Makefile	Wed Aug 28 10:30:17 2002
@@ -11,8 +11,7 @@ obj-n :=
 obj-  :=
 led-y := leds.o
 
-export-objs :=	dma.o generic.o irq.o pcipool.o sa1111.o sa1111-pcibuf.o \
-		usb_ctl.o usb_recv.o usb_send.o pm.o
+export-objs :=	dma.o generic.o pcipool.o sa1111.o sa1111-pcibuf.o pm.o
 
 # This needs to be cleaned up.  We probably need to have SA1100
 # and SA1110 config symbols.
diff -Nurp linux-2.5.32/arch/i386/kernel/Makefile thunder-2.5/arch/i386/kernel/Makefile
--- linux-2.5.32/arch/i386/kernel/Makefile	Tue Aug 27 13:26:36 2002
+++ thunder-2.5/arch/i386/kernel/Makefile	Wed Aug 28 10:30:17 2002
@@ -6,7 +6,7 @@ EXTRA_TARGETS := kernel.o head.o init_ta
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o msr.o i386_ksyms.o time.o
+export-objs     := mca.o i386_ksyms.o time.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -Nurp linux-2.5.32/arch/m68k/hp300/Makefile thunder-2.5/arch/m68k/hp300/Makefile
--- linux-2.5.32/arch/m68k/hp300/Makefile	Tue Aug 27 13:26:33 2002
+++ thunder-2.5/arch/m68k/hp300/Makefile	Wed Aug 28 10:30:17 2002
@@ -9,8 +9,6 @@
 
 O_TARGET := hp300.o
 
-export-objs	:= ksyms.o
-
 obj-y		:= ksyms.o config.o ints.o time.o reboot.o
 
 obj-$(CONFIG_VT)	+= hil.o
diff -Nurp linux-2.5.32/arch/m68k/sun3x/Makefile thunder-2.5/arch/m68k/sun3x/Makefile
--- linux-2.5.32/arch/m68k/sun3x/Makefile	Tue Aug 27 13:26:41 2002
+++ thunder-2.5/arch/m68k/sun3x/Makefile	Wed Aug 28 10:30:17 2002
@@ -9,6 +9,8 @@
 
 O_TARGET := sun3x.o
 
+export-objs	:= sun3x_ksyms.o
+
 obj-y		:= config.o time.o dvma.o prom.o
 
 include $(TOPDIR)/Rules.make
diff -Nurp linux-2.5.32/arch/mips/au1000/common/Makefile thunder-2.5/arch/mips/au1000/common/Makefile
--- linux-2.5.32/arch/mips/au1000/common/Makefile	Tue Aug 27 13:27:32 2002
+++ thunder-2.5/arch/mips/au1000/common/Makefile	Wed Aug 28 10:30:17 2002
@@ -8,6 +8,8 @@
 
 O_TARGET := au1000.o
 
+export-objs := serial.o
+
 obj-y := prom.o dbg_io.o int-handler.o irq.o puts.o time.o reset.o
 
 obj-$(CONFIG_AU1000_UART) += serial.o             
diff -Nurp linux-2.5.32/arch/ppc/amiga/Makefile thunder-2.5/arch/ppc/amiga/Makefile
--- linux-2.5.32/arch/ppc/amiga/Makefile	Tue Aug 27 13:26:41 2002
+++ thunder-2.5/arch/ppc/amiga/Makefile	Wed Aug 28 10:30:17 2002
@@ -11,8 +11,6 @@
 
 O_TARGET := amiga.o
 
-export-objs	:= amiga_ksyms.o
-
 obj-y		:= config.o amiints.o cia.o time.o bootinfo.o amisound.o \
 			chipram.o amiga_ksyms.o
 
diff -Nurp linux-2.5.32/drivers/base/fs/Makefile thunder-2.5/drivers/base/fs/Makefile
--- linux-2.5.32/drivers/base/fs/Makefile	Tue Aug 27 13:26:43 2002
+++ thunder-2.5/drivers/base/fs/Makefile	Wed Aug 28 10:55:49 2002
@@ -1,5 +1,5 @@
 obj-y		:= device.o bus.o driver.o class.o intf.o
 
-export-objs	:= device.o bus.o driver.o class.o intf.o
+export-objs	:= device.o bus.o driver.o class.o
 
 include $(TOPDIR)/Rules.make
diff -Nurp linux-2.5.32/drivers/block/Makefile thunder-2.5/drivers/block/Makefile
--- linux-2.5.32/drivers/block/Makefile	Tue Aug 27 13:27:10 2002
+++ thunder-2.5/drivers/block/Makefile	Wed Aug 28 10:30:17 2002
@@ -8,8 +8,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o genhd.o \
-		   block_ioctl.o acsi.o
+export-objs	:= elevator.o ll_rw_blk.o loop.o genhd.o acsi.o \
+		   block_ioctl.o
 
 obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o
 
diff -Nurp linux-2.5.32/drivers/char/Makefile thunder-2.5/drivers/char/Makefile
--- linux-2.5.32/drivers/char/Makefile	Tue Aug 27 13:27:32 2002
+++ thunder-2.5/drivers/char/Makefile	Wed Aug 28 10:56:14 2002
@@ -12,10 +12,9 @@ obj-y	 += mem.o tty_io.o n_tty.o tty_ioc
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
-			misc.o pty.o random.o selection.o \
-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
-			ip2main.o
+export-objs     :=	busmouse.o console.o sysrq.o ip2main.o \
+			misc.o random.o selection.o ite_gpio.o rtc.o \
+			sonypi.o tty_io.o tty_ioctl.o generic_serial.o
 
 obj-$(CONFIG_VT) += vt.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += console.o defkeymap.o
diff -Nurp linux-2.5.32/drivers/char/ftape/lowlevel/Makefile thunder-2.5/drivers/char/ftape/lowlevel/Makefile
--- linux-2.5.32/drivers/char/ftape/lowlevel/Makefile	Tue Aug 27 13:26:39 2002
+++ thunder-2.5/drivers/char/ftape/lowlevel/Makefile	Wed Aug 28 10:30:17 2002
@@ -23,8 +23,6 @@
 #      driver for Linux.
 #
 
-export-objs := ftape_syms.o
-
 obj-$(CONFIG_FTAPE) += ftape.o
 
 ftape-objs := ftape-init.o fdc-io.o fdc-isr.o \
diff -Nurp linux-2.5.32/drivers/char/ftape/zftape/Makefile thunder-2.5/drivers/char/ftape/zftape/Makefile
--- linux-2.5.32/drivers/char/ftape/zftape/Makefile	Tue Aug 27 13:27:05 2002
+++ thunder-2.5/drivers/char/ftape/zftape/Makefile	Wed Aug 28 10:30:17 2002
@@ -27,8 +27,6 @@
 # ZFT_OBSOLETE - enable the MTIOC_ZFTAPE_GETBLKSZ ioctl. You should
 #                leave this enabled for compatibility with taper.
 
-export-objs := zftape_syms.o
-
 obj-$(CONFIG_ZFTAPE) += zftape.o
 
 zftape-objs := zftape-rw.o zftape-ctl.o zftape-read.o \
diff -Nurp linux-2.5.32/drivers/i2c/Makefile thunder-2.5/drivers/i2c/Makefile
--- linux-2.5.32/drivers/i2c/Makefile	Tue Aug 27 13:26:32 2002
+++ thunder-2.5/drivers/i2c/Makefile	Wed Aug 28 10:30:17 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
-		   i2c-algo-ite.o i2c-proc.o
+		   i2c-algo-ite.o i2c-proc.o i2c-algo-ibm_ocp.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
diff -Nurp linux-2.5.32/drivers/ide/Makefile thunder-2.5/drivers/ide/Makefile
--- linux-2.5.32/drivers/ide/Makefile	Tue Aug 27 13:26:43 2002
+++ thunder-2.5/drivers/ide/Makefile	Wed Aug 28 10:30:17 2002
@@ -7,7 +7,7 @@
 # Note : at this point, these files are compiled on all systems.
 # In the future, some of these should be built conditionally.
 #
-export-objs		:= ide-taskfile.o ide.o ide-probe.o ataraid.o
+export-objs		:= ide-taskfile.o ide.o ide-probe.o
 
 obj-$(CONFIG_BLK_DEV_IDE)       += ide-mod.o ide-probe-mod.o
 obj-$(CONFIG_BLK_DEV_IDECS)     += ide-cs.o
diff -Nurp linux-2.5.32/drivers/message/i2o/Makefile thunder-2.5/drivers/message/i2o/Makefile
--- linux-2.5.32/drivers/message/i2o/Makefile	Tue Aug 27 13:26:35 2002
+++ thunder-2.5/drivers/message/i2o/Makefile	Wed Aug 28 10:30:17 2002
@@ -5,7 +5,7 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= i2o_pci.o i2o_core.o i2o_config.o i2o_block.o i2o_lan.o i2o_scsi.o i2o_proc.o
+export-objs	:= i2o_core.o
 
 obj-$(CONFIG_I2O_PCI)	+= i2o_pci.o
 obj-$(CONFIG_I2O)	+= i2o_core.o i2o_config.o
diff -Nurp linux-2.5.32/drivers/pcmcia/Makefile thunder-2.5/drivers/pcmcia/Makefile
--- linux-2.5.32/drivers/pcmcia/Makefile	Tue Aug 27 13:26:37 2002
+++ thunder-2.5/drivers/pcmcia/Makefile	Wed Aug 28 10:30:17 2002
@@ -2,7 +2,7 @@
 # Makefile for the kernel pcmcia subsystem (c/o David Hinds)
 #
 
-export-objs := ds.o cs.o yenta.o sa1100_pcmcia.o
+export-objs := ds.o cs.o yenta.o sa1100_generic.o
 
 obj-$(CONFIG_PCMCIA)			+= pcmcia_core.o ds.o
 ifeq ($(CONFIG_CARDBUS),y)
diff -Nurp linux-2.5.32/drivers/usb/class/Makefile thunder-2.5/drivers/usb/class/Makefile
--- linux-2.5.32/drivers/usb/class/Makefile	Tue Aug 27 13:26:42 2002
+++ thunder-2.5/drivers/usb/class/Makefile	Wed Aug 28 10:56:42 2002
@@ -3,6 +3,8 @@
 # (one step up from the misc category)
 #
 
+export-objs			:= usb-midi.o
+
 obj-$(CONFIG_USB_ACM)		+= cdc-acm.o
 obj-$(CONFIG_USB_AUDIO)		+= audio.o
 obj-$(CONFIG_USB_BLUETOOTH_TTY)	+= bluetty.o
diff -Nurp linux-2.5.32/drivers/video/Makefile thunder-2.5/drivers/video/Makefile
--- linux-2.5.32/drivers/video/Makefile	Tue Aug 27 13:26:34 2002
+++ thunder-2.5/drivers/video/Makefile	Wed Aug 28 10:30:17 2002
@@ -6,12 +6,11 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs    	:= fbmem.o fbcmap.o fbcon.o fbmon.o modedb.o \
-		   fbcon-afb.o fbcon-ilbm.o fbcon-accel.o \
-		   fbcon-vga.o fbcon-iplan2p2.o fbcon-iplan2p4.o \
+		   fbcon-afb.o fbcon-ilbm.o fbcon-accel.o cyber2000fb.o \
+		   fbcon-iplan2p2.o fbcon-iplan2p4.o fbgen.o \
 		   fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		   fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
-		   fbcon-cfb8.o fbcon-mfb.o fbcon-hga.o \
-		   cyber2000fb.o sa1100fb.o fbgen.o
+		   fbcon-cfb8.o fbcon-mfb.o fbcon-hga.o
 
 # Each configuration option enables a list of files.
 
diff -Nurp linux-2.5.32/fs/partitions/Makefile thunder-2.5/fs/partitions/Makefile
--- linux-2.5.32/fs/partitions/Makefile	Tue Aug 27 13:26:41 2002
+++ thunder-2.5/fs/partitions/Makefile	Wed Aug 28 10:30:17 2002
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-export-objs := check.o msdos.o
+export-objs := msdos.o
 
 obj-y := check.o
 
diff -Nurp linux-2.5.32/net/802/Makefile thunder-2.5/net/802/Makefile
--- linux-2.5.32/net/802/Makefile	Tue Aug 27 13:26:41 2002
+++ thunder-2.5/net/802/Makefile	Wed Aug 28 10:30:17 2002
@@ -2,7 +2,7 @@
 # Makefile for the Linux 802.x protocol layers.
 #
 
-export-objs		:= p8022.o psnap.o tr.o
+export-objs		:= p8022.o psnap.o
 
 obj-y			:= p8023.o
 
diff -Nurp linux-2.5.32/net/ipv4/netfilter/Makefile thunder-2.5/net/ipv4/netfilter/Makefile
--- linux-2.5.32/net/ipv4/netfilter/Makefile	Tue Aug 27 13:26:37 2002
+++ thunder-2.5/net/ipv4/netfilter/Makefile	Wed Aug 28 10:57:13 2002
@@ -2,7 +2,7 @@
 # Makefile for the netfilter modules on top of IPv4.
 #
 
-export-objs  := ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o \
+export-objs  := ip_conntrack_standalone.o ip_nat_standalone.o \
 		ip_tables.o arp_tables.o
 
 # objects for the conntrack and NAT core (used by standalone and backw. compat)
diff -Nurp linux-2.5.32/net/ipx/Makefile thunder-2.5/net/ipx/Makefile
--- linux-2.5.32/net/ipx/Makefile	Tue Aug 27 13:27:05 2002
+++ thunder-2.5/net/ipx/Makefile	Wed Aug 28 10:30:17 2002
@@ -2,8 +2,6 @@
 # Makefile for the Linux IPX layer.
 #
 
-export-objs = af_ipx.o
-
 obj-$(CONFIG_IPX) += ipx.o
 
 ipx-y			:= af_ipx.o

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me

