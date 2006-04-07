Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWDGOgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWDGOgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDGOgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:36:04 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43484 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932349AbWDGOcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:25 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 07/17] uml: fix "extern-vs-static" proto conflict in TLS code
Date: Fri, 07 Apr 2006 16:31:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143105.19201.88376.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Move the prototype from arch-generic to arch-specific includes because on x86_64
these functions are two static inlines.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h  |    4 ----
 include/asm-um/ptrace-i386.h |    3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 4255713..efa3d33 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -117,10 +117,6 @@ extern struct task_struct *get_task(int 
 extern void machine_halt(void);
 extern int is_syscall(unsigned long addr);
 
-extern void arch_switch_to_tt(struct task_struct *from, struct task_struct *to);
-
-extern void arch_switch_to_skas(struct task_struct *from, struct task_struct *to);
-
 extern void free_irq(unsigned int, void *);
 extern int cpu(void);
 
diff --git a/include/asm-um/ptrace-i386.h b/include/asm-um/ptrace-i386.h
index 30656c9..6e2528b 100644
--- a/include/asm-um/ptrace-i386.h
+++ b/include/asm-um/ptrace-i386.h
@@ -56,6 +56,9 @@ extern int do_get_thread_area_tt(struct 
 extern int arch_switch_tls_skas(struct task_struct *from, struct task_struct *to);
 extern int arch_switch_tls_tt(struct task_struct *from, struct task_struct *to);
 
+extern void arch_switch_to_tt(struct task_struct *from, struct task_struct *to);
+extern void arch_switch_to_skas(struct task_struct *from, struct task_struct *to);
+
 static inline int do_get_thread_area(struct user_desc *info)
 {
 	return CHOOSE_MODE_PROC(do_get_thread_area_tt, do_get_thread_area_skas, info);
