Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWB1VEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWB1VEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWB1VEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:04:37 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:3261 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932589AbWB1VEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:04:36 -0500
Date: Tue, 28 Feb 2006 16:01:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: fix orphaned bits of timer init messages
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602281604_MC3-1-B984-EC14@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When x86_64 timer init messages were changed to use apic verbosity
levels, two messages were missed and one got the wrong level. This
causes the last word of a suppressed message to print on a line
by itself.  Fix that so either the entire message prints or none
of it does.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc5-64.orig/arch/x86_64/kernel/io_apic.c
+++ 2.6.16-rc5-64/arch/x86_64/kernel/io_apic.c
@@ -1848,7 +1848,7 @@ static inline void check_timer(void)
 		 */
 		setup_ExtINT_IRQ0_pin(apic2, pin2, vector);
 		if (timer_irq_works()) {
-			printk("works.\n");
+			apic_printk(APIC_VERBOSE," works.\n");
 			nmi_watchdog_default();
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
@@ -1860,7 +1860,7 @@ static inline void check_timer(void)
 		 */
 		clear_IO_APIC_pin(apic2, pin2);
 	}
-	printk(" failed.\n");
+	apic_printk(APIC_VERBOSE," failed.\n");
 
 	if (nmi_watchdog == NMI_IO_APIC) {
 		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
@@ -1875,7 +1875,7 @@ static inline void check_timer(void)
 	enable_8259A_irq(0);
 
 	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, " works.\n");
+		apic_printk(APIC_VERBOSE," works.\n");
 		return;
 	}
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
