Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUGLK4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUGLK4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266794AbUGLK4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:56:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:21911 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266791AbUGLKzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:55:45 -0400
Date: Mon, 12 Jul 2004 12:55:31 +0200 (MEST)
Message-Id: <200407121055.i6CAtVSN003773@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH][2.6.8-rc1] ppc32 open_pic.c cpumask_t conversion
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.8-rc1 triggers a warning in ppc's open_pic.c:

arch/ppc/syslib/open_pic.c:103: warning: initialization from incompatible pointer type

This is due to incomplete conversion from ulong to cpumask_t.

Patch below. Given the u32 nature of physmask(), this should suffice.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.8-rc1/arch/ppc/syslib/open_pic.c.~1~	2004-07-12 01:00:37.000000000 +0200
+++ linux-2.6.8-rc1/arch/ppc/syslib/open_pic.c	2004-07-12 11:47:20.948418000 +0200
@@ -89,7 +89,7 @@
  */
 static void openpic_end_irq(unsigned int irq_nr);
 static void openpic_ack_irq(unsigned int irq_nr);
-static void openpic_set_affinity(unsigned int irq_nr, unsigned long cpumask);
+static void openpic_set_affinity(unsigned int irq_nr, cpumask_t cpumask);
 
 struct hw_interrupt_type open_pic = {
 	" OpenPIC  ",
@@ -820,9 +820,9 @@
 #endif
 }
 
-static void openpic_set_affinity(unsigned int irq_nr, unsigned long cpumask)
+static void openpic_set_affinity(unsigned int irq_nr, cpumask_t cpumask)
 {
-	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpumask), 0);
+	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_addr(cpumask)[0]), 0);
 }
 
 #ifdef CONFIG_SMP
