Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSHZPOg>; Mon, 26 Aug 2002 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSHZPOg>; Mon, 26 Aug 2002 11:14:36 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:19633 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317434AbSHZPOb>; Mon, 26 Aug 2002 11:14:31 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Russell M King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing Lost <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] Export symbols v4
X-Mailer: Lightweight Patch Manager
Message-ID: <20020826151834.BAD621@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Mon, 26 Aug 2002 15:18:34 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from being a bit dyslexic  today (a truck with flashlights on --
woah!), I'm being  a bit productive either. I've  already done some of
the work that Zeiss needs, and I've rediffed the whole garbage that my
script produced. Here it goes.

BTW, I really  get the idea that sometimes a perl  script might do the
debugging work of ours...

diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/arm/mach-clps711x/Makefile correct-2.5/arch/arm/mach-clps711x/Makefile
--- linus-2.5/arch/arm/mach-clps711x/Makefile	Sat Aug 24 04:50:18 2002
+++ correct-2.5/arch/arm/mach-clps711x/Makefile	Sun Aug 25 08:17:49 2002
@@ -14,8 +14,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-export-objs		:= leds-p720t.o
-
 obj-$(CONFIG_ARCH_AUTCPU12) += autcpu12.o
 obj-$(CONFIG_ARCH_CDB89712) += cdb89712.o
 obj-$(CONFIG_ARCH_CLEP7312) += clep7312.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/arm/mach-ftvpci/Makefile correct-2.5/arch/arm/mach-ftvpci/Makefile
--- linus-2.5/arch/arm/mach-ftvpci/Makefile	Sat Aug 24 04:50:19 2002
+++ correct-2.5/arch/arm/mach-ftvpci/Makefile	Sun Aug 25 08:18:23 2002
@@ -14,7 +14,7 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-export-objs		:= 
+export-objs		:= leds.o
 
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_LEDS)	+= leds.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/arm/mach-integrator/Makefile correct-2.5/arch/arm/mach-integrator/Makefile
--- linus-2.5/arch/arm/mach-integrator/Makefile	Sat Aug 24 04:50:19 2002
+++ correct-2.5/arch/arm/mach-integrator/Makefile	Sun Aug 25 08:18:07 2002
@@ -14,8 +14,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-export-objs		:= leds.o
-
 obj-$(CONFIG_LEDS)	+= leds.o
 obj-$(CONFIG_PCI)	+= pci_v3.o pci.o
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/arm/mach-pxa/Makefile correct-2.5/arch/arm/mach-pxa/Makefile
--- linus-2.5/arch/arm/mach-pxa/Makefile	Sat Aug 24 04:50:19 2002
+++ correct-2.5/arch/arm/mach-pxa/Makefile	Mon Aug 26 09:04:27 2002
@@ -12,7 +12,7 @@ obj-m :=
 obj-n :=
 obj-  :=
 
-export-objs := generic.o irq.o dma.o sa1111.o
+export-objs := generic.o dma.o sa1111.o
 
 # Common support (must be linked before board specific support)
 obj-y += generic.o irq.o dma.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/arm/mach-sa1100/Makefile correct-2.5/arch/arm/mach-sa1100/Makefile
--- linus-2.5/arch/arm/mach-sa1100/Makefile	Sat Aug 24 04:50:20 2002
+++ correct-2.5/arch/arm/mach-sa1100/Makefile	Sun Aug 25 08:20:30 2002
@@ -11,8 +11,7 @@ obj-n :=
 obj-  :=
 led-y := leds.o
 
-export-objs :=	dma.o generic.o irq.o pcipool.o sa1111.o sa1111-pcibuf.o \
-		usb_ctl.o usb_recv.o usb_send.o pm.o
+export-objs :=	dma.o generic.o pcipool.o sa1111.o sa1111-pcibuf.o pm.o
 
 # This needs to be cleaned up.  We probably need to have SA1100
 # and SA1110 config symbols.
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/i386/kernel/Makefile correct-2.5/arch/i386/kernel/Makefile
--- linus-2.5/arch/i386/kernel/Makefile	Sat Aug 24 04:50:25 2002
+++ correct-2.5/arch/i386/kernel/Makefile	Sun Aug 25 08:20:53 2002
@@ -6,7 +6,7 @@ EXTRA_TARGETS := kernel.o head.o init_ta
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o msr.o i386_ksyms.o time.o
+export-objs     := mca.o i386_ksyms.o time.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/m68k/hp300/Makefile correct-2.5/arch/m68k/hp300/Makefile
--- linus-2.5/arch/m68k/hp300/Makefile	Sat Aug 24 04:50:38 2002
+++ correct-2.5/arch/m68k/hp300/Makefile	Sun Aug 25 08:22:55 2002
@@ -9,8 +9,6 @@
 
 O_TARGET := hp300.o
 
-export-objs	:= ksyms.o
-
 obj-y		:= ksyms.o config.o ints.o time.o reboot.o
 
 obj-$(CONFIG_VT)	+= hil.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/m68k/sun3x/Makefile correct-2.5/arch/m68k/sun3x/Makefile
--- linus-2.5/arch/m68k/sun3x/Makefile	Sat Aug 24 04:50:43 2002
+++ correct-2.5/arch/m68k/sun3x/Makefile	Sun Aug 25 08:23:25 2002
@@ -9,6 +9,8 @@
 
 O_TARGET := sun3x.o
 
+export-objs	:= sun3x_ksyms.o
+
 obj-y		:= config.o time.o dvma.o prom.o
 
 include $(TOPDIR)/Rules.make
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/mips/au1000/common/Makefile correct-2.5/arch/mips/au1000/common/Makefile
--- linus-2.5/arch/mips/au1000/common/Makefile	Sat Aug 24 04:50:44 2002
+++ correct-2.5/arch/mips/au1000/common/Makefile	Sun Aug 25 08:24:13 2002
@@ -8,6 +8,8 @@
 
 O_TARGET := au1000.o
 
+export-objs := serial.o
+
 obj-y := prom.o dbg_io.o int-handler.o irq.o puts.o time.o reset.o
 
 obj-$(CONFIG_AU1000_UART) += serial.o             
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/arch/ppc/amiga/Makefile correct-2.5/arch/ppc/amiga/Makefile
--- linus-2.5/arch/ppc/amiga/Makefile	Sat Aug 24 04:50:58 2002
+++ correct-2.5/arch/ppc/amiga/Makefile	Sun Aug 25 08:24:31 2002
@@ -11,8 +11,6 @@
 
 O_TARGET := amiga.o
 
-export-objs	:= amiga_ksyms.o
-
 obj-y		:= config.o amiints.o cia.o time.o bootinfo.o amisound.o \
 			chipram.o amiga_ksyms.o
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/block/Makefile correct-2.5/drivers/block/Makefile
--- linus-2.5/drivers/block/Makefile	Sat Aug 24 04:51:40 2002
+++ correct-2.5/drivers/block/Makefile	Sun Aug 25 08:25:27 2002
@@ -8,8 +8,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o genhd.o \
-		   block_ioctl.o acsi.o
+export-objs	:= elevator.o ll_rw_blk.o loop.o genhd.o acsi.o \
+		   block_ioctl.o
 
 obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/char/Makefile correct-2.5/drivers/char/Makefile
--- linus-2.5/drivers/char/Makefile	Sat Aug 24 04:51:45 2002
+++ correct-2.5/drivers/char/Makefile	Sun Aug 25 08:27:12 2002
@@ -12,10 +12,9 @@ obj-y	 += mem.o tty_io.o n_tty.o tty_ioc
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
-			misc.o pty.o random.o selection.o \
-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o \
-			ip2main.o
+export-objs     :=	busmouse.o console.o keyboard.o sysrq.o ip2main.o \
+			misc.o random.o selection.o ite_gpio.o rtc.o \
+			sonypi.o tty_io.o tty_ioctl.o generic_serial.o
 
 KEYMAP   =defkeymap.o
 KEYBD    =pc_keyb.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/char/ftape/lowlevel/Makefile correct-2.5/drivers/char/ftape/lowlevel/Makefile
--- linus-2.5/drivers/char/ftape/lowlevel/Makefile	Sat Aug 24 04:51:55 2002
+++ correct-2.5/drivers/char/ftape/lowlevel/Makefile	Sun Aug 25 08:25:52 2002
@@ -23,8 +23,6 @@
 #      driver for Linux.
 #
 
-export-objs := ftape_syms.o
-
 obj-$(CONFIG_FTAPE) += ftape.o
 
 ftape-objs := ftape-init.o fdc-io.o fdc-isr.o \
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/char/ftape/zftape/Makefile correct-2.5/drivers/char/ftape/zftape/Makefile
--- linus-2.5/drivers/char/ftape/zftape/Makefile	Sat Aug 24 04:51:55 2002
+++ correct-2.5/drivers/char/ftape/zftape/Makefile	Sun Aug 25 08:26:06 2002
@@ -27,8 +27,6 @@
 # ZFT_OBSOLETE - enable the MTIOC_ZFTAPE_GETBLKSZ ioctl. You should
 #                leave this enabled for compatibility with taper.
 
-export-objs := zftape_syms.o
-
 obj-$(CONFIG_ZFTAPE) += zftape.o
 
 zftape-objs := zftape-rw.o zftape-ctl.o zftape-read.o \
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/i2c/Makefile correct-2.5/drivers/i2c/Makefile
--- linus-2.5/drivers/i2c/Makefile	Sat Aug 24 04:52:00 2002
+++ correct-2.5/drivers/i2c/Makefile	Sun Aug 25 08:28:53 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
-		   i2c-algo-ite.o i2c-proc.o
+		   i2c-algo-ite.o i2c-proc.o i2c-algo-ibm_ocp.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/ide/Makefile correct-2.5/drivers/ide/Makefile
--- linus-2.5/drivers/ide/Makefile	Sat Aug 24 04:52:01 2002
+++ correct-2.5/drivers/ide/Makefile	Sun Aug 25 08:29:14 2002
@@ -7,7 +7,7 @@
 # Note : at this point, these files are compiled on all systems.
 # In the future, some of these should be built conditionally.
 #
-export-objs		:= ide-taskfile.o ide.o ide-probe.o ataraid.o
+export-objs		:= ide-taskfile.o ide.o ide-probe.o
 
 obj-$(CONFIG_BLK_DEV_IDE)       += ide-mod.o ide-probe-mod.o
 obj-$(CONFIG_BLK_DEV_IDECS)     += ide-cs.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/message/i2o/Makefile correct-2.5/drivers/message/i2o/Makefile
--- linus-2.5/drivers/message/i2o/Makefile	Sat Aug 24 04:52:21 2002
+++ correct-2.5/drivers/message/i2o/Makefile	Sun Aug 25 08:30:14 2002
@@ -5,7 +5,7 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= i2o_pci.o i2o_core.o i2o_config.o i2o_block.o i2o_lan.o i2o_scsi.o i2o_proc.o
+export-objs	:= i2o_core.o
 
 obj-$(CONFIG_I2O_PCI)	+= i2o_pci.o
 obj-$(CONFIG_I2O)	+= i2o_core.o i2o_config.o
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/pcmcia/Makefile correct-2.5/drivers/pcmcia/Makefile
--- linus-2.5/drivers/pcmcia/Makefile	Sat Aug 24 04:52:53 2002
+++ correct-2.5/drivers/pcmcia/Makefile	Sun Aug 25 08:30:53 2002
@@ -2,7 +2,7 @@
 # Makefile for the kernel pcmcia subsystem (c/o David Hinds)
 #
 
-export-objs := ds.o cs.o yenta.o sa1100_pcmcia.o
+export-objs := ds.o cs.o yenta.o sa1100_generic.o
 
 obj-$(CONFIG_PCMCIA)			+= pcmcia_core.o ds.o
 ifeq ($(CONFIG_CARDBUS),y)
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/usb/class/Makefile correct-2.5/drivers/usb/class/Makefile
--- linus-2.5/drivers/usb/class/Makefile	Sat Aug 24 04:53:23 2002
+++ correct-2.5/drivers/usb/class/Makefile	Sun Aug 25 08:31:28 2002
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
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/drivers/video/Makefile correct-2.5/drivers/video/Makefile
--- linus-2.5/drivers/video/Makefile	Sat Aug 24 04:53:33 2002
+++ correct-2.5/drivers/video/Makefile	Sun Aug 25 08:32:15 2002
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
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/fs/partitions/Makefile correct-2.5/fs/partitions/Makefile
--- linus-2.5/fs/partitions/Makefile	Sat Aug 24 04:54:00 2002
+++ correct-2.5/fs/partitions/Makefile	Sun Aug 25 08:32:36 2002
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-export-objs := check.o msdos.o
+export-objs := msdos.o
 
 obj-y := check.o
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/net/802/Makefile correct-2.5/net/802/Makefile
--- linus-2.5/net/802/Makefile	Sat Aug 24 04:55:28 2002
+++ correct-2.5/net/802/Makefile	Sun Aug 25 08:32:50 2002
@@ -2,7 +2,7 @@
 # Makefile for the Linux 802.x protocol layers.
 #
 
-export-objs		:= p8022.o psnap.o tr.o
+export-objs		:= p8022.o psnap.o
 
 obj-y			:= p8023.o
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/net/ipv4/netfilter/Makefile correct-2.5/net/ipv4/netfilter/Makefile
--- linus-2.5/net/ipv4/netfilter/Makefile	Sat Aug 24 04:55:34 2002
+++ correct-2.5/net/ipv4/netfilter/Makefile	Sun Aug 25 08:33:19 2002
@@ -2,7 +2,7 @@
 # Makefile for the netfilter modules on top of IPv4.
 #
 
-export-objs  := ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o \
+export-objs  := ip_conntrack_standalone.o ip_nat_standalone.o \
 		ip_tables.o arp_tables.o ip_conntrack_ftp.o \
 		ip_conntrack_irc.o
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet linus-2.5/net/ipx/Makefile correct-2.5/net/ipx/Makefile
--- linus-2.5/net/ipx/Makefile	Sat Aug 24 04:55:37 2002
+++ correct-2.5/net/ipx/Makefile	Sun Aug 25 08:33:39 2002
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

