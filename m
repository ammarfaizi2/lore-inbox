Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266286AbUBLFqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266288AbUBLFqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:46:30 -0500
Received: from ozlabs.org ([203.10.76.45]:27351 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266286AbUBLFq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:46:29 -0500
Subject: [PATCH] fix rivafb build on ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076564635.866.170.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 16:43:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew !

rivafb is part of the g5 defconfig, but will cause a build error
on ppc64 due to a missing #include, here is a fix, please apply:

===== drivers/video/riva/fbdev.c 1.51 vs edited =====
--- 1.51/drivers/video/riva/fbdev.c	Wed Feb  4 16:29:30 2004
+++ edited/drivers/video/riva/fbdev.c	Thu Feb 12 16:39:59 2004
@@ -44,6 +44,10 @@
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
+#ifdef CONFIG_PPC_OF
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#endif
 
 #include "rivafb.h"
 #include "nvreg.h"


