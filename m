Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVAECXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVAECXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAECXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:23:14 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:5522 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262204AbVAECW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:22:57 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105022313.22296.30405.46556@localhost.localdomain>
In-Reply-To: <20050105022304.22296.7672.51691@localhost.localdomain>
References: <20050105022304.22296.7672.51691@localhost.localdomain>
Subject: [PATCH /3] sh64: remove cli()/sti() in arch/sh64/kernel/time.c
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:22:53 -0600
Date: Tue, 4 Jan 2005 20:22:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/sh64/kernel/time.c linux-2.6.10-mm1/arch/sh64/kernel/time.c
--- linux-2.6.10-mm1-original/arch/sh64/kernel/time.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-mm1/arch/sh64/kernel/time.c	2005-01-04 21:06:31.232945929 -0500
@@ -424,7 +424,7 @@
 	*/
 	register unsigned long long  __rtc_irq_flag __asm__ ("r3");
 
-	sti();
+	local_irq_enable();
 	do {} while (ctrl_inb(R64CNT) != 0);
 	ctrl_outb(RCR1_CIE, RCR1); /* Enable carry interrupt */
 
@@ -443,7 +443,7 @@
 		     "getcon	" __CTC ", %0\n\t"
 		: "=r"(ctc_val), "=r" (__dummy), "=r" (__rtc_irq_flag)
 		: "0" (0));
-	cli();
+	local_irq_disable();
 	/*
 	 * SH-3:
 	 * CPU clock = 4 stages * loop
