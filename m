Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289074AbSBKNZe>; Mon, 11 Feb 2002 08:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSBKNZY>; Mon, 11 Feb 2002 08:25:24 -0500
Received: from zero.tech9.net ([209.61.188.187]:17167 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289074AbSBKNZU>;
	Mon, 11 Feb 2002 08:25:20 -0500
Subject: Re: 2.5.4 does not compile
From: Robert Love <rml@tech9.net>
To: Boszormenyi Zoltan <zboszor@mail.externet.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C67C48B.6010905@mail.externet.hu>
In-Reply-To: <3C67C48B.6010905@mail.externet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 08:25:13 -0500
Message-Id: <1013433914.6785.416.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 08:18, Boszormenyi Zoltan wrote:

> It's a freshly downloaded linux-2.5.4.tar.bz2. The usual make oldconfig 
> dep clean bzImage:

The attached patch by Andrew Morton will do the trick.

	Robert Love

--- linux-2.5.4/include/asm-i386/processor.h    Sun Feb 10 22:00:29 2002
+++ 25/include/asm-i386/processor.h     Sun Feb 10 22:21:53 2002
@@ -435,14 +435,7 @@ extern int kernel_thread(int (*fn)(void 
 /* Copy and release all segment info associated with a VM */
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
 extern void release_segments(struct mm_struct * mm);
-
-/*
- * Return saved PC of a blocked thread.
- */
-static inline unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-       return ((unsigned long *)tsk->thread->esp)[3];
-}
+extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)  (((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
--- linux-2.5.4/arch/i386/kernel/process.c      Sun Feb 10 22:00:28 2002
+++ 25/arch/i386/kernel/process.c       Sun Feb 10 22:26:35 2002
@@ -55,6 +55,14 @@ asmlinkage void ret_from_fork(void) __as
 int hlt_counter;
 
 /*
+ * Return saved PC of a blocked thread.
+ */
+unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+       return ((unsigned long *)tsk->thread.esp)[3];
+}
+
+/*
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);

