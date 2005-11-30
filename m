Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVK3Hl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVK3Hl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 02:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVK3Hl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 02:41:29 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:12455 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1751115AbVK3Hl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 02:41:28 -0500
Subject: [PATCH 3/4] stack overflow safe kdump (	2.6.15-rc3-i386) - do_nmi
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 30 Nov 2005 16:36:57 +0900
Message-Id: <1133336217.2412.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

crash_nmi_callback is called right after a system crash which might have
caused by stack overflow, thus smp_processor_id should not be trusted.
Use the safe replacement safe_smp_processor_id.

---
diff -urNp linux-2.6.15-rc3/arch/i386/kernel/traps.c linux-2.6.15-rc3-sov/arch/i386/kernel/traps.c
--- linux-2.6.15-rc3/arch/i386/kernel/traps.c	2005-11-30 14:51:49.000000000 +0900
+++ linux-2.6.15-rc3-sov/arch/i386/kernel/traps.c	2005-11-30 14:55:57.000000000 +0900
@@ -648,7 +648,7 @@ fastcall void do_nmi(struct pt_regs * re
 
 	nmi_enter();
 
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (!cpu_online(cpu)) {


