Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUG2CQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUG2CQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUG2CQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:16:31 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:19615 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S267414AbUG2COi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:14:38 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/5] [FBDEV]: ATTN: Maintainers - Set correct hardware capabilities
Date: Thu, 29 Jul 2004 10:04:21 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407291004.21338.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With David Eger's patch for advertising hardware capabilities
to fbcon, only a few drivers so far have been converted to do
just that.  As a result, scrolling speed of some drivers will
not be optimal (SCROLL_REDRAW). The patch adds the correct
flags for all drivers (except for matroxfb -leave this to
Petr-, and a few drivers that are not ported yet to 2.6).

*Majority of changes is FBINFO_FLAG_DEFAULT -> FBINFO_DEFAULT

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 68328fb.c     |    2 +-
 acornfb.c     |    2 +-
 amifb.c       |    5 ++++-
 asiliantfb.c  |    2 +-
 bw2.c         |    2 +-
 cg14.c        |    2 +-
 cg3.c         |    2 +-
 cg6.c         |    3 ++-
 chipsfb.c     |    2 +-
 clps711xfb.c  |    2 +-
 controlfb.c   |    2 +-
 cyber2000fb.c |    2 +-
 epson1355fb.c |    2 +-
 ffb.c         |    2 +-
 fm2fb.c       |    2 +-
 g364fb.c      |    2 +-
 gbefb.c       |    2 +-
 hgafb.c       |    2 +-
 hitfb.c       |    2 +-
 hpfb.c        |    2 +-
 igafb.c       |    2 +-
 imsttfb.c     |    5 ++++-
 kyro/fbdev.c  |    2 +-
 leo.c         |    2 +-
 macfb.c       |    2 +-
 maxinefb.c    |    2 +-
 neofb.c       |    6 +++++-
 offb.c        |    2 +-
 p9100.c       |    2 +-
 platinumfb.c  |    2 +-
 pm2fb.c       |    3 ++-
 pmag-ba-fb.c  |    2 +-
 pmagb-b-fb.c  |    2 +-
 pvr2fb.c      |    2 +-
 pxafb.c       |    2 +-
 q40fb.c       |    2 +-
 radeonfb.c    |    2 +-
 sa1100fb.c    |    2 +-
 sgivwfb.c     |    2 +-
 sstfb.c       |    2 +-
 stifb.c       |    2 +-
 tcx.c         |    2 +-
 tdfxfb.c      |    6 +++++-
 tgafb.c       |    3 ++-
 tridentfb.c   |    5 ++++-
 tx3912fb.c    |    2 +-
 valkyriefb.c  |    2 +-
 47 files changed, 67 insertions(+), 47 deletions(-)

diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/68328fb.c linux-2.6.8-rc2-mm1/drivers/video/68328fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/68328fb.c	2004-07-29 00:06:11.605818720 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/68328fb.c	2004-07-29 00:06:31.435804104 +0000
@@ -466,7 +466,7 @@ int __init mc68x328fb_init(void)
 		fb_info.var.red.offset = fb_info.var.green.offset = fb_info.var.blue.offset = 0;
 	}
 	fb_info.pseudo_palette = &mc68x328fb_pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/acornfb.c linux-2.6.8-rc2-mm1/drivers/video/acornfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/acornfb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/acornfb.c	2004-07-29 00:06:31.437803800 +0000
@@ -1010,7 +1010,7 @@ static void __init acornfb_init_fbinfo(v
 	first = 0;
 
 	fb_info.fbops		= &acornfb_ops;
-	fb_info.flags		= FBINFO_FLAG_DEFAULT;
+	fb_info.flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	fb_info.pseudo_palette	= current_par.pseudo_palette;
 
 	strcpy(fb_info.fix.id, "Acorn");
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/amifb.c linux-2.6.8-rc2-mm1/drivers/video/amifb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/amifb.c	2004-07-28 19:51:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/amifb.c	2004-07-29 00:06:31.440803344 +0000
@@ -1307,6 +1307,8 @@ static int amifb_set_par(struct fb_info 
 		info->fix.ywrapstep = 1;
 		info->fix.xpanstep = 0;
 		info->fix.ypanstep = 0;
+		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YWRAP |
+		    FBINFO_READS_FAST; /* override SCROLL_REDRAW */
 	} else {
 		info->fix.ywrapstep = 0;
 		if (par->vmode & FB_VMODE_SMOOTH_XPAN)
@@ -1314,6 +1316,7 @@ static int amifb_set_par(struct fb_info 
 		else
 			info->fix.xpanstep = 16<<maxfmode;
 		info->fix.ypanstep = 1;
+		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	}
 	return 0;
 }
@@ -2382,7 +2385,7 @@ default_chipset:
 
 	fb_info.fbops = &amifb_ops;
 	fb_info.par = &currentpar;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	if (!fb_find_mode(&fb_info.var, &fb_info, mode_option, ami_modedb,
 			  NUM_TOTAL_MODES, &ami_modedb[defmode], 4)) {
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/asiliantfb.c linux-2.6.8-rc2-mm1/drivers/video/asiliantfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/asiliantfb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/asiliantfb.c	2004-07-29 00:06:31.441803192 +0000
@@ -524,7 +524,7 @@ static void __init init_asiliant(struct 
 	p->fix.smem_start	= addr;
 	p->var			= asiliantfb_var;
 	p->fbops		= &asiliantfb_ops;
-	p->flags		= FBINFO_FLAG_DEFAULT;
+	p->flags		= FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/bw2.c linux-2.6.8-rc2-mm1/drivers/video/bw2.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/bw2.c	2004-07-29 00:06:11.606818568 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/bw2.c	2004-07-29 00:06:31.442803040 +0000
@@ -351,7 +351,7 @@ static void bw2_init_one(struct sbus_dev
 
 	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &bw2_ops;
 #if defined(CONFIG_SPARC32)
 	if (sdev)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/cg14.c linux-2.6.8-rc2-mm1/drivers/video/cg14.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/cg14.c	2004-05-10 02:33:20.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/cg14.c	2004-07-29 00:06:31.443802888 +0000
@@ -550,7 +550,7 @@ static void cg14_init_one(struct sbus_de
 	all->par.mode = MDI_8_PIX;
 	all->par.ramsize = (is_8mb ? 0x800000 : 0x400000);
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	all->info.fbops = &cg14_ops;
 	all->info.currcon = -1;
 	all->info.par = &all->par;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/cg3.c linux-2.6.8-rc2-mm1/drivers/video/cg3.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/cg3.c	2004-05-10 02:32:52.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/cg3.c	2004-07-29 00:06:31.444802736 +0000
@@ -398,7 +398,7 @@ static void cg3_init_one(struct sbus_dev
 		sbus_ioremap(&sdev->resource[0], CG3_REGS_OFFSET,
 			     sizeof(struct cg3_regs), "cg3 regs");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &cg3_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/cg6.c linux-2.6.8-rc2-mm1/drivers/video/cg6.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/cg6.c	2004-05-10 02:32:26.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/cg6.c	2004-07-29 00:06:31.456800912 +0000
@@ -712,7 +712,8 @@ static void cg6_init_one(struct sbus_dev
 		sbus_ioremap(&sdev->resource[0], CG6_FHC_OFFSET,
 			     sizeof(u32), "cgsix fhc");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT |
+                          FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
 	all->info.fbops = &cg6_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/chipsfb.c linux-2.6.8-rc2-mm1/drivers/video/chipsfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/chipsfb.c	2004-07-28 19:51:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/chipsfb.c	2004-07-29 00:06:31.457800760 +0000
@@ -362,7 +362,7 @@ static void __init init_chips(struct fb_
 	p->var = chipsfb_var;
 
 	p->fbops = &chipsfb_ops;
-	p->flags = FBINFO_FLAG_DEFAULT;
+	p->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/clps711xfb.c linux-2.6.8-rc2-mm1/drivers/video/clps711xfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/clps711xfb.c	2004-05-10 02:32:02.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/clps711xfb.c	2004-07-29 00:06:31.458800608 +0000
@@ -372,7 +372,7 @@ int __init clps711xfb_init(void)
 	strcpy(cfb->fix.id, "clps711x");
 
 	cfb->fbops		= &clps7111fb_ops;
-	cfb->flags		= FBINFO_FLAG_DEFAULT;
+	cfb->flags		= FBINFO_DEFAULT;
 
 	clps711x_guess_lcd_params(cfb);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/controlfb.c linux-2.6.8-rc2-mm1/drivers/video/controlfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/controlfb.c	2004-05-10 02:32:21.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/controlfb.c	2004-07-29 00:06:31.459800456 +0000
@@ -1010,7 +1010,7 @@ static void __init control_init_info(str
 	info->par = &p->par;
 	info->fbops = &controlfb_ops;
 	info->pseudo_palette = p->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	info->screen_base = (char *) p->frame_buffer + CTRLFB_OFF;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/cyber2000fb.c linux-2.6.8-rc2-mm1/drivers/video/cyber2000fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/cyber2000fb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/cyber2000fb.c	2004-07-29 00:06:31.461800152 +0000
@@ -1281,7 +1281,7 @@ cyberpro_alloc_fb_info(unsigned int id, 
 	cfb->fb.var.accel_flags	= FB_ACCELF_TEXT;
 
 	cfb->fb.fbops		= &cyber2000fb_ops;
-	cfb->fb.flags		= FBINFO_FLAG_DEFAULT;
+	cfb->fb.flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	cfb->fb.pseudo_palette	= (void *)(cfb + 1);
 
 	fb_alloc_cmap(&cfb->fb.cmap, NR_PALETTE, 0);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/epson1355fb.c linux-2.6.8-rc2-mm1/drivers/video/epson1355fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/epson1355fb.c	2004-05-10 02:31:59.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/epson1355fb.c	2004-07-29 00:06:31.462800000 +0000
@@ -507,7 +507,7 @@ int __init e1355fb_init(void)
 	fb_info.gen.parsize = sizeof(struct e1355_par);
 	fb_info.gen.info.switch_con = &fbgen_switch;
 	fb_info.gen.info.updatevar = &fbgen_update_var;
-	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.gen.info.flags = FBINFO_DEFAULT;
 	/* This should give a reasonable default video mode */
 	fbgen_get_var(&disp.var, -1, &fb_info.gen.info);
 	fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/ffb.c linux-2.6.8-rc2-mm1/drivers/video/ffb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/ffb.c	2004-05-10 02:33:22.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/ffb.c	2004-07-29 00:06:31.463799848 +0000
@@ -1027,7 +1027,7 @@ static void ffb_init_one(int node, int p
 	all->par.prom_node = node;
 	all->par.prom_parent_node = parent;
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &ffb_ops;
 	all->info.screen_base = (char *) all->par.physbase + FFB_DFB24_POFF;
 	all->info.currcon = -1;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/fm2fb.c linux-2.6.8-rc2-mm1/drivers/video/fm2fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/fm2fb.c	2004-05-10 02:32:28.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/fm2fb.c	2004-07-29 00:06:31.464799696 +0000
@@ -280,7 +280,7 @@ static int __devinit fm2fb_probe(struct 
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 	info->fix = fb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/g364fb.c linux-2.6.8-rc2-mm1/drivers/video/g364fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/g364fb.c	2004-05-10 02:32:00.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/g364fb.c	2004-07-29 00:06:31.465799544 +0000
@@ -241,7 +241,7 @@ int __init g364fb_init(void)
 	fb_info.screen_base = (char *) G364_MEM_BASE;	/* virtual kernel address */
 	fb_info.var = fb_var;
 	fb_info.fix = fb_fix;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	fb_alloc_cmap(&fb_info.cmap, 255, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/gbefb.c linux-2.6.8-rc2-mm1/drivers/video/gbefb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/gbefb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/gbefb.c	2004-07-29 00:06:31.466799392 +0000
@@ -1135,7 +1135,7 @@ int __init gbefb_init(void)
 	fb_info.currcon = -1;
 	fb_info.fbops = &gbefb_ops;
 	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	fb_info.screen_base = gbe_mem;
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/hgafb.c linux-2.6.8-rc2-mm1/drivers/video/hgafb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/hgafb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/hgafb.c	2004-07-29 00:06:31.467799240 +0000
@@ -558,7 +558,7 @@ int __init hgafb_init(void)
 	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
 	hga_fix.smem_len = hga_vram_len;
 
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	fb_info.var = hga_default_var;
 	fb_info.fix = hga_fix;
 	fb_info.monspecs.hfmin = 0;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/hitfb.c linux-2.6.8-rc2-mm1/drivers/video/hitfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/hitfb.c	2004-05-10 02:32:00.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/hitfb.c	2004-07-29 00:06:31.468799088 +0000
@@ -321,7 +321,7 @@ int __init hitfb_init(void)
 	fb_info.var = hitfb_var;
 	fb_info.fix = hitfb_fix;
 	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	fb_info.screen_base = (void *)hitfb_fix.smem_start;
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/hpfb.c linux-2.6.8-rc2-mm1/drivers/video/hpfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/hpfb.c	2004-05-10 02:32:37.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/hpfb.c	2004-07-29 00:06:31.469798936 +0000
@@ -151,7 +151,7 @@ int __init hpfb_init_one(unsigned long b
 	 *	Let there be consoles..
 	 */
 	fb_info.fbops = &hpfb_ops;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	fb_info.var   = hpfb_defined;
 	fb_info.fix   = hpfb_fix;
 	fb_info.screen_base = (char *)hpfb_fix.smem_start;	// FIXME
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/igafb.c linux-2.6.8-rc2-mm1/drivers/video/igafb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/igafb.c	2004-05-10 02:32:38.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/igafb.c	2004-07-29 00:06:31.470798784 +0000
@@ -357,7 +357,7 @@ static int __init iga_init(struct fb_inf
                 video_cmap_len = 256;
 
 	info->fbops = &igafb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/imsttfb.c linux-2.6.8-rc2-mm1/drivers/video/imsttfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/imsttfb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/imsttfb.c	2004-07-29 00:06:31.471798632 +0000
@@ -1442,7 +1442,10 @@ init_imstt(struct fb_info *info)
 	info->var.pixclock = 1000000 / getclkMHz(par);
 
 	info->fbops = &imsttfb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT |
+                      FBINFO_HWACCEL_COPYAREA |
+	              FBINFO_HWACCEL_FILLRECT |
+	              FBINFO_HWACCEL_YPAN;
 
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/kyro/fbdev.c linux-2.6.8-rc2-mm1/drivers/video/kyro/fbdev.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/kyro/fbdev.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/kyro/fbdev.c	2004-07-29 00:06:31.472798480 +0000
@@ -712,7 +712,7 @@ static int __devinit kyrofb_probe(struct
 	info->fix		= kyro_fix;
 	info->par		= currentpar;
 	info->pseudo_palette	= (void *)(currentpar + 1);
-	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->flags		= FBINFO_DEFAULT;
 
 	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/leo.c linux-2.6.8-rc2-mm1/drivers/video/leo.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/leo.c	2004-05-10 02:33:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/leo.c	2004-07-29 00:06:31.473798328 +0000
@@ -588,7 +588,7 @@ static void leo_init_one(struct sbus_dev
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LX_CURSOR,
 			     sizeof(struct leo_cursor), "leolx cursor");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	all->info.fbops = &leo_ops;
 	all->info.currcon = -1;
 	all->info.par = &all->par;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/macfb.c linux-2.6.8-rc2-mm1/drivers/video/macfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/macfb.c	2004-07-29 00:06:11.611817808 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/macfb.c	2004-07-29 00:06:31.475798024 +0000
@@ -950,7 +950,7 @@ void __init macfb_init(void)
 	fb_info.var		= macfb_defined;
 	fb_info.fix		= macfb_fix;
 	fb_info.pseudo_palette	= pseudo_palette;
-	fb_info.flags		= FBINFO_FLAG_DEFAULT;
+	fb_info.flags		= FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 	
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/maxinefb.c linux-2.6.8-rc2-mm1/drivers/video/maxinefb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/maxinefb.c	2004-05-10 02:32:26.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/maxinefb.c	2004-07-29 00:06:31.475798024 +0000
@@ -159,7 +159,7 @@ int __init maxinefb_init(void)
 	fb_info.screen_base = (char *) maxinefb_fix.smem_start;
 	fb_info.var = maxinefb_defined;
 	fb_info.fix = maxinefb_fix;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/neofb.c linux-2.6.8-rc2-mm1/drivers/video/neofb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/neofb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/neofb.c	2004-07-29 00:06:31.477797720 +0000
@@ -2055,7 +2055,11 @@ static struct fb_info *__devinit neo_all
 	info->fix.accel = id->driver_data;
 
 	info->fbops = &neofb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT |
+	              FBINFO_HWACCEL_IMAGEBLIT |
+                      FBINFO_HWACCEL_FILLRECT |
+                      FBINFO_HWACCEL_COPYAREA |
+                      FBINFO_HWACCEL_YPAN;
 	info->pseudo_palette = (void *) (par + 1);
 	return info;
 }
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/offb.c linux-2.6.8-rc2-mm1/drivers/video/offb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/offb.c	2004-05-10 02:33:20.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/offb.c	2004-07-29 00:06:31.478797568 +0000
@@ -527,7 +527,7 @@ static void __init offb_init_fb(const ch
 	info->screen_base = ioremap(address, fix->smem_len);
 	info->par = par;
 	info->pseudo_palette = (void *) (info + 1);
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/p9100.c linux-2.6.8-rc2-mm1/drivers/video/p9100.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/p9100.c	2004-05-10 02:32:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/p9100.c	2004-07-29 00:06:31.479797416 +0000
@@ -297,7 +297,7 @@ static void p9100_init_one(struct sbus_d
 		sbus_ioremap(&sdev->resource[0], 0,
 			     sizeof(struct p9100_regs), "p9100 regs");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &p9100_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/platinumfb.c linux-2.6.8-rc2-mm1/drivers/video/platinumfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/platinumfb.c	2004-05-10 02:32:28.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/platinumfb.c	2004-07-29 00:06:31.480797264 +0000
@@ -311,7 +311,7 @@ static void __devinit platinum_init_info
 	/* Fill fb_info */
 	info->fbops = &platinumfb_ops;
 	info->pseudo_palette = pinfo->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT;
 	info->screen_base = (char *) pinfo->frame_buffer + 0x20;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/pm2fb.c linux-2.6.8-rc2-mm1/drivers/video/pm2fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/pm2fb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/pm2fb.c	2004-07-29 00:06:31.482796960 +0000
@@ -1124,7 +1124,8 @@ static int __devinit pm2fb_probe(struct 
 	info->fbops		= &pm2fb_ops;
 	info->fix		= pm2fb_fix; 	
 	info->pseudo_palette	= (void *)(default_par + 1); 
-	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->flags		= FBINFO_DEFAULT |
+                                  FBINFO_HWACCEL_YPAN;
 
 #ifndef MODULE
 	if (!mode)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/pmag-ba-fb.c linux-2.6.8-rc2-mm1/drivers/video/pmag-ba-fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/pmag-ba-fb.c	2004-05-10 02:33:20.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/pmag-ba-fb.c	2004-07-29 00:06:31.483796808 +0000
@@ -142,7 +142,7 @@ int __init pmagbafb_init_one(int slot)
 	info->var = pmagbafb_defined;
 	info->fix = pmagbafb_fix; 
 	info->screen_base = pmagbafb_fix.smem_start;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 	
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/pmagb-b-fb.c linux-2.6.8-rc2-mm1/drivers/video/pmagb-b-fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/pmagb-b-fb.c	2004-05-10 02:32:39.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/pmagb-b-fb.c	2004-07-29 00:06:31.483796808 +0000
@@ -145,7 +145,7 @@ int __init pmagbbfb_init_one(int slot)
 	info->var = pmagbbfb_defined;
 	info->fix = pmagbbfb_fix;
 	info->screen_base = pmagbbfb_fix.smem_start; 
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/pvr2fb.c linux-2.6.8-rc2-mm1/drivers/video/pvr2fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/pvr2fb.c	2004-05-10 02:32:00.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/pvr2fb.c	2004-07-29 00:06:31.484796656 +0000
@@ -795,7 +795,7 @@ static int __init pvr2fb_common_init(voi
 	fb_info->fix		= pvr2_fix;
 	fb_info->par		= currentpar;
 	fb_info->pseudo_palette	= (void *)(fb_info->par + 1);
-	fb_info->flags		= FBINFO_FLAG_DEFAULT;
+	fb_info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	if (video_output == VO_VGA)
 		defmode = DEFMODE_VGA;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/pxafb.c linux-2.6.8-rc2-mm1/drivers/video/pxafb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/pxafb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/pxafb.c	2004-07-29 00:06:31.486796352 +0000
@@ -1040,7 +1040,7 @@ static struct pxafb_info * __init pxafb_
 	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
 
 	fbi->fb.fbops		= &pxafb_ops;
-	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
+	fbi->fb.flags		= FBINFO_DEFAULT;
 	fbi->fb.node		= -1;
 	fbi->fb.currcon		= -1;
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/q40fb.c linux-2.6.8-rc2-mm1/drivers/video/q40fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/q40fb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/q40fb.c	2004-07-29 00:06:31.487796200 +0000
@@ -105,7 +105,7 @@ static int __init q40fb_probe(struct dev
 	info->var = q40fb_var;
 	info->fix = q40fb_fix;
 	info->fbops = &q40fb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
+	info->flags = FBINFO_DEFAULT;  /* not as module for now */
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 	info->screen_base = (char *) q40fb_fix.smem_start;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/radeonfb.c linux-2.6.8-rc2-mm1/drivers/video/radeonfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/radeonfb.c	2004-07-28 19:51:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/radeonfb.c	2004-07-29 00:06:31.489795896 +0000
@@ -2250,7 +2250,7 @@ static int __devinit radeon_set_fbinfo (
 	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
         info->fbops = &radeonfb_ops;
         info->screen_base = (char *)rinfo->fb_base;
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/sa1100fb.c linux-2.6.8-rc2-mm1/drivers/video/sa1100fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/sa1100fb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/sa1100fb.c	2004-07-29 00:06:31.491795592 +0000
@@ -1673,7 +1673,7 @@ static struct sa1100fb_info * __init sa1
 	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
 
 	fbi->fb.fbops		= &sa1100fb_ops;
-	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
+	fbi->fb.flags		= FBINFO_DEFAULT;
 	fbi->fb.monspecs	= monspecs;
 	fbi->fb.currcon		= -1;
 	fbi->fb.pseudo_palette	= (fbi + 1);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/sgivwfb.c linux-2.6.8-rc2-mm1/drivers/video/sgivwfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/sgivwfb.c	2004-05-10 02:32:30.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/sgivwfb.c	2004-07-29 00:06:31.493795288 +0000
@@ -790,7 +790,7 @@ int __init sgivwfb_init(void)
 	fb_info.fbops = &sgivwfb_ops;
 	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.par = &default_par;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_info.screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
 	if (!fb_info.screen_base) {
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/sstfb.c linux-2.6.8-rc2-mm1/drivers/video/sstfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/sstfb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/sstfb.c	2004-07-29 00:06:31.494795136 +0000
@@ -1473,7 +1473,7 @@ static int __devinit sstfb_probe(struct 
 	f_ddprintk("membase_phys: %#lx\n", fix->smem_start);
 	f_ddprintk("fbbase_virt: %p\n", info->screen_base);
 
-	info->flags	= FBINFO_FLAG_DEFAULT;
+	info->flags	= FBINFO_DEFAULT;
 	info->fbops	= &sstfb_ops;
 	info->currcon	= -1;
 	info->pseudo_palette = &all->pseudo_palette;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/stifb.c linux-2.6.8-rc2-mm1/drivers/video/stifb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/stifb.c	2004-07-29 00:06:11.613817504 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/stifb.c	2004-07-29 00:06:31.496794832 +0000
@@ -1325,7 +1325,7 @@ stifb_init_fb(struct sti_struct *sti, in
 	strcpy(fix->id, "stifb");
 	info->fbops = &stifb_ops;
 	info->screen_base = (void*) REGION_BASE(fb,1);
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	info->currcon = -1;
 
 	/* This has to been done !!! */
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/tcx.c linux-2.6.8-rc2-mm1/drivers/video/tcx.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/tcx.c	2004-05-10 02:31:55.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/tcx.c	2004-07-29 00:06:31.497794680 +0000
@@ -412,7 +412,7 @@ static void tcx_init_one(struct sbus_dev
 		all->par.mmap_map[i].poff = sdev->reg_addrs[j].phys_addr;
 	}
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &tcx_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/tdfxfb.c linux-2.6.8-rc2-mm1/drivers/video/tdfxfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/tdfxfb.c	2004-07-28 19:50:54.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/tdfxfb.c	2004-07-29 00:06:31.498794528 +0000
@@ -1253,7 +1253,11 @@ static int __devinit tdfxfb_probe(struct
 	info->fix		= tdfx_fix; 	
 	info->par		= default_par;
 	info->pseudo_palette	= (void *)(default_par + 1); 
-	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->flags		= FBINFO_DEFAULT |
+                                  FBINFO_HWACCEL_COPYAREA |
+                                  FBINFO_HWACCEL_FILLRECT |
+                                  FBINFO_HWACCEL_IMAGEBLIT |
+	                          FBINFO_HWACCEL_YPAN;
 
 #ifndef MODULE
 	if (!mode_option)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/tgafb.c linux-2.6.8-rc2-mm1/drivers/video/tgafb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/tgafb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/tgafb.c	2004-07-29 00:06:31.500794224 +0000
@@ -1426,7 +1426,8 @@ tgafb_pci_register(struct pci_dev *pdev,
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &all->par.tga_chip_rev);
 
 	/* Setup framebuffer.  */
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
+                          FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_FILLRECT;
 	all->info.fbops = &tgafb_ops;
 	all->info.screen_base = (char *) all->par.tga_fb_base;
 	all->info.currcon = -1;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/tridentfb.c linux-2.6.8-rc2-mm1/drivers/video/tridentfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/tridentfb.c	2004-07-15 12:26:34.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/tridentfb.c	2004-07-29 00:06:31.502793920 +0000
@@ -1149,7 +1149,10 @@ static int __devinit trident_pci_probe(s
 	fb_info.fbops = &tridentfb_ops;
 
 
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+#ifdef CONFIG_FB_TRIDENT_ACCEL
+	fb_info.flags |= FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
+#endif
 	fb_info.pseudo_palette = pseudo_pal;
 
 	if (!fb_find_mode(&default_var,&fb_info,mode,NULL,0,NULL,bpp))
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/tx3912fb.c linux-2.6.8-rc2-mm1/drivers/video/tx3912fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/tx3912fb.c	2004-07-29 00:06:11.614817352 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/tx3912fb.c	2004-07-29 00:06:31.503793768 +0000
@@ -299,7 +299,7 @@ int __init tx3912fb_init(void)
 	fb_info.var = tx3912fb_var;
 	fb_info.fix = tx3912fb_fix;
 	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	/* Clear the framebuffer */
 	memset((void *) fb_info.fix.smem_start, 0xff, fb_info.fix.smem_len);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/valkyriefb.c linux-2.6.8-rc2-mm1/drivers/video/valkyriefb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/valkyriefb.c	2004-07-28 19:51:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/valkyriefb.c	2004-07-29 00:06:31.504793616 +0000
@@ -540,7 +540,7 @@ static void __init valkyrie_init_info(st
 {
 	info->fbops = &valkyriefb_ops;
 	info->screen_base = (char *) p->frame_buffer + 0x1000;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	info->pseudo_palette = p->pseudo_palette;
 	fb_alloc_cmap(&info->cmap, 256, 0);
 	info->par = &p->par;


