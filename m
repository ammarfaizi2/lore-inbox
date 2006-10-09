Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWJIUCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWJIUCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWJIUCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:02:34 -0400
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:26043 "EHLO
	hoboe1bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964800AbWJIUCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:02:33 -0400
Date: Mon, 9 Oct 2006 22:02:25 +0200
Message-Id: <200610092002.k99K2P2W031156@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] m68k syscall updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some missing system calls (recent udev needs them)

Signed-Off-By: Kars de Jong <jongk@linux-m68k.org>
Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/kernel/entry.S  |    5 +++++
 include/asm-m68k/unistd.h |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- linux/arch/m68k/kernel/entry.S	2006/01/31 00:57:35	1.26
+++ linux/arch/m68k/kernel/entry.S	2006/02/11 16:28:36	1.27
@@ -707,4 +707,9 @@ sys_call_table:
 	.long sys_add_key
 	.long sys_request_key	/* 280 */
 	.long sys_keyctl
+	.long sys_ioprio_set
+	.long sys_ioprio_get
+	.long sys_inotify_init
+	.long sys_inotify_add_watch	/* 285 */
+	.long sys_inotify_rm_watch
 
--- linux/include/asm-m68k/unistd.h	2006/01/14 23:16:33	1.1.1.14
+++ linux/include/asm-m68k/unistd.h	2006/02/11 16:28:36	1.10
@@ -284,10 +284,15 @@
 #define __NR_add_key		279
 #define __NR_request_key	280
 #define __NR_keyctl		281
+#define __NR_ioprio_set		282
+#define __NR_ioprio_get		283
+#define __NR_inotify_init	284
+#define __NR_inotify_add_watch	285
+#define __NR_inotify_rm_watch	286
 
 #ifdef __KERNEL__
 
-#define NR_syscalls		282
+#define NR_syscalls		287
 #include <linux/err.h>
 
 /* user-visible error numbers are in the range -1 - -124: see

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
