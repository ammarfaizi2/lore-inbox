Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136473AbREIOK2>; Wed, 9 May 2001 10:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136477AbREIOKS>; Wed, 9 May 2001 10:10:18 -0400
Received: from NS.CenSoft.COM ([208.219.23.2]:55047 "EHLO
	ns.centurysoftware.com") by vger.kernel.org with ESMTP
	id <S136473AbREIOKL>; Wed, 9 May 2001 10:10:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jordan Crouse <jordanc@Censoft.com>
Reply-To: jordanc@Censoft.com
Organization: The Microwindows Project
To: Jocelyn Mayer <jma@netgem.com>, antonpoon@hongkong.com,
        linux-kernel@vger.kernel.org
Subject: Re: How to compile kernel for Geode GX1
Date: Wed, 9 May 2001 08:09:40 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <3AF91E88.1000705@netgem.com>
In-Reply-To: <3AF91E88.1000705@netgem.com>
MIME-Version: 1.0
Message-Id: <01050908094005.28749@cosmic>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are using the vesa framebuffer on the Geode, you will also want to 
make a minor change to vesafb.c.  Because the framebuffer is located within 
the processor itself, requesting the memory region always caused my Geode 
boxes to freeze.  I think that we can safely eliminate this call, since we 
know the memory is always available:  

--- /usr/src/linux/drivers/video/vesafb.c	Thu Mar  8 10:35:53 2001
+++ vesafb.c	Tue Mar 27 09:13:22 2001
@@ -519,12 +519,14 @@
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
+#ifdef NOTUSED
 	if (!request_mem_region(video_base, video_size, "vesafb")) {
 		printk(KERN_ERR
 		       "vesafb: abort, cannot reserve video memory at 0x%lx\n",
 			video_base);
 		return -EBUSY;
 	}
+#endif
 
         video_vbase = ioremap(video_base, video_size);
 	if (!video_vbase) {

Jordan
-- 
-- embed this!  http://www.microwindows.org --

