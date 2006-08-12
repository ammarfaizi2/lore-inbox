Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWHLRCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWHLRCc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHLRCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:02:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:16434 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964901AbWHLRB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:01:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ao95xFOdsKrLAE0sO+t7NBYqiZx20XkN010ynd8FTFgnMDx+jKhaH7mJd8leHwuX55/OabnBD6eYqJj2kKOATZePkl92d+HxzDYXfeN2dZPF62fEEfxwa2uGQzoqbHd7AzYWsukrjiXtubpasLFfoChyVPFw95MGkJd/42ZS45c=
Message-ID: <44DE09A9.1030209@gmail.com>
Date: Sat, 12 Aug 2006 19:02:33 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 7/10] drivers/video/sis/sis_main.c Removal of old
 code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/sis_main.c linux-work/drivers/video/sis/sis_main.c
--- linux-work-clean/drivers/video/sis/sis_main.c	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/drivers/video/sis/sis_main.c	2006-08-12 18:13:23.000000000 +0200
@@ -35,9 +35,7 @@

 #include <linux/version.h>
 #include <linux/module.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 #include <linux/moduleparam.h>
-#endif
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
@@ -58,9 +56,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <linux/vt_kern.h>
-#endif
 #include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/types.h>
@@ -70,35 +65,9 @@
 #include <asm/mtrr.h>
 #endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-#endif
-
 #include "sis.h"
 #include "sis_main.h"

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,3)
-#error "This version of sisfb requires at least 2.6.3"
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#ifdef FBCON_HAS_CFB8
-extern struct display_switch fbcon_sis8;
-#endif
-#ifdef FBCON_HAS_CFB16
-extern struct display_switch fbcon_sis16;
-#endif
-#ifdef FBCON_HAS_CFB32
-extern struct display_switch fbcon_sis32;
-#endif
-#endif
-
 static void sisfb_handle_command(struct sis_video_info *ivideo,
 				 struct sisfb_cmd *sisfb_command);

@@ -116,12 +85,8 @@ sisfb_setdefaultparms(void)
 	sisfb_useoem		= -1;
 #ifdef MODULE
 	/* Module: "None" for 2.4, default mode for 2.5+ */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	sisfb_mode_idx		= -1;
 #else
-	sisfb_mode_idx		= MODE_INDEX_NONE;
-#endif
-#else
 	/* Static: Default mode */
 	sisfb_mode_idx		= -1;
 #endif
@@ -142,10 +107,6 @@ sisfb_setdefaultparms(void)
 	sisfb_tvxposoffset	= 0;
 	sisfb_tvyposoffset	= 0;
 	sisfb_nocrt2rate	= 0;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	sisfb_inverse		= 0;
-	sisfb_fontname[0]	= 0;
-#endif
 #if !defined(__i386__) && !defined(__x86_64__)
 	sisfb_resetcard		= 0;
 	sisfb_videoram		= 0;
@@ -162,14 +123,11 @@ sisfb_search_vesamode(unsigned int vesam
 	/* We don't know the hardware specs yet and there is no ivideo */

 	if(vesamode == 0) {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		sisfb_mode_idx = MODE_INDEX_NONE;
-#else
 		if(!quiet)
 			printk(KERN_ERR "sisfb: Invalid mode. Using default.\n");

 		sisfb_mode_idx = DEFAULT_MODE;
-#endif
+
 		return;
 	}

@@ -215,7 +173,6 @@ sisfb_search_mode(char *name, BOOLEAN qu
 		return;
 	}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	if(!strnicmp(name, sisbios_mode[MODE_INDEX_NONE].name, strlen(name))) {
 		if(!quiet)
 			printk(KERN_ERR "sisfb: Mode 'none' not supported anymore. Using default.\n");
@@ -223,7 +180,7 @@ sisfb_search_mode(char *name, BOOLEAN qu
 		sisfb_mode_idx = DEFAULT_MODE;
 		return;
 	}
-#endif
+
 	if(strlen(name) <= 19) {
 		strcpy(strbuf1, name);
 		for(i = 0; i < strlen(strbuf1); i++) {
@@ -1315,20 +1272,7 @@ sisfb_do_set_var(struct fb_var_screeninf
 		ivideo->refresh_rate = 60;
 	}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	if(ivideo->sisfb_thismonitor.datavalid) {
-		if(!sisfb_verify_rate(ivideo, &ivideo->sisfb_thismonitor, ivideo->sisfb_mode_idx,
-	                         ivideo->rate_idx, ivideo->refresh_rate)) {
-			printk(KERN_INFO "sisfb: WARNING: Refresh rate exceeds monitor specs!\n");
-		}
-	}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	if(((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) && isactive) {
-#else
 	if(isactive) {
-#endif
 		/* If acceleration to be used? Need to know
 		 * before pre/post_set_mode()
 		 */
@@ -1367,9 +1311,7 @@ sisfb_do_set_var(struct fb_var_screeninf
 		ivideo->current_linelength = ivideo->video_linelength;
 		ivideo->current_pixclock = var->pixclock;
 		ivideo->current_refresh_rate = ivideo->refresh_rate;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		ivideo->sisfb_lastrates[ivideo->mode_no] = ivideo->refresh_rate;
-#endif
 	}

 	return 0;
@@ -1435,18 +1377,6 @@ sisfb_pan_var(struct sis_video_info *ivi
 	return 0;
 }

-/* ------------ FBDev related routines for 2.4 series ----------- */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-
-#include "sisfb_fbdev_2_4.h"
-
-#endif
-
-/* ------------ FBDev related routines for 2.6 series ----------- */
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-
 static int
 sisfb_open(struct fb_info *info, int user)
 {
@@ -1744,8 +1674,6 @@ sisfb_blank(int blank, struct fb_info *i
 	return sisfb_myblank(ivideo, blank);
 }

-#endif
-
 /* ----------- FBDev related routines for all series ---------- */

 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
@@ -1969,20 +1897,6 @@ sisfb_get_fix(struct fb_fix_screeninfo *

 /* ----------------  fb_ops structures ----------------- */

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static struct fb_ops sisfb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_get_fix	= sisfb_get_fix,
-	.fb_get_var	= sisfb_get_var,
-	.fb_set_var	= sisfb_set_var,
-	.fb_get_cmap	= sisfb_get_cmap,
-	.fb_set_cmap	= sisfb_set_cmap,
-	.fb_pan_display = sisfb_pan_display,
-	.fb_ioctl	= sisfb_ioctl
-};
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 static struct fb_ops sisfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= sisfb_open,
@@ -2004,7 +1918,6 @@ static struct fb_ops sisfb_ops = {
 #endif
 	.fb_ioctl	= sisfb_ioctl
 };
-#endif

 /* ---------------- Chip generation dependent routines ---------------- */

@@ -4100,16 +4013,6 @@ sisfb_setup(char *options)
 			sisfb_search_mode(this_opt + 5, FALSE);
 		} else if(!strnicmp(this_opt, "vesa:", 5)) {
 			sisfb_search_vesamode(simple_strtoul(this_opt + 5, NULL, 0), FALSE);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		} else if(!strnicmp(this_opt, "inverse", 7)) {
-			sisfb_inverse = 1;
-			/* fb_invert_cmaps(); */
-		} else if(!strnicmp(this_opt, "font:", 5)) {
-			if(strlen(this_opt + 5) < 40) {
-			   strncpy(sisfb_fontname, this_opt + 5, sizeof(sisfb_fontname) - 1);
-			   sisfb_fontname[sizeof(sisfb_fontname) - 1] = '\0';
-			}
-#endif
 		} else if(!strnicmp(this_opt, "rate:", 5)) {
 			sisfb_parm_rate = simple_strtoul(this_opt + 5, NULL, 0);
 		} else if(!strnicmp(this_opt, "forcecrt1:", 10)) {
@@ -5870,17 +5773,9 @@ sisfb_probe(struct pci_dev *pdev, const
 	if(sisfb_off)
 		return -ENXIO;

-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,3))
 	sis_fb_info = framebuffer_alloc(sizeof(*ivideo), &pdev->dev);
 	if(!sis_fb_info)
 		return -ENOMEM;
-#else
-	sis_fb_info = kmalloc(sizeof(*sis_fb_info) + sizeof(*ivideo), GFP_KERNEL);
-	if(!sis_fb_info)
-		return -ENOMEM;
-	memset(sis_fb_info, 0, sizeof(*sis_fb_info) + sizeof(*ivideo));
-	sis_fb_info->par = ((char *)sis_fb_info + sizeof(*sis_fb_info));
-#endif

 	ivideo = (struct sis_video_info *)sis_fb_info->par;
 	ivideo->memyselfandi = sis_fb_info;
@@ -5970,10 +5865,6 @@ sisfb_probe(struct pci_dev *pdev, const
 	ivideo->tvxpos = sisfb_tvxposoffset;
 	ivideo->tvypos = sisfb_tvyposoffset;
 	ivideo->sisfb_nocrt2rate = sisfb_nocrt2rate;
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
-	ivideo->sisfb_inverse = sisfb_inverse;
-#endif
-
 	ivideo->refresh_rate = 0;
 	if(ivideo->sisfb_parm_rate != -1) {
 		ivideo->refresh_rate = ivideo->sisfb_parm_rate;
@@ -6049,10 +5940,6 @@ sisfb_probe(struct pci_dev *pdev, const
 		}
 	}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	strcpy(sis_fb_info->modename, ivideo->myid);
-#endif
-
 	ivideo->SiS_Pr.ChipType = ivideo->chip;

 	ivideo->SiS_Pr.ivideo = (void *)ivideo;
@@ -6134,20 +6021,6 @@ sisfb_probe(struct pci_dev *pdev, const
 #endif
 	}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#ifdef MODULE
-	if((reg & 0x80) && (reg != 0xff)) {
-		if((sisbios_mode[ivideo->sisfb_mode_idx].mode_no[ivideo->mni])
-									!= 0xFF) {
-			printk(KERN_INFO "sisfb: Cannot initialize display mode, "
-					 "X server is active\n");
-			ret = -EBUSY;
-			goto error_4;
-		}
-	}
-#endif
-#endif
-
 	/* Search and copy ROM image */
 	ivideo->bios_abase = NULL;
 	ivideo->SiS_Pr.VirtualRomBase = NULL;
@@ -6281,9 +6154,6 @@ error_0:	iounmap(ivideo->video_vbase);
 error_1:	release_mem_region(ivideo->video_base, ivideo->video_size);
 error_2:	release_mem_region(ivideo->mmio_base, ivideo->mmio_size);
 error_3:	vfree(ivideo->bios_abase);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-error_4:
-#endif
 		if(ivideo->lpcdev)
 			SIS_PCI_PUT_DEVICE(ivideo->lpcdev);
 		if(ivideo->nbridge)
@@ -6586,7 +6456,6 @@ error_4:
 		sis_fb_info->fix = ivideo->sisfb_fix;
 		sis_fb_info->screen_base = ivideo->video_vbase + ivideo->video_offset;
 		sis_fb_info->fbops = &sisfb_ops;
-
 		sisfb_get_fix(&sis_fb_info->fix, -1, sis_fb_info);
 		sis_fb_info->pseudo_palette = ivideo->pseudo_palette;

@@ -6603,10 +6472,6 @@ error_4:
 		}
 #endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		vc_resize_con(1, 1, 0);
-#endif
-
 		if(register_framebuffer(sis_fb_info) < 0) {
 			printk(KERN_ERR "sisfb: Fatal error: Failed to register framebuffer\n");
 			ret = -EINVAL;
@@ -6653,12 +6518,7 @@ error_4:


 		printk(KERN_INFO "fb%d: %s frame buffer device version %d.%d.%d\n",
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-			GET_FB_IDX(sis_fb_info->node),
-#else
-			sis_fb_info->node,
-#endif
-			ivideo->myid, VER_MAJOR, VER_MINOR, VER_LEVEL);
+			sis_fb_info->node, ivideo->myid, VER_MAJOR, VER_MINOR, VER_LEVEL);

 		printk(KERN_INFO "sisfb: Copyright (C) 2001-2005 Thomas Winischhofer\n");

@@ -6732,11 +6592,7 @@ static void __devexit sisfb_remove(struc
 	/* Unregister the framebuffer */
 	if(ivideo->registered) {
 		unregister_framebuffer(sis_fb_info);
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,3))
 		framebuffer_release(sis_fb_info);
-#else
-		kfree(sis_fb_info);
-#endif
 	}

 	/* OK, our ivideo is gone for good from here. */
@@ -6762,7 +6618,6 @@ static struct pci_driver sisfb_driver =

 SISINITSTATIC int __init sisfb_init(void)
 {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
 #ifndef MODULE
 	char *options = NULL;

@@ -6771,15 +6626,12 @@ SISINITSTATIC int __init sisfb_init(void

 	sisfb_setup(options);
 #endif
-#endif
 	return pci_register_driver(&sisfb_driver);
 }

-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
 #ifndef MODULE
 module_init(sisfb_init);
 #endif
-#endif

 /*****************************************************/
 /*                      MODULE                       */
@@ -6799,9 +6651,6 @@ static int		pdc1 = -1;
 static int		noaccel = -1;
 static int		noypan  = -1;
 static int		nomax = -1;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static int		inverse = 0;
-#endif
 static int		userom = -1;
 static int		useoem = -1;
 static char		*tvstandard = NULL;
@@ -6861,10 +6710,6 @@ static int __init sisfb_init_module(void
 	else if(nomax == 0)
 		sisfb_max = 1;

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	if(inverse) sisfb_inverse = 1;
-#endif
-
 	if(mem)
 		sisfb_parm_mem = mem;

@@ -6913,35 +6758,6 @@ MODULE_DESCRIPTION("SiS 300/540/630/730/
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Thomas Winischhofer <thomas@winischhofer.net>, Others");

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM(mem, "i");
-MODULE_PARM(noaccel, "i");
-MODULE_PARM(noypan, "i");
-MODULE_PARM(nomax, "i");
-MODULE_PARM(userom, "i");
-MODULE_PARM(useoem, "i");
-MODULE_PARM(mode, "s");
-MODULE_PARM(vesa, "i");
-MODULE_PARM(rate, "i");
-MODULE_PARM(forcecrt1, "i");
-MODULE_PARM(forcecrt2type, "s");
-MODULE_PARM(scalelcd, "i");
-MODULE_PARM(pdc, "i");
-MODULE_PARM(pdc1, "i");
-MODULE_PARM(specialtiming, "s");
-MODULE_PARM(lvdshl, "i");
-MODULE_PARM(tvstandard, "s");
-MODULE_PARM(tvxposoffset, "i");
-MODULE_PARM(tvyposoffset, "i");
-MODULE_PARM(nocrt2rate, "i");
-MODULE_PARM(inverse, "i");
-#if !defined(__i386__) && !defined(__x86_64__)
-MODULE_PARM(resetcard, "i");
-MODULE_PARM(videoram, "i");
-#endif
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 module_param(mem, int, 0);
 module_param(noaccel, int, 0);
 module_param(noypan, int, 0);
@@ -6966,18 +6782,7 @@ module_param(nocrt2rate, int, 0);
 module_param(resetcard, int, 0);
 module_param(videoram, int, 0);
 #endif
-#endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM_DESC(mem,
-	"\nDetermines the beginning of the video memory heap in KB. This heap is used\n"
-	  "for video RAM management for eg. DRM/DRI. On 300 series, the default depends\n"
-	  "on the amount of video RAM available. If 8MB of video RAM or less is available,\n"
-	  "the heap starts at 4096KB, if between 8 and 16MB are available at 8192KB,\n"
-	  "otherwise at 12288KB. On 315/330/340 series, the heap size is 32KB by default.\n"
-	  "The value is to be specified without 'KB' and must match the MaxXFBMem setting\n"
-	  "for XFree86 4.x/X.org 6.7 and later.\n");
-#else
 MODULE_PARM_DESC(mem,
 	"\nDetermines the beginning of the video memory heap in KB. This heap is used\n"
 	  "for video RAM management for eg. DRM/DRI. On 300 series, the default depends\n"
@@ -6985,7 +6790,6 @@ MODULE_PARM_DESC(mem,
 	  "the heap starts at 4096KB, if between 8 and 16MB are available at 8192KB,\n"
 	  "otherwise at 12288KB. On 315/330/340 series, the heap size is 32KB by default.\n"
 	  "The value is to be specified without 'KB'.\n");
-#endif

 MODULE_PARM_DESC(noaccel,
 	"\nIf set to anything other than 0, 2D acceleration will be disabled.\n"
@@ -7002,23 +6806,6 @@ MODULE_PARM_DESC(nomax,
 	  "enable the user to positively specify a virtual Y size of the screen using\n"
 	  "fbset. (default: 0)\n");

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM_DESC(mode,
-	"\nSelects the desired display mode in the format [X]x[Y]x[Depth], eg.\n"
-	  "1024x768x16. Other formats supported include XxY-Depth and\n"
-	  "XxY-Depth@Rate. If the parameter is only one (decimal or hexadecimal)\n"
-	  "number, it will be interpreted as a VESA mode number. (default: none if\n"
-	  "sisfb is a module; this leaves the console untouched and the driver will\n"
-	  "only do the video memory management for eg. DRM/DRI; 800x600x8 if sisfb\n"
-	  "is in the kernel)\n");
-MODULE_PARM_DESC(vesa,
-	"\nSelects the desired display mode by VESA defined mode number, eg. 0x117\n"
-	  "(default: 0x0000 if sisfb is a module; this leaves the console untouched\n"
-	  "and the driver will only do the video memory management for eg. DRM/DRI;\n"
-	  "0x0103 if sisfb is in the kernel)\n");
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 MODULE_PARM_DESC(mode,
 	"\nSelects the desired default display mode in the format XxYxDepth,\n"
 	 "eg. 1024x768x16. Other formats supported include XxY-Depth and\n"
@@ -7028,7 +6815,6 @@ MODULE_PARM_DESC(mode,
 MODULE_PARM_DESC(vesa,
 	"\nSelects the desired default display mode by VESA defined mode number, eg.\n"
 	 "0x117 (default: 0x0103)\n");
-#endif

 MODULE_PARM_DESC(rate,
 	"\nSelects the desired vertical refresh rate for CRT1 (external VGA) in Hz.\n"
@@ -7094,12 +6880,6 @@ MODULE_PARM_DESC(nocrt2rate,
 	"\nSetting this to 1 will force the driver to use the default refresh rate for\n"
 	  "CRT2 if CRT2 type is VGA. (default: 0, use same rate as CRT1)\n");

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM_DESC(inverse,
-	"\nSetting this to anything but 0 should invert the display colors, but this\n"
-	  "does not seem to work. (default: 0)\n");
-#endif
-
 #if !defined(__i386__) && !defined(__x86_64__)
 #ifdef CONFIG_FB_SIS_300
 MODULE_PARM_DESC(resetcard,

