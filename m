Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWBHUBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWBHUBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWBHUBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:01:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36305 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030433AbWBHUBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:01:44 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] atyfb sparc ifdefs
Cc: adaplas@pol.net
Message-Id: <E1F6vVX-0008Be-Jk@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1133417630 -0500

... should be sparc64 ones.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/video/aty/atyfb_base.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

8310001f1387759e4613bd0c8fdfa91c555a0f02
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index c02a0f4..1a5c0f6 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -78,7 +78,7 @@
 #include <asm/prom.h>
 #include "../macmodes.h"
 #endif
-#ifdef __sparc__
+#ifdef __sparc_v9__
 #include <asm/pbm.h>
 #include <asm/fbio.h>
 #endif
@@ -242,7 +242,7 @@ static int atyfb_ioctl(struct fb_info *i
 extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
-#ifdef __sparc__
+#ifdef __sparc_v9__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
 static int atyfb_sync(struct fb_info *info);
@@ -300,7 +300,7 @@ static struct fb_ops atyfb_ops = {
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	.fb_mmap	= atyfb_mmap,
 #endif
 	.fb_sync	= atyfb_sync,
@@ -1519,7 +1519,7 @@ static int atyfb_open(struct fb_info *in
 
 	if (user) {
 		par->open++;
-#ifdef __sparc__
+#ifdef __sparc_v9__
 		par->mmaped = 0;
 #endif
 	}
@@ -1611,7 +1611,7 @@ static int atyfb_release(struct fb_info 
 		mdelay(1);
 		wait_for_idle(par);
 		if (!par->open) {
-#ifdef __sparc__
+#ifdef __sparc_v9__
 			int was_mmaped = par->mmaped;
 
 			par->mmaped = 0;
@@ -1741,12 +1741,12 @@ struct atyclk {
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	struct fbtype fbtyp;
 #endif
 
 	switch (cmd) {
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	case FBIOGTYPE:
 		fbtyp.fb_type = FBTYPE_PCI_GENERIC;
 		fbtyp.fb_width = par->crtc.vxres;
@@ -1757,7 +1757,7 @@ static int atyfb_ioctl(struct fb_info *i
 		if (copy_to_user((struct fbtype __user *) arg, &fbtyp, sizeof(fbtyp)))
 			return -EFAULT;
 		break;
-#endif /* __sparc__ */
+#endif /* __sparc_v9__ */
 
 	case FBIO_WAITFORVSYNC:
 		{
@@ -1842,7 +1842,7 @@ static int atyfb_sync(struct fb_info *in
 	return 0;
 }
 
-#ifdef __sparc__
+#ifdef __sparc_v9__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -1970,7 +1970,7 @@ static void atyfb_palette(int enter)
 		}
 	}
 }
-#endif /* __sparc__ */
+#endif /* __sparc_v9__ */
 
 
 
@@ -2588,7 +2588,7 @@ static int __init aty_init(struct fb_inf
 		goto aty_init_exit;
 	}
 
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	atyfb_save_palette(par, 0);
 #endif
 
@@ -2814,7 +2814,7 @@ static int atyfb_setcolreg(u_int regno, 
 
 #ifdef CONFIG_PCI
 
-#ifdef __sparc__
+#ifdef __sparc_v9__
 
 extern void (*prom_palette) (int);
 
@@ -3035,7 +3035,7 @@ static int __devinit atyfb_setup_sparc(s
 	return 0;
 }
 
-#else /* __sparc__ */
+#else /* __sparc_v9__ */
 
 #ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
@@ -3387,7 +3387,7 @@ atyfb_setup_generic_fail:
 	return ret;
 }
 
-#endif /* !__sparc__ */
+#endif /* !__sparc_v9__ */
 
 static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -3439,7 +3439,7 @@ static int __devinit atyfb_pci_probe(str
 	par->irq = pdev->irq;
 
 	/* Setup "info" structure */
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	rc = atyfb_setup_sparc(pdev, info, addr);
 #else
 	rc = atyfb_setup_generic(pdev, info, addr);
@@ -3453,7 +3453,7 @@ static int __devinit atyfb_pci_probe(str
 	if (aty_init(info, "PCI"))
 		goto err_release_io;
 
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	if (!prom_palette)
 		prom_palette = atyfb_palette;
 
@@ -3470,12 +3470,12 @@ static int __devinit atyfb_pci_probe(str
 	par->mmap_map[1].size = PAGE_SIZE;
 	par->mmap_map[1].prot_mask = _PAGE_CACHE;
 	par->mmap_map[1].prot_flag = _PAGE_E;
-#endif /* __sparc__ */
+#endif /* __sparc_v9__ */
 
 	return 0;
 
 err_release_io:
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	kfree(par->mmap_map);
 #else
 	if (par->ati_regbase)
@@ -3580,7 +3580,7 @@ static void __devexit atyfb_remove(struc
 	    par->mtrr_aper = -1;
 	}
 #endif
-#ifndef __sparc__
+#ifndef __sparc_v9__
 	if (par->ati_regbase)
 		iounmap(par->ati_regbase);
 	if (info->screen_base)
@@ -3590,7 +3590,7 @@ static void __devexit atyfb_remove(struc
 		iounmap(info->sprite.addr);
 #endif
 #endif
-#ifdef __sparc__
+#ifdef __sparc_v9__
 	kfree(par->mmap_map);
 #endif
 	if (par->aux_start)
-- 
0.99.9.GIT

