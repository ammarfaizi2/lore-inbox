Return-Path: <linux-kernel-owner+w=401wt.eu-S1753727AbWLPN5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbWLPN5b (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbWLPN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:57:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3337 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753713AbWLPN46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:56:58 -0500
Date: Sat, 16 Dec 2006 14:56:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>,
       adaplas@pol.net
Subject: [-mm patch] drivers/video/{s3fb,svgalib}.c: possible cleanups
Message-ID: <20061216135657.GC3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-mm1:
>...
> +fbdev-driver-for-s3-trio-virge.patch
>...
>  fbdev updates
>...

This patch contains the following possible cleanups:
- CodingStyle:
  - opening braces of functions at the beginning of the next line
  - C99 struct initializers
- make the following needlessly global functions static:
  - s3fb.c: s3fb_settile()
  - s3fb.c: s3fb_tilecopy()
  - s3fb.c: s3fb_tilefill()
  - s3fb.c: s3fb_tileblit()
  - s3fb.c: s3fb_tilecursor()
  - s3fb.c: s3fb_init()
  - svgalib.c: svga_regset_size()
- #if 0 the following unused global functions:
  - svga_wseq_multi()
  - svga_dump_var()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/s3fb.c    |   29 +++++++++++++++++------------
 drivers/video/svgalib.c |   11 +++++------
 include/linux/svga.h    |    4 ----
 3 files changed, 22 insertions(+), 22 deletions(-)

--- linux-2.6.20-rc1-mm1/drivers/video/s3fb.c.old	2006-12-15 22:47:49.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/video/s3fb.c	2006-12-15 22:51:26.000000000 +0100
@@ -161,7 +161,8 @@
 
 /* Set font in text (tileblit) mode */
 
-void s3fb_settile(struct fb_info *info, struct fb_tilemap *map) {
+static void s3fb_settile(struct fb_info *info, struct fb_tilemap *map)
+{
 	const u8 *font = map->data;
 	u8* fb = (u8 *) info->screen_base;
 	int i, c;
@@ -185,7 +186,8 @@
 
 /* Copy area in text (tileblit) mode */
 
-void s3fb_tilecopy(struct fb_info *info, struct fb_tilearea *area) {
+static void s3fb_tilecopy(struct fb_info *info, struct fb_tilearea *area)
+{
 	int dx, dy;
 //	int colstride = 4;
 	int colstride = 2;
@@ -222,7 +224,8 @@
 
 /* Fill area in text (tileblit) mode */
 
-void s3fb_tilefill(struct fb_info *info, struct fb_tilerect *rect) {
+static void s3fb_tilefill(struct fb_info *info, struct fb_tilerect *rect)
+{
 	int dx, dy;
 //	int colstride = 8;
 	int colstride = 4;
@@ -244,7 +247,8 @@
 
 /* Write text in text (tileblit) mode */
 
-void s3fb_tileblit(struct fb_info *info, struct fb_tileblit *blit) {
+static void s3fb_tileblit(struct fb_info *info, struct fb_tileblit *blit)
+{
 	int dx, dy, i;
 //	int colstride = 8;
 	int colstride = 4;
@@ -270,7 +274,8 @@
 
 /* Set cursor in text (tileblit) mode */
 
-void s3fb_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor) {
+static void s3fb_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor)
+{
 	u8 cs = 0x0d;
 	u8 ce = 0x0e;
 	u16 pos =  cursor->sx + (info->var.xoffset /  8)
@@ -1183,12 +1188,12 @@
 MODULE_DEVICE_TABLE(pci, s3_devices);
 
 static struct pci_driver s3fb_pci_driver = {
-	name:"s3fb",
-	id_table:s3_devices,
-	probe:s3_pci_probe,
-	remove:__devexit_p(s3_pci_remove),
-//	suspend:s3_pci_suspend,
-//	resume:s3_pci_resume,
+	.name		= "s3fb",
+	.id_table	= s3_devices,
+	.probe		= s3_pci_probe,
+	.remove		= __devexit_p(s3_pci_remove),
+//	.suspend	= s3_pci_suspend,
+//	.resume		= s3_pci_resume,
 };
 
 /* Parse user speficied options */
@@ -1228,7 +1233,7 @@
 
 /* Driver Initialisation */
 
-int __init s3fb_init(void)
+static int __init s3fb_init(void)
 {
 
 #ifndef MODULE
--- linux-2.6.20-rc1-mm1/include/linux/svga.h.old	2006-12-15 22:52:12.000000000 +0100
+++ linux-2.6.20-rc1-mm1/include/linux/svga.h	2006-12-15 22:53:05.000000000 +0100
@@ -91,8 +91,6 @@
 
 
 void svga_wcrt_multi(const struct vga_regset *regset, u32 value);
-void svga_wseq_multi(const struct vga_regset *regset, u32 value);
-unsigned int svga_regset_size(const struct vga_regset *regset);
 
 void svga_set_default_gfx_regs(void);
 void svga_set_default_atc_regs(void);
@@ -100,8 +98,6 @@
 void svga_set_default_crt_regs(void);
 void svga_set_textmode_vga_regs(void);
 
-void svga_dump_var(struct fb_var_screeninfo *var, int node);
-
 int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u16 *r, int node);
 int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, int node);
 void svga_set_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, u32 hmul, u32 hdiv, u32 vmul, u32 vdiv, int node);
--- linux-2.6.20-rc1-mm1/drivers/video/svgalib.c.old	2006-12-15 22:54:31.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/video/svgalib.c	2006-12-15 22:54:56.000000000 +0100
@@ -42,8 +42,8 @@
 	}
 }
 
+#if 0
 /* Write a sequence register value spread across multiple registers */
-
 void svga_wseq_multi(const struct vga_regset *regset, u32 value) {
 
 	u8 regval, bitval, bitnum;
@@ -62,8 +62,9 @@
 		regset ++;
 	}
 }
+#endif  /*  0  */
 
-unsigned int svga_regset_size(const struct vga_regset *regset)
+static unsigned int svga_regset_size(const struct vga_regset *regset)
 {
 	u8 count = 0;
 
@@ -163,6 +164,7 @@
 	vga_w(NULL, VGA_ATT_W, 0x20);
 }
 
+#if 0
 void svga_dump_var(struct fb_var_screeninfo *var, int node)
 {
 	pr_debug("fb%d: var.vmode         : 0x%X\n", node, var->vmode);
@@ -180,6 +182,7 @@
 	pr_debug("fb%d: var.sync          : 0x%X\n", node, var->sync);
 	pr_debug("fb%d: var.pixclock      : %d\n\n", node, var->pixclock);
 }
+#endif  /*  0  */
 
 /* ------------------------------------------------------------------------- */
 
@@ -433,9 +436,7 @@
 }
 
 
-EXPORT_SYMBOL(svga_wseq_multi);
 EXPORT_SYMBOL(svga_wcrt_multi);
-EXPORT_SYMBOL(svga_regset_size);
 
 EXPORT_SYMBOL(svga_set_default_gfx_regs);
 EXPORT_SYMBOL(svga_set_default_atc_regs);
@@ -443,8 +444,6 @@
 EXPORT_SYMBOL(svga_set_default_crt_regs);
 EXPORT_SYMBOL(svga_set_textmode_vga_regs);
 
-EXPORT_SYMBOL(svga_dump_var);
-
 EXPORT_SYMBOL(svga_compute_pll);
 EXPORT_SYMBOL(svga_check_timings);
 EXPORT_SYMBOL(svga_set_timings);

