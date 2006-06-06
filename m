Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932077AbWFFDGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFFDGM (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 23:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWFFDGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 23:06:12 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:60119 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932077AbWFFDGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 23:06:11 -0400
Date: Mon, 5 Jun 2006 23:01:14 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: print NUMA in oops messages
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606052303_MC3-1-C1B2-7E2C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print "NUMA" in oops messages if it is configured, since it makes a big
difference now that NUMA-aware code is common in the kernel.  "SMP"
could be removed since all NUMA machines are SMP, but it's probably
better to be backwards-compatible.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Applies after previous patch that added stack size printout.

 arch/i386/kernel/traps.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

--- 2.6.17-rc5-32.orig/arch/i386/kernel/traps.c
+++ 2.6.17-rc5-32/arch/i386/kernel/traps.c
@@ -368,16 +368,21 @@ void die(const char * str, struct pt_reg
 		handle_BUG(regs);
 		printk(KERN_EMERG "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 		printk(KERN_EMERG "%dK_STACKS ", THREAD_SIZE / 1024);
+		printk(
 #ifdef CONFIG_PREEMPT
-		printk("PREEMPT ");
+			"PREEMPT "
 #endif
 #ifdef CONFIG_SMP
-		printk("SMP ");
+			"SMP "
+#endif
+#ifdef CONFIG_NUMA
+			"NUMA "
 #endif
 #ifdef CONFIG_DEBUG_PAGEALLOC
-		printk("DEBUG_PAGEALLOC");
+			"DEBUG_PAGEALLOC"
 #endif
-		printk("\n");
+			"\n");
+
 		if (notify_die(DIE_OOPS, str, regs, err,
 					current->thread.trap_no, SIGSEGV) !=
 				NOTIFY_STOP) {
-- 
Chuck
