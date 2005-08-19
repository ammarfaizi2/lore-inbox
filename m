Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932753AbVHSXib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbVHSXib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbVHSXib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:38:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8979 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932753AbVHSXia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:38:30 -0400
Date: Sat, 20 Aug 2005 01:38:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] remove the second arg of do_timer_interrupt()
Message-ID: <20050819233828.GC3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second arg of do_timer_interrupt() is not used in the functions, and 
all callers pass NULL.

Is there any reason not to remove it?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/time.c |    5 ++---
 arch/sh/kernel/time.c   |    4 ++--
 arch/sh64/kernel/time.c |    4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.13-rc6-mm1-full/arch/i386/kernel/time.c.old	2005-08-20 00:10:36.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/i386/kernel/time.c	2005-08-20 00:11:02.000000000 +0200
@@ -252,8 +252,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id,
-					struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -307,7 +306,7 @@
 
 	cur_timer->mark_offset();
  
-	do_timer_interrupt(irq, NULL, regs);
+	do_timer_interrupt(irq, regs);
 
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
--- linux-2.6.13-rc6-mm1-full/arch/sh/kernel/time.c.old	2005-08-20 00:11:21.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/sh/kernel/time.c	2005-08-20 00:11:35.000000000 +0200
@@ -234,7 +234,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
 {
 	do_timer(regs);
 #ifndef CONFIG_SMP
@@ -285,7 +285,7 @@
 	 * locally disabled. -arca
 	 */
 	write_seqlock(&xtime_lock);
-	do_timer_interrupt(irq, NULL, regs);
+	do_timer_interrupt(irq, regs);
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
--- linux-2.6.13-rc6-mm1-full/arch/sh64/kernel/time.c.old	2005-08-20 00:11:49.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/sh64/kernel/time.c	2005-08-20 00:12:00.000000000 +0200
@@ -303,7 +303,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
 {
 	unsigned long long current_ctc;
 	asm ("getcon cr62, %0" : "=r" (current_ctc));
@@ -361,7 +361,7 @@
 	 * locally disabled. -arca
 	 */
 	write_lock(&xtime_lock);
-	do_timer_interrupt(irq, NULL, regs);
+	do_timer_interrupt(irq, regs);
 	write_unlock(&xtime_lock);
 
 	return IRQ_HANDLED;

