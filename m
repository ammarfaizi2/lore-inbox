Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVCUPSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCUPSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVCUPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:18:54 -0500
Received: from aun.it.uu.se ([130.238.12.36]:65204 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261248AbVCUPSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:18:52 -0500
Date: Mon, 21 Mar 2005 16:18:22 +0100 (MET)
Message-Id: <200503211518.j2LFIMP6021847@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, paulus@samba.org
Subject: [PATCH][2.6.12-rc1] fix gcc4 compile error in ppc64 paca.h
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.12-rc1 or 2.6.12-rc1-mm1 for ppc64 with gcc4
fails with:

In file included from include/asm/spinlock.h:20,
                 from include/linux/spinlock.h:43,
                 from include/linux/signal.h:5,
                 from arch/ppc64/kernel/asm-offsets.c:17:
include/asm/paca.h:25: error: array type has incomplete element type
make[1]: *** [arch/ppc64/kernel/asm-offsets.s] Error 1
make: *** [arch/ppc64/kernel/asm-offsets.s] Error 2

This is an array-of-incomplete-type error.
Fix: move array decl to after the struct decl.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.12-rc1/include/asm-ppc64/paca.h.~1~	2005-03-02 19:24:19.000000000 +0100
+++ linux-2.6.12-rc1/include/asm-ppc64/paca.h	2005-03-21 15:29:26.000000000 +0100
@@ -22,7 +22,6 @@
 #include	<asm/iSeries/ItLpRegSave.h>
 #include	<asm/mmu.h>
 
-extern struct paca_struct paca[];
 register struct paca_struct *local_paca asm("r13");
 #define get_paca()	local_paca
 
@@ -115,4 +114,6 @@ struct paca_struct {
 #endif
 };
 
+extern struct paca_struct paca[];
+
 #endif /* _PPC64_PACA_H */
