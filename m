Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVGFCTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVGFCTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVGFCTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:19:34 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:59032 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262039AbVGFCTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:14 -0400
Subject: [PATCH] [8/48] Suspend2 2.1.9.8 for 2.6.12: 353-disable-highmem-tlb-flush-for-copyback.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <1120616440826@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch-old/arch/i386/kernel/cpu/mcheck/non-fatal.c 354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch-new/arch/i386/kernel/cpu/mcheck/non-fatal.c
--- 354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch-old/arch/i386/kernel/cpu/mcheck/non-fatal.c	2004-12-10 14:26:18.000000000 +1100
+++ 354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch-new/arch/i386/kernel/cpu/mcheck/non-fatal.c	2005-07-04 23:14:20.000000000 +1000
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -58,7 +59,8 @@ static DECLARE_WORK(mce_work, mce_work_f
 
 static void mce_work_fn(void *data)
 { 
-	on_each_cpu(mce_checkregs, NULL, 1, 1);
+	if (!test_suspend_state(SUSPEND_RUNNING))
+		on_each_cpu(mce_checkregs, NULL, 1, 1);
 	schedule_delayed_work(&mce_work, MCE_RATE);
 } 
 

