Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbRAASKk>; Mon, 1 Jan 2001 13:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRAASK3>; Mon, 1 Jan 2001 13:10:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14353 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131142AbRAASKR>; Mon, 1 Jan 2001 13:10:17 -0500
Date: Mon, 1 Jan 2001 09:39:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Adam Sampson <azz@gnu.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <87ofxsdnns.fsf@cartman.azz.net>
Message-ID: <Pine.LNX.4.10.10101010938590.2892-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 Jan 2001, Adam Sampson wrote:
> 
> It appears to work (even with the reiserfs patch with the obvious
> Makefile tweak), but the drm modules have unresolved symbols:

Does this fix it for you (do a "make clean" before re-building your tree)?

		Linus

----
--- v2.4.0-prerelease/linux/drivers/char/drm/Makefile	Mon Jan  1 09:38:35 2001
+++ linux/drivers/char/drm/Makefile	Mon Jan  1 09:38:04 2001
@@ -44,22 +44,22 @@
 mga-objs   := mga_drv.o   mga_dma.o     mga_context.o  mga_bufs.o  mga_state.o
 i810-objs  := i810_drv.o  i810_dma.o    i810_context.o i810_bufs.o
 
-obj-$(CONFIG_DRM_GAMMA) += gamma.o
-obj-$(CONFIG_DRM_TDFX)  += tdfx.o
-obj-$(CONFIG_DRM_R128)  += r128.o
-obj-$(CONFIG_DRM_FFB)   += ffb.o
-obj-$(CONFIG_DRM_MGA)   += mga.o
-obj-$(CONFIG_DRM_I810)  += i810.o
-
-
 # When linking into the kernel, link the library just once. 
 # If making modules, we include the library into each module
 
 ifdef MAKING_MODULES
   lib = drmlib.a
 else
-  obj-y += drmlib.a
+  extra-obj = drmlib.a  
 endif
+
+obj-$(CONFIG_DRM_GAMMA) += gamma.o $(extra-obj)
+obj-$(CONFIG_DRM_TDFX)  += tdfx.o $(extra-obj)
+obj-$(CONFIG_DRM_R128)  += r128.o $(extra-obj)
+obj-$(CONFIG_DRM_FFB)   += ffb.o $(extra-obj)
+obj-$(CONFIG_DRM_MGA)   += mga.o $(extra-obj)
+obj-$(CONFIG_DRM_I810)  += i810.o $(extra-obj)
+
 
 include $(TOPDIR)/Rules.make
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
