Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbUKFT5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUKFT5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKFT5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:57:53 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4992 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261456AbUKFT5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:57:36 -0500
Date: Sat, 6 Nov 2004 20:57:24 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add argument-less ppdev ioctls to compat_ioctl.h
Message-ID: <20041106195724.GA9137@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,
  ppdev's ioctls are not available for 32bit apps on 64bit systems.  There are
four ioctls which take no argument at all (so they are compatible between
32bit and 64bit), these numbers do not clash with any other ioctl code, and
so I see no reason why not applying patch below.

  It solves problem VMware users are faced on 64bit systems if they want to
use direct access to the parallel port.
						Thanks,
							Petr Vandrovec


Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>

diff -urdN linux/fs/compat_ioctl.c linux/fs/compat_ioctl.c
--- linux/fs/compat_ioctl.c	2004-11-05 23:39:48.000000000 +0100
+++ linux/fs/compat_ioctl.c	2004-11-06 16:14:15.000000000 +0100
@@ -96,6 +96,7 @@
 #include <asm/module.h>
 #include <linux/soundcard.h>
 #include <linux/lp.h>
+#include <linux/ppdev.h>
 
 #include <linux/atm.h>
 #include <linux/atmarp.h>
diff -urdN linux/include/linux/compat_ioctl.h linux/include/linux/compat_ioctl.h
--- linux/include/linux/compat_ioctl.h	2004-11-05 23:39:16.000000000 +0100
+++ linux/include/linux/compat_ioctl.h	2004-11-06 14:55:55.000000000 +0100
@@ -340,6 +340,11 @@
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
 /* LP */
 COMPATIBLE_IOCTL(LPGETSTATUS)
+/* ppdev */
+COMPATIBLE_IOCTL(PPCLAIM)
+COMPATIBLE_IOCTL(PPRELEASE)
+COMPATIBLE_IOCTL(PPEXCL)
+COMPATIBLE_IOCTL(PPYIELD)
 /* CDROM stuff */
 COMPATIBLE_IOCTL(CDROMPAUSE)
 COMPATIBLE_IOCTL(CDROMRESUME)
