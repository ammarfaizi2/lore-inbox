Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRABRXa>; Tue, 2 Jan 2001 12:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRABRXV>; Tue, 2 Jan 2001 12:23:21 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:42741
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129825AbRABRXK>; Tue, 2 Jan 2001 12:23:10 -0500
Date: Tue, 2 Jan 2001 09:51:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-fbdev@vuser.vu.union.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] clgenfb on PPC
Message-ID: <20010102095133.B26653@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey all.  While going through the 2.4 tree and removing dead CONFIG_xxx's for
PPC stuff, I noticed clgenfb still had CONFIG_PREP stuff (which may have
partily explained why it no longer worked here).  I've attached a patch, that
with another patch to fix some PCI issues on certain machines, gives me a
working (so far, can't test heavily yet tho) framebuffer on my powerstack.

Comments?

Also, rivafb needs something similar to this, but since no PReP boxes I know
of anyways ship with something rivafb controlls, it's probably easier to just
remove the bits inside CONFIG_PREP

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clgenfb.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: 
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.393.1.12 -> 1.393.1.13
#	drivers/video/clgenfb.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 00/12/27	trini@entropy.crashing.org	1.393.1.13
# Fix up clgenfb.
# --------------------------------------------
#
diff -Nru a/drivers/video/clgenfb.c b/drivers/video/clgenfb.c
--- a/drivers/video/clgenfb.c	Tue Jan  2 09:42:09 2001
+++ b/drivers/video/clgenfb.c	Tue Jan  2 09:42:09 2001
@@ -56,6 +56,12 @@
 #ifdef CONFIG_AMIGA
 #include <asm/amigahw.h>
 #endif
+#ifdef CONFIG_ALL_PPC
+#include <asm/processor.h>
+#define isPReP (_machine == _MACH_prep)
+#else
+#define isPReP 0
+#endif
 
 #include <video/fbcon.h>
 #include <video/fbcon-mfb.h>
@@ -876,15 +882,15 @@
 	case 16:
 		_par->line_length = _par->var.xres_virtual * 2;
 		_par->visual = FB_VISUAL_DIRECTCOLOR;
-#ifdef CONFIG_PREP
-		_par->var.red.offset = 2;
-		_par->var.green.offset = -3;
-		_par->var.blue.offset = 8;
-#else
-		_par->var.red.offset = 10;
-		_par->var.green.offset = 5;
-		_par->var.blue.offset = 0;
-#endif
+		if(isPReP) {
+			_par->var.red.offset = 2;
+			_par->var.green.offset = -3;
+			_par->var.blue.offset = 8;
+		} else {
+			_par->var.red.offset = 10;
+			_par->var.green.offset = 5;
+			_par->var.blue.offset = 0;
+		}
 		_par->var.red.length = 5;
 		_par->var.green.length = 5;
 		_par->var.blue.length = 5;
@@ -893,15 +899,15 @@
 	case 24:
 		_par->line_length = _par->var.xres_virtual * 3;
 		_par->visual = FB_VISUAL_DIRECTCOLOR;
-#ifdef CONFIG_PREP
-		_par->var.red.offset = 8;
-		_par->var.green.offset = 16;
-		_par->var.blue.offset = 24;
-#else
-		_par->var.red.offset = 16;
-		_par->var.green.offset = 8;
-		_par->var.blue.offset = 0;
-#endif
+		if(isPReP) {
+			_par->var.red.offset = 8;
+			_par->var.green.offset = 16;
+			_par->var.blue.offset = 24;
+		} else {
+			_par->var.red.offset = 16;
+			_par->var.green.offset = 8;
+			_par->var.blue.offset = 0;
+		}
 		_par->var.red.length = 8;
 		_par->var.green.length = 8;
 		_par->var.blue.length = 8;
@@ -910,15 +916,15 @@
 	case 32:
 		_par->line_length = _par->var.xres_virtual * 4;
 		_par->visual = FB_VISUAL_DIRECTCOLOR;
-#ifdef CONFIG_PREP
-		_par->var.red.offset = 8;
-		_par->var.green.offset = 16;
-		_par->var.blue.offset = 24;
-#else
-		_par->var.red.offset = 16;
-		_par->var.green.offset = 8;
-		_par->var.blue.offset = 0;
-#endif
+		if(isPReP) {
+			_par->var.red.offset = 8;
+			_par->var.green.offset = 16;
+			_par->var.blue.offset = 24;
+		} else {
+			_par->var.red.offset = 16;
+			_par->var.green.offset = 8;
+			_par->var.blue.offset = 0;
+		}
 		_par->var.red.length = 8;
 		_par->var.green.length = 8;
 		_par->var.blue.length = 8;
@@ -1680,18 +1686,18 @@
 #ifdef FBCON_HAS_CFB16
 	case 16:
 		assert (regno < 16);
-#ifdef CONFIG_PREP
-		fb_info->fbcon_cmap.cfb16[regno] =
-		    ((red & 0xf800) >> 9) |
-		    ((green & 0xf800) >> 14) |
-		    ((green & 0xf800) << 2) |
-		    ((blue & 0xf800) >> 3);
-#else
-		fb_info->fbcon_cmap.cfb16[regno] =
-		    ((red & 0xf800) >> 1) |
-		    ((green & 0xf800) >> 6) |
-		    ((blue & 0xf800) >> 11);
-#endif
+		if(isPReP) {
+			fb_info->fbcon_cmap.cfb16[regno] =
+			    ((red & 0xf800) >> 9) |
+			    ((green & 0xf800) >> 14) |
+			    ((green & 0xf800) << 2) |
+			    ((blue & 0xf800) >> 3);
+		} else {
+			fb_info->fbcon_cmap.cfb16[regno] =
+			    ((red & 0xf800) >> 1) |
+			    ((green & 0xf800) >> 6) |
+			    ((blue & 0xf800) >> 11);
+		}
 #endif /* FBCON_HAS_CFB16 */
 
 #ifdef FBCON_HAS_CFB24
@@ -1707,17 +1713,17 @@
 #ifdef FBCON_HAS_CFB32
 	case 32:
 		assert (regno < 16);
-#ifdef CONFIG_PREP
-		fb_info->fbcon_cmap.cfb32[regno] =
-		    ((red & 0xff00)) |
-		    ((green & 0xff00) << 8) |
-		    ((blue & 0xff00) << 16);
-#else
-		fb_info->fbcon_cmap.cfb32[regno] =
-		    ((red & 0xff00) << 8) |
-		    ((green & 0xff00)) |
-		    ((blue & 0xff00) >> 8);
-#endif
+		if(isPReP) {
+			fb_info->fbcon_cmap.cfb32[regno] =
+			    ((red & 0xff00)) |
+			    ((green & 0xff00) << 8) |
+			    ((blue & 0xff00) << 16);
+		} else {
+			fb_info->fbcon_cmap.cfb32[regno] =
+			    ((red & 0xff00) << 8) |
+			    ((green & 0xff00)) |
+			    ((blue & 0xff00) >> 8);
+		}
 		break;
 #endif /* FBCON_HAS_CFB32 */
 	default:
@@ -2374,7 +2380,7 @@
 
 
 
-#ifdef CONFIG_PREP
+#ifdef CONFIG_ALL_PPC
 #define PREP_VIDEO_BASE ((volatile unsigned long) 0xC0000000)
 #define PREP_IO_BASE    ((volatile unsigned char *) 0x80000000)
 static void __init get_prep_addrs (unsigned long *display, unsigned long *registers)
@@ -2387,7 +2393,7 @@
 	DPRINTK ("EXIT\n");
 }
 
-#endif				/* CONFIG_PREP */
+#endif				/* CONFIG_ALL_PPC */
 
 
 
@@ -2510,26 +2516,24 @@
 
 	info->pdev = pdev;
 
-#ifdef CONFIG_PREP
-	/* Xbh does this, though 0 seems to be the init value */
-	pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0, 0x00000000);
-#endif
+	if(isPReP) {
+		/* Xbh does this, though 0 seems to be the init value */
+		pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0,
+			0x00000000);
 
-#ifdef CONFIG_PREP
-	get_prep_addrs (&board_addr, &info->fbregs_phys);
-#else				/* CONFIG_PREP */
-	DPRINTK ("Attempt to get PCI info for Cirrus Graphics Card\n");
-	get_pci_addrs (pdev, &board_addr, &info->fbregs_phys);
-#endif				/* CONFIG_PREP */
+		get_prep_addrs (&board_addr, &info->fbregs_phys);
+	} else {
+		DPRINTK ("Attempt to get PCI info for Cirrus Graphics Card\n");
+		get_pci_addrs (pdev, &board_addr, &info->fbregs_phys);
+	}
 
 	DPRINTK ("Board address: 0x%lx, register address: 0x%lx\n", board_addr, info->fbregs_phys);
 
-#ifdef CONFIG_PREP
-	/* PReP dies if we ioremap the IO registers, but it works w/out... */
-	info->regs = (char *) info->fbregs_phys;
-#else
-	info->regs = 0;		/* FIXME: this forces VGA.  alternatives? */
-#endif
+	if(isPReP) {
+		/* PReP dies if we ioremap the IO registers, but it works w/out... */
+		info->regs = (char *) info->fbregs_phys;
+	} else
+		info->regs = 0;		/* FIXME: this forces VGA.  alternatives? */
 
 	if (*btype == BT_GD5480) {
 		board_size = 32 * MB_;

--lrZ03NoBR/3+SXJZ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
