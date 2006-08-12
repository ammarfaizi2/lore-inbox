Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWHLRC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWHLRC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWHLRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:02:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:16434 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964916AbWHLRCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:02:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SEUSZZfCUmnh/7ivMFMcOACUVfSAwzWj2GIxdtZMEokCO1utVti6uKAEZfIN3p1menSn+Kzw8BDB34RcrbCO0PihYksOcYL38ax20EzSreHOTh5zHs9CtEVkmDvUsYsKSeDgOltJlFrytet0xtunty7foRuqG7O5cO+ZBy54GOE=
Message-ID: <44DE09BD.6050603@gmail.com>
Date: Sat, 12 Aug 2006 19:02:53 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 8/10] drivers/video/sis/sis_main.h Removal of old
 code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/sis_main.h linux-work/drivers/video/sis/sis_main.h
--- linux-work-clean/drivers/video/sis/sis_main.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-work/drivers/video/sis/sis_main.h	2006-08-12 18:00:31.000000000 +0200
@@ -68,12 +68,6 @@ static int sisfb_max = -1;
 static int sisfb_userom = 1;
 static int sisfb_useoem = -1;
 #ifdef MODULE
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-static int sisfb_mode_idx = -1;
-#else
-static int sisfb_mode_idx = MODE_INDEX_NONE;  /* Don't use a mode by default if we are a module */
-#endif
-#else
 static int sisfb_mode_idx = -1;               /* Use a default mode if we are inside the kernel */
 #endif
 static int sisfb_parm_rate = -1;
@@ -93,10 +87,6 @@ static int sisfb_tvstd  = -1;
 static int sisfb_tvxposoffset = 0;
 static int sisfb_tvyposoffset = 0;
 static int sisfb_nocrt2rate = 0;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static int  sisfb_inverse = 0;
-static char sisfb_fontname[40];
-#endif
 #if !defined(__i386__) && !defined(__x86_64__)
 static int sisfb_resetcard = 0;
 static int sisfb_videoram = 0;
@@ -687,54 +677,8 @@ SISINITSTATIC int sisfb_init(void);
 static int	sisfb_get_fix(struct fb_fix_screeninfo *fix, int con,
 				struct fb_info *info);

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static int	sisfb_get_fix(struct fb_fix_screeninfo *fix,
-				int con,
-				struct fb_info *info);
-static int	sisfb_get_var(struct fb_var_screeninfo *var,
-				int con,
-				struct fb_info *info);
-static int	sisfb_set_var(struct fb_var_screeninfo *var,
-				int con,
-				struct fb_info *info);
-static void	sisfb_crtc_to_var(struct sis_video_info *ivideo,
-				struct fb_var_screeninfo *var);
-static int	sisfb_get_cmap(struct fb_cmap *cmap,
-				int kspc,
-				int con,
-				struct fb_info *info);
-static int	sisfb_set_cmap(struct fb_cmap *cmap,
-				int kspc,
-				int con,
-				struct fb_info *info);
-static int	sisfb_update_var(int con,
-				struct fb_info *info);
-static int	sisfb_switch(int con,
-			     struct fb_info *info);
-static void	sisfb_blank(int blank,
-				struct fb_info *info);
-static void	sisfb_set_disp(int con,
-				struct fb_var_screeninfo *var,
-				struct fb_info *info);
-static int	sis_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-				unsigned *blue, unsigned *transp,
-				struct fb_info *fb_info);
-static void	sisfb_do_install_cmap(int con,
-				struct fb_info *info);
-static int	sisfb_ioctl(struct inode *inode, struct file *file,
-				unsigned int cmd, unsigned long arg, int con,
-				struct fb_info *info);
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
 static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 			    unsigned long arg);
-#else
-static int	sisfb_ioctl(struct inode *inode, struct file *file,
-				unsigned int cmd, unsigned long arg,
-				struct fb_info *info);
-#endif
 static int	sisfb_set_par(struct fb_info *info);
 static int	sisfb_blank(int blank,
 				struct fb_info *info);
@@ -743,7 +687,6 @@ extern void	fbcon_sis_fillrect(struct fb
 extern void	fbcon_sis_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area);
 extern int	fbcon_sis_sync(struct fb_info *info);
-#endif

 /* Internal 2D accelerator functions */
 extern int	sisfb_initaccel(struct sis_video_info *ivideo);
@@ -811,16 +754,10 @@ extern BOOLEAN		SiSDetermineROMLayout661

 extern BOOLEAN		sisfb_gettotalfrommode(struct SiS_Private *SiS_Pr, unsigned char modeno,
 				int *htotal, int *vtotal, unsigned char rateindex);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 extern int		sisfb_mode_rate_to_dclock(struct SiS_Private *SiS_Pr,
 				unsigned char modeno, unsigned char rateindex);
 extern int		sisfb_mode_rate_to_ddata(struct SiS_Private *SiS_Pr, unsigned char modeno,
 				unsigned char rateindex, struct fb_var_screeninfo *var);
-#endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-extern void		SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata, int xres,
-				int yres, struct fb_var_screeninfo *var, BOOLEAN writeres);
-#endif

 /* Chrontel TV, DDC and DPMS functions */
 extern unsigned short	SiS_GetCH700x(struct SiS_Private *SiS_Pr, unsigned short reg);



