Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbSJEDZ5>; Fri, 4 Oct 2002 23:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261995AbSJEDZ5>; Fri, 4 Oct 2002 23:25:57 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:44770 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261990AbSJEDZv>; Fri, 4 Oct 2002 23:25:51 -0400
Message-ID: <3D9E5D42.1060503@quark.didntduck.org>
Date: Fri, 04 Oct 2002 23:32:18 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] unistd.h cleanups
Content-Type: multipart/mixed;
 boundary="------------030606050904030805020409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030606050904030805020409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes the stubs for syscalls that are not used from the 
kernel anymore.

--
				Brian Gerst

--------------030606050904030805020409
Content-Type: text/plain;
 name="ksyscalls-1a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksyscalls-1a"

diff -urN linux-2.5.40-bk3/include/asm-alpha/unistd.h linux/include/asm-alpha/unistd.h
--- linux-2.5.40-bk3/include/asm-alpha/unistd.h	Sat Sep 28 04:05:08 2002
+++ linux/include/asm-alpha/unistd.h	Fri Oct  4 20:52:27 2002
@@ -533,12 +533,6 @@
 #include <linux/signal.h>
 #include <asm/ptrace.h>
 
-extern void sys_idle(void);
-static inline void idle(void)
-{
-	sys_idle();
-}
-
 extern long sys_open(const char *, int, int);
 static inline long open(const char * name, int mode, int flags)
 {
@@ -597,12 +591,6 @@
 	return sys_setsid();
 }
 
-extern long sys_sync(void);
-static inline long sync(void)
-{
-	return sys_sync();
-}
-
 struct rusage;
 extern asmlinkage long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 static inline pid_t waitpid(int pid, int * wait_stat, int flags)
@@ -610,17 +598,6 @@
 	return sys_wait4(pid, wait_stat, flags, NULL);
 }
 
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
-
-extern long sys_delete_module(const char *name);
-static inline long delete_module(const char *name)
-{
-	return sys_delete_module(name);
-}
-
 #endif
 
 /*
diff -urN linux-2.5.40-bk3/include/asm-arm/unistd.h linux/include/asm-arm/unistd.h
--- linux-2.5.40-bk3/include/asm-arm/unistd.h	Tue Oct  1 19:53:19 2002
+++ linux/include/asm-arm/unistd.h	Fri Oct  4 20:52:32 2002
@@ -403,24 +403,6 @@
 struct rusage;
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
-static inline long idle(void)
-{
-	extern long sys_idle(void);
-	return sys_idle();
-}
-
-static inline long pause(void)
-{
-	extern long sys_pause(void);
-	return sys_pause();
-}
-
-static inline long sync(void)
-{
-	extern long sys_sync(void);
-	return sys_sync();
-}
-
 static inline pid_t setsid(void)
 {
 	extern long sys_setsid(void);
@@ -474,17 +456,6 @@
 	return sys_wait4((int)pid, wait_stat, options, NULL);
 }
 
-static inline long delete_module(const char *name)
-{
-	extern long sys_delete_module(const char *name);
-	return sys_delete_module(name);
-}
-
-static inline pid_t wait(int * wait_stat)
-{
-	return sys_wait4(-1, wait_stat, 0, NULL);
-}
-
 /*
  * The following two can't be eliminated yet - they rely on
  * specific conditions.
diff -urN linux-2.5.40-bk3/include/asm-cris/unistd.h linux/include/asm-cris/unistd.h
--- linux-2.5.40-bk3/include/asm-cris/unistd.h	Sun Sep 15 22:18:26 2002
+++ linux/include/asm-cris/unistd.h	Fri Oct  4 21:03:40 2002
@@ -365,12 +365,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,idle)
-static inline _syscall0(int,fork)
-static inline _syscall2(int,clone,unsigned long,flags,char *,esp)
-static inline _syscall0(int,pause)
-static inline _syscall0(int,setup)
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall1(int,dup,int,fd)
@@ -384,14 +378,6 @@
   /* the following are just while developing the elinux port! */
 
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static inline _syscall2(int,socketcall,int,call,unsigned long *,args)
-static inline _syscall3(int,ioctl,unsigned int,fd,unsigned int,cmd,unsigned long,arg)
-static inline _syscall5(int,mount,const char *,a,const char *,b,const char *,c,unsigned long,rwflag,const void *,data)
-
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif
 
diff -urN linux-2.5.40-bk3/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.40-bk3/include/asm-i386/unistd.h	Sun Sep 15 22:18:39 2002
+++ linux/include/asm-i386/unistd.h	Fri Oct  4 20:52:41 2002
@@ -362,8 +362,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,pause)
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -374,12 +372,6 @@
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static inline _syscall1(int,delete_module,const char *,name)
-
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif
 
diff -urN linux-2.5.40-bk3/include/asm-ia64/unistd.h linux/include/asm-ia64/unistd.h
--- linux-2.5.40-bk3/include/asm-ia64/unistd.h	Mon Sep 23 09:00:33 2002
+++ linux/include/asm-ia64/unistd.h	Fri Oct  4 20:56:14 2002
@@ -309,7 +309,6 @@
 
 struct rusage;
 
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -319,7 +318,6 @@
 static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
 static inline _syscall1(int,close,int,fd)
 static inline _syscall4(pid_t,wait4,pid_t,pid,int *,wait_stat,int,options,struct rusage*, rusage)
-static inline _syscall1(int,delete_module,const char *,name)
 static inline _syscall2(pid_t,clone,unsigned long,flags,void*,sp);
 
 #define __NR__exit __NR_exit
@@ -331,12 +329,6 @@
 	return wait4(pid, wait_stat, flags, NULL);
 }
 
-static inline pid_t
-wait (int * wait_stat)
-{
-	return wait4(-1, wait_stat, 0, 0);
-}
-
 #endif /* __KERNEL_SYSCALLS__ */
 
 /*
diff -urN linux-2.5.40-bk3/include/asm-m68k/unistd.h linux/include/asm-m68k/unistd.h
--- linux-2.5.40-bk3/include/asm-m68k/unistd.h	Sun Sep 15 22:18:29 2002
+++ linux/include/asm-m68k/unistd.h	Fri Oct  4 20:52:52 2002
@@ -350,8 +350,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,pause)
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -362,12 +360,6 @@
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static inline _syscall1(int,delete_module,const char *,name)
-
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif
 
diff -urN linux-2.5.40-bk3/include/asm-mips/unistd.h linux/include/asm-mips/unistd.h
--- linux-2.5.40-bk3/include/asm-mips/unistd.h	Sun Sep 15 22:18:17 2002
+++ linux/include/asm-mips/unistd.h	Fri Oct  4 20:53:02 2002
@@ -467,7 +467,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -478,12 +477,6 @@
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static inline _syscall1(int,delete_module,const char *,name)
-
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif /* !defined (__KERNEL_SYSCALLS__) */
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
diff -urN linux-2.5.40-bk3/include/asm-mips64/unistd.h linux/include/asm-mips64/unistd.h
--- linux-2.5.40-bk3/include/asm-mips64/unistd.h	Sun Sep 15 22:18:24 2002
+++ linux/include/asm-mips64/unistd.h	Fri Oct  4 20:52:56 2002
@@ -793,7 +793,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -804,12 +803,6 @@
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static inline _syscall1(int,delete_module,const char *,name)
-
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif /* !defined (__KERNEL_SYSCALLS__) */
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
diff -urN linux-2.5.40-bk3/include/asm-parisc/unistd.h linux/include/asm-parisc/unistd.h
--- linux-2.5.40-bk3/include/asm-parisc/unistd.h	Sun Sep 15 22:18:16 2002
+++ linux/include/asm-parisc/unistd.h	Fri Oct  4 20:53:09 2002
@@ -806,24 +806,6 @@
 
 #ifdef __KERNEL_SYSCALLS__
 
-static inline int idle(void)
-{
-	extern int sys_idle(void);
-	return sys_idle();
-}
-
-static inline int pause(void)
-{
-	extern int sys_pause(void);
-	return sys_pause();
-}
-
-static inline int sync(void)
-{
-	extern int sys_sync(void);
-	return sys_sync();
-}
-
 static inline pid_t setsid(void)
 {
 	extern int sys_setsid(void);
@@ -877,18 +859,6 @@
 	return sys_wait4((int)pid, wait_stat, options, NULL);
 }
 
-static inline int delete_module(const char *name)
-{
-	extern int sys_delete_module(const char *name);
-	return sys_delete_module(name);
-}
-
-static inline pid_t wait(int * wait_stat)
-{
-	extern int sys_wait4(int, int *, int, struct rusage *);
-	return sys_wait4(-1, wait_stat, 0, NULL);
-}
-
 static inline int execve(char *filename, char * argv [],
 	char * envp[])
 {
diff -urN linux-2.5.40-bk3/include/asm-ppc/unistd.h linux/include/asm-ppc/unistd.h
--- linux-2.5.40-bk3/include/asm-ppc/unistd.h	Fri Sep 20 16:27:57 2002
+++ linux/include/asm-ppc/unistd.h	Fri Oct  4 20:53:51 2002
@@ -436,10 +436,6 @@
 extern int close(int fd);
 extern pid_t waitpid(pid_t pid, int *wait_stat, int options);
 
-static inline pid_t wait(int * wait_stat) 
-{
-	return waitpid(-1, wait_stat, 0);
-}
 #endif /* __KERNEL_SYSCALLS__ */
 
 /*
diff -urN linux-2.5.40-bk3/include/asm-ppc64/unistd.h linux/include/asm-ppc64/unistd.h
--- linux-2.5.40-bk3/include/asm-ppc64/unistd.h	Fri Sep 20 16:27:57 2002
+++ linux/include/asm-ppc64/unistd.h	Fri Oct  4 20:53:45 2002
@@ -431,8 +431,6 @@
  * System call prototypes.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,pause)
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -443,12 +441,6 @@
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static inline _syscall1(int,delete_module,const char *,name)
-
-static inline pid_t wait(int * wait_stat) 
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif /* __KERNEL_SYSCALLS__ */
 
diff -urN linux-2.5.40-bk3/include/asm-s390/unistd.h linux/include/asm-s390/unistd.h
--- linux-2.5.40-bk3/include/asm-s390/unistd.h	Sun Sep 15 22:19:09 2002
+++ linux/include/asm-s390/unistd.h	Fri Oct  4 20:53:57 2002
@@ -368,9 +368,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,idle)
-static inline _syscall0(int,pause)
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -380,7 +377,6 @@
 static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
-static inline _syscall1(int,delete_module,const char *,name)
 static inline _syscall2(long,stat,char *,filename,struct stat *,statbuf)
 
 struct rusage;
@@ -390,11 +386,6 @@
 	return sys_wait4(pid, wait_stat, flags, NULL);
 }
 
-static inline pid_t wait(int * wait_stat)
-{
-        return waitpid(-1,wait_stat,0);
-}
-
 #endif
 
 /*
diff -urN linux-2.5.40-bk3/include/asm-s390x/unistd.h linux/include/asm-s390x/unistd.h
--- linux-2.5.40-bk3/include/asm-s390x/unistd.h	Sun Sep 15 22:18:43 2002
+++ linux/include/asm-s390x/unistd.h	Fri Oct  4 20:54:02 2002
@@ -335,9 +335,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,idle)
-static inline _syscall0(int,pause)
-static inline _syscall0(int,sync)
 static inline _syscall0(pid_t,setsid)
 static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -347,7 +344,6 @@
 static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
 static inline _syscall1(int,close,int,fd)
 static inline _syscall1(int,_exit,int,exitcode)
-static inline _syscall1(int,delete_module,const char *,name)
 static inline _syscall2(long,stat,char *,filename,struct stat *,statbuf)
 
 struct rusage;
@@ -357,11 +353,6 @@
 	return sys_wait4(pid, wait_stat, flags, NULL);
 }
 
-static inline pid_t wait(int * wait_stat)
-{
-        return waitpid(-1,wait_stat,0);
-}
-
 #endif
 
 /*
diff -urN linux-2.5.40-bk3/include/asm-sh/unistd.h linux/include/asm-sh/unistd.h
--- linux-2.5.40-bk3/include/asm-sh/unistd.h	Sun Sep 15 22:18:50 2002
+++ linux/include/asm-sh/unistd.h	Fri Oct  4 20:54:07 2002
@@ -347,8 +347,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static __inline__ _syscall0(int,pause)
-static __inline__ _syscall0(int,sync)
 static __inline__ _syscall0(pid_t,setsid)
 static __inline__ _syscall3(int,write,int,fd,const char *,buf,off_t,count)
 static __inline__ _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -359,12 +357,7 @@
 static __inline__ _syscall1(int,close,int,fd)
 static __inline__ _syscall1(int,_exit,int,exitcode)
 static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static __inline__ _syscall1(int,delete_module,const char *,name)
 
-static __inline__ pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 #endif
 
 /*
diff -urN linux-2.5.40-bk3/include/asm-sparc/unistd.h linux/include/asm-sparc/unistd.h
--- linux-2.5.40-bk3/include/asm-sparc/unistd.h	Fri Sep 20 16:27:57 2002
+++ linux/include/asm-sparc/unistd.h	Fri Oct  4 20:54:16 2002
@@ -416,8 +416,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static __inline__ _syscall0(int,pause)
-static __inline__ _syscall0(int,sync)
 static __inline__ _syscall0(pid_t,setsid)
 static __inline__ _syscall3(int,write,int,fd,__const__ char *,buf,off_t,count)
 static __inline__ _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -428,12 +426,6 @@
 static __inline__ _syscall1(int,close,int,fd)
 static __inline__ _syscall1(int,_exit,int,exitcode)
 static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static __inline__ _syscall1(int,delete_module,const char *,name)
-
-static __inline__ pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif /* __KERNEL_SYSCALLS__ */
 
diff -urN linux-2.5.40-bk3/include/asm-sparc64/unistd.h linux/include/asm-sparc64/unistd.h
--- linux-2.5.40-bk3/include/asm-sparc64/unistd.h	Fri Sep 20 16:27:57 2002
+++ linux/include/asm-sparc64/unistd.h	Fri Oct  4 20:54:11 2002
@@ -406,8 +406,6 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-static __inline__ _syscall0(int,pause)
-static __inline__ _syscall0(int,sync)
 static __inline__ _syscall0(pid_t,setsid)
 static __inline__ _syscall3(int,write,int,fd,__const__ char *,buf,off_t,count)
 static __inline__ _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -418,12 +416,6 @@
 static __inline__ _syscall1(int,close,int,fd)
 static __inline__ _syscall1(int,_exit,int,exitcode)
 static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static __inline__ _syscall1(int,delete_module,const char *,name)
-
-static __inline__ pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif /* __KERNEL_SYSCALLS__ */
 
diff -urN linux-2.5.40-bk3/include/asm-um/unistd.h linux/include/asm-um/unistd.h
--- linux-2.5.40-bk3/include/asm-um/unistd.h	Sun Sep 15 22:18:50 2002
+++ linux/include/asm-um/unistd.h	Fri Oct  4 20:54:32 2002
@@ -61,11 +61,6 @@
 	KERNEL_CALL(pid_t, sys_wait4, pid, status, options, NULL)
 }
 
-static inline pid_t wait(int *status)
-{
-	KERNEL_CALL(pid_t, sys_wait4, -1, status, 0, NULL)
-}
-
 static inline pid_t setsid(void)
 {
 	KERNEL_CALL(pid_t, sys_setsid)
diff -urN linux-2.5.40-bk3/include/asm-x86_64/unistd.h linux/include/asm-x86_64/unistd.h
--- linux-2.5.40-bk3/include/asm-x86_64/unistd.h	Sun Sep 15 22:18:41 2002
+++ linux/include/asm-x86_64/unistd.h	Fri Oct  4 20:54:39 2002
@@ -573,18 +573,6 @@
  */
 #define __NR__exit __NR_exit
 
-extern long sys_pause(void);
-static inline long pause(void)
-{
-	return sys_pause();
-}
-
-extern long sys_sync(void);
-static inline long sync(void)
-{
-	return sys_sync();
-}
-
 extern pid_t sys_setsid(void);
 static inline pid_t setsid(void)
 {
@@ -636,12 +624,6 @@
 	sys_exit(error_code);
 }
 
-extern long sys_delete_module(const char *);
-static inline long delete_module(const char *name_user)
-{
-	return sys_delete_module(name_user);
-}
-
 struct rusage; 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, 
 			int options, struct rusage * ru);
@@ -650,11 +632,6 @@
 	return sys_wait4(pid, wait_stat, flags, NULL);
 }
 
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
-
 #endif /* __KERNEL_SYSCALLS__ */
 
 #endif /* __NO_STUBS */
diff -urN linux-2.5.40-bk3/init/do_mounts.c linux/init/do_mounts.c
--- linux-2.5.40-bk3/init/do_mounts.c	Fri Oct  4 13:42:36 2002
+++ linux/init/do_mounts.c	Fri Oct  4 20:51:37 2002
@@ -710,7 +710,7 @@
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != wait(&i))
+		while (pid != waitpid(-1, &i, 0))
 			yield();
 	}
 

--------------030606050904030805020409--

