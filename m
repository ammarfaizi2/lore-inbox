Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWAPNYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWAPNYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWAPNYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:24:02 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:7108 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750746AbWAPNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:24:00 -0500
Subject: [PATCH 2/5] stack overflow safe kdump (2.6.15-i386) -
	use_safe_smp_processor_id
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ak@suse.de, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Mon, 16 Jan 2006 22:23:53 +0900
Message-Id: <1137417833.2256.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the reboot path to the second kernel.

---
diff -urNp linux-2.6.15/arch/i386/kernel/crash.c
linux-2.6.15-sov/arch/i386/kernel/crash.c
--- linux-2.6.15/arch/i386/kernel/crash.c	2006-01-03 12:21:10.000000000
+0900
+++ linux-2.6.15-sov/arch/i386/kernel/crash.c	2006-01-16
20:28:31.000000000 +0900
@@ -120,7 +120,7 @@ static void crash_save_self(struct pt_re
 	struct pt_regs regs;
 	int cpu;
 
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 	if (saved_regs)
 		crash_setup_regs(&regs, saved_regs);
 	else
@@ -211,7 +211,7 @@ void machine_crash_shutdown(struct pt_re
 	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
-	crashing_cpu = smp_processor_id();
+	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)


