Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSIKHAq>; Wed, 11 Sep 2002 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318426AbSIKHAq>; Wed, 11 Sep 2002 03:00:46 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:22031 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318407AbSIKHAp>;
	Wed, 11 Sep 2002 03:00:45 -0400
Date: Wed, 11 Sep 2002 09:05:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] zftape: Cleanup zftape_syms.c
Message-ID: <20020911090519.A16000@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed compatibility cruft from zftape_syms.c.
There is no need to be compatible with kernel 2.1.18 and older.
Replaced FT_KSYM with direct call to EXPORT_SYMBOL.

Compiled - not tested.

	Sam

===== drivers/char/ftape/zftape/zftape_syms.c 1.1 vs edited =====
--- 1.1/drivers/char/ftape/zftape/zftape_syms.c	Tue Feb  5 18:40:05 2002
+++ edited/drivers/char/ftape/zftape/zftape_syms.c	Wed Sep 11 08:38:06 2002
@@ -34,26 +34,12 @@
 #include "../zftape/zftape-buffers.h"
 #include "../zftape/zftape-ctl.h"
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,18)
-# define FT_KSYM(sym) EXPORT_SYMBOL(sym);
-#else
-# define FT_KSYM(sym) X(sym),
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-struct symbol_table zft_symbol_table = {
-#include <linux/symtab_begin.h>
-#endif
 /* zftape-init.c */
-FT_KSYM(zft_cmpr_register)
-FT_KSYM(zft_cmpr_unregister)
+EXPORT_SYMBOL(zft_cmpr_register);
+EXPORT_SYMBOL(zft_cmpr_unregister);
 /* zftape-read.c */
-FT_KSYM(zft_fetch_segment_fraction)
+EXPORT_SYMBOL(zft_fetch_segment_fraction);
 /* zftape-buffers.c */
-FT_KSYM(zft_vmalloc_once)
-FT_KSYM(zft_vmalloc_always)
-FT_KSYM(zft_vfree)
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-#include <linux/symtab_end.h>
-};
-#endif
+EXPORT_SYMBOL(zft_vmalloc_once);
+EXPORT_SYMBOL(zft_vmalloc_always);
+EXPORT_SYMBOL(zft_vfree);
