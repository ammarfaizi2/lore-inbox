Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSDOSru>; Mon, 15 Apr 2002 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313166AbSDOSrt>; Mon, 15 Apr 2002 14:47:49 -0400
Received: from zero.tech9.net ([209.61.188.187]:27920 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313165AbSDOSrt>;
	Mon, 15 Apr 2002 14:47:49 -0400
Subject: [PATCH] Re: Kernel 2.5.8 on Alpha
From: Robert Love <rml@tech9.net>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: axp-kernel-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <000001c1e3f7$86214880$1201a8c0@pitzeier.priv.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 14:47:42 -0400
Message-Id: <1018896466.857.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-04-14 at 17:01, Oliver Pitzeier wrote:
> I tried to compile kernel 2.5.8 on an Alpha. I just wanted to try it...
> This happens:
> <snip>
> sched.c: In function `schedule':
> sched.c:771: `PREEMPT_ACTIVE' undeclared (first use in this function)

2.5.8-pre2 uses PREEMPT_ACTIVE directly in entry.S and thus moved the
definition of PREEMPT_ACTIVE into include/asm/thread_info.h from
include/linux/sched.h, presumably because including sched.h in entry.S
would not be pretty.

Each arch thus needs to define PREEMPT_ACTIVE ... patch applied.

	Robert Love

diff -urN linux-2.5.8/include/asm-alpha/thread_info.h linux/include/asm-alpha/thread_info.h
--- linux-2.5.8/include/asm-alpha/thread_info.h	Sun Apr 14 15:18:56 2002
+++ linux/include/asm-alpha/thread_info.h	Mon Apr 15 14:32:50 2002
@@ -53,6 +53,8 @@
 
 #endif /* __ASSEMBLY__ */
 
+#define PREEMPT_ACTIVE		0x4000000
+
 /*
  * Thread information flags:
  * - these are process state flags and used from assembly


