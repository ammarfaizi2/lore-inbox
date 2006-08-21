Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751862AbWHULAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWHULAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWHULAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:00:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13319 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751865AbWHULAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:00:44 -0400
Date: Mon, 21 Aug 2006 13:00:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-v850/unistd.h: "extern inline" -> "static inline"
Message-ID: <20060821110044.GJ11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" generates a warning with -Wmissing-prototypes and I'm 
currently working on getting the kernel cleaned up for adding this to 
the CFLAGS since it will help us to avoid a nasty class of runtime 
errors.

If there are places that really need a forced inline, __always_inline 
would be the correct solution.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-v850/unistd.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.18-rc4-mm1/include/asm-v850/unistd.h.old	2006-08-13 23:30:20.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/asm-v850/unistd.h	2006-08-13 23:30:27.000000000 +0200
@@ -405,18 +405,18 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-extern inline _syscall0(pid_t,setsid)
-extern inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-extern inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-extern inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-extern inline _syscall1(int,dup,int,fd)
-extern inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-extern inline _syscall3(int,open,const char *,file,int,flag,int,mode)
-extern inline _syscall1(int,close,int,fd)
-extern inline _syscall1(int,_exit,int,exitcode)
-extern inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
+static inline _syscall0(pid_t,setsid)
+static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
+static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
+static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
+static inline _syscall1(int,dup,int,fd)
+static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
+static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
+static inline _syscall1(int,close,int,fd)
+static inline _syscall1(int,_exit,int,exitcode)
+static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 
-extern inline pid_t wait(int * wait_stat)
+static inline pid_t wait(int * wait_stat)
 {
 	return waitpid (-1, wait_stat, 0);
 }

