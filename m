Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWE2Veq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWE2Veq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWE2VeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:34:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14803 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751359AbWE2V0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:10 -0400
Date: Mon, 29 May 2006 23:26:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 42/61] lock validator: special locking: kgdb
Message-ID: <20060529212630.GP3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive, non-ordered) locking code to the lock validator.
Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 kernel/kgdb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/kgdb.c
===================================================================
--- linux.orig/kernel/kgdb.c
+++ linux/kernel/kgdb.c
@@ -1539,7 +1539,7 @@ int kgdb_handle_exception(int ex_vector,
 
 	if (!debugger_step || !kgdb_contthread) {
 		for (i = 0; i < NR_CPUS; i++)
-			spin_unlock(&slavecpulocks[i]);
+			spin_unlock_non_nested(&slavecpulocks[i]);
 		/* Wait till all the processors have quit
 		 * from the debugger. */
 		for (i = 0; i < NR_CPUS; i++) {
@@ -1622,7 +1622,7 @@ static void __init kgdb_internal_init(vo
 
 	/* Initialize our spinlocks. */
 	for (i = 0; i < NR_CPUS; i++)
-		spin_lock_init(&slavecpulocks[i]);
+		spin_lock_init_static(&slavecpulocks[i]);
 
 	for (i = 0; i < MAX_BREAKPOINTS; i++)
 		kgdb_break[i].state = bp_none;
