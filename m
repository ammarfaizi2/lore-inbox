Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291374AbSBMFJb>; Wed, 13 Feb 2002 00:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291378AbSBMFJV>; Wed, 13 Feb 2002 00:09:21 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:51701 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291374AbSBMFJI>; Wed, 13 Feb 2002 00:09:08 -0500
Message-ID: <3C69F4F3.8080208@linuxhq.com>
Date: Wed, 13 Feb 2002 00:09:07 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.5.4: "control reaches end of non-void functionm"
In-Reply-To: <fa.l69quuv.1ljio8r@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Kieu wrote:
> Hi,
> 
> It seems nobody having this problem? No one replies at
> least why, so I just want to add one more case of
> compiling error. Exactly the same message as yours.
> 

Folks on LKML are pretty good about replying to people with problems, so 
whenever my posts are ignored here I start checking the archives 
(figuring that my problem has probably already been reported and dealt 
with).  :)


diff -Nru linux-2.5.4 25
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
  #define KSTK_EIP(tsk)  (((unsigned long *)(4096+(unsigned 
long)(tsk)->thread_in
fo))[1019])
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



-- 
(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

