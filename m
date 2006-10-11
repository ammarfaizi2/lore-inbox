Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWJKQ2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWJKQ2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWJKQ2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:28:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49572 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030682AbWJKQ2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:08 -0400
To: torvalds@osdl.org
Subject: [PATCH] misc m68k __user annotations
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1GXgwB-0005fa-9O@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:28:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/kernel/process.c |    8 ++++----
 arch/m68k/kernel/traps.c   |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 45a4664..24e83d5 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -221,13 +221,13 @@ asmlinkage int m68k_clone(struct pt_regs
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int *parent_tidptr, *child_tidptr;
+	int __user *parent_tidptr, *child_tidptr;
 
 	/* syscall2 puts clone_flags in d1 and usp in d2 */
 	clone_flags = regs->d1;
 	newsp = regs->d2;
-	parent_tidptr = (int *)regs->d3;
-	child_tidptr = (int *)regs->d4;
+	parent_tidptr = (int __user *)regs->d3;
+	child_tidptr = (int __user *)regs->d4;
 	if (!newsp)
 		newsp = rdusp();
 	return do_fork(clone_flags, newsp, regs, 0,
@@ -361,7 +361,7 @@ void dump_thread(struct pt_regs * regs, 
 /*
  * sys_execve() executes a new program.
  */
-asmlinkage int sys_execve(char *name, char **argv, char **envp)
+asmlinkage int sys_execve(char __user *name, char __user * __user *argv, char __user * __user *envp)
 {
 	int error;
 	char * filename;
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 4569406..759fa24 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -326,13 +326,13 @@ static inline int do_040writeback1(unsig
 
 	switch (wbs & WBSIZ_040) {
 	case BA_SIZE_BYTE:
-		res = put_user(wbd & 0xff, (char *)wba);
+		res = put_user(wbd & 0xff, (char __user *)wba);
 		break;
 	case BA_SIZE_WORD:
-		res = put_user(wbd & 0xffff, (short *)wba);
+		res = put_user(wbd & 0xffff, (short __user *)wba);
 		break;
 	case BA_SIZE_LONG:
-		res = put_user(wbd, (int *)wba);
+		res = put_user(wbd, (int __user *)wba);
 		break;
 	}
 
-- 
1.4.2.GIT


