Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWJIUCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWJIUCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWJIUCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:02:38 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:49621 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964803AbWJIUCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:02:36 -0400
Date: Mon, 9 Oct 2006 22:02:31 +0200
Message-Id: <200610092002.k99K2VPS031175@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] m68k syscall updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing syscalls

Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/kernel/entry.S  |   24 ++++++++++++++++++++++++
 include/asm-m68k/unistd.h |   26 +++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

--- linux-2.6.19-rc1/arch/m68k/kernel/entry.S	2006-09-26 17:25:42.000000000 +0200
+++ linux-m68k-2.6.19-rc1/arch/m68k/kernel/entry.S	2006-10-03 17:24:01.000000000 +0200
@@ -711,4 +711,28 @@ sys_call_table:
 	.long sys_inotify_init
 	.long sys_inotify_add_watch	/* 285 */
 	.long sys_inotify_rm_watch
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
 
--- linux-2.6.19-rc1/include/asm-m68k/unistd.h	2006-10-08 12:00:01.000000000 +0200
+++ linux-m68k-2.6.19-rc1/include/asm-m68k/unistd.h	2006-10-05 17:42:26.000000000 +0200
@@ -289,10 +289,34 @@
 #define __NR_inotify_init	284
 #define __NR_inotify_add_watch	285
 #define __NR_inotify_rm_watch	286
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
 
 #ifdef __KERNEL__
 
-#define NR_syscalls		287
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
