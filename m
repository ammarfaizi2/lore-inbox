Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVCEPq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVCEPq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVCEPht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:37:49 -0500
Received: from coderock.org ([193.77.147.115]:42147 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262008AbVCEPfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:41 -0500
Subject: [patch 06/12] i386/traps: replace schedule_timeout() with ssleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:25 +0100
Message-Id: <20050305153525.032C51EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please consider applying. 

Use ssleep() instead of schedule_timeout() to guarantee the task
delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/kernel/traps.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/i386/kernel/traps.c~ssleep-arch_i386_kernel_traps arch/i386/kernel/traps.c
--- kj/arch/i386/kernel/traps.c~ssleep-arch_i386_kernel_traps	2005-03-05 16:11:14.000000000 +0100
+++ kj-domen/arch/i386/kernel/traps.c	2005-03-05 16:11:14.000000000 +0100
@@ -345,8 +345,7 @@ void die(const char * str, struct pt_reg
 
 	if (panic_on_oops) {
 		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(5 * HZ);
+		ssleep(5);
 		panic("Fatal exception");
 	}
 	do_exit(SIGSEGV);
_
