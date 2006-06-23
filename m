Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWFWNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWFWNZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFWNZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:25:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:55488 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751488AbWFWNZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:25:36 -0400
Date: Fri, 23 Jun 2006 15:25:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/4] lock validator: fix compile warnings in lockdep.c
Message-ID: <20060623132506.GF9446@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix a few compile warnings on 64 bit machines:

kernel/lockdep.c: In function 'check_chain_key':
kernel/lockdep.c:1399:
 warning: format '%016Lx' expects type 'long long unsigned int',
 but argument 4 has type 'u64'
kernel/lockdep.c:1399:
 warning: format '%016Lx' expects type 'long long unsigned int',
 but argument 5 has type 'u64'
...

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 kernel/lockdep.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.17-mm1/kernel/lockdep.c
===================================================================
--- linux-2.6.17-mm1.orig/kernel/lockdep.c
+++ linux-2.6.17-mm1/kernel/lockdep.c
@@ -1395,8 +1395,9 @@ static void check_chain_key(struct task_
 		if (chain_key != hlock->prev_chain_key) {
 			debug_locks_off();
 			printk("hm#1, depth: %u [%u], %016Lx != %016Lx\n",
-				curr->lockdep_depth, i, chain_key,
-				hlock->prev_chain_key);
+				curr->lockdep_depth, i,
+				(unsigned long long)chain_key,
+				(unsigned long long)hlock->prev_chain_key);
 			WARN_ON(1);
 			return;
 		}
@@ -1411,8 +1412,9 @@ static void check_chain_key(struct task_
 	if (chain_key != curr->curr_chain_key) {
 		debug_locks_off();
 		printk("hm#2, depth: %u [%u], %016Lx != %016Lx\n",
-			curr->lockdep_depth, i, chain_key,
-			curr->curr_chain_key);
+			curr->lockdep_depth, i,
+			(unsigned long long)chain_key,
+			(unsigned long long)curr->curr_chain_key);
 		WARN_ON(1);
 	}
 #endif
