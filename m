Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319440AbSH3Fzf>; Fri, 30 Aug 2002 01:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319445AbSH3Fy1>; Fri, 30 Aug 2002 01:54:27 -0400
Received: from dp.samba.org ([66.70.73.150]:62142 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319444AbSH3FyY>;
	Fri, 30 Aug 2002 01:54:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: trivial@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: per_cpu data question 
In-reply-to: Your message of "Thu, 29 Aug 2002 18:24:31 +0530."
             <20020829182431.A4936@in.ibm.com> 
Date: Fri, 30 Aug 2002 11:59:20 +1000
Message-Id: <20020830005909.926812C224@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020829182431.A4936@in.ibm.com> you write:
> Hi Rusty,
> 
> I can't do this -
> 
>         struct rcu_data *rdata;
>         rdata = &get_cpu_var(rcu_data);
> 
> Has this been deliberately made illegal ?

No, I suck.  Lvalues continue to haunt me.  This works for me.

BTW, I prefer to have bug reports cc'd to linux-kernel, so the
results are archived.  Plus, public humiliation is good for the
soul.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.32/include/linux/percpu.h working-2.5.32-percpu/include/linux/percpu.h
--- linux-2.5.32/include/linux/percpu.h	2002-08-28 09:29:53.000000000 +1000
+++ working-2.5.32-percpu/include/linux/percpu.h	2002-08-30 11:50:46.000000000 +1000
@@ -3,7 +3,8 @@
 #include <linux/spinlock.h> /* For preempt_disable() */
 #include <asm/percpu.h>
 
-#define get_cpu_var(var) ({ preempt_disable(); __get_cpu_var(var); })
+/* Must be an lvalue. */
+#define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
 #endif /* __LINUX_PERCPU_H */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
