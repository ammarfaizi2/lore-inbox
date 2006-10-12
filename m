Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWJLVTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWJLVTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWJLVTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:19:03 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:5526 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750845AbWJLVTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:19:00 -0400
Date: Thu, 12 Oct 2006 23:18:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Greg Ungerer <gerg@snapgear.com>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] m68knommu: sync syscalls with m68k
Message-ID: <Pine.LNX.4.64.0610122316480.10901@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68knommu: sync syscalls with m68k

Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-Off-By: Greg Ungerer <gerg@uclinux.org>

diff --git a/arch/m68knommu/kernel/syscalltable.S b/arch/m68knommu/kernel/syscalltable.S
index 617e43e..4603f4f 100644
--- a/arch/m68knommu/kernel/syscalltable.S
+++ b/arch/m68knommu/kernel/syscalltable.S
@@ -296,10 +296,39 @@ ENTRY(sys_call_table)
 	.long sys_mq_notify	/* 275 */
 	.long sys_mq_getsetattr
 	.long sys_waitid
-	.long sys_ni_syscall	/* sys_setaltroot */
-	.long sys_ni_syscall	/* sys_add_key */
-	.long sys_ni_syscall	/* 280 */ /* sys_request_key */
-	.long sys_ni_syscall	/* sys_keyctl */
+	.long sys_ni_syscall	/* for sys_vserver */
+	.long sys_add_key
+	.long sys_request_key	/* 280 */
+	.long sys_keyctl
+	.long sys_ioprio_set
+	.long sys_ioprio_get
+	.long sys_inotify_init
+	.long sys_inotify_add_watch	/* 285 */
+	.long sys_inotify_rm_watch
+	.long sys_migrate_pages
+	.long sys_openat
+	.long sys_mkdirat
+	.long sys_mknodat		/* 290 */
+	.long sys_fchownat
+	.long sys_futimesat
+	.long sys_fstatat64
+	.long sys_unlinkat
+	.long sys_renameat		/* 295 */
+	.long sys_linkat
+	.long sys_symlinkat
+	.long sys_readlinkat
+	.long sys_fchmodat
+	.long sys_faccessat		/* 300 */
+	.long sys_ni_syscall		/* Reserved for pselect6 */
+	.long sys_ni_syscall		/* Reserved for ppoll */
+	.long sys_unshare
+	.long sys_set_robust_list
+	.long sys_get_robust_list	/* 305 */
+	.long sys_splice
+	.long sys_sync_file_range
+	.long sys_tee
+	.long sys_vmsplice
+	.long sys_move_pages		/* 310 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff --git a/include/asm-m68knommu/unistd.h b/include/asm-m68knommu/unistd.h
index daafb5d..ebaf031 100644
--- a/include/asm-m68knommu/unistd.h
+++ b/include/asm-m68knommu/unistd.h
@@ -281,14 +281,43 @@ #define __NR_mq_timedreceive	274
 #define __NR_mq_notify		275
 #define __NR_mq_getsetattr	276
 #define __NR_waitid		277
-#define __NR_sys_setaltroot	278
+#define __NR_vserver		278
 #define __NR_add_key		279
 #define __NR_request_key	280
 #define __NR_keyctl		281
- 
+#define __NR_ioprio_set		282
+#define __NR_ioprio_get		283
+#define __NR_inotify_init	284
+#define __NR_inotify_add_watch	285
+#define __NR_inotify_rm_watch	286
+#define __NR_migrate_pages	287
+#define __NR_openat		288
+#define __NR_mkdirat		289
+#define __NR_mknodat		290
+#define __NR_fchownat		291
+#define __NR_futimesat		292
+#define __NR_fstatat64		293
+#define __NR_unlinkat		294
+#define __NR_renameat		295
+#define __NR_linkat		296
+#define __NR_symlinkat		297
+#define __NR_readlinkat		298
+#define __NR_fchmodat		299
+#define __NR_faccessat		300
+#define __NR_pselect6		301
+#define __NR_ppoll		302
+#define __NR_unshare		303
+#define __NR_set_robust_list	304
+#define __NR_get_robust_list	305
+#define __NR_splice		306
+#define __NR_sync_file_range	307
+#define __NR_tee		308
+#define __NR_vmsplice		309
+#define __NR_move_pages		310
+
 #ifdef __KERNEL__
 
-#define NR_syscalls		282
+#define NR_syscalls		311
 #include <linux/err.h>
 
 /* user-visible error numbers are in the range -1 - -MAX_ERRNO: see

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
