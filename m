Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVAEBXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVAEBXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVAEBTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:19:31 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:23780 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262208AbVAEBKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:10:36 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linux-sh@m17n.org
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105011053.22124.23492.17036@localhost.localdomain>
Subject: [PATCH] sh: remove cli()/sti() in arch/sh/boards/mpc1211/setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 19:10:33 -0600
Date: Tue, 4 Jan 2005 19:10:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/sh/boards/mpc1211/setup.c linux-2.6.10-mm1/arch/sh/boards/mpc1211/setup.c
--- linux-2.6.10-mm1-original/arch/sh/boards/mpc1211/setup.c	2004-12-24 16:34:01.000000000 -0500
+++ linux-2.6.10-mm1/arch/sh/boards/mpc1211/setup.c	2005-01-04 20:06:16.543941867 -0500
@@ -83,7 +83,7 @@
 {
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	if( irq < 8) {
 		m_irq_mask |= (1 << irq);
 		outb(m_irq_mask,I8259_M_MR);
@@ -91,7 +91,7 @@
 		s_irq_mask |= (1 << (irq - 8));
 		outb(s_irq_mask,I8259_S_MR);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 }
 
@@ -99,7 +99,7 @@
 {
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	if( irq < 8) {
 		m_irq_mask &= ~(1 << irq);
@@ -108,7 +108,7 @@
 		s_irq_mask &= ~(1 << (irq - 8));
 		outb(s_irq_mask,I8259_S_MR);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static inline int mpc1211_irq_real(unsigned int irq)
@@ -134,7 +134,7 @@
 {
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	if(irq < 8) {
 		if(m_irq_mask & (1<<irq)){
@@ -163,7 +163,7 @@
 		outb(0x60+(irq-8),I8259_S_CR); 	/* EOI */
 		outb(0x60+2,I8259_M_CR);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void end_mpc1211_irq(unsigned int irq)
