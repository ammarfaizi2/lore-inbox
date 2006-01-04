Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWADJpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWADJpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWADJpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:45:22 -0500
Received: from verein.lst.de ([213.95.11.210]:58313 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030196AbWADJpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:45:19 -0500
Date: Wed, 4 Jan 2006 10:45:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sanitize ->fb_mmap prototype
Message-ID: <20060104094509.GB26944@lst.de>
References: <20051111083629.GB26175@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111083629.GB26175@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 09:36:29AM +0100, Christoph Hellwig wrote:
> Again, no need for a file argument.  If we'd really need it it's in
> vma->vm_file already.  gbefb and sgivwfb used to set vma->vm_file to
> the file argument, but the kernel alrady did that.

ping?


Index: linux-2.6/drivers/video/68328fb.c
===================================================================
--- linux-2.6.orig/drivers/video/68328fb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/68328fb.c	2005-11-10 01:30:27.000000000 +0100
@@ -102,8 +102,7 @@
 			 u_int transp, struct fb_info *info);
 static int mc68x328fb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info);
-static int mc68x328fb_mmap(struct fb_info *info, struct file *file,
-		    struct vm_area_struct *vma);
+static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 
 static struct fb_ops mc68x328fb_ops = {
 	.fb_check_var	= mc68x328fb_check_var,
@@ -398,8 +397,7 @@
      *  Most drivers don't need their own mmap function 
      */
 
-static int mc68x328fb_mmap(struct fb_info *info, struct file *file,
-		    struct vm_area_struct *vma)
+static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 #ifndef MMU
 	/* this is uClinux (no MMU) specific code */
Index: linux-2.6/drivers/video/acornfb.c
===================================================================
--- linux-2.6.orig/drivers/video/acornfb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/acornfb.c	2005-11-10 01:30:27.000000000 +0100
@@ -883,7 +883,7 @@
  * Note that we are entered with the kernel locked.
  */
 static int
-acornfb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+acornfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	unsigned long off, start;
 	u32 len;
Index: linux-2.6/drivers/video/amba-clcd.c
===================================================================
--- linux-2.6.orig/drivers/video/amba-clcd.c	2005-11-10 01:26:31.000000000 +0100
+++ linux-2.6/drivers/video/amba-clcd.c	2005-11-10 01:30:27.000000000 +0100
@@ -308,7 +308,7 @@
 	return 0;
 }
 
-static int clcdfb_mmap(struct fb_info *info, struct file *file,
+static int clcdfb_mmap(struct fb_info *info,
 		       struct vm_area_struct *vma)
 {
 	struct clcd_fb *fb = to_clcd(info);
Index: linux-2.6/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/atyfb_base.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/aty/atyfb_base.c	2005-11-10 01:30:27.000000000 +0100
@@ -234,7 +234,7 @@
 extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
 #ifdef __sparc__
-static int atyfb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
 static int atyfb_sync(struct fb_info *info);
 
@@ -1810,7 +1810,7 @@
 }
 
 #ifdef __sparc__
-static int atyfb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	unsigned int size, page, map_size = 0;
Index: linux-2.6/drivers/video/au1100fb.c
===================================================================
--- linux-2.6.orig/drivers/video/au1100fb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/au1100fb.c	2005-11-10 01:30:27.000000000 +0100
@@ -379,7 +379,7 @@
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1100fb_fb_mmap(struct fb_info *fbi, struct file *file, struct vm_area_struct *vma)
+int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 	unsigned int len;
Index: linux-2.6/drivers/video/bw2.c
===================================================================
--- linux-2.6.orig/drivers/video/bw2.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/bw2.c	2005-11-10 01:30:27.000000000 +0100
@@ -35,7 +35,7 @@
 
 static int bw2_blank(int, struct fb_info *);
 
-static int bw2_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int bw2_mmap(struct fb_info *, struct vm_area_struct *);
 static int bw2_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -166,7 +166,7 @@
 	{ .size = 0 }
 };
 
-static int bw2_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int bw2_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct bw2_par *par = (struct bw2_par *)info->par;
 
Index: linux-2.6/drivers/video/cg14.c
===================================================================
--- linux-2.6.orig/drivers/video/cg14.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/cg14.c	2005-11-10 01:30:27.000000000 +0100
@@ -31,7 +31,7 @@
 static int cg14_setcolreg(unsigned, unsigned, unsigned, unsigned,
 			 unsigned, struct fb_info *);
 
-static int cg14_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int cg14_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg14_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int cg14_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -265,7 +265,7 @@
 	return 0;
 }
 
-static int cg14_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int cg14_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct cg14_par *par = (struct cg14_par *) info->par;
 
Index: linux-2.6/drivers/video/cg3.c
===================================================================
--- linux-2.6.orig/drivers/video/cg3.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/cg3.c	2005-11-10 01:30:27.000000000 +0100
@@ -33,7 +33,7 @@
 			 unsigned, struct fb_info *);
 static int cg3_blank(int, struct fb_info *);
 
-static int cg3_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int cg3_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg3_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -227,7 +227,7 @@
 	{ .size = 0 }
 };
 
-static int cg3_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int cg3_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct cg3_par *par = (struct cg3_par *)info->par;
 
Index: linux-2.6/drivers/video/cg6.c
===================================================================
--- linux-2.6.orig/drivers/video/cg6.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/cg6.c	2005-11-10 01:30:27.000000000 +0100
@@ -36,7 +36,7 @@
 static void cg6_imageblit(struct fb_info *, const struct fb_image *);
 static void cg6_fillrect(struct fb_info *, const struct fb_fillrect *);
 static int cg6_sync(struct fb_info *);
-static int cg6_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int cg6_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg6_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -521,7 +521,7 @@
 	{ .size	= 0 }
 };
 
-static int cg6_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int cg6_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct cg6_par *par = (struct cg6_par *)info->par;
 
Index: linux-2.6/drivers/video/controlfb.c
===================================================================
--- linux-2.6.orig/drivers/video/controlfb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/controlfb.c	2005-11-10 01:30:27.000000000 +0100
@@ -128,7 +128,7 @@
 static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	u_int transp, struct fb_info *info);
 static int controlfb_blank(int blank_mode, struct fb_info *info);
-static int controlfb_mmap(struct fb_info *info, struct file *file,
+static int controlfb_mmap(struct fb_info *info,
 	struct vm_area_struct *vma);
 static int controlfb_set_par (struct fb_info *info);
 static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info);
@@ -286,7 +286,7 @@
  * for controlfb.
  * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
  */
-static int controlfb_mmap(struct fb_info *info, struct file *file,
+static int controlfb_mmap(struct fb_info *info,
                        struct vm_area_struct *vma)
 {
        unsigned long off, start;
Index: linux-2.6/drivers/video/ffb.c
===================================================================
--- linux-2.6.orig/drivers/video/ffb.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/ffb.c	2005-11-10 01:30:27.000000000 +0100
@@ -37,7 +37,7 @@
 static void ffb_fillrect(struct fb_info *, const struct fb_fillrect *);
 static void ffb_copyarea(struct fb_info *, const struct fb_copyarea *);
 static int ffb_sync(struct fb_info *);
-static int ffb_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int ffb_mmap(struct fb_info *, struct vm_area_struct *);
 static int ffb_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int ffb_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -836,7 +836,7 @@
 	{ .size = 0 }
 };
 
-static int ffb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int ffb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct ffb_par *par = (struct ffb_par *)info->par;
 
Index: linux-2.6/drivers/video/gbefb.c
===================================================================
--- linux-2.6.orig/drivers/video/gbefb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/gbefb.c	2005-11-10 01:30:27.000000000 +0100
@@ -979,7 +979,7 @@
 	return 0;
 }
 
-static int gbefb_mmap(struct fb_info *info, struct file *file,
+static int gbefb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
@@ -1000,7 +1000,6 @@
 		pgprot_fb(pgprot_val(vma->vm_page_prot));
 
 	vma->vm_flags |= VM_IO | VM_RESERVED;
-	vma->vm_file = file;
 
 	/* look for the starting tile */
 	tile = &gbe_tiles.cpu[offset >> TILE_SHIFT];
Index: linux-2.6/drivers/video/igafb.c
===================================================================
--- linux-2.6.orig/drivers/video/igafb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/igafb.c	2005-11-10 01:30:27.000000000 +0100
@@ -219,7 +219,7 @@
 }
 
 #ifdef __sparc__
-static int igafb_mmap(struct fb_info *info, struct file *file,
+static int igafb_mmap(struct fb_info *info,
 		      struct vm_area_struct *vma)
 {
 	struct iga_par *par = (struct iga_par *)info->par;
Index: linux-2.6/drivers/video/leo.c
===================================================================
--- linux-2.6.orig/drivers/video/leo.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/leo.c	2005-11-10 01:30:27.000000000 +0100
@@ -32,7 +32,7 @@
 			 unsigned, struct fb_info *);
 static int leo_blank(int, struct fb_info *);
 
-static int leo_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int leo_mmap(struct fb_info *, struct vm_area_struct *);
 static int leo_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -360,7 +360,7 @@
 	{ .size = 0 }
 };
 
-static int leo_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int leo_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct leo_par *par = (struct leo_par *)info->par;
 
Index: linux-2.6/drivers/video/p9100.c
===================================================================
--- linux-2.6.orig/drivers/video/p9100.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/p9100.c	2005-11-10 01:30:27.000000000 +0100
@@ -31,7 +31,7 @@
 			   unsigned, struct fb_info *);
 static int p9100_blank(int, struct fb_info *);
 
-static int p9100_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int p9100_mmap(struct fb_info *, struct vm_area_struct *);
 static int p9100_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -219,7 +219,7 @@
 	{ 0,			0,		0		    }
 };
 
-static int p9100_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int p9100_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct p9100_par *par = (struct p9100_par *)info->par;
 
Index: linux-2.6/drivers/video/pxafb.c
===================================================================
--- linux-2.6.orig/drivers/video/pxafb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/pxafb.c	2005-11-10 01:30:27.000000000 +0100
@@ -395,7 +395,7 @@
 	return 0;
 }
 
-static int pxafb_mmap(struct fb_info *info, struct file *file,
+static int pxafb_mmap(struct fb_info *info,
 		      struct vm_area_struct *vma)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
Index: linux-2.6/drivers/video/sa1100fb.c
===================================================================
--- linux-2.6.orig/drivers/video/sa1100fb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/sa1100fb.c	2005-11-10 01:30:27.000000000 +0100
@@ -816,7 +816,7 @@
 	return 0;
 }
 
-static int sa1100fb_mmap(struct fb_info *info, struct file *file,
+static int sa1100fb_mmap(struct fb_info *info,
 			 struct vm_area_struct *vma)
 {
 	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
Index: linux-2.6/drivers/video/sgivwfb.c
===================================================================
--- linux-2.6.orig/drivers/video/sgivwfb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/sgivwfb.c	2005-11-10 01:30:27.000000000 +0100
@@ -115,7 +115,7 @@
 static int sgivwfb_setcolreg(u_int regno, u_int red, u_int green,
 			     u_int blue, u_int transp,
 			     struct fb_info *info);
-static int sgivwfb_mmap(struct fb_info *info, struct file *file,
+static int sgivwfb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma);
 
 static struct fb_ops sgivwfb_ops = {
@@ -706,7 +706,7 @@
 	return 0;
 }
 
-static int sgivwfb_mmap(struct fb_info *info, struct file *file,
+static int sgivwfb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
@@ -723,7 +723,6 @@
 	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
 						size, vma->vm_page_prot))
 		return -EAGAIN;
-	vma->vm_file = file;
 	printk(KERN_DEBUG "sgivwfb: mmap framebuffer P(%lx)->V(%lx)\n",
 	       offset, vma->vm_start);
 	return 0;
Index: linux-2.6/drivers/video/tcx.c
===================================================================
--- linux-2.6.orig/drivers/video/tcx.c	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/drivers/video/tcx.c	2005-11-10 01:30:27.000000000 +0100
@@ -33,7 +33,7 @@
 			 unsigned, struct fb_info *);
 static int tcx_blank(int, struct fb_info *);
 
-static int tcx_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int tcx_mmap(struct fb_info *, struct vm_area_struct *);
 static int tcx_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int tcx_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -299,7 +299,7 @@
 	{ .size = 0 }
 };
 
-static int tcx_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int tcx_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct tcx_par *par = (struct tcx_par *)info->par;
 
Index: linux-2.6/drivers/video/vfb.c
===================================================================
--- linux-2.6.orig/drivers/video/vfb.c	2005-11-10 01:20:48.000000000 +0100
+++ linux-2.6/drivers/video/vfb.c	2005-11-10 01:30:27.000000000 +0100
@@ -81,7 +81,7 @@
 			 u_int transp, struct fb_info *info);
 static int vfb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info);
-static int vfb_mmap(struct fb_info *info, struct file *file,
+static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma);
 
 static struct fb_ops vfb_ops = {
@@ -368,7 +368,7 @@
      *  Most drivers don't need their own mmap function 
      */
 
-static int vfb_mmap(struct fb_info *info, struct file *file,
+static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma)
 {
 	return -EINVAL;
Index: linux-2.6/drivers/video/fbmem.c
===================================================================
--- linux-2.6.orig/drivers/video/fbmem.c	2005-11-10 01:30:13.000000000 +0100
+++ linux-2.6/drivers/video/fbmem.c	2005-11-10 01:30:27.000000000 +0100
@@ -1107,7 +1107,7 @@
 	if (fb->fb_mmap) {
 		int res;
 		lock_kernel();
-		res = fb->fb_mmap(info, file, vma);
+		res = fb->fb_mmap(info, vma);
 		unlock_kernel();
 		return res;
 	}
Index: linux-2.6/include/linux/fb.h
===================================================================
--- linux-2.6.orig/include/linux/fb.h	2005-11-10 01:28:56.000000000 +0100
+++ linux-2.6/include/linux/fb.h	2005-11-10 01:30:27.000000000 +0100
@@ -616,7 +616,7 @@
 			unsigned long arg);
 
 	/* perform fb specific mmap */
-	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
 };
 
 #ifdef CONFIG_FB_TILEBLITTING
