Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWHJTnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWHJTnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWHJTh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:29 -0400
Received: from ns.suse.de ([195.135.220.2]:15761 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932658AbWHJThK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:10 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [111/145] x86_64: Move unwind_init earlier
Message-Id: <20060810193709.BD7D513C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:09 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Needed for use of the unwinder in lockdep, because lockdep runs really
early too.

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 init/main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -468,6 +468,7 @@ asmlinkage void __init start_kernel(void
 	 * Need to run as early as possible, to initialize the
 	 * lockdep hash:
 	 */
+	unwind_init();
 	lockdep_init();
 
 	local_irq_disable();
@@ -506,7 +507,6 @@ asmlinkage void __init start_kernel(void
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
-	unwind_init();
 	trap_init();
 	rcu_init();
 	init_IRQ();
