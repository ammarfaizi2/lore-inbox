Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVGNWDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVGNWDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNWBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:01:07 -0400
Received: from coderock.org ([193.77.147.115]:13985 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263149AbVGNVoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:44:30 -0400
Message-Id: <20050714214407.974952000@homer>
Date: Thu, 14 Jul 2005 23:44:03 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 5/5] i386/smpboot: use msleep() instead of schedule_timeout()
Content-Disposition: inline; filename=msleep-arch_i386_kernel_smpboot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>


From: Nishanth Aravamudan <nacc@us.ibm.com>

Replace schedule_timeout() with msleep() to guarantee the
task delays as expected.

Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 smpboot.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt/arch/i386/kernel/smpboot.c
===================================================================
--- quilt.orig/arch/i386/kernel/smpboot.c
+++ quilt/arch/i386/kernel/smpboot.c
@@ -1327,8 +1327,7 @@ void __cpu_die(unsigned int cpu)
 			printk ("CPU %d is now offline\n", cpu);
 			return;
 		}
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(HZ/10);
+		msleep(100);
 	}
  	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
 }

--
