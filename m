Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUG1Kab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUG1Kab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUG1Kab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:30:31 -0400
Received: from everest.2mbit.com ([24.123.221.2]:40895 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266870AbUG1Ka2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:30:28 -0400
Message-ID: <41078007.5000802@greatcn.org>
Date: Wed, 28 Jul 2004 18:29:27 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jdike@karaya.com, akpm@osdl.org
CC: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Scan-Signature: ec6cedc14a2c94d5e7cc71388ad972a6
X-SA-Exim-Connect-IP: 218.24.189.120
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] [UM] remove a group of unused bh functions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.189.120 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jdike, akpm,

This patch removes a group of unused bh functions in um.
This 2.2 legacy code should be cleaned up.

    -- coywolf

Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>

 smp.c |   35 -----------------------------------
 1 files changed, 35 deletions(-)

diff -Nrup linux-2.6.8-rc2/arch/um/kernel/smp.c linux-2.6.8-rc2-cy/arch/um/kernel/smp.c
--- linux-2.6.8-rc2/arch/um/kernel/smp.c	2004-06-29 23:03:33.000000000 -0500
+++ linux-2.6.8-rc2-cy/arch/um/kernel/smp.c	2004-07-28 05:26:32.554146767 -0500
@@ -59,41 +59,6 @@ void smp_send_reschedule(int cpu)
 	num_reschedules_sent++;
 }
 
-static void show(char * str)
-{
-	int cpu = smp_processor_id();
-
-	printk(KERN_INFO "\n%s, CPU %d:\n", str, cpu);
-}
-	
-#define MAXCOUNT 100000000
-
-static inline void wait_on_bh(void)
-{
-	int count = MAXCOUNT;
-	do {
-		if (!--count) {
-			show("wait_on_bh");
-			count = ~0;
-		}
-		/* nothing .. wait for the other bh's to go away */
-	} while (atomic_read(&global_bh_count) != 0);
-}
-
-/*
- * This is called when we want to synchronize with
- * bottom half handlers. We need to wait until
- * no other CPU is executing any bottom half handler.
- *
- * Don't wait if we're already running in an interrupt
- * context or are inside a bh handler. 
- */
-void synchronize_bh(void)
-{
-	if (atomic_read(&global_bh_count) && !in_interrupt())
-		wait_on_bh();
-}
-
 void smp_send_stop(void)
 {
 	int i;



-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

