Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSK2NwH>; Fri, 29 Nov 2002 08:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSK2NwH>; Fri, 29 Nov 2002 08:52:07 -0500
Received: from skunk.directfb.org ([212.84.236.169]:10441 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S267041AbSK2Nvg>; Fri, 29 Nov 2002 08:51:36 -0500
Date: Fri, 29 Nov 2002 14:58:16 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: linux-kernel@vger.kernel.org
Cc: marcelo@connective.com.br
Subject: [PATCH] vmwarefb 0.6.0 (Linux 2.4.20)
Message-ID: <20021129135816.GA30108@skunk>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hi,

this is an updated patch of the vmware framebuffer driver.
Copyright headers are fixed now. Some users asked me to
post this patch here to have it included in the official
tree.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="vmwarefb-0.6.0-linux-2.4.20.patch"

diff -uraN linux-2.4.20/CREDITS linux-2.4.20-vmwarefb/CREDITS
--- linux-2.4.20/CREDITS	2002-11-29 13:18:20.000000000 +0100
+++ linux-2.4.20-vmwarefb/CREDITS	2002-11-29 13:25:32.000000000 +0100
@@ -1688,6 +1688,7 @@
 E: dok@directfb.org
 D: NeoMagic framebuffer driver
 D: CyberPro 32 bit support, fixes
+D: VMware framebuffer driver
 S: Badensche Str. 46
 S: 10715 Berlin
 S: Germany
diff -uraN linux-2.4.20/drivers/video/Config.in linux-2.4.20-vmwarefb/drivers/video/Config.in
--- linux-2.4.20/drivers/video/Config.in	2002-11-29 13:18:42.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/Config.in	2002-11-29 13:28:40.000000000 +0100
@@ -147,6 +147,7 @@
 	    bool '    SIS 315H/315 support' CONFIG_FB_SIS_315
 	 fi
 	 tristate '  NeoMagic display support (EXPERIMENTAL)' CONFIG_FB_NEOMAGIC
+	 tristate '  VMware SVGA display support (EXPERIMENTAL)' CONFIG_FB_VMWARE_SVGA
 	 tristate '  3Dfx Banshee/Voodoo3 display support (EXPERIMENTAL)' CONFIG_FB_3DFX
 	 tristate '  3Dfx Voodoo Graphics (sst1) support (EXPERIMENTAL)' CONFIG_FB_VOODOO1
 	 tristate '  Trident support (EXPERIMENTAL)' CONFIG_FB_TRIDENT
@@ -292,7 +293,8 @@
 	   "$CONFIG_FB_PMAG_BA" = "y" -o "$CONFIG_FB_PMAGB_B" = "y" -o \
 	   "$CONFIG_FB_MAXINE" = "y" -o "$CONFIG_FB_TX3912" = "y" -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
-	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" ]; then
+	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o \
+	   "$CONFIG_FB_VMWARE_SVGA" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB8 y
       else
 	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_ATARI" = "m" -o \
@@ -314,7 +316,7 @@
 	      "$CONFIG_FB_MAXINE" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_TX3912" = "m" -o "$CONFIG_FB_NEOMAGIC" = "m" -o \
-	      "$CONFIG_FB_STI" = "m" ]; then
+	      "$CONFIG_FB_STI" = "m" -o "$CONFIG_FB_VMWARE_SVGA" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB8 m
 	 fi
       fi
@@ -332,7 +334,7 @@
 	   "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_3DFX" = "y"  -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_SA1100" = "y" -o \
 	   "$CONFIG_FB_PVR2" = "y" -o "$CONFIG_FB_VOODOO1" = "y" -o \
-	   "$CONFIG_FB_NEOMAGIC" = "y" ]; then
+	   "$CONFIG_FB_NEOMAGIC" = "y" -o "$CONFIG_FB_VMWARE_SVGA" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB16 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -349,7 +351,7 @@
 	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_VOODOO1" = "m" -o \
-	      "$CONFIG_FB_NEOMAGIC" = "m" ]; then
+	      "$CONFIG_FB_NEOMAGIC" = "m" -o "$CONFIG_FB_VMWARE_SVGA" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB16 m
 	 fi
       fi
@@ -358,7 +360,8 @@
 	   "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
            "$CONFIG_FB_ATY128" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
 	   "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
-	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" ]; then
+	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
+	   "$CONFIG_FB_VMWARE_SVGA" = "y" -o "$CONFIG_FB_VMWARE_SVGA" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB24 y
       else
 	 if [ "$CONFIG_FB_ATY" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
@@ -366,7 +369,8 @@
 	      "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
 	      "$CONFIG_FB_ATY128" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_PVR2" = "m" -o \
-	      "$CONFIG_FB_VOODOO1" = "m" -o "$CONFIG_FB_NEOMAGIC" = "m" ]; then
+	      "$CONFIG_FB_VOODOO1" = "m" -o "$CONFIG_FB_NEOMAGIC" = "m" -o \
+	      "$CONFIG_FB_VMWARE_SVGA" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB24 m
 	 fi
       fi
@@ -381,7 +385,7 @@
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
 	   "$CONFIG_FB_3DFX" = "y" -o "$CONFIG_FB_SIS" = "y" -o \
 	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
-	   "$CONFIG_FB_STI" = "y" ]; then
+	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_VMWARE_SVGA" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB32 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -394,7 +398,8 @@
 	      "$CONFIG_FB_3DFX" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_VOODOO1" = "m" -o \
-	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_STI" = "y" ]; then
+	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_STI" = "y" -o \
+	      "$CONFIG_FB_VMWARE_SVGA" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
       fi
diff -uraN linux-2.4.20/drivers/video/Makefile linux-2.4.20-vmwarefb/drivers/video/Makefile
--- linux-2.4.20/drivers/video/Makefile	2002-11-29 13:18:42.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/Makefile	2002-11-29 13:24:53.000000000 +0100
@@ -107,6 +107,11 @@
 obj-y				  += riva/rivafb.o
 endif
 
+subdir-$(CONFIG_FB_VMWARE_SVGA)	  += vmware
+ifeq ($(CONFIG_FB_VMWARE_SVGA),y)
+obj-y				  += vmware/vmware.o
+endif
+
 subdir-$(CONFIG_FB_SIS)		  += sis
 ifeq ($(CONFIG_FB_SIS),y)
 obj-y				  += sis/sisfb.o
diff -uraN linux-2.4.20/drivers/video/fbmem.c linux-2.4.20-vmwarefb/drivers/video/fbmem.c
--- linux-2.4.20/drivers/video/fbmem.c	2002-11-29 13:18:43.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/fbmem.c	2002-11-29 13:24:53.000000000 +0100
@@ -76,6 +76,8 @@
 extern int aty128fb_setup(char*);
 extern int neofb_init(void);
 extern int neofb_setup(char*);
+extern int vmwarefb_init(void);
+extern int vmwarefb_setup(char*);
 extern int igafb_init(void);
 extern int igafb_setup(char*);
 extern int imsttfb_init(void);
@@ -190,6 +192,9 @@
 #ifdef CONFIG_FB_NEOMAGIC
 	{ "neo", neofb_init, neofb_setup },
 #endif
+#ifdef CONFIG_FB_VMWARE_SVGA
+	{ "vmware", vmwarefb_init, vmwarefb_setup },
+#endif
 #ifdef CONFIG_FB_VIRGE
 	{ "virge", virgefb_init, virgefb_setup },
 #endif
diff -uraN linux-2.4.20/drivers/video/vmware/Makefile linux-2.4.20-vmwarefb/drivers/video/vmware/Makefile
--- linux-2.4.20/drivers/video/vmware/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/vmware/Makefile	2002-11-29 13:24:53.000000000 +0100
@@ -0,0 +1,15 @@
+#
+# Makefile for the VMware SVGA framebuffer driver
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile...
+
+O_TARGET := vmware.o
+
+obj-y    := vmwarefb.o
+obj-m    := $(O_TARGET)
+
+include $(TOPDIR)/Rules.make
diff -uraN linux-2.4.20/drivers/video/vmware/guest_os.h linux-2.4.20-vmwarefb/drivers/video/vmware/guest_os.h
--- linux-2.4.20/drivers/video/vmware/guest_os.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/vmware/guest_os.h	2002-11-29 13:35:53.000000000 +0100
@@ -0,0 +1,35 @@
+/*
+ * linux/drivers/video/vmware/guest_os.h -- VMware SVGA Framebuffer Driver
+ *
+ * Copyright (c) 2002  Denis Oliver Kropp <dok@directfb.org>
+ *
+ *
+ * Card specific code is based on XFree86's VMware driver.
+ * Framebuffer framework code is based on code of neofb.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ */
+
+#ifndef _GUEST_OS_H_
+#define _GUEST_OS_H_
+
+#define GUEST_OS_BASE  0x5000
+
+#define GUEST_OS_DOS        (GUEST_OS_BASE+1)
+#define GUEST_OS_WIN31      (GUEST_OS_BASE+2)
+#define GUEST_OS_WINDOWS95  (GUEST_OS_BASE+3)
+#define GUEST_OS_WINDOWS98  (GUEST_OS_BASE+4)
+#define GUEST_OS_WINDOWSME  (GUEST_OS_BASE+5)
+#define GUEST_OS_NT         (GUEST_OS_BASE+6)
+#define GUEST_OS_WIN2000    (GUEST_OS_BASE+7)
+#define GUEST_OS_LINUX      (GUEST_OS_BASE+8)
+#define GUEST_OS_OS2        (GUEST_OS_BASE+9)
+#define GUEST_OS_OTHER      (GUEST_OS_BASE+10)
+#define GUEST_OS_FREEBSD    (GUEST_OS_BASE+11)
+#define GUEST_OS_WHISTLER   (GUEST_OS_BASE+12)
+
+
+#endif 
diff -uraN linux-2.4.20/drivers/video/vmware/svga_limits.h linux-2.4.20-vmwarefb/drivers/video/vmware/svga_limits.h
--- linux-2.4.20/drivers/video/vmware/svga_limits.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/vmware/svga_limits.h	2002-11-29 13:35:50.000000000 +0100
@@ -0,0 +1,55 @@
+/*
+ * linux/drivers/video/vmware/svga_limits.h -- VMware SVGA Framebuffer Driver
+ *
+ * Copyright (c) 2002  Denis Oliver Kropp <dok@directfb.org>
+ *
+ *
+ * Card specific code is based on XFree86's VMware driver.
+ * Framebuffer framework code is based on code of neofb.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ */
+
+#ifndef _SVGA_LIMITS_H_
+#define _SVGA_LIMITS_H_
+
+/*
+ * Location and size of SVGA frame buffer.
+ */
+#define SVGA_FB_MAX_SIZE       (16*1024*1024)
+#define SVGA_MEM_SIZE          (256*1024)
+
+/*
+ * SVGA_FB_START is the default starting address of the SVGA frame
+ * buffer in the guest's physical address space.
+ * SVGA_FB_START_BIGMEM is the starting address of the SVGA frame
+ * buffer for VMs that have a large amount of physical memory.
+ *
+ * The address of SVGA_FB_START is set to 2GB - (SVGA_FB_MAX_SIZE + SVGA_MEM_SIZE), 
+ * thus the SVGA frame buffer sits at [SVGA_FB_START .. 2GB-1] in the
+ * physical address space.  Our older SVGA drivers for NT treat the
+ * address of the frame buffer as a signed integer.  For backwards
+ * compatibility, we keep the default location of the frame buffer
+ * at under 2GB in the address space.  This restricts VMs to have "only"
+ * up to ~2031MB (i.e., up to SVGA_FB_START) of physical memory.
+ *
+ * For VMs that want more memory than the ~2031MB, we place the SVGA
+ * frame buffer at SVGA_FB_START_BIGMEM.  This allows VMs to have up
+ * to 3584MB, at least as far as the SVGA frame buffer is concerned
+ * (note that there may be other issues that limit the VM memory
+ * size).  PCI devices use high memory addresses, so we have to put
+ * SVGA_FB_START_BIGMEM low enough so that it doesn't overlap with any
+ * of these devices.  Placing SVGA_FB_START_BIGMEM at 0xE0000000
+ * should leave plenty of room for the PCI devices.
+ *
+ * NOTE: All of that is only true for the 0710 chipset.  As of the 0405
+ * chipset, the framebuffer start is determined solely based on the value
+ * the guest BIOS or OS programs into the PCI base address registers.
+ */
+#define SVGA_FB_LEGACY_START		0x7EFC0000
+#define SVGA_FB_LEGACY_START_BIGMEM	0xE0000000
+
+#endif
diff -uraN linux-2.4.20/drivers/video/vmware/svga_reg.h linux-2.4.20-vmwarefb/drivers/video/vmware/svga_reg.h
--- linux-2.4.20/drivers/video/vmware/svga_reg.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/vmware/svga_reg.h	2002-11-29 13:35:50.000000000 +0100
@@ -0,0 +1,300 @@
+/*
+ * linux/drivers/video/vmware/svga_reg.h -- VMware SVGA Framebuffer Driver
+ *
+ * Copyright (c) 2002  Denis Oliver Kropp <dok@directfb.org>
+ *
+ *
+ * Card specific code is based on XFree86's VMware driver.
+ * Framebuffer framework code is based on code of neofb.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ */
+
+#ifndef _SVGA_REG_H_
+#define _SVGA_REG_H_
+
+#include "svga_limits.h"
+
+/*
+ * Memory and port addresses and fundamental constants
+ */
+
+#define SVGA_MAX_WIDTH			2364
+#define SVGA_MAX_HEIGHT			1773
+
+#ifdef VMX86_SERVER
+#define SVGA_DEFAULT_MAX_WIDTH		1600
+#define SVGA_DEFAULT_MAX_HEIGHT		1200
+#else
+#define SVGA_DEFAULT_MAX_WIDTH		SVGA_MAX_WIDTH
+#define SVGA_DEFAULT_MAX_HEIGHT		SVGA_MAX_HEIGHT
+#endif
+
+#define SVGA_MAX_BITS_PER_PIXEL		32
+#if SVGA_MAX_WIDTH * SVGA_MAX_HEIGHT * SVGA_MAX_BITS_PER_PIXEL / 8 > \
+    SVGA_FB_MAX_SIZE
+#error "Bad SVGA maximum sizes"
+#endif
+#define SVGA_MAX_PSEUDOCOLOR_DEPTH	8
+#define SVGA_MAX_PSEUDOCOLORS		(1 << SVGA_MAX_PSEUDOCOLOR_DEPTH)
+
+#define SVGA_MAGIC         0x900000
+#define SVGA_MAKE_ID(ver)  (SVGA_MAGIC << 8 | (ver))
+
+/* Version 2 let the address of the frame buffer be unsigned on Win32 */
+#define SVGA_VERSION_2     2
+#define SVGA_ID_2          SVGA_MAKE_ID(SVGA_VERSION_2)
+
+/* Version 1 has new registers starting with SVGA_REG_CAPABILITIES so
+   PALETTE_BASE has moved */
+#define SVGA_VERSION_1     1
+#define SVGA_ID_1          SVGA_MAKE_ID(SVGA_VERSION_1)
+
+/* Version 0 is the initial version */
+#define SVGA_VERSION_0     0
+#define SVGA_ID_0          SVGA_MAKE_ID(SVGA_VERSION_0)
+
+/* Invalid SVGA_ID_ */
+#define SVGA_ID_INVALID    0xFFFFFFFF
+
+/* More backwards compatibility, old location of color map: */
+#define SVGA_OLD_PALETTE_BASE	 17
+
+/* Base and Offset gets us headed the right way for PCI Base Addr Registers */
+#define SVGA_LEGACY_BASE_PORT	0x4560
+#define SVGA_INDEX_PORT		0x0
+#define SVGA_VALUE_PORT		0x1
+#define SVGA_BIOS_PORT		0x2
+#define SVGA_NUM_PORTS		0x3
+
+/* This port is deprecated, but retained because of old drivers. */
+#define SVGA_LEGACY_ACCEL_PORT	0x3
+
+/* Legal values for the SVGA_REG_CURSOR_ON register in cursor bypass mode */
+#define SVGA_CURSOR_ON_HIDE               0x0    /* Must be 0 to maintain backward compatibility */
+#define SVGA_CURSOR_ON_SHOW               0x1    /* Must be 1 to maintain backward compatibility */
+#define SVGA_CURSOR_ON_REMOVE_FROM_FB     0x2    /* Remove the cursor from the framebuffer because we need to see what's under it */
+#define SVGA_CURSOR_ON_RESTORE_TO_FB      0x3    /* Put the cursor back in the framebuffer so the user can see it */
+
+/*
+ * Registers
+ */
+
+enum {
+   SVGA_REG_ID = 0,
+   SVGA_REG_ENABLE = 1,
+   SVGA_REG_WIDTH = 2,
+   SVGA_REG_HEIGHT = 3,
+   SVGA_REG_MAX_WIDTH = 4,
+   SVGA_REG_MAX_HEIGHT = 5,
+   SVGA_REG_DEPTH = 6,
+   SVGA_REG_BITS_PER_PIXEL = 7,     /* Current bpp in the guest */
+   SVGA_REG_PSEUDOCOLOR = 8,
+   SVGA_REG_RED_MASK = 9,
+   SVGA_REG_GREEN_MASK = 10,
+   SVGA_REG_BLUE_MASK = 11,
+   SVGA_REG_BYTES_PER_LINE = 12,
+   SVGA_REG_FB_START = 13,
+   SVGA_REG_FB_OFFSET = 14,
+   SVGA_REG_FB_MAX_SIZE = 15,
+   SVGA_REG_FB_SIZE = 16,
+
+   SVGA_REG_CAPABILITIES = 17,
+   SVGA_REG_MEM_START = 18,	   /* Memory for command FIFO and bitmaps */
+   SVGA_REG_MEM_SIZE = 19,
+   SVGA_REG_CONFIG_DONE = 20,      /* Set when memory area configured */
+   SVGA_REG_SYNC = 21,             /* Write to force synchronization */
+   SVGA_REG_BUSY = 22,             /* Read to check if sync is done */
+   SVGA_REG_GUEST_ID = 23,	   /* Set guest OS identifier */
+   SVGA_REG_CURSOR_ID = 24,	   /* ID of cursor */
+   SVGA_REG_CURSOR_X = 25,	   /* Set cursor X position */
+   SVGA_REG_CURSOR_Y = 26,	   /* Set cursor Y position */
+   SVGA_REG_CURSOR_ON = 27,	   /* Turn cursor on/off */
+   SVGA_REG_HOST_BITS_PER_PIXEL = 28, /* Current bpp in the host */
+
+   SVGA_REG_TOP = 30,		   /* Must be 1 greater than the last register */
+
+   SVGA_PALETTE_BASE = 1024	   /* Base of SVGA color map */ 
+};
+
+
+/*
+ *  Capabilities
+ */
+
+#define	SVGA_CAP_RECT_FILL	 0x0001
+#define	SVGA_CAP_RECT_COPY	 0x0002
+#define	SVGA_CAP_RECT_PAT_FILL   0x0004
+#define	SVGA_CAP_OFFSCREEN       0x0008
+#define	SVGA_CAP_RASTER_OP	 0x0010
+#define	SVGA_CAP_CURSOR		 0x0020
+#define	SVGA_CAP_CURSOR_BYPASS	 0x0040
+#define	SVGA_CAP_CURSOR_BYPASS_2 0x0080
+#define	SVGA_CAP_8BIT_EMULATION  0x0100
+#define SVGA_CAP_ALPHA_CURSOR    0x0200
+
+
+/*
+ *  Raster op codes (same encoding as X) used by FIFO drivers.
+ */
+
+#define SVGA_ROP_CLEAR          0x00     /* 0 */
+#define SVGA_ROP_AND            0x01     /* src AND dst */
+#define SVGA_ROP_AND_REVERSE    0x02     /* src AND NOT dst */
+#define SVGA_ROP_COPY           0x03     /* src */
+#define SVGA_ROP_AND_INVERTED   0x04     /* NOT src AND dst */
+#define SVGA_ROP_NOOP           0x05     /* dst */
+#define SVGA_ROP_XOR            0x06     /* src XOR dst */
+#define SVGA_ROP_OR             0x07     /* src OR dst */
+#define SVGA_ROP_NOR            0x08     /* NOT src AND NOT dst */
+#define SVGA_ROP_EQUIV          0x09     /* NOT src XOR dst */
+#define SVGA_ROP_INVERT         0x0a     /* NOT dst */
+#define SVGA_ROP_OR_REVERSE     0x0b     /* src OR NOT dst */
+#define SVGA_ROP_COPY_INVERTED  0x0c     /* NOT src */
+#define SVGA_ROP_OR_INVERTED    0x0d     /* NOT src OR dst */
+#define SVGA_ROP_NAND           0x0e     /* NOT src OR NOT dst */
+#define SVGA_ROP_SET            0x0f     /* 1 */
+#define SVGA_ROP_UNSUPPORTED    0x10
+
+#define SVGA_NUM_SUPPORTED_ROPS   16
+#define SVGA_ROP_ALL            0x0000ffff
+
+/*
+ *  Memory area offsets (viewed as an array of 32-bit words)
+ */
+
+/*
+ *  The distance from MIN to MAX must be at least 10K
+ */
+
+#define	 SVGA_FIFO_MIN	      0
+#define	 SVGA_FIFO_MAX	      1
+#define	 SVGA_FIFO_NEXT_CMD   2
+#define	 SVGA_FIFO_STOP	      3
+
+#define	 SVGA_FIFO_USER_DEFINED	    4
+
+/*
+ *  Drawing object ID's, in the range 0 to SVGA_MAX_ID
+ */
+
+#define	 SVGA_MAX_ID	      499
+
+/*
+ *  Macros to compute variable length items (sizes in 32-bit words)
+ */
+
+#define SVGA_BITMAP_SIZE(w,h) ((((w)+31) >> 5) * (h))
+#define SVGA_BITMAP_SCANLINE_SIZE(w) (( (w)+31 ) >> 5)
+#define SVGA_PIXMAP_SIZE(w,h,d) ((( ((w)*(d))+31 ) >> 5) * (h))
+#define SVGA_PIXMAP_SCANLINE_SIZE(w,d) (( ((w)*(d))+31 ) >> 5)
+
+/*
+ *  Increment from one scanline to the next of a bitmap or pixmap
+ */
+#define SVGA_BITMAP_INCREMENT(w) ((( (w)+31 ) >> 5) * sizeof (uint32))
+#define SVGA_PIXMAP_INCREMENT(w,d) ((( ((w)*(d))+31 ) >> 5) * sizeof (uint32))
+
+/*
+ *  Commands in the command FIFO
+ */
+
+#define	 SVGA_CMD_UPDATE		   1
+	 /* FIFO layout:
+	    X, Y, Width, Height */
+
+#define	 SVGA_CMD_RECT_FILL		   2
+	 /* FIFO layout:
+	    Color, X, Y, Width, Height */
+
+#define	 SVGA_CMD_RECT_COPY		   3
+	 /* FIFO layout:
+	    Source X, Source Y, Dest X, Dest Y, Width, Height */
+
+#define	 SVGA_CMD_DEFINE_BITMAP		   4
+	 /* FIFO layout:
+	    Pixmap ID, Width, Height, <scanlines> */
+
+#define	 SVGA_CMD_DEFINE_BITMAP_SCANLINE   5
+	 /* FIFO layout:
+	    Pixmap ID, Width, Height, Line #, scanline */
+
+#define	 SVGA_CMD_DEFINE_PIXMAP		   6
+	 /* FIFO layout:
+	    Pixmap ID, Width, Height, Depth, <scanlines> */
+
+#define	 SVGA_CMD_DEFINE_PIXMAP_SCANLINE   7
+	 /* FIFO layout:
+	    Pixmap ID, Width, Height, Depth, Line #, scanline */
+
+#define	 SVGA_CMD_RECT_BITMAP_FILL	   8
+	 /* FIFO layout:
+	    Bitmap ID, X, Y, Width, Height, Foreground, Background */
+
+#define	 SVGA_CMD_RECT_PIXMAP_FILL	   9
+	 /* FIFO layout:
+	    Pixmap ID, X, Y, Width, Height */
+
+#define	 SVGA_CMD_RECT_BITMAP_COPY	  10
+	 /* FIFO layout:
+	    Bitmap ID, Source X, Source Y, Dest X, Dest Y,
+	    Width, Height, Foreground, Background */
+
+#define	 SVGA_CMD_RECT_PIXMAP_COPY	  11
+	 /* FIFO layout:
+	    Pixmap ID, Source X, Source Y, Dest X, Dest Y, Width, Height */
+
+#define	 SVGA_CMD_FREE_OBJECT		  12
+	 /* FIFO layout:
+	    Object (pixmap, bitmap, ...) ID */
+
+#define	 SVGA_CMD_RECT_ROP_FILL           13
+         /* FIFO layout:
+            Color, X, Y, Width, Height, ROP */
+
+#define	 SVGA_CMD_RECT_ROP_COPY           14
+         /* FIFO layout:
+            Source X, Source Y, Dest X, Dest Y, Width, Height, ROP */
+
+#define	 SVGA_CMD_RECT_ROP_BITMAP_FILL    15
+         /* FIFO layout:
+            ID, X, Y, Width, Height, Foreground, Background, ROP */
+
+#define	 SVGA_CMD_RECT_ROP_PIXMAP_FILL    16
+         /* FIFO layout:
+            ID, X, Y, Width, Height, ROP */
+
+#define	 SVGA_CMD_RECT_ROP_BITMAP_COPY    17
+         /* FIFO layout:
+            ID, Source X, Source Y,
+            Dest X, Dest Y, Width, Height, Foreground, Background, ROP */
+
+#define	 SVGA_CMD_RECT_ROP_PIXMAP_COPY    18
+         /* FIFO layout:
+            ID, Source X, Source Y, Dest X, Dest Y, Width, Height, ROP */
+
+#define	SVGA_CMD_DEFINE_CURSOR		  19
+	/* FIFO layout:
+	   ID, Hotspot X, Hotspot Y, Width, Height,
+	   Depth for AND mask, Depth for XOR mask,
+	   <scanlines for AND mask>, <scanlines for XOR mask> */
+
+#define	SVGA_CMD_DISPLAY_CURSOR		  20
+	/* FIFO layout:
+	   ID, On/Off (1 or 0) */
+
+#define	SVGA_CMD_MOVE_CURSOR		  21
+	/* FIFO layout:
+	   X, Y */
+
+#define SVGA_CMD_DEFINE_ALPHA_CURSOR      22
+	/* FIFO layout:
+	   ID, Hotspot X, Hotspot Y, Width, Height,
+	   <scanlines> */
+
+#define	SVGA_CMD_MAX			  23
+
+#endif
diff -uraN linux-2.4.20/drivers/video/vmware/vmwarefb.c linux-2.4.20-vmwarefb/drivers/video/vmware/vmwarefb.c
--- linux-2.4.20/drivers/video/vmware/vmwarefb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/vmware/vmwarefb.c	2002-11-29 13:35:53.000000000 +0100
@@ -0,0 +1,1529 @@
+/*
+ * linux/drivers/video/vmware/vmwarefb.c -- VMware SVGA Framebuffer Driver
+ *
+ * Copyright (c) 2002  Denis Oliver Kropp <dok@directfb.org>
+ *
+ *
+ * Card specific code is based on XFree86's VMware driver.
+ * Framebuffer framework code is based on code of neofb.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ *
+ * 0.6.0
+ *  - added accelerated clear and move for console acceleration (dok)
+ *  - removed VGA code that isn't needed at all in SVGA mode (dok)
+ *  - disabling acceleration is only possible after power off via "noaccel" (dok)
+ *  - added a workaround to fix console after running X (dok)
+ *
+ * 0.5.2
+ *  - take care of fb offset, fixes non-standard resolutions (dok)
+ *
+ * 0.5.1
+ *  - fixed undeclared integer when built as a module (dok)
+ *
+ * 0.5.0
+ *  - initial version (dok)
+ *
+ *
+ * TODO
+ * - support for changing bits per pixel (using 8bit emulation capability)
+ * - panning (yet unsupported by WMware)
+ * - disabling accel after bootup (requires yet unreleased VMware above 3.1)
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-cfb8.h>
+#include <video/fbcon-cfb16.h>
+#include <video/fbcon-cfb24.h>
+#include <video/fbcon-cfb32.h>
+
+#include "vmwarefb.h"
+
+#include "svga_reg.h"
+#include "guest_os.h"
+
+#define VMWAREFB_VERSION "0.6.0"
+
+/* --------------------------------------------------------------------- */
+
+static int disabled = 0;
+static int noaccel = 0;
+
+MODULE_AUTHOR("(c) 2002  Denis Oliver Kropp <dok@directfb.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FBDev driver for VMware Virtual SVGA Card");
+MODULE_PARM(disabled, "i");
+MODULE_PARM_DESC(disabled, "Disable this driver's initialization.");
+MODULE_PARM(noaccel, "i");
+MODULE_PARM_DESC(noaccel, "Disable console acceleration.");
+
+static struct fb_var_screeninfo __devinitdata vmwarefb_var640x480x8 = {
+  accel_flags:          0,
+  xres:                 640,
+  yres:                 480,
+  xres_virtual:         640,
+  yres_virtual:         480,
+  bits_per_pixel:       8,
+  pixclock:             39722,
+  left_margin:          48,
+  right_margin:         16,
+  upper_margin:         33,
+  lower_margin:         10,
+  hsync_len:            96,
+  vsync_len:            2,
+  sync:                 0,
+  vmode:                FB_VMODE_NONINTERLACED
+};
+
+static struct fb_var_screeninfo __devinitdata vmwarefb_var800x600x8 = {
+  accel_flags:          0,
+  xres:                 800,
+  yres:                 600,
+  xres_virtual:         800,
+  yres_virtual:         600,
+  bits_per_pixel:       8,
+  pixclock:             25000,
+  left_margin:  	88,
+  right_margin: 	40,
+  upper_margin: 	23,
+  lower_margin: 	1,
+  hsync_len:            128,
+  vsync_len:            4,
+  sync:                 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+  vmode:                FB_VMODE_NONINTERLACED
+};
+
+static struct fb_var_screeninfo __devinitdata vmwarefb_var1024x768x8 = {
+  accel_flags:          0,
+  xres:                 1024,
+  yres:                 768,
+  xres_virtual:         1024,
+  yres_virtual:         768,
+  bits_per_pixel:       8,
+  pixclock:             15385,
+  left_margin:          160,
+  right_margin:         24,
+  upper_margin:         29,
+  lower_margin:         3,
+  hsync_len:            136,
+  vsync_len:            6,
+  sync:                 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+  vmode:                FB_VMODE_NONINTERLACED
+};
+
+static struct fb_var_screeninfo *vmwarefb_var = &vmwarefb_var800x600x8;
+
+/* ------------------------ VMware specific functions ------------------------ */
+
+static volatile u32
+vmwareReadReg (const struct vmwarefb_info *info, int index)
+{
+  outl (index, info->indexReg);
+
+  return inl (info->valueReg);
+}
+
+static void
+vmwareWriteReg (const struct vmwarefb_info *info, int index, u32 value)
+{
+  outl (index, info->indexReg);
+  outl (value, info->valueReg);
+}
+
+static void
+vmwareWriteWordToFIFO (const struct vmwarefb_info *info, u32 value)
+{
+  u32* vmwareFIFO = info->vmwareFIFO;
+
+  if (!vmwareFIFO)
+    return;
+
+  /* Need to sync? */
+  if ((vmwareFIFO[SVGA_FIFO_NEXT_CMD] + sizeof(u32) == vmwareFIFO[SVGA_FIFO_STOP])
+      || (vmwareFIFO[SVGA_FIFO_NEXT_CMD] == vmwareFIFO[SVGA_FIFO_MAX] - sizeof(u32) &&
+          vmwareFIFO[SVGA_FIFO_STOP] == vmwareFIFO[SVGA_FIFO_MIN]))
+    {
+      vmwareWriteReg(info, SVGA_REG_SYNC, 1);
+      while (vmwareReadReg(info, SVGA_REG_BUSY)) ;
+    }
+
+  vmwareFIFO[vmwareFIFO[SVGA_FIFO_NEXT_CMD] / sizeof(u32)] = value;
+  vmwareFIFO[SVGA_FIFO_NEXT_CMD] += sizeof(u32);
+
+  if (vmwareFIFO[SVGA_FIFO_NEXT_CMD] == vmwareFIFO[SVGA_FIFO_MAX])
+    vmwareFIFO[SVGA_FIFO_NEXT_CMD] = vmwareFIFO[SVGA_FIFO_MIN];
+}
+
+static void
+vmwareWaitForFB (struct vmwarefb_info *info)
+{
+  if (info->vmwareFIFOMarkSet)
+    {
+      vmwareWriteReg (info, SVGA_REG_SYNC, 1);
+
+      while (vmwareReadReg(info, SVGA_REG_BUSY)) ;
+
+      info->vmwareFIFOMarkSet = 0;
+    }
+}
+
+static void
+vmwareSendSVGACmdUpdate (const struct vmwarefb_info *info,
+                         int x, int y, int width, int height)
+{
+  vmwareWriteWordToFIFO (info, SVGA_CMD_UPDATE);
+  vmwareWriteWordToFIFO (info, x);
+  vmwareWriteWordToFIFO (info, y);
+  vmwareWriteWordToFIFO (info, width);
+  vmwareWriteWordToFIFO (info, height);
+}
+
+static u32
+vmwareCalculateWeight (u32 mask)
+{
+  u32 weight;
+
+  for (weight = 0; mask; mask >>= 1)
+    {
+      if (mask & 1)
+        weight++;
+    }
+
+  return weight;
+}
+
+/*
+ *-----------------------------------------------------------------------------
+ *
+ * VMXGetVMwareSvgaId --
+ *
+ *    Retrieve the SVGA_ID of the VMware SVGA adapter.
+ *    This function should hide any backward compatibility mess.
+ *
+ * Results:
+ *    The SVGA_ID_* of the present VMware adapter.
+ *
+ * Side effects:
+ *    ins/outs
+ *
+ *-----------------------------------------------------------------------------
+ */
+
+static u32
+VMXGetVMwareSvgaId (const struct vmwarefb_info *info)
+{
+   u32 vmware_svga_id;
+
+   /* Any version with any SVGA_ID_* support will initialize SVGA_REG_ID
+    * to SVGA_ID_0 to support versions of this driver with SVGA_ID_0.
+    *
+    * Versions of SVGA_ID_0 ignore writes to the SVGA_REG_ID register.
+    *
+    * Versions of SVGA_ID_1 will allow us to overwrite the content
+    * of the SVGA_REG_ID register only with the values SVGA_ID_0 or SVGA_ID_1.
+    *
+    * Versions of SVGA_ID_2 will allow us to overwrite the content
+    * of the SVGA_REG_ID register only with the values SVGA_ID_0 or SVGA_ID_1
+    * or SVGA_ID_2.
+    */
+
+   vmwareWriteReg(info, SVGA_REG_ID, SVGA_ID_2);
+   vmware_svga_id = vmwareReadReg(info, SVGA_REG_ID);
+   if (vmware_svga_id == SVGA_ID_2) {
+      return SVGA_ID_2;
+   }
+
+   vmwareWriteReg(info, SVGA_REG_ID, SVGA_ID_1);
+   vmware_svga_id = vmwareReadReg(info, SVGA_REG_ID);
+   if (vmware_svga_id == SVGA_ID_1) {
+      return SVGA_ID_1;
+   }
+
+   if (vmware_svga_id == SVGA_ID_0) {
+      return SVGA_ID_0;
+   }
+
+   /* No supported VMware SVGA devices found */
+   return SVGA_ID_INVALID;
+}
+
+static void
+VMWAREInitFIFO (struct vmwarefb_info *info)
+{
+  u32* vmwareFIFO = info->vmwareFIFO;
+
+  if (vmwareFIFO)
+    return;
+
+  vmwareFIFO = (u32*) info->mmio.vbase;
+
+  vmwareFIFO[SVGA_FIFO_MIN]      = 4 * sizeof(u32);
+  vmwareFIFO[SVGA_FIFO_MAX]      = info->mmio.len;
+  vmwareFIFO[SVGA_FIFO_NEXT_CMD] = 4 * sizeof(u32);
+  vmwareFIFO[SVGA_FIFO_STOP]     = 4 * sizeof(u32);
+
+  info->vmwareFIFO = vmwareFIFO;
+  info->vmwareFIFOMarkSet = 0;
+
+  vmwareWriteReg (info, SVGA_REG_CONFIG_DONE, 1);
+}
+
+static void
+VMWAREStopFIFO (struct vmwarefb_info *info)
+{
+  u32* vmwareFIFO = info->vmwareFIFO;
+
+  if (!vmwareFIFO)
+    return;
+
+  vmwareWaitForFB (info);
+
+  /* doesn't work in current version of VMware */
+  vmwareWriteReg (info, SVGA_REG_CONFIG_DONE, 0);
+
+  info->vmwareFIFO = NULL;
+}
+
+/* -------------------------- Hardware Acceleration -------------------------- */
+
+static void
+vmware_rectfill (struct vmwarefb_info *info,
+                 int x, int y, int width, int height, u32 color)
+{
+  vmwareWriteWordToFIFO (info, SVGA_CMD_RECT_FILL);
+  vmwareWriteWordToFIFO (info, color);
+  vmwareWriteWordToFIFO (info, x);
+  vmwareWriteWordToFIFO (info, y);
+  vmwareWriteWordToFIFO (info, width);
+  vmwareWriteWordToFIFO (info, height);
+
+  info->vmwareFIFOMarkSet = 1;
+
+  vmwareSendSVGACmdUpdate (info, x, y, width, height);
+}
+
+static void
+vmware_accel_setup (struct display *p)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+
+  info->dispsw.setup (p);
+}
+
+static void
+vmware_accel_bmove (struct display *p,
+                    int sy, int sx, int dy, int dx,
+                    int height, int width)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+  unsigned int fh, fw;
+
+  fw      = fontwidth(p);
+  sx     *= fw;
+  dx     *= fw;
+  width  *= fw;
+
+  fh      = fontheight(p);
+  sy     *= fh;
+  dy     *= fh;
+  height *= fh;
+
+  vmwareWriteWordToFIFO (info, SVGA_CMD_RECT_COPY);
+  vmwareWriteWordToFIFO (info, sx);
+  vmwareWriteWordToFIFO (info, sy);
+  vmwareWriteWordToFIFO (info, dx);
+  vmwareWriteWordToFIFO (info, dy);
+  vmwareWriteWordToFIFO (info, width);
+  vmwareWriteWordToFIFO (info, height);
+
+  info->vmwareFIFOMarkSet = 1;
+
+  vmwareSendSVGACmdUpdate (info, dx, dy, width, height);
+}
+
+static void
+vmware_accel_clear (struct vc_data *conp, struct display *p,
+                    int y, int x, int height, int width)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+  unsigned int fw, fh;
+  u32 bgx = attr_bgcol_ec(p, conp);
+
+  fw      = fontwidth(p);
+  x      *= fw;
+  width  *= fw;
+
+  fh      = fontheight(p);
+  y      *= fh;
+  height *= fh;
+
+  vmware_rectfill (info, x, y, width, height, bgx);
+}
+
+static void
+vmware_accel_putc (struct vc_data *conp, struct display *p,
+                   int c, int y, int x)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+  unsigned int fw, fh;
+
+  fw = fontwidth(p);
+  fh = fontheight(p);
+
+  vmwareWaitForFB (info);
+
+  info->dispsw.putc (conp, p, c, y, x);
+
+  vmwareSendSVGACmdUpdate (info, x * fw, y * fh, fw, fh);
+}
+
+static void
+vmware_accel_putcs (struct vc_data *conp, struct display *p,
+                    const unsigned short *s, int count, int y, int x)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+  unsigned int fw, fh;
+
+  fw = fontwidth(p);
+  fh = fontheight(p);
+
+  vmwareWaitForFB (info);
+
+  info->dispsw.putcs (conp, p, s, count, y, x);
+
+  vmwareSendSVGACmdUpdate (info, x * fw, y * fh, fw * count, fh);
+}
+
+static void
+vmware_accel_revc (struct display *p, int x, int y)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+  unsigned int fw, fh;
+
+  fw = fontwidth(p);
+  fh = fontheight(p);
+	
+  vmwareWaitForFB (info);
+
+  info->dispsw.revc (p, x, y);
+
+  vmwareSendSVGACmdUpdate (info, x * fw, y * fh, fw, fh);
+}
+
+static void
+vmware_accel_clear_margins (struct vc_data *conp, struct display *p,
+                            int bottom_only)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)p->fb_info;
+
+  unsigned int right_start  = conp->vc_cols * fontwidth(p);
+  unsigned int bottom_start = conp->vc_rows * fontheight(p);
+  unsigned int right_width, bottom_height;
+
+  u32 bgx = attr_bgcol_ec (p, conp);
+
+  if (!bottom_only && (right_width = p->var.xres - right_start))
+    vmware_rectfill (info, right_start, 0,
+                     right_width, p->var.yres_virtual, bgx);
+
+  if ((bottom_height = p->var.yres - bottom_start))
+    vmware_rectfill (info, 0, p->var.yoffset + bottom_start,
+                     right_start, bottom_height, bgx);
+}
+
+static struct display_switch fbcon_vmware_accel = {
+  setup:		vmware_accel_setup,
+  bmove:		vmware_accel_bmove,
+  clear:		vmware_accel_clear,
+  putc:			vmware_accel_putc,
+  putcs:		vmware_accel_putcs,
+  revc:			vmware_accel_revc,
+  clear_margins:	vmware_accel_clear_margins,
+  fontwidthmask:	FONTWIDTH(8)|FONTWIDTH(16)
+};
+
+/* --------------------------------------------------------------------- */
+
+/*
+ *    Set a single color register. Return != 0 for invalid regno.
+ */
+static int
+vmware_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+                 u_int transp, struct fb_info *fb)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+
+  if (regno >= NR_PALETTE)
+    return -EINVAL;
+
+  info->palette[regno].red    = red;
+  info->palette[regno].green  = green;
+  info->palette[regno].blue   = blue;
+  info->palette[regno].transp = transp;
+
+  switch (fb->var.bits_per_pixel)
+    {
+#ifdef FBCON_HAS_CFB8
+    case 8:
+      vmwareWriteReg (info, SVGA_PALETTE_BASE + regno + 0, red >> 8);
+      vmwareWriteReg (info, SVGA_PALETTE_BASE + regno + 1, green >> 8);
+      vmwareWriteReg (info, SVGA_PALETTE_BASE + regno + 2, blue >> 8);
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB16
+    case 16:
+      if (regno < 16)
+	((u16 *)fb->pseudo_palette)[regno] = ((red   & 0xf800)      ) |
+	                                     ((green & 0xfc00) >>  5) |
+                                             ((blue  & 0xf800) >> 11);
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB24
+    case 24:
+      if (regno < 16)
+	((u32 *)fb->pseudo_palette)[regno] = ((red   & 0xff00) << 8) |
+                                             ((green & 0xff00)     ) |
+	                                     ((blue  & 0xff00) >> 8);
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB32
+    case 32:
+      if (regno < 16)
+	((u32 *)fb->pseudo_palette)[regno] = ((transp & 0xff00) << 16) |
+	                                     ((red    & 0xff00) <<  8) |
+                                             ((green  & 0xff00)      ) |
+	                                     ((blue   & 0xff00) >>  8);
+      break;
+#endif
+
+    default:
+      return 1;
+    }
+
+  return 0;
+}
+
+static void
+vmwarefb_set_par (struct vmwarefb_info       *info,
+                  const struct vmwarefb_par  *par)
+{
+  DBG("vmwarefb_set_par");
+
+  vmwareWaitForFB (info);
+
+  /* Write SVGA mode registers */
+  vmwareWriteReg (info, SVGA_REG_WIDTH, par->svga_reg_width);
+  vmwareWriteReg (info, SVGA_REG_HEIGHT, par->svga_reg_height);
+  vmwareWriteReg (info, SVGA_REG_ENABLE, 1);
+  vmwareWriteReg (info, SVGA_REG_CURSOR_ON, 0);
+  vmwareWriteReg (info, SVGA_REG_GUEST_ID, GUEST_OS_LINUX);
+}
+
+static void
+vmwarefb_update_start (struct vmwarefb_info *info, struct fb_var_screeninfo *var)
+{
+}
+
+/*
+ * Set the Colormap
+ */
+static int
+vmwarefb_set_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *fb)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+  struct display* disp = (con < 0) ? fb->disp : (fb_display + con);
+  struct fb_cmap *dcmap = &disp->cmap;
+  int err = 0;
+
+  /* no colormap allocated? */
+  if (!dcmap->len)
+    {
+      int size;
+
+      if (fb->var.bits_per_pixel == 8)
+	size = NR_PALETTE;
+      else
+	size = 32;
+
+      err = fb_alloc_cmap (dcmap, size, 0);
+    }
+
+  /*
+   * we should be able to remove this test once fbcon has been
+   * "improved" --rmk
+   */
+  if (!err && con == info->currcon)
+    {
+      err = fb_set_cmap (cmap, kspc, vmware_setcolreg, fb);
+      dcmap = &fb->cmap;
+    }
+
+  if (!err)
+    fb_copy_cmap (cmap, dcmap, kspc ? 0 : 1);
+
+  return err;
+}
+
+static int
+vmwarefb_decode_var (struct fb_var_screeninfo        *var,
+                     const struct vmwarefb_info      *info,
+                     struct vmwarefb_par             *par)
+{
+  int memlen, vramlen;
+  unsigned int pixclock = var->pixclock;
+
+  DBG("vmwarefb_decode_var");
+
+  if (!pixclock)
+    pixclock = 10000;	/* 10ns = 100MHz */
+
+  pixclock = 1000000000 / pixclock;
+
+  if (pixclock < 1)
+    pixclock = 1;
+
+  if (pixclock > info->maxClock)
+    return -EINVAL;
+
+  /* No double scan or interlaced support */
+  if (var->vmode & (FB_VMODE_DOUBLE | FB_VMODE_INTERLACED))
+    {
+      printk (KERN_INFO "vmwarefb: Double scan and interlaced "
+              "modes are not supported\n");
+      return -EINVAL;
+    }
+
+  /* Is the mode larger than the maximum screen resolution? */
+  if (var->xres > info->maxWidth || var->yres > info->maxHeight)
+    {
+      printk (KERN_INFO "vmwarefb: Mode (%dx%d) larger than the maximum "
+              "screen resolution (%dx%d)\n", var->xres, var->yres,
+              info->maxWidth, info->maxHeight);
+      return -EINVAL;
+    }
+
+  /* The right bits per pixel? (TODO: Add switching support) */
+  if (var->bits_per_pixel != info->hostBitsPerPixel)
+    {
+      printk (KERN_INFO "vmwarefb: %d bits per pixel not supported, "
+              "only %d bits per pixel available for now\n",
+	      var->bits_per_pixel, info->hostBitsPerPixel);
+      return -EINVAL;
+    }
+
+  /* (TODO: Add virtual resolution support if possible) */
+  if (var->xres_virtual != var->xres ||
+      var->yres_virtual != var->yres)
+    {
+      printk (KERN_INFO "vmwarefb: Virtual resolutions are not supported yet\n");
+      return -EINVAL;
+    }
+
+  switch (var->bits_per_pixel)
+    {
+#ifdef FBCON_HAS_CFB8
+    case 8:
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB16
+    case 16:
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB24
+    case 24:
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB32
+    case 32:
+      break;
+#endif
+
+    default:
+      return -EINVAL;
+    }
+
+  vramlen = info->video.len;
+
+  if (var->yres_virtual < var->yres)
+    var->yres_virtual = var->yres;
+  if (var->xres_virtual < var->xres)
+    var->xres_virtual = var->xres;
+
+  memlen = var->xres_virtual * var->bits_per_pixel * var->yres_virtual / 8;
+  if (memlen > vramlen)
+    {
+      var->yres_virtual = vramlen * 8 / (var->xres_virtual * var->bits_per_pixel);
+      memlen = var->xres_virtual * var->bits_per_pixel * var->yres_virtual / 8;
+    }
+
+  /* we must round yres/xres down, we already rounded y/xres_virtual up
+     if it was possible. We should return -EINVAL, but I disagree */
+  if (var->yres_virtual < var->yres)
+    var->yres = var->yres_virtual;
+  if (var->xres_virtual < var->xres)
+    var->xres = var->xres_virtual;
+  if (var->xoffset + var->xres > var->xres_virtual)
+    var->xoffset = var->xres_virtual - var->xres;
+  if (var->yoffset + var->yres > var->yres_virtual)
+    var->yoffset = var->yres_virtual - var->yres;
+
+  /*
+   * SVGA mode registers
+   */
+  par->svga_reg_width  = var->xres;
+  par->svga_reg_height = var->yres;
+
+  return 0;
+}
+
+static int
+vmwarefb_set_var (struct fb_var_screeninfo *var, int con,
+                  struct fb_info *fb)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+  struct display *display;
+  struct display_switch *dispsw;
+  struct vmwarefb_par par;
+  int err, chgvar = 0;
+
+  DBG("vmwarefb_set_var");
+
+  err = vmwarefb_decode_var (var, info, &par);
+  if (err)
+    return err;
+
+  if (var->activate & FB_ACTIVATE_TEST)
+    return 0;
+
+  if (con < 0)
+    {
+      display = fb->disp;
+      chgvar = 0;
+    }
+  else
+    {
+      display = fb_display + con;
+
+      if (fb->var.xres != var->xres)
+	chgvar = 1;
+      if (fb->var.yres != var->yres)
+	chgvar = 1;
+      if (fb->var.xres_virtual != var->xres_virtual)
+	chgvar = 1;
+      if (fb->var.yres_virtual != var->yres_virtual)
+	chgvar = 1;
+      if (fb->var.bits_per_pixel != var->bits_per_pixel)
+	chgvar = 1;
+      if (fb->var.accel_flags != var->accel_flags)
+	chgvar = 1;
+
+      /* cannot disable acceleration in current VMware version */
+      if (fb->var.accel_flags && !var->accel_flags)
+        {
+          printk (KERN_INFO "vmwarefb: Acceleration cannot be "
+                  "disabled once it it's initialized\n");
+          return -EINVAL;
+        }
+    }
+
+  if ((info->capabilities & (SVGA_CAP_RECT_FILL | SVGA_CAP_RECT_COPY)) !=
+      (SVGA_CAP_RECT_FILL | SVGA_CAP_RECT_COPY))
+    var->accel_flags &= ~FB_ACCELF_TEXT;
+
+  if (con == info->currcon)
+    {
+#if 0 /* work around X server, always reinitialize FIFO and mode */
+      if (chgvar || con < 0)
+        vmwarefb_set_par (info, &par);
+#else
+      VMWAREStopFIFO (info);
+      vmwarefb_set_par (info, &par);
+#endif
+
+      vmwarefb_update_start (info, var);
+
+      if (con < 0)
+        fb_copy_cmap (fb_default_cmap (var->bits_per_pixel > 8 ? 16 : NR_PALETTE),
+                      &fb->cmap, 0);
+
+      fb_set_cmap (&fb->cmap, 1, vmware_setcolreg, fb);
+    }
+
+  var->transp.offset   = 0;
+  var->transp.length   = 0;
+  var->red.length      = vmwareCalculateWeight(vmwareReadReg(info, SVGA_REG_RED_MASK));
+  var->green.length    = vmwareCalculateWeight(vmwareReadReg(info, SVGA_REG_GREEN_MASK));
+  var->blue.length     = vmwareCalculateWeight(vmwareReadReg(info, SVGA_REG_BLUE_MASK));
+  var->red.offset      = var->green.length + var->green.offset;
+  var->green.offset    = var->blue.length;
+  var->blue.offset     = 0;
+
+  fb->fix.line_length  = vmwareReadReg(info, SVGA_REG_BYTES_PER_LINE);
+
+  var->red.msb_right   = 0;
+  var->green.msb_right = 0;
+  var->blue.msb_right  = 0;
+                                               
+  switch (var->bits_per_pixel)
+    {
+#ifdef FBCON_HAS_CFB8
+    case 8:
+      var->red.length      = 8;
+      var->green.length    = 8;
+      var->blue.length     = 8;
+      var->red.offset      = 0;
+      var->green.offset    = 0;
+      var->blue.offset     = 0;
+
+      fb->fix.visual       = FB_VISUAL_PSEUDOCOLOR;
+      dispsw               = &fbcon_cfb8;
+      display->dispsw_data = NULL;
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB16
+    case 16:
+      fb->fix.visual       = FB_VISUAL_TRUECOLOR;
+      dispsw               = &fbcon_cfb16;
+      display->dispsw_data = fb->pseudo_palette;
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB24
+    case 24:
+      fb->fix.visual       = FB_VISUAL_TRUECOLOR;
+      dispsw               = &fbcon_cfb24;
+      display->dispsw_data = fb->pseudo_palette;
+      break;
+#endif
+
+#ifdef FBCON_HAS_CFB32
+    case 32:
+      fb->fix.visual       = FB_VISUAL_TRUECOLOR;
+      dispsw               = &fbcon_cfb32;
+      display->dispsw_data = fb->pseudo_palette;
+      break;
+#endif
+
+    default:
+      printk (KERN_WARNING "vmwarefb: no support for %dbpp\n", var->bits_per_pixel);
+      dispsw            = &fbcon_dummy;
+      var->accel_flags &= ~FB_ACCELF_TEXT;
+      break;
+    }
+
+  /* Copy default console text drawing functions */
+  memcpy (&info->dispsw, dispsw, sizeof(struct display_switch));
+
+  /* Using acceleration? */
+  if (var->accel_flags & FB_ACCELF_TEXT)
+    {
+      VMWAREInitFIFO (info);
+
+      vmwareSendSVGACmdUpdate (info, 0, 0, var->xres, var->yres);
+
+      /* move content */
+      if (chgvar)
+        display->scrollmode = 0;
+
+      /* use accelerated functions */
+      dispsw = &fbcon_vmware_accel;
+    }
+  else
+    {
+      VMWAREStopFIFO (info);
+
+      /* redraw content */
+      display->scrollmode = SCROLL_YREDRAW;
+      info->dispsw.bmove  = fbcon_redraw_bmove;
+
+      /* use (modified) default functions */
+      dispsw = &info->dispsw;
+    }
+
+  /* Setup display information */
+  display->dispsw         = dispsw;
+  display->screen_base    = fb->screen_base + vmwareReadReg(info, SVGA_REG_FB_OFFSET);
+  display->next_line      =
+  display->line_length    = fb->fix.line_length;
+  display->visual         = fb->fix.visual;
+  display->type	          = fb->fix.type;
+  display->type_aux       = fb->fix.type_aux;
+  display->ypanstep       = fb->fix.ypanstep;
+  display->ywrapstep      = fb->fix.ywrapstep;
+  display->can_soft_blank = 1;
+  display->inverse        = 0;
+
+  /* Update var info */
+  fb->var = *var;
+  fb->var.activate &= ~FB_ACTIVATE_ALL;
+
+  /*
+   * Update the old var.  The fbcon drivers still use this.
+   * Once they are using cfb->fb.var, this can be dropped.
+   *					--rmk
+   */
+  display->var = fb->var;
+
+  /*
+   * If we are setting all the virtual consoles, also set the
+   * defaults used to create new consoles.
+   */
+  if (var->activate & FB_ACTIVATE_ALL)
+    fb->disp->var = fb->var;
+
+  if (chgvar && fb && fb->changevar)
+    fb->changevar (con);
+
+  return 0;
+}
+
+/*
+ *    Pan or Wrap the Display
+ */
+static int
+vmwarefb_pan_display (struct fb_var_screeninfo *var, int con,
+                      struct fb_info *fb)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+  u_int y_bottom;
+
+  y_bottom = var->yoffset;
+
+  if (!(var->vmode & FB_VMODE_YWRAP))
+    y_bottom += var->yres;
+
+  if (var->xoffset > (var->xres_virtual - var->xres))
+    return -EINVAL;
+  if (y_bottom > fb->var.yres_virtual)
+    return -EINVAL;
+
+  vmwarefb_update_start (info, var);
+
+  fb->var.xoffset = var->xoffset;
+  fb->var.yoffset = var->yoffset;
+
+  if (var->vmode & FB_VMODE_YWRAP)
+    fb->var.vmode |= FB_VMODE_YWRAP;
+  else
+    fb->var.vmode &= ~FB_VMODE_YWRAP;
+
+  return 0;
+}
+
+
+/*
+ *    Update the `var' structure (called by fbcon.c)
+ *
+ *    This call looks only at yoffset and the FB_VMODE_YWRAP flag in `var'.
+ *    Since it's called by a kernel driver, no range checking is done.
+ */
+static int
+vmwarefb_updatevar (int con, struct fb_info *fb)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+
+  vmwarefb_update_start (info, &fb_display[con].var);
+
+  return 0;
+}
+
+static int
+vmwarefb_switch (int con, struct fb_info *fb)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+  struct display *disp;
+  struct fb_cmap *cmap;
+
+  if (info->currcon >= 0)
+    {
+      disp = fb_display + info->currcon;
+
+      /*
+       * Save the old colormap and video mode.
+       */
+      disp->var = fb->var;
+      if (disp->cmap.len)
+	fb_copy_cmap(&fb->cmap, &disp->cmap, 0);
+    }
+
+  info->currcon = con;
+  disp = fb_display + con;
+
+  /*
+   * Install the new colormap and change the video mode.  By default,
+   * fbcon sets all the colormaps and video modes to the default
+   * values at bootup.
+   *
+   * Really, we want to set the colourmap size depending on the
+   * depth of the new video mode.  For now, we leave it at its
+   * default 256 entry.
+   */
+  if (disp->cmap.len)
+    cmap = &disp->cmap;
+  else
+    cmap = fb_default_cmap(disp->var.bits_per_pixel > 8 ? 16 : NR_PALETTE);
+
+  fb_copy_cmap(cmap, &fb->cmap, 0);
+
+  disp->var.activate = FB_ACTIVATE_NOW;
+  vmwarefb_set_var(&disp->var, con, fb);
+
+  return 0;
+}
+
+/*
+ *    (Un)Blank the display.
+ */
+static void
+vmwarefb_blank (int blank, struct fb_info *fb)
+{
+  //  struct vmwarefb_info *info = (struct vmwarefb_info *)fb;
+
+  /*
+   *  Blank the screen if blank_mode != 0, else unblank. If
+   *  blank == NULL then the caller blanks by setting the CLUT
+   *  (Color Look Up Table) to all black. Return 0 if blanking
+   *  succeeded, != 0 if un-/blanking failed due to e.g. a
+   *  video mode which doesn't support it. Implements VESA
+   *  suspend and powerdown modes on hardware that supports
+   *  disabling hsync/vsync:
+   *    blank_mode == 2: suspend vsync
+   *    blank_mode == 3: suspend hsync
+   *    blank_mode == 4: powerdown
+   *
+   *  wms...Enable VESA DMPS compatible powerdown mode
+   *  run "setterm -powersave powerdown" to take advantage
+   */
+     
+  switch (blank)
+    {
+    case 4:	/* powerdown - both sync lines down */
+      break;	
+    case 3:	/* hsync off */
+      break;	
+    case 2:	/* vsync off */
+      break;	
+    case 1:	/* just software blanking of screen */
+      break;
+    default: /* case 0, or anything else: unblank */
+      break;
+    }
+}
+
+/*
+ * Get the currently displayed virtual consoles colormap.
+ */
+static int
+gen_get_cmap (struct fb_cmap *cmap, int kspc, int con, struct fb_info *fb)
+{
+  fb_copy_cmap (&fb->cmap, cmap, kspc ? 0 : 2);
+  return 0;
+}
+
+/*
+ * Get the currently displayed virtual consoles fixed part of the display.
+ */
+static int
+gen_get_fix (struct fb_fix_screeninfo *fix, int con, struct fb_info *fb)
+{
+  *fix = fb->fix;
+  return 0;
+}
+
+/*
+ * Get the current user defined part of the display.
+ */
+static int
+gen_get_var (struct fb_var_screeninfo *var, int con, struct fb_info *fb)
+{
+  *var = fb->var;
+  return 0;
+}
+
+static struct fb_ops vmwarefb_ops = {
+  owner:          THIS_MODULE,
+  fb_set_var:     vmwarefb_set_var,
+  fb_set_cmap:    vmwarefb_set_cmap,
+  fb_pan_display: vmwarefb_pan_display,
+  fb_get_fix:     gen_get_fix,
+  fb_get_var:     gen_get_var,
+  fb_get_cmap:    gen_get_cmap,
+};
+
+/* --------------------------------------------------------------------- */
+
+static int __devinit
+vmware_map_mmio (struct vmwarefb_info *info)
+{
+  DBG("vmware_map_mmio");
+
+  info->mmio.pbase = vmwareReadReg (info, SVGA_REG_MEM_START);
+  info->mmio.len   = vmwareReadReg (info, SVGA_REG_MEM_SIZE) & ~3;
+
+  if (!request_mem_region (info->mmio.pbase, info->mmio.len, "memory mapped I/O"))
+    {
+      printk (KERN_ERR "vmwarefb: memory mapped IO at 0x%08x in use\n",
+              info->mmio.pbase);
+      return -EBUSY;
+    }
+
+  info->mmio.vbase = ioremap (info->mmio.pbase, info->mmio.len);
+  if (!info->mmio.vbase)
+    {
+      printk (KERN_ERR "vmwarefb: unable to map memory mapped IO at 0x%08x\n",
+              info->mmio.pbase);
+      release_mem_region (info->mmio.pbase, info->mmio.len);
+      return -ENOMEM;
+    }
+  else
+    printk (KERN_INFO "vmwarefb: mapped io at 0x%08x -> %p\n",
+            info->mmio.pbase, info->mmio.vbase);
+
+  info->fb.fix.mmio_start = info->mmio.pbase;
+  info->fb.fix.mmio_len   = info->mmio.len;
+
+  return 0;
+}
+
+static void __devexit
+vmware_unmap_mmio (struct vmwarefb_info *info)
+{
+  DBG("vmware_unmap_mmio");
+
+  VMWAREStopFIFO (info);
+
+  if (info->mmio.vbase)
+    {
+      iounmap (info->mmio.vbase);
+      info->mmio.vbase = NULL;
+
+      release_mem_region (info->mmio.pbase, info->mmio.len);
+    }
+}
+
+static int __devinit
+vmware_map_video (struct vmwarefb_info *info)
+{
+  DBG("vmware_map_video");
+
+  info->video.pbase = vmwareReadReg (info, SVGA_REG_FB_START);
+  info->video.len   = vmwareReadReg (info, SVGA_REG_FB_MAX_SIZE);
+
+  if (!request_mem_region (info->video.pbase, info->video.len, "frame buffer"))
+    {
+      printk (KERN_ERR "vmwarefb: frame buffer at 0x%08x in use\n",
+              info->video.pbase);
+      return -EBUSY;
+    }
+
+  info->video.vbase = ioremap (info->video.pbase, info->video.len);
+  if (!info->video.vbase)
+    {
+      printk (KERN_ERR "vmwarefb: unable to map screen memory at 0x%08x\n",
+              info->video.pbase);
+      release_mem_region (info->video.pbase, info->video.len);
+      return -ENOMEM;
+    }
+  else
+    printk (KERN_INFO "vmwarefb: mapped framebuffer at 0x%08x -> %p\n",
+            info->video.pbase, info->video.vbase);
+
+  info->fb.fix.smem_start = info->video.pbase;
+  info->fb.fix.smem_len   = info->video.len;
+  info->fb.screen_base    = info->video.vbase;
+
+  return 0;
+}
+
+static void __devexit
+vmware_unmap_video (struct vmwarefb_info *info)
+{
+  DBG("vmware_unmap_video");
+
+  if (info->video.vbase)
+    {
+      iounmap (info->video.vbase);
+      info->video.vbase = NULL;
+      info->fb.screen_base = NULL;
+
+      release_mem_region (info->video.pbase, info->video.len);
+    }
+}
+
+static int __devinit
+vmware_init_hw (struct vmwarefb_info *info)
+{
+  u32 id;
+
+  DBG("vmware_init_hw");
+
+  /* Figure out SVGA ports */
+  switch (info->accel)
+    {
+    case FB_ACCEL_VMWARE_SVGA:
+      info->indexReg = SVGA_LEGACY_BASE_PORT + SVGA_INDEX_PORT * sizeof(u32);
+      info->valueReg = SVGA_LEGACY_BASE_PORT + SVGA_VALUE_PORT * sizeof(u32);
+      break;
+
+    case FB_ACCEL_VMWARE_SVGA2:
+      info->indexReg = pci_resource_start (info->pcidev, 0) + SVGA_INDEX_PORT;
+      info->valueReg = pci_resource_start (info->pcidev, 0) + SVGA_VALUE_PORT;
+      break;
+    }
+
+  /* Check for supported SVGA id */
+  id = VMXGetVMwareSvgaId (info);
+  if (id == SVGA_ID_0 || id == SVGA_ID_INVALID)
+    {
+      printk (KERN_ERR "vmwarefb: No supported "
+              "VMware SVGA found (read ID 0x%08x).\n", id);
+      return -ENOTSUPP;
+    }
+
+  /* Maximum dot clock in kHz */
+  info->maxClock = 400000;
+
+  /* Maximum screen resolution */
+  info->maxWidth  = vmwareReadReg (info, SVGA_REG_MAX_WIDTH);
+  info->maxHeight = vmwareReadReg (info, SVGA_REG_MAX_HEIGHT);
+
+  /* Bits per pixel in host format */
+  info->hostBitsPerPixel = vmwareReadReg (info, SVGA_REG_HOST_BITS_PER_PIXEL);
+
+  /* Capabilities like 8bit emulation */
+  info->capabilities = vmwareReadReg (info, SVGA_REG_CAPABILITIES);
+
+  printk (KERN_INFO
+          "vmwarefb: Maximum screen resolution is %dx%d, host bpp is %d\n",
+	  info->maxWidth, info->maxHeight, info->hostBitsPerPixel);
+
+  return 0;
+}
+
+
+static struct vmwarefb_info * __devinit
+vmware_alloc_fb_info (struct pci_dev             *dev,
+                      const struct pci_device_id *id)
+{
+  struct vmwarefb_info *info;
+
+  info = kmalloc (sizeof(struct vmwarefb_info) + sizeof(struct display) +
+		  sizeof(u32) * 16, GFP_KERNEL);
+
+  if (!info)
+    return NULL;
+
+  memset (info, 0, sizeof(struct vmwarefb_info) + sizeof(struct display));
+
+  info->currcon = -1;
+  info->pcidev  = dev;
+  info->accel   = id->driver_data;
+
+  switch (info->accel)
+    {
+    case FB_ACCEL_VMWARE_SVGA:
+      sprintf (info->fb.fix.id, "VMware SVGA");
+      break;
+
+    case FB_ACCEL_VMWARE_SVGA2:
+      sprintf (info->fb.fix.id, "VMware SVGA2");
+      break;
+    }
+
+  info->fb.fix.type	   = FB_TYPE_PACKED_PIXELS;
+  info->fb.fix.type_aux	   = 0;
+  info->fb.fix.xpanstep	   = 0;
+  info->fb.fix.ypanstep	   = 0; /* No virtual resolution support yet */
+  info->fb.fix.ywrapstep   = 0;
+  info->fb.fix.accel       = id->driver_data;
+
+  info->fb.var.nonstd      = 0;
+  info->fb.var.activate    = FB_ACTIVATE_NOW;
+  info->fb.var.height      = -1;
+  info->fb.var.width       = -1;
+  info->fb.var.accel_flags = 0;
+
+  strcpy (info->fb.modename, info->fb.fix.id);
+
+  info->fb.fbops          = &vmwarefb_ops;
+  info->fb.changevar      = NULL;
+  info->fb.switch_con     = vmwarefb_switch;
+  info->fb.updatevar      = vmwarefb_updatevar;
+  info->fb.blank          = vmwarefb_blank;
+  info->fb.flags          = FBINFO_FLAG_DEFAULT;
+  info->fb.disp           = (struct display *)(info + 1);
+  info->fb.pseudo_palette = (void *)(info->fb.disp + 1);
+
+  fb_alloc_cmap (&info->fb.cmap, NR_PALETTE, 0);
+
+  return info;
+}
+
+static void __devexit
+vmware_free_fb_info (struct vmwarefb_info *info)
+{
+  if (info)
+    {
+      /*
+       * Free the colourmap
+       */
+      fb_alloc_cmap (&info->fb.cmap, 0, 0);
+
+      kfree (info);
+    }
+}
+
+/* --------------------------------------------------------------------- */
+
+static int __devinit
+vmwarefb_probe (struct pci_dev* dev, const struct pci_device_id* id)
+{
+  struct vmwarefb_info *info;
+  u_int h_sync, v_sync;
+  int err;
+
+  DBG("vmwarefb_probe");
+
+  err = pci_enable_device (dev);
+  if (err)
+    return err;
+
+  err = -ENOMEM;
+  info = vmware_alloc_fb_info (dev, id);
+  if (!info)
+    goto failed;
+
+  err = vmware_init_hw (info);
+  if (err)
+    goto failed;
+
+  err = vmware_map_mmio (info);
+  if (err)
+    goto failed;
+
+  err = vmware_map_video (info);
+  if (err)
+    goto failed;
+
+  /* Use bits per pixel of host */
+  vmwarefb_var->bits_per_pixel = info->hostBitsPerPixel;
+
+  /* Use acceleration? */
+  if (!noaccel)
+    vmwarefb_var->accel_flags = FB_ACCELF_TEXT;
+
+  /* Set initial mode */
+  vmwarefb_set_var (vmwarefb_var, -1, &info->fb);
+
+  /*
+   * Calculate the hsync and vsync frequencies.  Note that
+   * we split the 1e12 constant up so that we can preserve
+   * the precision and fit the results into 32-bit registers.
+   *  (1953125000 * 512 = 1e12)
+   */
+  h_sync = 1953125000 / info->fb.var.pixclock;
+  h_sync = h_sync * 512 / (info->fb.var.xres + info->fb.var.left_margin +
+			   info->fb.var.right_margin + info->fb.var.hsync_len);
+  v_sync = h_sync / (info->fb.var.yres + info->fb.var.upper_margin +
+		     info->fb.var.lower_margin + info->fb.var.vsync_len);
+
+  printk(KERN_INFO "vmwarefb v" VMWAREFB_VERSION ": "
+         "%dkB VRAM, using %dx%d, %d.%03dkHz, %dHz\n",
+	 info->fb.fix.smem_len >> 10,
+	 info->fb.var.xres, info->fb.var.yres,
+	 h_sync / 1000, h_sync % 1000, v_sync);
+
+
+  err = register_framebuffer (&info->fb);
+  if (err < 0)
+    goto failed;
+
+  printk (KERN_INFO "fb%d: %s frame buffer device\n",
+	  GET_FB_IDX(info->fb.node), info->fb.modename);
+
+  /*
+   * Our driver data
+   */
+  dev->driver_data = info;
+
+  return 0;
+
+failed:
+  vmware_unmap_video (info);
+  vmware_unmap_mmio (info);
+  vmware_free_fb_info (info);
+
+  return err;
+}
+
+static void __devexit
+vmwarefb_remove (struct pci_dev *dev)
+{
+  struct vmwarefb_info *info = (struct vmwarefb_info *)dev->driver_data;
+
+  DBG("vmwarefb_remove");
+
+  if (info)
+    {
+      /*
+       * If unregister_framebuffer fails, then
+       * we will be leaving hooks that could cause
+       * oopsen laying around.
+       */
+      if (unregister_framebuffer (&info->fb))
+	printk (KERN_WARNING "vmwarefb: danger danger!  Oopsen imminent!\n");
+
+      vmware_unmap_video (info);
+      vmware_unmap_mmio (info);
+      vmware_free_fb_info (info);
+
+      /*
+       * Ensure that the driver data is no longer
+       * valid.
+       */
+      dev->driver_data = NULL;
+    }
+}
+
+static struct pci_device_id vmwarefb_devices[] __devinitdata = {
+  {PCI_VENDOR_ID_VMWARE, PCI_DEVICE_ID_VMWARE_SVGA,
+   PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_VMWARE_SVGA},
+
+  {PCI_VENDOR_ID_VMWARE, PCI_DEVICE_ID_VMWARE_SVGA2,
+   PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_VMWARE_SVGA2},
+
+  {0, 0, 0, 0, 0, 0, 0}
+};
+
+MODULE_DEVICE_TABLE(pci, vmwarefb_devices);
+
+static struct pci_driver vmwarefb_driver = {
+  name:      "vmwarefb",
+  id_table:  vmwarefb_devices,
+  probe:     vmwarefb_probe,
+  remove:    vmwarefb_remove
+};
+
+/* **************************** init-time only **************************** */
+
+static void __init
+vmware_init (void)
+{
+  DBG("vmware_init");
+  pci_register_driver (&vmwarefb_driver);
+}
+
+/* **************************** exit-time only **************************** */
+
+static void __exit
+vmware_done (void)
+{
+  DBG("vmware_done");
+  pci_unregister_driver (&vmwarefb_driver);
+}
+
+
+/* ************************* init in-kernel code ************************** */
+
+#ifndef MODULE
+
+static int initialized = 0;
+
+int __init
+vmwarefb_setup (char *options)
+{
+  char *this_opt;
+
+  DBG("vmwarefb_setup");
+
+  if (!options || !*options)
+    return 0;
+
+  for (this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,","))
+    {
+      if (!*this_opt) continue;
+
+      if (!strncmp(this_opt, "disabled", 8))
+	disabled = 1;
+      if (!strncmp(this_opt, "noaccel", 8))
+	noaccel = 1;
+      if (!strncmp(this_opt, "640x480", 7))
+	vmwarefb_var = &vmwarefb_var640x480x8;
+      if (!strncmp(this_opt, "800x600", 7))
+	vmwarefb_var = &vmwarefb_var800x600x8;
+      if (!strncmp(this_opt, "1024x768", 8))
+	vmwarefb_var = &vmwarefb_var1024x768x8;
+    }
+
+  return 0;
+}
+
+int __init
+vmwarefb_init(void)
+{
+  DBG("vmwarefb_init");
+
+  if (disabled)
+    return -ENXIO;
+
+  if (!initialized)
+    {
+      initialized = 1;
+      vmware_init();
+    }
+
+  /* never return failure, user can hotplug card later... */
+  return 0;
+}
+
+#else
+
+/* *************************** init module code **************************** */
+
+int __init
+init_module(void)
+{
+  DBG("init_module");
+
+  if (disabled)
+    return -ENXIO;
+
+  vmware_init();
+
+  /* never return failure; user can hotplug card later... */
+  return 0;
+}
+
+#endif	/* MODULE */
+
+module_exit(vmware_done);
diff -uraN linux-2.4.20/drivers/video/vmware/vmwarefb.h linux-2.4.20-vmwarefb/drivers/video/vmware/vmwarefb.h
--- linux-2.4.20/drivers/video/vmware/vmwarefb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-vmwarefb/drivers/video/vmware/vmwarefb.h	2002-11-29 13:34:28.000000000 +0100
@@ -0,0 +1,95 @@
+/*
+ * linux/drivers/video/vmware/vmwarefb.h -- VMware SVGA Framebuffer Driver
+ *
+ * Copyright (c) 2002  Denis Oliver Kropp <dok@directfb.org>
+ *
+ *
+ * Card specific code is based on XFree86's VMware driver.
+ * Framebuffer framework code is based on code of neofb.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ */
+
+
+#ifdef VMWAREFB_DEBUG
+# define DBG(x)		printk (KERN_DEBUG "vmwarefb: %s\n", (x));
+#else
+# define DBG(x)
+#endif
+
+#define PCI_VENDOR_ID_VMWARE        0x15AD
+#define PCI_DEVICE_ID_VMWARE_SVGA2  0x0405
+#define PCI_DEVICE_ID_VMWARE_SVGA   0x0710
+
+/* --------------------------------------------------------------------- */
+
+#define NR_PALETTE	256
+
+
+struct vmwarefb_par {
+
+  /* SVGA registers */
+  u32 svga_reg_width;
+  u32 svga_reg_height;
+};
+
+struct vmwarefb_info {
+
+  /* Base struct */
+  struct fb_info  fb;
+
+  /* Console drawing functions */
+  struct display_switch	dispsw;
+
+  /* VMware VGA PCI device */
+  struct pci_dev *pcidev;
+
+  /* Current active console */
+  int currcon;
+
+  /* Accelerator id */
+  int accel;
+
+  /* Video memory */
+  struct {
+    u8  *vbase;
+    u32  pbase;
+    u32  len;
+  } video;
+
+  /* Memory mapped IO for acceleration */
+  struct {
+    u8  *vbase;
+    u32  pbase;
+    u32  len;
+  } mmio;
+
+  /* FIFO handling */
+  u32 *vmwareFIFO;
+  int  vmwareFIFOMarkSet;
+
+  /* SVGA ports */
+  u32 indexReg;
+  u32 valueReg;
+
+  /* Maximum screen resolution */
+  int maxWidth;
+  int maxHeight;
+
+  /* Maximum dot clock */
+  int maxClock;
+
+  /* Bits per pixel in host format */
+  unsigned int hostBitsPerPixel;
+
+  /* Capabilities of the virtual card */
+  unsigned int capabilities;
+
+  /* Text color map */
+  struct {
+    u16 red, green, blue, transp;
+  } palette[NR_PALETTE];
+};
diff -uraN linux-2.4.20/include/linux/fb.h linux-2.4.20-vmwarefb/include/linux/fb.h
--- linux-2.4.20/include/linux/fb.h	2002-11-01 13:33:02.000000000 +0100
+++ linux-2.4.20-vmwarefb/include/linux/fb.h	2002-11-29 13:24:53.000000000 +0100
@@ -96,6 +96,8 @@
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
 #define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon family		*/
 
+#define FB_ACCEL_VMWARE_SVGA	50	/* VMware Virtual SVGA Graphics */
+#define FB_ACCEL_VMWARE_SVGA2	51	/* VMware Virtual SVGA Graphics */
 
 #define FB_ACCEL_NEOMAGIC_NM2070 90	/* NeoMagic NM2070              */
 #define FB_ACCEL_NEOMAGIC_NM2090 91	/* NeoMagic NM2090              */

--MGYHOYXEY6WxJCY8--
