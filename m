Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVAOVnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVAOVnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVAOVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:42:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21521 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262332AbVAOVkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:40:12 -0500
Date: Sat, 15 Jan 2005 22:40:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Hariprasad Nellitheertha <hari@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: [-mm patch] i386 crash_dump: make a function static (fwd)
Message-ID: <20050115214008.GW4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 1 Dec 2004 22:39:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] i386 crash_dump: make a function static

The patch below makes a needlessly global function static.


diffstat output:
 arch/i386/kernel/crash_dump.c |   13 ++++++-------
 include/asm-i386/crash_dump.h |    1 -
 2 files changed, 6 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/asm-i386/crash_dump.h.old	2004-12-01 07:53:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/crash_dump.h	2004-12-01 07:53:26.000000000 +0100
@@ -13,7 +13,6 @@
 
 extern struct pt_regs crash_smp_regs[NR_CPUS];
 extern long crash_smp_current_task[NR_CPUS];
-extern void crash_dump_save_this_cpu(struct pt_regs *, int);
 extern void __crash_dump_stop_cpus(void);
 extern void crash_get_current_regs(struct pt_regs *regs);
 
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/crash_dump.c.old	2004-12-01 07:53:36.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/crash_dump.c	2004-12-01 08:06:40.000000000 +0100
@@ -28,6 +28,12 @@
 extern void crash_dump_send_ipi(void);
 extern void stop_this_cpu(void *);
 
+static void crash_dump_save_this_cpu(struct pt_regs *regs, int cpu)
+{
+	crash_smp_current_task[cpu] = (long)current;
+	crash_smp_regs[cpu] = *regs;
+}
+
 static int crash_dump_nmi_callback(struct pt_regs *regs, int cpu)
 {
 	if (!crash_dump_expect_ipi[cpu])
@@ -96,10 +102,3 @@
 
 	regs->eip = (unsigned long)current_text_addr();
 }
-
-void crash_dump_save_this_cpu(struct pt_regs *regs, int cpu)
-{
-	crash_smp_current_task[cpu] = (long)current;
-	crash_smp_regs[cpu] = *regs;
-}
-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

