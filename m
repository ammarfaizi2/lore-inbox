Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319123AbSILHPR>; Thu, 12 Sep 2002 03:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319356AbSILHPR>; Thu, 12 Sep 2002 03:15:17 -0400
Received: from dp.samba.org ([66.70.73.150]:29112 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319123AbSILHPQ>;
	Thu, 12 Sep 2002 03:15:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] get_cpu_var must be an lvalue
Date: Thu, 12 Sep 2002 17:15:24 +1000
Message-Id: <20020912072006.F23DA2C0CC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Name: get_per_cpu lvalue fix
Author: Rusty Russell
Status: Trivial

D: get_cpu_var(var) should be an lvalue.  Spotted by Dipankar Sarma.

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
