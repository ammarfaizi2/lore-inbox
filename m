Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWGQFxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGQFxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 01:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWGQFxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 01:53:06 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:59951 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S1751239AbWGQFxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 01:53:05 -0400
Date: Mon, 17 Jul 2006 14:52:51 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] changed to using CHECK_IRQ_PER_CPU
Message-Id: <20060717145251.0069d16e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has changed to using CHECK_IRQ_PER_CPU.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X 2.6.18-rc2/Documentation/dontdiff 2.6.18-rc2-orig/arch/powerpc/kernel/irq.c 2.6.18-rc2/arch/powerpc/kernel/irq.c
--- 2.6.18-rc2-orig/arch/powerpc/kernel/irq.c	2006-07-16 22:27:18.417697000 +0900
+++ 2.6.18-rc2/arch/powerpc/kernel/irq.c	2006-07-16 23:29:05.548305750 +0900
@@ -164,7 +164,7 @@ void fixup_irqs(cpumask_t map)
 	for_each_irq(irq) {
 		cpumask_t mask;
 
-		if (irq_desc[irq].status & IRQ_PER_CPU)
+		if (CHECK_IRQ_PER_CPU(irq_desc[irq].status))
 			continue;
 
 		cpus_and(mask, irq_desc[irq].affinity, map);
