Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUJaKXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUJaKXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbUJaKUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:20:19 -0500
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:6179
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261536AbUJaKDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:41 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3dMH009632@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 503] M68k: Add 43 missing syscalls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add 43 missing syscalls (up to 2.6.9)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/kernel/entry.S	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/kernel/entry.S	2004-10-24 16:36:15.000000000 +0200
@@ -663,3 +663,47 @@ sys_call_table:
 	.long sys_lremovexattr
 	.long sys_fremovexattr
 	.long sys_futex		/* 235 */
+	.long sys_sendfile64
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_fcntl64
+	.long sys_readahead	/* 240 */
+	.long sys_io_setup
+	.long sys_io_destroy
+	.long sys_io_getevents
+	.long sys_io_submit
+	.long sys_io_cancel	/* 245 */
+	.long sys_fadvise64
+	.long sys_exit_group
+	.long sys_lookup_dcookie
+	.long sys_epoll_create
+	.long sys_epoll_ctl	/* 250 */
+	.long sys_epoll_wait
+	.long sys_remap_file_pages
+	.long sys_set_tid_address
+	.long sys_timer_create
+	.long sys_timer_settime	/* 255 */
+	.long sys_timer_gettime
+	.long sys_timer_getoverrun
+	.long sys_timer_delete
+	.long sys_clock_settime
+	.long sys_clock_gettime	/* 260 */
+	.long sys_clock_getres
+	.long sys_clock_nanosleep
+	.long sys_statfs64
+	.long sys_fstatfs64
+	.long sys_tgkill	/* 265 */
+	.long sys_utimes
+	.long sys_fadvise64_64
+	.long sys_mbind	
+	.long sys_get_mempolicy
+	.long sys_set_mempolicy	/* 270 */
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive
+	.long sys_mq_notify	/* 275 */
+	.long sys_mq_getsetattr
+	.long sys_waitid
+	.long sys_ni_syscall	/* for sys_vserver */
+
--- linux-2.6.10-rc1/include/asm-m68k/unistd.h	2004-06-16 12:50:43.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/unistd.h	2004-10-24 16:34:49.000000000 +0200
@@ -238,8 +238,51 @@
 #define __NR_lremovexattr	233
 #define __NR_fremovexattr	234
 #define __NR_futex		235
+#define __NR_sendfile64		236
+#define __NR_mincore		237
+#define __NR_madvise		238
+#define __NR_fcntl64		239
+#define __NR_readahead		240
+#define __NR_io_setup		241
+#define __NR_io_destroy		242
+#define __NR_io_getevents	243
+#define __NR_io_submit		244
+#define __NR_io_cancel		245
+#define __NR_fadvise64		246
+#define __NR_exit_group		247
+#define __NR_lookup_dcookie	248
+#define __NR_epoll_create	249
+#define __NR_epoll_ctl		250
+#define __NR_epoll_wait		251
+#define __NR_remap_file_pages	252
+#define __NR_set_tid_address	253
+#define __NR_timer_create	254
+#define __NR_timer_settime	255
+#define __NR_timer_gettime	256
+#define __NR_timer_getoverrun	257
+#define __NR_timer_delete	258
+#define __NR_clock_settime	259
+#define __NR_clock_gettime	260
+#define __NR_clock_getres	261
+#define __NR_clock_nanosleep	262
+#define __NR_statfs64		263
+#define __NR_fstatfs64		264
+#define __NR_tgkill		265
+#define __NR_utimes		266
+#define __NR_fadvise64_64	267
+#define __NR_mbind		268
+#define __NR_get_mempolicy	269
+#define __NR_set_mempolicy	270
+#define __NR_mq_open		271
+#define __NR_mq_unlink		272
+#define __NR_mq_timedsend	273
+#define __NR_mq_timedreceive	274
+#define __NR_mq_notify		275
+#define __NR_mq_getsetattr	276
+#define __NR_waitid		277
+#define __NR_vserver		278
 
-#define NR_syscalls		236
+#define NR_syscalls		279
 
 /* user-visible error numbers are in the range -1 - -124: see
    <asm-m68k/errno.h> */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
