Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTEFC5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTEFC5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:57:07 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:32144 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262284AbTEFC5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add __KERNEL__ guard to nb85e_cache.h on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030924.BB389377A@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:24 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This header ends up getting included by uClibc (though nothing in it is
used), so this protection is necessary to avoid problems with kernel-only
typedefs.

diff -ruN -X../cludes linux-2.5.69-uc0/include/asm-v850/nb85e_cache.h linux-2.5.69-uc0-v850-20030506/include/asm-v850/nb85e_cache.h
--- linux-2.5.69-uc0/include/asm-v850/nb85e_cache.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/include/asm-v850/nb85e_cache.h	2003-05-06 10:40:26.000000000 +0900
@@ -35,7 +35,7 @@
 #define L1_CACHE_BYTES				NB85E_CACHE_LINE_SIZE
 
 
-#ifndef __ASSEMBLY__
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
 /* Set caching params via the BHC and DCC registers.  */
 void nb85e_cache_enable (u16 bhc, u16 dcc);
@@ -73,6 +74,6 @@
 #define flush_icache_user_range	nb85e_cache_flush_icache_user_range
 #define flush_cache_sigtramp	nb85e_cache_flush_sigtramp
 
-#endif /* !__ASSEMBLY__ */
+#endif /* __KERNEL__ && !__ASSEMBLY__ */
 
 #endif /* __V850_NB85E_CACHE_H__ */
