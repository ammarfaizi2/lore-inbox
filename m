Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265183AbUETQE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265183AbUETQE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbUETQE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:04:26 -0400
Received: from havoc.gtf.org ([216.162.42.101]:8623 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265183AbUETQBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:01:32 -0400
Date: Thu, 20 May 2004 12:01:17 -0400
From: David Eger <eger@havoc.gtf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@theboonies.us>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] s/FBINFO_FLAG_/FBINFO_/g
Message-ID: <20040520160116.GB17807@havoc.gtf.org>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us> <20040519030319.1f0e6eec.akpm@osdl.org> <20040520155439.GA17330@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520155439.GA17330@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
#   2004/05/15 14:09:31+02:00 eger@rosencrantz.theboonies.us 
#	Baseline patch to make framebuffer/fbcon interaction more sane by 
#	basing the fbcon heuristics on capabilities advertized by underlying 
#	framebuffer via the fb_info.flags field.
#
#	This patch runs 's/FBINFO_FLAG_DEFAULT/FBINFO_DEFAULT/g' on the fb drivers 
#	to let them compile with the new flags (see part a of this patch).  
# 
diff -Nru a/drivers/video/S3triofb.c b/drivers/video/S3triofb.c
--- a/drivers/video/S3triofb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/S3triofb.c	Sat May 15 22:53:10 2004
@@ -536,7 +536,7 @@
     fb_info.setcmap = &s3triofbcon_setcmap;
 #endif
 
-    fb_info.flags = FBINFO_FLAG_DEFAULT;
+    fb_info.flags = FBINFO_DEFAULT;
     if (register_framebuffer(&fb_info) < 0)
 	return;
 
diff -Nru a/drivers/video/amifb.c b/drivers/video/amifb.c
--- a/drivers/video/amifb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/amifb.c	Sat May 15 22:53:10 2004
@@ -2382,7 +2382,7 @@
 
 	fb_info.fbops = &amifb_ops;
 	fb_info.par = &currentpar;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	if (!fb_find_mode(&fb_info.var, &fb_info, mode_option, ami_modedb,
 			  NUM_TOTAL_MODES, &ami_modedb[defmode], 4)) {
diff -Nru a/drivers/video/atafb.c b/drivers/video/atafb.c
--- a/drivers/video/atafb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/atafb.c	Sat May 15 22:53:10 2004
@@ -2798,7 +2798,7 @@
 	fb_info.currcon = -1;
 	fb_info.switch_con = &atafb_switch;
 	fb_info.updatevar = &fb_update_var;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	do_fb_set_var(&atafb_predefined[default_par-1], 1);
 	strcat(fb_info.modename, fb_var_names[default_par-1][0]);
 
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/aty/aty128fb.c	Sat May 15 22:53:10 2004
@@ -1771,7 +1771,7 @@
 
 	/* fill in info */
 	info->fbops = &aty128fb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 #ifdef CONFIG_PMAC_PBOOK
 	par->lcd_on = default_lcd_on;
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/aty/atyfb_base.c	Sat May 15 22:53:10 2004
@@ -1790,7 +1790,7 @@
 
 	info->fbops = &atyfb_ops;
 	info->pseudo_palette = pseudo_palette;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (M64_HAS(G3_PB_1_1) && machine_is_compatible("PowerBook1,1")) {
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/aty/radeon_base.c	Sat May 15 22:53:10 2004
@@ -1781,7 +1781,7 @@
 	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT;
         info->fbops = &radeonfb_ops;
         info->display_fg = NULL;
         info->screen_base = (char *)rinfo->fb_base;
diff -Nru a/drivers/video/bw2.c b/drivers/video/bw2.c
--- a/drivers/video/bw2.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/bw2.c	Sat May 15 22:53:10 2004
@@ -347,7 +347,7 @@
 
 	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &bw2_ops;
 #if defined(CONFIG_SPARC32)
 	if (sdev)
diff -Nru a/drivers/video/cg14.c b/drivers/video/cg14.c
--- a/drivers/video/cg14.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/cg14.c	Sat May 15 22:53:10 2004
@@ -550,7 +550,7 @@
 	all->par.mode = MDI_8_PIX;
 	all->par.ramsize = (is_8mb ? 0x800000 : 0x400000);
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &cg14_ops;
 	all->info.currcon = -1;
 	all->info.par = &all->par;
diff -Nru a/drivers/video/cg3.c b/drivers/video/cg3.c
--- a/drivers/video/cg3.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/cg3.c	Sat May 15 22:53:10 2004
@@ -398,7 +398,7 @@
 		sbus_ioremap(&sdev->resource[0], CG3_REGS_OFFSET,
 			     sizeof(struct cg3_regs), "cg3 regs");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &cg3_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -Nru a/drivers/video/cg6.c b/drivers/video/cg6.c
--- a/drivers/video/cg6.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/cg6.c	Sat May 15 22:53:10 2004
@@ -712,7 +712,7 @@
 		sbus_ioremap(&sdev->resource[0], CG6_FHC_OFFSET,
 			     sizeof(u32), "cgsix fhc");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &cg6_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -Nru a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
--- a/drivers/video/chipsfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/chipsfb.c	Sat May 15 22:53:10 2004
@@ -362,7 +362,7 @@
 	p->var = chipsfb_var;
 
 	p->fbops = &chipsfb_ops;
-	p->flags = FBINFO_FLAG_DEFAULT;
+	p->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/cirrusfb.c	Sat May 15 22:53:10 2004
@@ -2786,7 +2786,7 @@
 	fb_info->gen.info.changevar = NULL;
 	fb_info->gen.info.switch_con = &fbgen_switch;
 	fb_info->gen.info.updatevar = &fbgen_update_var;
-	fb_info->gen.info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->gen.info.flags = FBINFO_DEFAULT;
 
 	for (j = 0; j < 256; j++) {
 		if (j < 16) {
diff -Nru a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
--- a/drivers/video/clps711xfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/clps711xfb.c	Sat May 15 22:53:10 2004
@@ -372,7 +372,7 @@
 	strcpy(cfb->fix.id, "clps711x");
 
 	cfb->fbops		= &clps7111fb_ops;
-	cfb->flags		= FBINFO_FLAG_DEFAULT;
+	cfb->flags		= FBINFO_DEFAULT;
 
 	clps711x_guess_lcd_params(cfb);
 
diff -Nru a/drivers/video/controlfb.c b/drivers/video/controlfb.c
--- a/drivers/video/controlfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/controlfb.c	Sat May 15 22:53:10 2004
@@ -1010,7 +1010,7 @@
 	info->par = &p->par;
 	info->fbops = &controlfb_ops;
 	info->pseudo_palette = p->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT;
 	info->screen_base = (char *) p->frame_buffer + CTRLFB_OFF;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/cyber2000fb.c	Sat May 15 22:53:10 2004
@@ -1281,7 +1281,7 @@
 	cfb->fb.var.accel_flags	= FB_ACCELF_TEXT;
 
 	cfb->fb.fbops		= &cyber2000fb_ops;
-	cfb->fb.flags		= FBINFO_FLAG_DEFAULT;
+	cfb->fb.flags		= FBINFO_DEFAULT;
 	cfb->fb.pseudo_palette	= (void *)(cfb + 1);
 
 	fb_alloc_cmap(&cfb->fb.cmap, NR_PALETTE, 0);
diff -Nru a/drivers/video/ffb.c b/drivers/video/ffb.c
--- a/drivers/video/ffb.c	Sat May 15 22:53:11 2004
+++ b/drivers/video/ffb.c	Sat May 15 22:53:11 2004
@@ -1027,7 +1027,7 @@
 	all->par.prom_node = node;
 	all->par.prom_parent_node = parent;
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &ffb_ops;
 	all->info.screen_base = (char *) all->par.physbase + FFB_DFB24_POFF;
 	all->info.currcon = -1;
diff -Nru a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
--- a/drivers/video/fm2fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/fm2fb.c	Sat May 15 22:53:10 2004
@@ -280,7 +280,7 @@
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 	info->fix = fb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
diff -Nru a/drivers/video/g364fb.c b/drivers/video/g364fb.c
--- a/drivers/video/g364fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/g364fb.c	Sat May 15 22:53:10 2004
@@ -241,7 +241,7 @@
 	fb_info.screen_base = (char *) G364_MEM_BASE;	/* virtual kernel address */
 	fb_info.var = fb_var;
 	fb_info.fix = fb_fix;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 255, 0);
 
diff -Nru a/drivers/video/hgafb.c b/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/hgafb.c	Sat May 15 22:53:10 2004
@@ -558,7 +558,7 @@
 	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
 	hga_fix.smem_len = hga_vram_len;
 
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	fb_info.var = hga_default_var;
 	fb_info.fix = hga_fix;
 	fb_info.monspecs.hfmin = 0;
diff -Nru a/drivers/video/hitfb.c b/drivers/video/hitfb.c
--- a/drivers/video/hitfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/hitfb.c	Sat May 15 22:53:10 2004
@@ -321,7 +321,7 @@
 	fb_info.var = hitfb_var;
 	fb_info.fix = hitfb_fix;
 	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_info.screen_base = (void *)hitfb_fix.smem_start;
 
diff -Nru a/drivers/video/hpfb.c b/drivers/video/hpfb.c
--- a/drivers/video/hpfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/hpfb.c	Sat May 15 22:53:10 2004
@@ -151,7 +151,7 @@
 	 *	Let there be consoles..
 	 */
 	fb_info.fbops = &hpfb_ops;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	fb_info.var   = hpfb_defined;
 	fb_info.fix   = hpfb_fix;
 	fb_info.screen_base = (char *)hpfb_fix.smem_start;	// FIXME
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/i810/i810_main.c	Sat May 15 22:53:10 2004
@@ -1879,7 +1879,7 @@
 	info->screen_base = par->fb.virtual;
 	info->fbops = &par->i810fb_ops;
 	info->pseudo_palette = par->pseudo_palette;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
diff -Nru a/drivers/video/igafb.c b/drivers/video/igafb.c
--- a/drivers/video/igafb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/igafb.c	Sat May 15 22:53:10 2004
@@ -357,7 +357,7 @@
                 video_cmap_len = 256;
 
 	info->fbops = &igafb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
 
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/imsttfb.c	Sat May 15 22:53:10 2004
@@ -1441,7 +1441,7 @@
 	info->var.pixclock = 1000000 / getclkMHz(par);
 
 	info->fbops = &imsttfb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
diff -Nru a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
--- a/drivers/video/kyro/fbdev.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/kyro/fbdev.c	Sat May 15 22:53:10 2004
@@ -714,7 +714,7 @@
 	info->fix		= kyro_fix;
 	info->par		= currentpar;
 	info->pseudo_palette	= (void *)(currentpar + 1);
-	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->flags		= FBINFO_DEFAULT;
 
 	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
 
diff -Nru a/drivers/video/leo.c b/drivers/video/leo.c
--- a/drivers/video/leo.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/leo.c	Sat May 15 22:53:10 2004
@@ -588,7 +588,7 @@
 		sbus_ioremap(&sdev->resource[0], LEO_OFF_LX_CURSOR,
 			     sizeof(struct leo_cursor), "leolx cursor");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &leo_ops;
 	all->info.currcon = -1;
 	all->info.par = &all->par;
diff -Nru a/drivers/video/macfb.c b/drivers/video/macfb.c
--- a/drivers/video/macfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/macfb.c	Sat May 15 22:53:10 2004
@@ -947,7 +947,7 @@
 	fb_info.var		= macfb_defined;
 	fb_info.fix		= macfb_fix;
 	fb_info.pseudo_palette	= pseudo_palette;
-	fb_info.flags		= FBINFO_FLAG_DEFAULT;
+	fb_info.flags		= FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 	
diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/matrox/matroxfb_base.c	Sat May 15 22:53:10 2004
@@ -1716,7 +1716,7 @@
 	ACCESS_FBINFO(fbcon.fbops) = &ACCESS_FBINFO(fbops);
 	ACCESS_FBINFO(fbcon.pseudo_palette) = ACCESS_FBINFO(cmap);
 	/* after __init time we are like module... no logo */
-	ACCESS_FBINFO(fbcon.flags) = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
+	ACCESS_FBINFO(fbcon.flags) = hotplug ? FBINFO_MODULE : FBINFO_DEFAULT;
 	ACCESS_FBINFO(video.len_usable) &= PAGE_MASK;
 	fb_alloc_cmap(&ACCESS_FBINFO(fbcon.cmap), 256, 1);
 
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/matrox/matroxfb_crtc2.c	Sat May 15 22:53:10 2004
@@ -602,7 +602,7 @@
 	void* oldcrtc2;
 
 	m2info->fbcon.fbops = &matroxfb_dh_ops;
-	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
+	m2info->fbcon.flags = FBINFO_DEFAULT;
 	m2info->fbcon.currcon = -1;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
 	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
diff -Nru a/drivers/video/maxinefb.c b/drivers/video/maxinefb.c
--- a/drivers/video/maxinefb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/maxinefb.c	Sat May 15 22:53:10 2004
@@ -159,7 +159,7 @@
 	fb_info.screen_base = (char *) maxinefb_fix.smem_start;
 	fb_info.var = maxinefb_defined;
 	fb_info.fix = maxinefb_fix;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/neofb.c	Sat May 15 22:53:10 2004
@@ -2055,7 +2055,7 @@
 	info->fix.accel = id->driver_data;
 
 	info->fbops = &neofb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	info->pseudo_palette = (void *) (par + 1);
 	return info; 
 }
diff -Nru a/drivers/video/offb.c b/drivers/video/offb.c
--- a/drivers/video/offb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/offb.c	Sat May 15 22:53:10 2004
@@ -527,7 +527,7 @@
 	info->screen_base = ioremap(address, fix->smem_len);
 	info->par = par;
 	info->pseudo_palette = (void *) (info + 1);
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
diff -Nru a/drivers/video/p9100.c b/drivers/video/p9100.c
--- a/drivers/video/p9100.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/p9100.c	Sat May 15 22:53:10 2004
@@ -297,7 +297,7 @@
 		sbus_ioremap(&sdev->resource[0], 0,
 			     sizeof(struct p9100_regs), "p9100 regs");
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &p9100_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -Nru a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
--- a/drivers/video/platinumfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/platinumfb.c	Sat May 15 22:53:10 2004
@@ -311,7 +311,7 @@
 	/* Fill fb_info */
 	info->fbops = &platinumfb_ops;
 	info->pseudo_palette = pinfo->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT;
 	info->screen_base = (char *) pinfo->frame_buffer + 0x20;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/pm2fb.c	Sat May 15 22:53:10 2004
@@ -1124,7 +1124,7 @@
 	info->fbops    = &pm2fb_ops;
 	info->fix		= pm2fb_fix; 	
 	info->pseudo_palette	= (void *)(default_par + 1); 
-	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->flags		= FBINFO_DEFAULT;
 
 #ifndef MODULE
 	if (!mode)
diff -Nru a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
--- a/drivers/video/pm3fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/pm3fb.c	Sat May 15 22:53:10 2004
@@ -1608,7 +1608,7 @@
 		       fontn[l_fb_info->board_num]);
 	l_fb_info->gen.info.switch_con = &fbgen_switch;
 	l_fb_info->gen.info.updatevar = &fbgen_update_var;	/* */
-	l_fb_info->gen.info.flags = FBINFO_FLAG_DEFAULT;
+	l_fb_info->gen.info.flags = FBINFO_DEFAULT;
 
 	pm3fb_mapIO(l_fb_info);
 
diff -Nru a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
--- a/drivers/video/pmag-ba-fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/pmag-ba-fb.c	Sat May 15 22:53:10 2004
@@ -142,7 +142,7 @@
 	info->var = pmagbafb_defined;
 	info->fix = pmagbafb_fix; 
 	info->screen_base = pmagbafb_fix.smem_start;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 	
diff -Nru a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
--- a/drivers/video/pmagb-b-fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/pmagb-b-fb.c	Sat May 15 22:53:10 2004
@@ -145,7 +145,7 @@
 	info->var = pmagbbfb_defined;
 	info->fix = pmagbbfb_fix;
 	info->screen_base = pmagbbfb_fix.smem_start; 
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
diff -Nru a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
--- a/drivers/video/pvr2fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/pvr2fb.c	Sat May 15 22:53:10 2004
@@ -795,7 +795,7 @@
 	fb_info->fix		= pvr2_fix;
 	fb_info->par		= currentpar;
 	fb_info->pseudo_palette	= (void *)(fb_info->par + 1);
-	fb_info->flags		= FBINFO_FLAG_DEFAULT;
+	fb_info->flags		= FBINFO_DEFAULT;
 
 	if (video_output == VO_VGA)
 		defmode = DEFMODE_VGA;
diff -Nru a/drivers/video/q40fb.c b/drivers/video/q40fb.c
--- a/drivers/video/q40fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/q40fb.c	Sat May 15 22:53:10 2004
@@ -105,7 +105,7 @@
	info->var = q40fb_var;
	info->fix = q40fb_fix;
	info->fbops = &q40fb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
+	info->flags = FBINFO_DEFAULT;  /* not as module for now */
	info->pseudo_palette = info->par;
	info->par = NULL;
	info->screen_base = (char *) q40fb_fix.smem_start;
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/radeonfb.c	Sat May 15 22:53:10 2004
@@ -2250,7 +2250,7 @@
 	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
+        info->flags = FBINFO_DEFAULT;
         info->fbops = &radeonfb_ops;
         info->display_fg = NULL;
         info->screen_base = (char *)rinfo->fb_base;
diff -Nru a/drivers/video/retz3fb.c b/drivers/video/retz3fb.c
--- a/drivers/video/retz3fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/retz3fb.c	Sat May 15 22:53:10 2004
@@ -1408,7 +1408,7 @@
 		fb_info->currcon = -1;
 		fb_info->switch_con = &z3fb_switch;
 		fb_info->updatevar = &z3fb_updatevar;
-		fb_info->flags = FBINFO_FLAG_DEFAULT;
+		fb_info->flags = FBINFO_DEFAULT;
 		strlcpy(fb_info->fontname, fontname, sizeof(fb_info->fontname));
 
 		if (z3fb_mode == -1)
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/riva/fbdev.c	Sat May 15 22:53:10 2004
@@ -1589,7 +1589,7 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	unsigned int cmap_len;
 
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	info->var = rivafb_default_var;
 	info->fix = rivafb_fix;
 	info->fbops = &riva_fb_ops;
diff -Nru a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/sa1100fb.c	Sat May 15 22:53:10 2004
@@ -1673,7 +1673,7 @@
 	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
 
 	fbi->fb.fbops		= &sa1100fb_ops;
-	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
+	fbi->fb.flags		= FBINFO_DEFAULT;
 	fbi->fb.monspecs	= monspecs;
 	fbi->fb.currcon		= -1;
 	fbi->fb.pseudo_palette	= (fbi + 1);
diff -Nru a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- a/drivers/video/sgivwfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/sgivwfb.c	Sat May 15 22:53:10 2004
@@ -790,7 +790,7 @@
 	fb_info.fbops = &sgivwfb_ops;
 	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.par = &default_par;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_info.screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
 	if (!fb_info.screen_base) {
diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/sis/sis_main.c	Sat May 15 22:53:10 2004
@@ -4914,7 +4914,7 @@
 	    	   }
 		}
 
-		sis_fb_info->flags = FBINFO_FLAG_DEFAULT;
+		sis_fb_info->flags = FBINFO_DEFAULT;
 		sis_fb_info->var = default_var;
 		sis_fb_info->fix = sisfb_fix;
 		sis_fb_info->par = &ivideo;
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/sstfb.c	Sat May 15 22:53:10 2004
@@ -1473,7 +1473,7 @@
 	f_ddprintk("membase_phys: %#lx\n", fix->smem_start);
 	f_ddprintk("fbbase_virt: %p\n", info->screen_base);
 
-	info->flags	= FBINFO_FLAG_DEFAULT;
+	info->flags	= FBINFO_DEFAULT;
 	info->fbops	= &sstfb_ops;
 	info->currcon	= -1;
 	info->pseudo_palette = &all->pseudo_palette;
diff -Nru a/drivers/video/stifb.c b/drivers/video/stifb.c
--- a/drivers/video/stifb.c	Sat May 15 22:53:11 2004
+++ b/drivers/video/stifb.c	Sat May 15 22:53:11 2004
@@ -1324,7 +1324,7 @@
 	strcpy(fix->id, "stifb");
 	info->fbops = &stifb_ops;
 	info->screen_base = (void*) REGION_BASE(fb,1);
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	info->currcon = -1;
 
 	/* This has to been done !!! */
diff -Nru a/drivers/video/sun3fb.c b/drivers/video/sun3fb.c
--- a/drivers/video/sun3fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/sun3fb.c	Sat May 15 22:53:10 2004
@@ -576,7 +576,7 @@
 	fb->info.changevar = NULL;
 	fb->info.switch_con = &sun3fbcon_switch;
 	fb->info.updatevar = &sun3fbcon_updatevar;
-	fb->info.flags = FBINFO_FLAG_DEFAULT;
+	fb->info.flags = FBINFO_DEFAULT;
 	
 	fb->cursor.hwsize.fbx = 32;
 	fb->cursor.hwsize.fby = 32;
diff -Nru a/drivers/video/tcx.c b/drivers/video/tcx.c
--- a/drivers/video/tcx.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/tcx.c	Sat May 15 22:53:10 2004
@@ -412,7 +412,7 @@
 		all->par.mmap_map[i].poff = sdev->reg_addrs[j].phys_addr;
 	}
 
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &tcx_ops;
 #ifdef CONFIG_SPARC32
 	all->info.screen_base = (char *)
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/tdfxfb.c	Sat May 15 22:53:10 2004
@@ -1253,7 +1253,7 @@
 	info->fix		= tdfx_fix; 	
 	info->par		= default_par;
 	info->pseudo_palette	= (void *)(default_par + 1); 
-	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->flags		= FBINFO_DEFAULT;
 
 #ifndef MODULE
 	if (!mode_option)
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/tgafb.c	Sat May 15 22:53:10 2004
@@ -1425,7 +1425,7 @@
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &all->par.tga_chip_rev);
 
 	/* Setup framebuffer.  */
-	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.flags = FBINFO_DEFAULT;
 	all->info.fbops = &tgafb_ops;
 	all->info.screen_base = (char *) all->par.tga_fb_base;
 	all->info.currcon = -1;
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/tridentfb.c	Sat May 15 22:53:10 2004
@@ -1149,7 +1149,7 @@
 	fb_info.fbops = &tridentfb_ops;
 
 
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	fb_info.pseudo_palette = pseudo_pal;
 
 	if (!fb_find_mode(&default_var,&fb_info,mode,NULL,0,NULL,bpp))
diff -Nru a/drivers/video/tx3912fb.c b/drivers/video/tx3912fb.c
--- a/drivers/video/tx3912fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/tx3912fb.c	Sat May 15 22:53:10 2004
@@ -296,7 +296,7 @@
 	fb_info.var = tx3912fb_var;
 	fb_info.fix = tx3912fb_fix;
 	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 
 	/* Clear the framebuffer */
 	memset((void *) fb_info.fix.smem_start, 0xff, fb_info.fix.smem_len);
diff -Nru a/drivers/video/valkyriefb.c b/drivers/video/valkyriefb.c
--- a/drivers/video/valkyriefb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/valkyriefb.c	Sat May 15 22:53:10 2004
@@ -541,7 +541,7 @@
 {
 	info->fbops = &valkyriefb_ops;
 	info->screen_base = (char *) p->frame_buffer + 0x1000;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 	info->pseudo_palette = p->pseudo_palette;
 	fb_alloc_cmap(&info->cmap, 256, 0);
 	info->par = &p->par;
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/vesafb.c	Sat May 15 22:53:10 2004
@@ -362,7 +362,7 @@
 	info->fbops = &vesafb_ops;
 	info->var = vesafb_defined;
 	info->fix = vesafb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	if (fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0) < 0) {
 		err = -ENXIO;
diff -Nru a/drivers/video/vfb.c b/drivers/video/vfb.c
--- a/drivers/video/vfb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/vfb.c	Sat May 15 22:53:10 2004
@@ -435,7 +435,7 @@
 	info->fix = vfb_fix;
 	info->pseudo_palette = &vfb_pseudo_palette;
 	info->par = NULL;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT;
 
 	retval = fb_alloc_cmap(&fb_info.cmap, 256, 0);
 	if (retval < 0)
diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/vga16fb.c	Sat May 15 22:53:10 2004
@@ -1370,7 +1370,7 @@
 	vga16fb.var = vga16fb_defined;
 	vga16fb.fix = vga16fb_fix;
 	vga16fb.par = &vga16_par;
-	vga16fb.flags = FBINFO_FLAG_DEFAULT;
+	vga16fb.flags = FBINFO_DEFAULT;
 
 	vga16fb.fix.smem_start	= VGA_MAP_MEM(vga16fb.fix.smem_start);
 
diff -Nru a/drivers/video/virgefb.c b/drivers/video/virgefb.c
--- a/drivers/video/virgefb.c	Sat May 15 22:53:10 2004
+++ b/drivers/video/virgefb.c	Sat May 15 22:53:10 2004
@@ -1788,7 +1788,7 @@
 	fb_info.currcon = -1;
 	fb_info.switch_con = &virgefb_switch;
 	fb_info.updatevar = &virgefb_updatevar;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info.flags = FBINFO_DEFAULT;
 	fbhw->init();
 	fbhw->decode_var(&virgefb_default, &par);
 	fbhw->encode_var(&virgefb_default, &par);

