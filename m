Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932398AbWFEDKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWFEDKp (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 23:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWFEDKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 23:10:44 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:48527 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932398AbWFEDKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 23:10:44 -0400
Date: Sun, 4 Jun 2006 23:07:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: print stack size in oops messages
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606042309_MC3-1-C19F-CFFE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always print stack size in oops messages.  By having this line
in every message, ugly newline logic can be removed as well.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/traps.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

--- 2.6.17-rc5-32.orig/arch/i386/kernel/traps.c
+++ 2.6.17-rc5-32/arch/i386/kernel/traps.c
@@ -362,30 +362,22 @@ void die(const char * str, struct pt_reg
 		local_save_flags(flags);
 
 	if (++die.lock_owner_depth < 3) {
-		int nl = 0;
 		unsigned long esp;
 		unsigned short ss;
 
 		handle_BUG(regs);
 		printk(KERN_EMERG "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
+		printk(KERN_EMERG "%dK_STACKS ", THREAD_SIZE / 1024);
 #ifdef CONFIG_PREEMPT
-		printk(KERN_EMERG "PREEMPT ");
-		nl = 1;
+		printk("PREEMPT ");
 #endif
 #ifdef CONFIG_SMP
-		if (!nl)
-			printk(KERN_EMERG);
 		printk("SMP ");
-		nl = 1;
 #endif
 #ifdef CONFIG_DEBUG_PAGEALLOC
-		if (!nl)
-			printk(KERN_EMERG);
 		printk("DEBUG_PAGEALLOC");
-		nl = 1;
 #endif
-		if (nl)
-			printk("\n");
+		printk("\n");
 		if (notify_die(DIE_OOPS, str, regs, err,
 					current->thread.trap_no, SIGSEGV) !=
 				NOTIFY_STOP) {
-- 
Chuck
