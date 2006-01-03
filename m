Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWACVHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWACVHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWACVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49295 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932540AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 46/50] mips: namespace pollution: dump_regs() -> elf_dump_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Sc-DN@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

dump_regs() is used by a bunch of drivers for their internal stuff;
renamed mips instance (one that is seen in system-wide headers)
to elf_dump_regs()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/mips/kernel/process.c |    4 ++--
 include/asm-mips/elf.h     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

36918d02f947b9ed2c4f209ff6ee3d9d02e1ac22
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index dd72577..0476a4d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -205,7 +205,7 @@ int dump_fpu(struct pt_regs *regs, elf_f
 	return 1;
 }
 
-void dump_regs(elf_greg_t *gp, struct pt_regs *regs)
+void elf_dump_regs(elf_greg_t *gp, struct pt_regs *regs)
 {
 	int i;
 
@@ -231,7 +231,7 @@ int dump_task_regs (struct task_struct *
 {
 	struct thread_info *ti = tsk->thread_info;
 	long ksp = (unsigned long)ti + THREAD_SIZE - 32;
-	dump_regs(&(*regs)[0], (struct pt_regs *) ksp - 1);
+	elf_dump_regs(&(*regs)[0], (struct pt_regs *) ksp - 1);
 	return 1;
 }
 
diff --git a/include/asm-mips/elf.h b/include/asm-mips/elf.h
index d2c9a25..851f013 100644
--- a/include/asm-mips/elf.h
+++ b/include/asm-mips/elf.h
@@ -277,12 +277,12 @@ do {									\
 
 struct task_struct;
 
-extern void dump_regs(elf_greg_t *, struct pt_regs *regs);
+extern void elf_dump_regs(elf_greg_t *, struct pt_regs *regs);
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
 
 #define ELF_CORE_COPY_REGS(elf_regs, regs)			\
-	dump_regs((elf_greg_t *)&(elf_regs), regs);
+	elf_dump_regs((elf_greg_t *)&(elf_regs), regs);
 #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs)			\
 	dump_task_fpu(tsk, elf_fpregs)
-- 
0.99.9.GIT

