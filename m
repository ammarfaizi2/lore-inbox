Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVAJFpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVAJFpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVAJFor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:44:47 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:27396
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262106AbVAJFOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:32 -0500
Message-Id: <200501100735.j0A7ZvPW005825@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 19/28] UML - add the new syscalls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:57 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new 2.6.10 syscalls.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/sys_call_table.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/sys_call_table.c	2005-01-07 23:19:23.000000000 -0500
+++ 2.6.10/arch/um/kernel/sys_call_table.c	2005-01-07 23:24:31.000000000 -0500
@@ -20,7 +20,7 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif
 
-#define LAST_GENERIC_SYSCALL __NR_vserver
+#define LAST_GENERIC_SYSCALL __NR_vperfctr_read
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -48,6 +48,17 @@
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_rt_sigsuspend;
+extern syscall_handler_t sys_vserver;
+extern syscall_handler_t sys_mbind;
+extern syscall_handler_t sys_get_mempolicy;
+extern syscall_handler_t sys_set_mempolicy;
+extern syscall_handler_t sys_sys_kexec_load;
+extern syscall_handler_t sys_sys_setaltroot;
+extern syscall_handler_t sys_vperfctr_open;
+extern syscall_handler_t sys_vperfctr_control;
+extern syscall_handler_t sys_vperfctr_unlink;
+extern syscall_handler_t sys_vperfctr_iresume;
+extern syscall_handler_t sys_vperfctr_read;
 
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -247,7 +258,34 @@
 	[ __NR_clock_gettime ] (syscall_handler_t *) sys_clock_gettime,
 	[ __NR_clock_getres ] (syscall_handler_t *) sys_clock_getres,
 	[ __NR_clock_nanosleep ] (syscall_handler_t *) sys_clock_nanosleep,
+	[ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64,
+	[ __NR_fstatfs64 ] = (syscall_handler_t *) sys_fstatfs64,
 	[ __NR_tgkill ] (syscall_handler_t *) sys_tgkill,
+	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
+	[ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64,
+	[ __NR_vserver ] = (syscall_handler_t *) sys_vserver,
+	[ __NR_mbind ] = (syscall_handler_t *) sys_mbind,
+	[ __NR_get_mempolicy ] = (syscall_handler_t *) sys_get_mempolicy,
+	[ __NR_set_mempolicy ] = (syscall_handler_t *) sys_set_mempolicy,
+	[ __NR_mq_open ] = (syscall_handler_t *) sys_mq_open,
+	[ __NR_mq_unlink ] = (syscall_handler_t *) sys_mq_unlink,
+	[ __NR_mq_timedsend ] = (syscall_handler_t *) sys_mq_timedsend,
+	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
+	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
+	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
+	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
+#if 0
+	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
+#endif
+	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
+	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
+	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
+	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
+	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
+	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
+	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
+	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
 
 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 

