Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVKFAu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVKFAu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVKFAu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:50:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932254AbVKFAu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:50:27 -0500
Date: Sun, 6 Nov 2005 01:50:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/: possible cleanups
Message-ID: <20051106005026.GE3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the possible cleanups including the following:
- every file should #include the headers containing the prototypes for
  it's global functions
- make needlessly global functions static
- kyro/STG4000Interface.h: #include video/kyro.h and linux/pci.h
  instead of a manual "struct pci_dev"
- i810_main.{c,h}: prototypes for static functions belong to the
                   C file


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/arcfb.c                     |    8 +--
 drivers/video/console/softcursor.c        |    2 
 drivers/video/i810/i810-i2c.c             |    1 
 drivers/video/i810/i810_accel.c           |    1 
 drivers/video/i810/i810_gtf.c             |    1 
 drivers/video/i810/i810_main.c            |   51 ++++++++++++++++++--
 drivers/video/i810/i810_main.h            |   56 +---------------------
 drivers/video/kyro/STG4000InitDevice.c    |    1 
 drivers/video/kyro/STG4000Interface.h     |    3 -
 drivers/video/kyro/STG4000OverlayDevice.c |    1 
 drivers/video/matrox/matroxfb_g450.c      |    2 
 drivers/video/nvidia/nv_hw.c              |    1 
 drivers/video/tdfxfb.c                    |    2 
 13 files changed, 68 insertions(+), 62 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c.old	2005-11-06 00:31:15.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c	2005-11-06 00:31:30.000000000 +0100
@@ -17,6 +17,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#include "fbcon.h"
+
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	unsigned int scan_align = info->pixmap.scan_align - 1;
--- linux-2.6.14-rc5-mm1-full/drivers/video/kyro/STG4000Interface.h.old	2005-11-06 00:41:04.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/kyro/STG4000Interface.h	2005-11-06 00:42:17.000000000 +0100
@@ -11,7 +11,8 @@
 #ifndef _STG4000INTERFACE_H
 #define _STG4000INTERFACE_H
 
-struct pci_dev;
+#include <linux/pci.h>
+#include <video/kyro.h>
 
 /*
  * Ramdac Setup
--- linux-2.6.14-rc5-mm1-full/drivers/video/kyro/STG4000OverlayDevice.c.old	2005-11-06 00:31:51.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/kyro/STG4000OverlayDevice.c	2005-11-06 00:32:03.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 #include "STG4000Reg.h"
+#include "STG4000Interface.h"
 
 /* HW Defines */
 
--- linux-2.6.14-rc5-mm1-full/drivers/video/kyro/STG4000InitDevice.c.old	2005-11-06 00:32:22.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/kyro/STG4000InitDevice.c	2005-11-06 00:32:37.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 
 #include "STG4000Reg.h"
+#include "STG4000Interface.h"
 
 /* SDRAM fixed settings */
 #define SDRAM_CFG_0   0x49A1
--- linux-2.6.14-rc5-mm1-full/drivers/video/matrox/matroxfb_g450.c.old	2005-11-06 00:33:03.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/matrox/matroxfb_g450.c	2005-11-06 00:33:19.000000000 +0100
@@ -20,6 +20,8 @@
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 
+#include "matroxfb_g450.h"
+
 /* Definition of the various controls */
 struct mctl {
 	struct v4l2_queryctrl desc;
--- linux-2.6.14-rc5-mm1-full/drivers/video/nvidia/nv_hw.c.old	2005-11-06 00:33:52.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/nvidia/nv_hw.c	2005-11-06 00:34:04.000000000 +0100
@@ -52,6 +52,7 @@
 #include <linux/pci.h>
 #include "nv_type.h"
 #include "nv_local.h"
+#include "nv_proto.h"
 
 void NVLockUnlock(struct nvidia_par *par, int Lock)
 {
--- linux-2.6.14-rc5-mm1-full/drivers/video/arcfb.c.old	2005-11-06 00:34:25.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/arcfb.c	2005-11-06 00:35:14.000000000 +0100
@@ -365,7 +365,8 @@
 	}
 }
 
-void arcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void arcfb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect)
 {
 	struct arcfb_par *par = info->par;
 
@@ -375,7 +376,8 @@
 	arcfb_lcd_update(par, rect->dx, rect->dy, rect->width, rect->height);
 }
 
-void arcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void arcfb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *area)
 {
 	struct arcfb_par *par = info->par;
 
@@ -385,7 +387,7 @@
 	arcfb_lcd_update(par, area->dx, area->dy, area->width, area->height);
 }
 
-void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct arcfb_par *par = info->par;
 
--- linux-2.6.14-rc5-mm1-full/drivers/video/tdfxfb.c.old	2005-11-06 00:35:47.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/tdfxfb.c	2005-11-06 00:35:53.000000000 +0100
@@ -1307,7 +1307,7 @@
 }
 
 #ifndef MODULE
-void tdfxfb_setup(char *options)
+static void tdfxfb_setup(char *options)
 {
 	char* this_opt;
 
--- linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_main.h.old	2005-11-06 00:36:28.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_main.h	2005-11-06 00:50:45.000000000 +0100
@@ -14,55 +14,6 @@
 #ifndef __I810_MAIN_H__
 #define __I810_MAIN_H__
 
-static int  __devinit i810fb_init_pci (struct pci_dev *dev, 
-				       const struct pci_device_id *entry);
-static void __exit i810fb_remove_pci(struct pci_dev *dev);
-static int i810fb_resume(struct pci_dev *dev);
-static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
-
-/*
- * voffset - framebuffer offset in MiB from aperture start address.  In order for
- * the driver to work with X, we must try to use memory holes left untouched by X. The 
- * following table lists where X's different surfaces start at.  
- * 
- * ---------------------------------------------
- * :                :  64 MiB     : 32 MiB      :
- * ----------------------------------------------
- * : FrontBuffer    :   0         :  0          :
- * : DepthBuffer    :   48        :  16         :
- * : BackBuffer     :   56        :  24         :
- * ----------------------------------------------
- *
- * So for chipsets with 64 MiB Aperture sizes, 32 MiB for v_offset is okay, allowing up to
- * 15 + 1 MiB of Framebuffer memory.  For 32 MiB Aperture sizes, a v_offset of 8 MiB should
- * work, allowing 7 + 1 MiB of Framebuffer memory.
- * Note, the size of the hole may change depending on how much memory you allocate to X,
- * and how the memory is split up between these surfaces.  
- *
- * Note: Anytime the DepthBuffer or FrontBuffer is overlapped, X would still run but with
- * DRI disabled.  But if the Frontbuffer is overlapped, X will fail to load.
- * 
- * Experiment with v_offset to find out which works best for you.
- */
-static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should be the default */
-static u32 voffset          __initdata = 0;
-
-static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
-
-/* Chipset Specific Functions */
-static int i810fb_set_par    (struct fb_info *info);
-static int i810fb_getcolreg  (u8 regno, u8 *red, u8 *green, u8 *blue,
-			      u8 *transp, struct fb_info *info);
-static int i810fb_setcolreg  (unsigned regno, unsigned red, unsigned green, unsigned blue,
-			      unsigned transp, struct fb_info *info);
-static int i810fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
-static int i810fb_blank      (int blank_mode, struct fb_info *info);
-
-/* Initialization */
-static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
-extern int __init agp_intel_init(void);
-
-
 /* Video Timings */
 extern void round_off_xres         (u32 *xres);
 extern void round_off_yres         (u32 *xres, u32 *yres);
@@ -101,7 +52,7 @@
 
 /* Conditionals */
 #ifdef CONFIG_X86
-inline void flush_cache(void)
+static inline void flush_cache(void)
 {
 	asm volatile ("wbinvd":::"memory");
 }
@@ -110,7 +61,9 @@
 #endif 
 
 #ifdef CONFIG_MTRR
-#define KERNEL_HAS_MTRR 1
+
+#include <asm/mtrr.h>
+
 static inline void __devinit set_mtrr(struct i810fb_par *par)
 {
 	par->mtrr_reg = mtrr_add((u32) par->aperture.physical, 
@@ -128,7 +81,6 @@
 			 par->aperture.size); 
 }
 #else
-#define KERNEL_HAS_MTRR 0
 #define set_mtrr(x) printk("set_mtrr: MTRR is disabled in the kernel\n")
 
 #define unset_mtrr(x) do { } while (0)
--- linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_main.c.old	2005-11-06 00:44:20.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_main.c	2005-11-06 00:50:48.000000000 +0100
@@ -45,17 +45,58 @@
 
 #include <asm/io.h>
 #include <asm/div64.h>
-
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif 
-
 #include <asm/page.h>
 
 #include "i810_regs.h"
 #include "i810.h"
 #include "i810_main.h"
 
+/*
+ * voffset - framebuffer offset in MiB from aperture start address.  In order for
+ * the driver to work with X, we must try to use memory holes left untouched by X. The 
+ * following table lists where X's different surfaces start at.  
+ * 
+ * ---------------------------------------------
+ * :                :  64 MiB     : 32 MiB      :
+ * ----------------------------------------------
+ * : FrontBuffer    :   0         :  0          :
+ * : DepthBuffer    :   48        :  16         :
+ * : BackBuffer     :   56        :  24         :
+ * ----------------------------------------------
+ *
+ * So for chipsets with 64 MiB Aperture sizes, 32 MiB for v_offset is okay, allowing up to
+ * 15 + 1 MiB of Framebuffer memory.  For 32 MiB Aperture sizes, a v_offset of 8 MiB should
+ * work, allowing 7 + 1 MiB of Framebuffer memory.
+ * Note, the size of the hole may change depending on how much memory you allocate to X,
+ * and how the memory is split up between these surfaces.  
+ *
+ * Note: Anytime the DepthBuffer or FrontBuffer is overlapped, X would still run but with
+ * DRI disabled.  But if the Frontbuffer is overlapped, X will fail to load.
+ * 
+ * Experiment with v_offset to find out which works best for you.
+ */
+static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should be the default */
+static u32 voffset          __initdata = 0;
+
+static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
+static int  __devinit i810fb_init_pci (struct pci_dev *dev, 
+				       const struct pci_device_id *entry);
+static void __exit i810fb_remove_pci(struct pci_dev *dev);
+static int i810fb_resume(struct pci_dev *dev);
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
+
+/* Chipset Specific Functions */
+static int i810fb_set_par    (struct fb_info *info);
+static int i810fb_getcolreg  (u8 regno, u8 *red, u8 *green, u8 *blue,
+			      u8 *transp, struct fb_info *info);
+static int i810fb_setcolreg  (unsigned regno, unsigned red, unsigned green, unsigned blue,
+			      unsigned transp, struct fb_info *info);
+static int i810fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
+static int i810fb_blank      (int blank_mode, struct fb_info *info);
+
+/* Initialization */
+static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
+
 /* PCI */
 static const char *i810_pci_list[] __devinitdata = {
 	"Intel(R) 810 Framebuffer Device"                                 ,
--- linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_accel.c.old	2005-11-06 00:36:57.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_accel.c	2005-11-06 00:37:11.000000000 +0100
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 static u32 i810fb_rop[] = {
 	COLOR_COPY_ROP, /* ROP_COPY */
--- linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_gtf.c.old	2005-11-06 00:37:27.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810_gtf.c	2005-11-06 00:37:58.000000000 +0100
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 /*
  * FIFO and Watermark tables - based almost wholly on i810_wmark.c in 
--- linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810-i2c.c.old	2005-11-06 00:38:16.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/i810/i810-i2c.c	2005-11-06 00:38:30.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/fb.h>
 #include "i810.h"
 #include "i810_regs.h"
+#include "i810_main.h"
 #include "../edid.h"
 
 #define I810_DDC 0x50

