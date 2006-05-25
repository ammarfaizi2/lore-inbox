Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWEYB3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWEYB3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWEYB1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30606 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964820AbWEYB1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:03 -0400
Message-Id: <20060525003420.488315000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:45 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] cleanup unistd.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove long obsolete kernel syscalls, only execve is still used.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/unistd.h |   39 ---------------------------------------
 1 file changed, 39 deletions(-)

Index: linux-2.6-mm/include/asm-m68k/unistd.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/unistd.h
+++ linux-2.6-mm/include/asm-m68k/unistd.h
@@ -410,46 +410,7 @@ __syscall_return(type,__res); \
 
 #ifdef __KERNEL_SYSCALLS__
 
-#include <linux/compiler.h>
-#include <linux/interrupt.h>
-#include <linux/types.h>
-
-/*
- * we need this inline - forking from kernel space will result
- * in NO COPY ON WRITE (!!!), until an execve is executed. This
- * is no problem, but for the stack. This is handled by not letting
- * main() use the stack at all after fork(). Thus, no function
- * calls - which means inline code for fork too, as otherwise we
- * would use the stack upon exit from 'fork()'.
- *
- * Actually only pause and fork are needed inline, so that there
- * won't be any messing with the stack from main(), but we define
- * some others too.
- */
-#define __NR__exit __NR_exit
-static inline _syscall0(pid_t,setsid)
-static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-static inline _syscall1(int,dup,int,fd)
 static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
-static inline _syscall1(int,close,int,fd)
-static inline _syscall1(int,_exit,int,exitcode)
-static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-
-asmlinkage long sys_mmap2(
-			unsigned long addr, unsigned long len,
-			unsigned long prot, unsigned long flags,
-			unsigned long fd, unsigned long pgoff);
-asmlinkage int sys_execve(char *name, char **argv, char **envp);
-asmlinkage int sys_pipe(unsigned long *fildes);
-struct pt_regs;
-struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
 
 #endif /* __KERNEL_SYSCALLS__ */
 

--

