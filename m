Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264374AbUDVQUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUDVQUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbUDVQUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:20:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40918 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264383AbUDVQTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:19:06 -0400
Date: Thu, 22 Apr 2004 18:19:01 +0200 (MEST)
Message-Id: <200404221619.i3MGJ1eb014800@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.6.6-rc2] use smp_processor_id() in init_IRQ()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces current_thread_info()->cpu in
i386' init_IRQ() by the equivalent smp_processor_id().
Reduces overhead on UP, and makes the code cleaner.

/Mikael

--- linux-2.6.6-rc2/arch/i386/kernel/i8259.c.~1~	2004-04-22 12:33:48.000000000 +0200
+++ linux-2.6.6-rc2/arch/i386/kernel/i8259.c	2004-04-22 13:15:40.000000000 +0200
@@ -445,5 +445,5 @@
 	if (boot_cpu_data.hard_math && !cpu_has_fpu)
 		setup_irq(FPU_IRQ, &fpu_irq);
 
-	irq_ctx_init(current_thread_info()->cpu);
+	irq_ctx_init(smp_processor_id());
 }
