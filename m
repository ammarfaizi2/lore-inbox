Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVDLTwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVDLTwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVDLTvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:51:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:49096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262167AbVDLKbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:52 -0400
Message-Id: <200504121031.j3CAVmaW005411@shell0.pdx.osdl.net>
Subject: [patch 071/198] x86_64 show_stack(): call touch_nmi_watchdog
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I had strange NMI watchdog timeouts running sysrq-T across 9600-baud serial.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/traps.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/x86_64/kernel/traps.c~x86_64-show_stack-touch_nmi_watchdog arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~x86_64-show_stack-touch_nmi_watchdog	2005-04-12 03:21:20.429031216 -0700
+++ 25-akpm/arch/x86_64/kernel/traps.c	2005-04-12 03:21:20.433030608 -0700
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/nmi.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -243,6 +244,7 @@ void show_stack(struct task_struct *tsk,
 		if (i && ((i % 4) == 0))
 			printk("\n       ");
 		printk("%016lx ", *stack++);
+		touch_nmi_watchdog();
 	}
 	show_trace((unsigned long *)rsp);
 }
_
