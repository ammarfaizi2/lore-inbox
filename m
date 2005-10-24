Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVJXPzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVJXPzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVJXPzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:55:20 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:43530 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751119AbVJXPzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:55:20 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: [PATCH 2.6.14-rc5-mm1] UML: fix compile part-1
Message-Id: <E1EU4es-0005l0-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 17:54:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error:

  CC      arch/um/kernel/syscall_kern.o
In file included from arch/um/kernel/syscall_kern.c:22:
arch/um/include/sysdep/syscalls.h:14: error: conflicting types for `sys_ptrace'
include/linux/syscalls.h:494: error: previous declaration of `sys_ptrace'

Don't know if it's the correct fix, but result seems to work fine for
me.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/arch/um/include/sysdep/syscalls.h
===================================================================
--- linux.orig/arch/um/include/sysdep/syscalls.h	2005-10-04 14:18:29.000000000 +0200
+++ linux/arch/um/include/sysdep/syscalls.h	2005-10-04 14:19:07.000000000 +0200
@@ -11,7 +11,6 @@ typedef long syscall_handler_t(struct pt
 /* Not declared on x86, incompatible declarations on x86_64, so these have
  * to go here rather than in sys_call_table.c
  */
-extern syscall_handler_t sys_ptrace;
 extern syscall_handler_t sys_rt_sigaction;
 
 extern syscall_handler_t old_mmap_i386;
