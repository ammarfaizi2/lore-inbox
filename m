Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967733AbWK3AfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967733AbWK3AfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967735AbWK3AfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:35:17 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:13535 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S967733AbWK3AfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:35:15 -0500
Date: Thu, 30 Nov 2006 03:35:06 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] doc: atomic_add_unless() doesn't imply mb() on failure
Message-ID: <20061130003506.GA1248@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most implementations of atomic_add_unless() can fail (return 0) after the first
atomic_read() (before cmpxchg). In that case we have a compiler barrier only.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 Documentation/atomic_ops.txt      |    3 ++-
 Documentation/memory-barriers.txt |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- 19-rc6/Documentation/memory-barriers.txt~doc	2006-11-27 21:20:20.000000000 +0300
+++ 19-rc6/Documentation/memory-barriers.txt	2006-11-30 03:32:06.000000000 +0300
@@ -1492,7 +1492,7 @@ about the state (old or new) implies an 
 	atomic_dec_and_test();
 	atomic_sub_and_test();
 	atomic_add_negative();
-	atomic_add_unless();
+	atomic_add_unless();	/* when succeeds (returns 1) */
 	test_and_set_bit();
 	test_and_clear_bit();
 	test_and_change_bit();
--- 19-rc6/Documentation/atomic_ops.txt~doc	2006-07-29 05:05:33.000000000 +0400
+++ 19-rc6/Documentation/atomic_ops.txt	2006-11-30 03:22:58.000000000 +0300
@@ -137,7 +137,8 @@ If the atomic value v is not equal to u,
 returns non zero. If v is equal to u then it returns zero. This is done as
 an atomic operation.
 
-atomic_add_unless requires explicit memory barriers around the operation.
+atomic_add_unless requires explicit memory barriers around the operation
+unless it fails (returns 0).
 
 atomic_inc_not_zero, equivalent to atomic_add_unless(v, 1, 0)
 

