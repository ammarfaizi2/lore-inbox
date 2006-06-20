Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWFTWZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWFTWZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWFTWZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:25:50 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:475 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751307AbWFTWZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:25:50 -0400
Message-Id: <200606202225.k5KMP3U5006871@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [-stable PATCH] UML - fix uptime
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Jun 2006 18:25:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this for 2.6.17-stable.  It made -mm briefly, but missed
2.6.17.  It fixes the value of uptime, which was broken by a patch late in
2.6.17-rc.

The use of unsigned instead of unsigned here broke the calculations on
negative numbers that are involved in calculating wall_to_monotonic.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/kernel/time_kern.c	2006-06-11 16:35:49.000000000 -0400
+++ linux-2.6.17-mm/arch/um/kernel/time_kern.c	2006-06-12 17:44:54.000000000 -0400
@@ -87,7 +87,7 @@ void timer_irq(union uml_pt_regs *regs)
 
 void time_init_kern(void)
 {
-	unsigned long long nsecs;
+	long long nsecs;
 
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,

