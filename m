Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWFUQ4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWFUQ4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWFUQ4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:56:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48135 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932263AbWFUQ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:56:50 -0400
Date: Wed, 21 Jun 2006 18:56:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64: remove sys32_ni_syscall()
Message-ID: <20060621165648.GG9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the no longer used sys32_ni_syscall()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/x86_64/ia32/ia32entry.S |    4 ----
 arch/x86_64/ia32/sys_ia32.c  |   13 -------------
 2 files changed, 17 deletions(-)

--- linux-2.6.17-mm1-x86_64/arch/x86_64/ia32/ia32entry.S.old	2006-06-21 18:51:14.000000000 +0200
+++ linux-2.6.17-mm1-x86_64/arch/x86_64/ia32/ia32entry.S	2006-06-21 18:51:25.000000000 +0200
@@ -340,10 +340,6 @@
 	movq $-ENOSYS,RAX-ARGOFFSET(%rsp)
 	jmp int_ret_from_sys_call
 
-ni_syscall:
-	movq %rax,%rdi
-	jmp  sys32_ni_syscall			
-
 quiet_ni_syscall:
 	movq $-ENOSYS,%rax
 	ret
--- linux-2.6.17-mm1-x86_64/arch/x86_64/ia32/sys_ia32.c.old	2006-06-21 18:51:38.000000000 +0200
+++ linux-2.6.17-mm1-x86_64/arch/x86_64/ia32/sys_ia32.c	2006-06-21 18:51:43.000000000 +0200
@@ -508,19 +508,6 @@
 	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
 
-int sys32_ni_syscall(int call)
-{ 
-	struct task_struct *me = current;
-	static char lastcomm[sizeof(me->comm)];
-
-	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
-		compat_printk(KERN_INFO "IA32 syscall %d from %s not implemented\n",
-		       call, me->comm);
-		strncpy(lastcomm, me->comm, sizeof(lastcomm));
-	} 
-	return -ENOSYS;	       
-} 
-
 /* 32-bit timeval and related flotsam.  */
 
 asmlinkage long

