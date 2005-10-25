Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVJYWLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVJYWLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVJYWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:11:22 -0400
Received: from [151.97.230.9] ([151.97.230.9]:44216 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932437AbVJYWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:11:18 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel EM64T [for 2.6.14?]
Date: Wed, 26 Oct 2005 00:12:54 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025221253.21106.22572.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current value was correct before the introduction of Intel EM64T support -
but now L1_CACHE_SHIFT_MAX can be less than L1_CACHE_SHIFT, which _is_ funny!

Between the few users of ____cacheline_maxaligned_in_smp, we also have (for
example) rcu_ctrlblk, and struct zone, with zone->{lru_,}lock. I.e. we have a
lot of excess cacheline bouncing on them.

No correctness issues, obviously. So this could even be merged for 2.6.14 (I'm
not a fan of this idea, though).

CC: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-x86_64/cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/cache.h b/include/asm-x86_64/cache.h
--- a/include/asm-x86_64/cache.h
+++ b/include/asm-x86_64/cache.h
@@ -9,6 +9,6 @@
 /* L1 cache line size */
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
-#define L1_CACHE_SHIFT_MAX 6	/* largest L1 which this arch supports */
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
 #endif

