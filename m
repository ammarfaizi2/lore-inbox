Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVK1SFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVK1SFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVK1SFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:05:10 -0500
Received: from 58x158x20x104.ap58.ftth.ucom.ne.jp ([58.158.20.104]:37557 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932153AbVK1SFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:05:08 -0500
Subject: [PATCH 2/4] stack overflow safe kdump (i386) - crash
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Tue, 29 Nov 2005 03:00:42 +0900
Message-Id: <1133200842.2425.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace smp_processor_id with the stack overflow safe
safe_smp_processor_id in the reboot patch to the crash capture kernel.

---

diff -urNp linux-2.6.15-rc2/arch/i386/kernel/crash.c
linux-2.6.15-rc2-sov/arch/i386/kernel/crash.c
--- linux-2.6.15-rc2/arch/i386/kernel/crash.c	2005-10-28
09:02:08.000000000 +0900
+++ linux-2.6.15-rc2-sov/arch/i386/kernel/crash.c	2005-11-29
01:56:13.000000000 +0900
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


