Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319667AbSH3Vir>; Fri, 30 Aug 2002 17:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319687AbSH3Vid>; Fri, 30 Aug 2002 17:38:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319682AbSH3Ve4>; Fri, 30 Aug 2002 17:34:56 -0400
To: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.32-flags
Message-Id: <E17ktU1-00035J-00@flint.arm.linux.org.uk>
Date: Fri, 30 Aug 2002 22:39:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.32, but applies cleanly.

softirq uses "long" with local_irq_save().  Flags should be saved
into an unsigned long variable.

 kernel/softirq.c |    4 ++--
 1 files changed, 2 insertions, 2 deletions

diff -ur orig/kernel/softirq.c linux/kernel/softirq.c
--- orig/kernel/softirq.c	Fri Aug 30 14:53:34 2002
+++ linux/kernel/softirq.c	Thu Aug 29 17:22:33 2002
@@ -59,7 +59,7 @@
 asmlinkage void do_softirq()
 {
 	__u32 pending;
-	long flags;
+	unsigned long flags;
 	__u32 mask;
 	int cpu;
 
@@ -129,7 +129,7 @@
 
 void raise_softirq(unsigned int nr)
 {
-	long flags;
+	unsigned long flags;
 
 	local_irq_save(flags);
 	cpu_raise_softirq(smp_processor_id(), nr);
