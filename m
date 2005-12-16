Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVLPWks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVLPWks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVLPWks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:40:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23728 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932543AbVLPWks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:40:48 -0500
Date: Fri, 16 Dec 2005 22:40:47 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: namespace pollution: dump_regs() -> elf_dump_regs()
Message-ID: <20051216224047.GE27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dump_regs() is used by a bunch of drivers for their internal stuff;
renamed mips instance (one that is seen in system-wide headers)
to elf_dump_regs()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/mips/kernel/process.c |    4 ++--
 include/asm-mips/elf.h     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

7cb0f5ab7ecf09fc83483f3f2b0d2005d789dba5
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
