Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVAEC3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVAEC3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVAEC1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:27:16 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:41909 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262205AbVAECYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:24:36 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105022455.22297.89801.95368@localhost.localdomain>
In-Reply-To: <20050105022449.22297.54853.67329@localhost.localdomain>
References: <20050105022449.22297.54853.67329@localhost.localdomain>
Subject: [PATCH 1/3] sh64: remove cli()/sti() in arch/sh64/kernel/time.c
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:24:35 -0600
Date: Tue, 4 Jan 2005 20:24:35 -0600
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
