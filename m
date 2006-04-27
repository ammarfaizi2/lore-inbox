Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWD0R5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWD0R5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWD0R5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:57:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965016AbWD0R53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:57:29 -0400
Date: Thu, 27 Apr 2006 19:57:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] fix VIDEO_DEV=m, VIDEO_V4L1_COMPAT=y
Message-ID: <20060427175727.GH3570@stusta.de>
References: <20060427014141.06b88072.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427014141.06b88072.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 01:41:41AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm3:
>...
> +git-dvb-Kconfig-fix.patch
> +git-dvb-Kconfig-fix-2.patch
> 
>  git-dvb.patch is a bit sick.
>...

These patches are completely sick.

Not every compatibility issue is about 32<->64 Bit...

Below is the patch I sent you after I discovered the bug 
in 2.6.17-rc1-mm3. Is there any reason why you didn't merge my patch?

cu
Adrian


<--  snip  -->


If CONFIG_VIDEO_DEV=m and CONFIG_VIDEO_V4L1_COMPAT=y, v4l1-compat should 
be built as a module (currently, it isn't built at all leading to 
problems with modules using it).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Apr 2006

--- linux-2.6.17-rc1-mm3-full/drivers/media/video/Makefile.old	2006-04-18 16:52:10.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/media/video/Makefile	2006-04-18 16:57:06.000000000 +0200
@@ -11,7 +11,10 @@
 msp3400-objs	:=	msp3400-driver.o msp3400-kthreads.o
 
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o compat_ioctl32.o
-obj-$(CONFIG_VIDEO_V4L1_COMPAT) += v4l1-compat.o
+
+ifeq ($(CONFIG_VIDEO_V4L1_COMPAT),y)
+  obj-$(CONFIG_VIDEO_DEV) += v4l1-compat.o
+endif
 
 obj-$(CONFIG_VIDEO_BT848) += bt8xx/
 obj-$(CONFIG_VIDEO_BT848) += tvaudio.o tda7432.o tda9875.o ir-kbd-i2c.o

