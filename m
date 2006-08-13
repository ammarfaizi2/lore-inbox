Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWHMOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWHMOIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWHMOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 10:08:48 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:21194 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751260AbWHMOIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 10:08:47 -0400
Date: Sun, 13 Aug 2006 23:10:25 +0900 (JST)
Message-Id: <20060813.231025.25477781.anemo@mba.ocn.ne.jp>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hskinnemoen@atmel.com
Subject: [PATCH -mm] avr32: missing conversion of do_timer() argument
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch could be folded into
simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
in 2.6.18-rc4-mm1.


do_timer() take "ticks" argument instead of "regs".

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

--- linux-2.6.18-rc4-mm1.org/arch/avr32/kernel/time.c	2006-08-13 22:59:22.400023000 +0900
+++ linux-2.6.18-rc4-mm1/arch/avr32/kernel/time.c	2006-08-13 23:01:02.415818456 +0900
@@ -148,7 +148,7 @@ timer_interrupt(int irq, void *dev_id, s
 	 * Call the generic timer interrupt handler
 	 */
 	write_seqlock(&xtime_lock);
-	do_timer(regs);
+	do_timer(1);
 	write_sequnlock(&xtime_lock);
 
 	/*
