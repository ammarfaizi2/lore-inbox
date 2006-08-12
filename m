Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWHLRBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWHLRBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHLRBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:01:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964904AbWHLRBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:01:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X7wgHBIdble3qMmt9mEJlwP73wOazsCl77F+Iyh+c/Sa5S74CKsHT4Bt4dc7PHW1bC0EqvdfJB4Kxr5/jANaDvMAjaizR8GaLccGSpComBCwARytgjmLXmmorGchXskuGMzwteMyCJ/l049J93dkGARb7hFD8lBBh+QlMZfzBGs=
Message-ID: <44DE097E.8090202@gmail.com>
Date: Sat, 12 Aug 2006 19:01:50 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 5/10] drivers/video/sis/sis_accel.c Removal of old
 code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/sis_accel.c linux-work/drivers/video/sis/sis_accel.c
--- linux-work-clean/drivers/video/sis/sis_accel.c	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/drivers/video/sis/sis_accel.c	2006-08-12 18:16:13.000000000 +0200
@@ -32,22 +32,10 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fb.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <linux/console.h>
-#endif
 #include <linux/ioport.h>
 #include <linux/types.h>
-
 #include <asm/io.h>

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-#endif
-
 #include "sis.h"
 #include "sis_accel.h"

@@ -91,11 +79,9 @@ static const u8 sisPatALUConv[] =
     0xFF,       /* dest = 0xFF;         1,      GXset,          0xF */
 };

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
 static const int myrops[] = {
    	3, 10, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
 };
-#endif

 /* 300 series ----------------------------------------------------- */
 #ifdef CONFIG_FB_SIS_300
@@ -315,8 +301,6 @@ void sisfb_syncaccel(struct sis_video_in
 	}
 }

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)  /* --------------- 2.5 --------------- */
-
 int fbcon_sis_sync(struct fb_info *info)
 {
 	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
@@ -438,13 +422,3 @@ void fbcon_sis_copyarea(struct fb_info *

 	sisfb_syncaccel(ivideo);
 }
-
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)  /* -------------- 2.4 --------------- */
-
-#include "sisfb_accel_2_4.h"
-
-#endif /* KERNEL VERSION */
-
-

