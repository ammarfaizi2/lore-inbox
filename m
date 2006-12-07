Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031888AbWLGJdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031888AbWLGJdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031889AbWLGJdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:33:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49492 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031888AbWLGJdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:33:13 -0500
Date: Thu, 7 Dec 2006 10:32:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] lockdep: use chain hash on CONFIG_DEBUG_LOCKDEP too
Message-ID: <20061207093221.GA1940@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: use chain hash on CONFIG_DEBUG_LOCKDEP too
From: Ingo Molnar <mingo@elte.hu>

CONFIG_DEBUG_LOCKDEP is unacceptably slow because it does not utilize 
the chain-hash. Turn the chain-hash back on in this case too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1278,14 +1278,6 @@ static inline int lookup_chain_cache(u64
 		if (chain->chain_key == chain_key) {
 cache_hit:
 			debug_atomic_inc(&chain_lookup_hits);
-			/*
-			 * In the debugging case, force redundant checking
-			 * by returning 1:
-			 */
-#ifdef CONFIG_DEBUG_LOCKDEP
-			__raw_spin_lock(&hash_lock);
-			return 1;
-#endif
 			if (very_verbose(class))
 				printk("\nhash chain already cached, key: %016Lx tail class: [%p] %s\n", chain_key, class->key, class->name);
 			return 0;
