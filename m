Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVCLXfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVCLXfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVCLXdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:33:43 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55754 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262426AbVCLX1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:27:07 -0500
Date: Sun, 13 Mar 2005 00:27:01 +0100 (MET)
Message-Id: <200503122327.j2CNR17W029088@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ppc32 the ATI Mach64 frame buffer references symbols on macmodes.o.
In Linus' 2.6.11 macmodes.o is automatically included, but not so in
2.6.11-mm3, causing linkage errors.

The quick-and-dirty hack below worked for me.

/Mikael

--- linux-2.6.11-mm2/drivers/video/Makefile.~1~	2005-03-09 23:20:08.000000000 +0100
+++ linux-2.6.11-mm2/drivers/video/Makefile	2005-03-11 18:03:29.000000000 +0100
@@ -29,7 +29,7 @@ obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
 obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
-obj-$(CONFIG_FB_ATY)		  += aty/
+obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_ATY128)		  += aty/
 obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/
