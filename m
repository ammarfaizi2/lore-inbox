Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUILUIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUILUIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUILUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:08:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:9113 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261232AbUILUIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:08:40 -0400
Date: Sun, 12 Sep 2004 22:08:18 +0200 (MEST)
Message-Id: <200409122008.i8CK8I0U016064@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com, vandrove@vc.cvut.cz
Subject: [PATCH][2.4.28-pre3] matrox framebuffer driver gcc-3.4 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's matrox framebuffer driver. The changes are backports from
the 2.6 kernel. The warnings don't appear for x86, but they do appear
for ppc32.

/Mikael

--- linux-2.4.28-pre3/drivers/video/matrox/matroxfb_base.h.~1~	2003-08-25 20:07:46.000000000 +0200
+++ linux-2.4.28-pre3/drivers/video/matrox/matroxfb_base.h	2004-09-12 21:32:52.000000000 +0200
@@ -253,21 +253,21 @@
 #ifdef MEMCPYTOIO_WORKS
 	memcpy_toio(va.vaddr + offs, src, len);
 #elif defined(MEMCPYTOIO_WRITEL)
-#define srcd ((const u_int32_t*)src)
 	if (offs & 3) {
 		while (len >= 4) {
-			mga_writel(va, offs, get_unaligned(srcd++));
+			mga_writel(va, offs, get_unaligned((u32 *)src));
 			offs += 4;
 			len -= 4;
+			src += 4;
 		}
 	} else {
 		while (len >= 4) {
-			mga_writel(va, offs, *srcd++);
+			mga_writel(va, offs, *(u32 *)src);
 			offs += 4;
 			len -= 4;
+			src += 4;
 		}
 	}
-#undef srcd
 	if (len) {
 		u_int32_t tmp;
 
