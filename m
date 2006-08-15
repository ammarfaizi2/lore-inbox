Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932764AbWHOAlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWHOAlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWHOAlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:41:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58887 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932764AbWHOAlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:41:02 -0400
Date: Tue, 15 Aug 2006 02:41:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/video/aty/: possible cleanups
Message-ID: <20060815004101.GE3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - mach64_ct.c: aty_st_pll_ct()
- proper prototypes for the following functions:
  - atyfb_base.c: atyfb_copyarea()
  - atyfb_base.c: atyfb_fillrect()
  - atyfb_base.c: atyfb_imageblit()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/aty/atyfb.h      |    6 +++++-
 drivers/video/aty/atyfb_base.c |    3 ---
 drivers/video/aty/mach64_ct.c  |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb.h.old	2006-08-13 23:45:13.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb.h	2006-08-13 23:50:36.000000000 +0200
@@ -355,5 +355,9 @@
 
 extern void aty_reset_engine(const struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
-extern void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par);
 extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
+
+void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
+void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
+
--- linux-2.6.18-rc4-mm1/drivers/video/aty/mach64_ct.c.old	2006-08-13 23:45:31.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/video/aty/mach64_ct.c	2006-08-13 23:45:36.000000000 +0200
@@ -27,7 +27,7 @@
 	return res;
 }
 
-void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
+static void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
 {
 	/* write addr byte */
 	aty_st_8(CLOCK_CNTL_ADDR, ((offset << 2) & PLL_ADDR) | PLL_WR_EN, par);
--- linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb_base.c.old	2006-08-13 23:48:29.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb_base.c	2006-08-13 23:50:25.000000000 +0200
@@ -240,9 +240,6 @@
 static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
-extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
-extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif


