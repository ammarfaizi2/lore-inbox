Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWJIXCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWJIXCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWJIXCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 19:02:00 -0400
Received: from deeprooted.net ([216.254.16.51]:36552 "EHLO paris.hilman.org")
	by vger.kernel.org with ESMTP id S1751914AbWJIXB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 19:01:59 -0400
Message-Id: <20061009230146.234622000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 09 Oct 2006 16:01:46 -0700
From: Kevin Hilman <khilman@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rt5 1/1] ARM: Use IRQF_NODELAY for XScale oprofile interrupt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert XScale performance monitor unit (PMU) interrupt used by
oprofile to IRQF_NODELAY.  PMU results not useful if ISR is run as
thread.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: dev/arch/arm/oprofile/op_model_xscale.c
===================================================================
--- dev.orig/arch/arm/oprofile/op_model_xscale.c
+++ dev/arch/arm/oprofile/op_model_xscale.c
@@ -383,8 +383,9 @@ static int xscale_pmu_start(void)
 {
 	int ret;
 	u32 pmnc = read_pmnc();
+	int irq_flags = IRQF_DISABLED | IRQF_NODELAY;
 
-	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, IRQF_DISABLED,
+	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, irq_flags,
 			"XScale PMU", (void *)results);
 
 	if (ret < 0) {
--
