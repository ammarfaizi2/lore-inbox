Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWGJHvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWGJHvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGJHvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:51:21 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:59369 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751284AbWGJHvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:51:20 -0400
Subject: [PATCH 2/3] stack overflow safe kdump (2.6.18-rc1-i386) -
	crash_use_safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Mon, 10 Jul 2006 16:51:11 +0900
Message-Id: <1152517871.2120.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the reboot path to the second kernel.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc1/arch/i386/kernel/crash.c linux-2.6.18-rc1-sof/arch/i386/kernel/crash.c
--- linux-2.6.18-rc1/arch/i386/kernel/crash.c	2006-07-10 10:59:58.000000000 +0900
+++ linux-2.6.18-rc1-sof/arch/i386/kernel/crash.c	2006-07-10 16:06:55.000000000 +0900
@@ -86,7 +86,7 @@ static void crash_save_self(struct pt_re
 {
 	int cpu;
 
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 	crash_save_this_cpu(regs, cpu);
 }
 
@@ -169,7 +169,7 @@ void machine_crash_shutdown(struct pt_re
 	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
-	crashing_cpu = smp_processor_id();
+	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)


