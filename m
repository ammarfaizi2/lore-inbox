Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVAEC0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVAEC0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAEC0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:26:34 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:28839 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262210AbVAECYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:24:43 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105022501.22297.18661.69457@localhost.localdomain>
In-Reply-To: <20050105022449.22297.54853.67329@localhost.localdomain>
References: <20050105022449.22297.54853.67329@localhost.localdomain>
Subject: [PATCH 2/3] sh64: remove cli()/sti() in arch/sh64/mach-cayman/irq.c
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:24:41 -0600
Date: Tue, 4 Jan 2005 20:24:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/sh64/mach-cayman/irq.c linux-2.6.10-mm1/arch/sh64/mach-cayman/irq.c
--- linux-2.6.10-mm1-original/arch/sh64/mach-cayman/irq.c	2004-12-24 16:35:40.000000000 -0500
+++ linux-2.6.10-mm1/arch/sh64/mach-cayman/irq.c	2005-01-04 21:07:39.756694978 -0500
@@ -64,11 +64,11 @@
 	irq -= START_EXT_IRQS;
 	reg = EPLD_MASK_BASE + ((irq / 8) << 2);
 	bit = 1<<(irq % 8);
-	save_and_cli(flags);
+	local_irq_save(flags);
 	mask = ctrl_inl(reg);
 	mask |= bit;
 	ctrl_outl(mask, reg);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 void disable_cayman_irq(unsigned int irq)
@@ -81,11 +81,11 @@
 	irq -= START_EXT_IRQS;
 	reg = EPLD_MASK_BASE + ((irq / 8) << 2);
 	bit = 1<<(irq % 8);
-	save_and_cli(flags);
+	local_irq_save(flags);
 	mask = ctrl_inl(reg);
 	mask &= ~bit;
 	ctrl_outl(mask, reg);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void ack_cayman_irq(unsigned int irq)
