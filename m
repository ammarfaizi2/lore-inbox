Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSBJXXw>; Sun, 10 Feb 2002 18:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSBJXXm>; Sun, 10 Feb 2002 18:23:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:21515 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284987AbSBJXXa>;
	Sun, 10 Feb 2002 18:23:30 -0500
Subject: Re: 2.5.4-pre6 fails to build on UP (sched.c)
From: Robert Love <rml@tech9.net>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C66F7C4.D559680D@oracle.com>
In-Reply-To: <3C66F7C4.D559680D@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 10 Feb 2002 18:23:27 -0500
Message-Id: <1013383408.6783.369.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-02-10 at 17:44, Alessandro Suardi wrote:

> It appears that global_irq_holder will only be seen from
>  <asm/hardirq.h> if CONFIG_SMP is defined. I haven't dug
>  deeper to see whether this is due to CONFIG_PREEMPT (to
>  which I said 'Y') or not.

Indeed, there is a compile error if preemption is enabled but SMP is
not.  I apologize.  Fix is attached.

	Robert Love

diff -urN linux-2.5.4-pre6/include/asm-i386/smplock.h linux/include/asm-i386/smplock.h
--- linux-2.5.4-pre6/include/asm-i386/smplock.h	Sun Feb 10 15:35:55 2002
+++ linux/include/asm-i386/smplock.h	Sun Feb 10 18:15:55 2002
@@ -15,6 +15,7 @@
 #else
 #ifdef CONFIG_PREEMPT
 #define kernel_locked()		preempt_get_count()
+#define global_irq_holder	0
 #else
 #define kernel_locked()		1
 #endif

