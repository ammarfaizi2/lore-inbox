Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbQLTUZj>; Wed, 20 Dec 2000 15:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQLTUZa>; Wed, 20 Dec 2000 15:25:30 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:47116 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S129631AbQLTUZ0>; Wed, 20 Dec 2000 15:25:26 -0500
Date: Wed, 20 Dec 2000 11:56:56 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test13-pre3 drivers/char/Makefile and CONFIG_DRM_MGA=m
Message-ID: <Pine.LNX.4.30.0012201131410.14898-100000@shimura.math.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

When I use 'make menuconfig' on 2.4.0-test13-pre3 to select DRM and the
Matrox DRM driver as a module, I get a .config with CONFIG_DRM=y and
CONFIG_DRM_MGA=m.  However, this causes drivers/char/Makefile to skip the
drm subdirectory when compiling modules: its only reference to CONFIG_DRM
is the line 'subdir-$(CONFIG_DRM) += drm' and 'make menuconfig' does not
allow me to select 'm' for CONFIG_DRM.

I don't know enough about the kernel Makefiles to figure out the proper
solution, but I was able to get the modules compiled by adding the line
'mod-subdirs += drm' to drivers/char/Makefile.  This is not the proper
solution, I expect, as now 'make modules' will enter the driver/char/drm
subdirectory even if CONFIG_DRM=n.

Cheers,
Wayne


--- drivers/char/Makefile~	Wed Dec 20 11:16:59 2000
+++ drivers/char/Makefile	Wed Dec 20 11:21:54 2000
@@ -154,6 +154,7 @@

 subdir-$(CONFIG_FTAPE) += ftape
 subdir-$(CONFIG_DRM) += drm
+mod-subdirs += drm
 subdir-$(CONFIG_PCMCIA) += pcmcia
 subdir-$(CONFIG_AGP) += agp



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
