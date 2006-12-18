Return-Path: <linux-kernel-owner+w=401wt.eu-S1753421AbWLRHP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbWLRHP6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbWLRHP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:15:58 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:40423 "EHLO
	liaag1ab.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421AbWLRHP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:15:57 -0500
Date: Mon, 18 Dec 2006 02:06:36 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: more ioapic checks
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200612180210_MC3-1-D56C-8B2C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity reports apic numbers are being passed to functions without
checking to see if they are legal.

(This is Kernel Bugzilla #6188.)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.20-rc1-32.orig/arch/i386/kernel/io_apic.c
+++ 2.6.20-rc1-32/arch/i386/kernel/io_apic.c
@@ -2265,13 +2265,17 @@ static inline void __init check_timer(vo
 				clear_IO_APIC_pin(0, pin1);
 			return;
 		}
-		clear_IO_APIC_pin(apic1, pin1);
+		if (apic1 == -1)
+			WARN_ON_ONCE(1);
+		else
+			clear_IO_APIC_pin(apic1, pin1);
+
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to "
 				"IO-APIC\n");
 	}
 
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
-	if (pin2 != -1) {
+	if (pin2 != -1 && apic2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);
 		/*
 		 * legacy devices should be connected to IO APIC #0
-- 
MBTI: IXTP
