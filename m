Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVK1SFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVK1SFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVK1SFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:05:48 -0500
Received: from 58x158x20x104.ap58.ftth.ucom.ne.jp ([58.158.20.104]:38325 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932153AbVK1SFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:05:24 -0500
Subject: [PATCH 3/4] stack overflow safe kdump (i386) - do_nmi
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Tue, 29 Nov 2005 03:00:57 +0900
Message-Id: <1133200858.2425.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

crash_nmi_callback is called right after a system crash which might have
caused by stack overflow, thus smp_processor_id should not be trusted.
Use the safe replacement safe_smp_processor_id.

---

diff -urNp linux-2.6.15-rc2/arch/i386/kernel/traps.c
linux-2.6.15-rc2-sov/arch/i386/kernel/traps.c
--- linux-2.6.15-rc2/arch/i386/kernel/traps.c	2005-11-29
01:46:34.000000000 +0900
+++ linux-2.6.15-rc2-sov/arch/i386/kernel/traps.c	2005-11-29
01:52:17.000000000 +0900
@@ -648,7 +648,7 @@ fastcall void do_nmi(struct pt_regs * re
 
 	nmi_enter();
 
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (!cpu_online(cpu)) {


