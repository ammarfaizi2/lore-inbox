Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWDRPHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWDRPHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWDRPHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:07:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53509 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932266AbWDRPHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:07:02 -0400
Date: Tue, 18 Apr 2006 17:07:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix VIDEO_DEV=m, VIDEO_V4L1_COMPAT=y
Message-ID: <20060418150700.GJ11582@stusta.de>
References: <20060418031423.3cbef2f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418031423.3cbef2f7.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 03:14:23AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm2:
>...
>  git-dvb.patch
>...
>  git trees
>...

If CONFIG_VIDEO_DEV=m and CONFIG_VIDEO_V4L1_COMPAT=y, v4l1-compat should 
be built as a module (currently, it isn't built at all leading to 
problems with modules using it).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

