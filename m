Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289917AbSBOQMK>; Fri, 15 Feb 2002 11:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSBOQMA>; Fri, 15 Feb 2002 11:12:00 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:43552 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S289917AbSBOQLr>; Fri, 15 Feb 2002 11:11:47 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F0C@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'davem@redhat.com'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: MAX_RT_PRIO in 2.5.5pre1 (Was:  build problem on Sparc64)
Date: Fri, 15 Feb 2002 11:11:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see that the #define for MAX_RT_PRIO was moved from:
/include/linux/sched.h
To:
/kernel/sched.c

This caused the build to fail on Sparc64, and maybe others, because of what
looks to be an unfinished function define in /asm/mmu_context.h.  I am not
sure what the function is supposed to be defined at all, as it looks to be
unfinished.  To get the build further along, I commented the unfinished one
out.  Not sure if this is the correct way to go, but I don't see it as doing
anything effective with it in.  I included a diff for you against 2.5.4, if
you want it. 

Thanks,
Bruce H.

diff -Nru ../linux-2.5.4/include/asm-sparc64/mmu_context.h
./include/asm-sparc64/mmu_context.h                        
--- ../linux-2.5.4/include/asm-sparc64/mmu_context.h    Thu Feb 14 14:28:10
2002
 

+++ ./include/asm-sparc64/mmu_context.h Fri Feb 15 10:59:45 2002

@@ -28,14 +28,18 @@

 #include <asm/spitfire.h>

 

 /*

+ * ??? Does This Belong Here?  Build failed after Define for MAX_RT_PRIO

+ * was moved from /kernel/sched.h to /kernel/sched.c

+ *

  * Every architecture must define this function. It's the fastest

  * way of searching a 168-bit bitmap where the first 128 bits are

  * unlikely to be set. It's guaranteed that at least one of the 168

  * bits is cleared.

+ *

+ * #if MAX_RT_PRIO != 128 || MAX_PRIO != 168

+ * # error update this function.

+ * #endif

  */

-#if MAX_RT_PRIO != 128 || MAX_PRIO != 168

-# error update this function.

-#endif

 

 static inline int sched_find_first_bit(unsigned long *b)

 {

