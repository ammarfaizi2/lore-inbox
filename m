Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVF0EfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVF0EfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVF0EfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:35:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:36996 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261820AbVF0Eer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:34:47 -0400
Subject: [PATCH] ppc64: Add missing exports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 14:29:56 +1000
Message-Id: <1119846596.5133.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds a couple of missing symbol exports. flush_dcache_page is
used by the AGP driver and rtc_lock by the RTC driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-work/arch/ppc64/kernel/time.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/time.c	2005-06-27 12:08:53.000000000 +1000
+++ linux-work/arch/ppc64/kernel/time.c	2005-06-27 14:31:13.000000000 +1000
@@ -91,7 +91,8 @@
 unsigned      tb_to_us;
 unsigned long processor_freq;
 DEFINE_SPINLOCK(rtc_lock);
-
+EXPORT_SYMBOL_GPL(rtc_lock);
+ 
 unsigned long tb_to_ns_scale;
 unsigned long tb_to_ns_shift;
 
Index: linux-work/arch/ppc64/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/ppc_ksyms.c	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc64/kernel/ppc_ksyms.c	2005-06-27 14:31:30.000000000 +1000
@@ -75,6 +75,7 @@
 EXPORT_SYMBOL(giveup_altivec);
 #endif
 EXPORT_SYMBOL(__flush_icache_range);
+EXPORT_SYMBOL(flush_dcache_range);
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PPC_ISERIES



