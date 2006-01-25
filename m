Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWAYGwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWAYGwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWAYGwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:52:19 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:45471 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750702AbWAYGwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:52:18 -0500
Subject: [PATCH 2/5] stack overflow safe kdump (2.6.16-rc1-i386) -
	use_safe_smp_processor_id
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, ak@suse.de, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 25 Jan 2006 15:52:16 +0900
Message-Id: <1138171936.2370.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the reboot path to the second kernel.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.16-rc1/arch/i386/kernel/crash.c linux-2.6.16-rc1-sov/arch/i386/kernel/crash.c
--- linux-2.6.16-rc1/arch/i386/kernel/crash.c	2006-01-25 14:28:30.000000000 +0900
+++ linux-2.6.16-rc1-sov/arch/i386/kernel/crash.c	2006-01-25 14:35:32.000000000 +0900
@@ -86,7 +86,7 @@ static void crash_save_self(struct pt_re
 {
 	int cpu;
 
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 	crash_save_this_cpu(regs, cpu);
 }
 
@@ -173,7 +173,7 @@ void machine_crash_shutdown(struct pt_re
 	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
-	crashing_cpu = smp_processor_id();
+	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)


