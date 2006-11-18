Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754282AbWKRIWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbWKRIWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbWKRIWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:22:00 -0500
Received: from c-24-21-154-103.hsd1.or.comcast.net ([24.21.154.103]:62413 "EHLO
	p1b.net") by vger.kernel.org with ESMTP id S1754265AbWKRIV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:21:59 -0500
Date: Sat, 18 Nov 2006 00:27:27 -0800
From: Paul Bonser <misterpib@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Networking: re-fix of doc-comment in sock.h
Message-ID: <20061118082727.GA1250@pib>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Bonser <misterpib@gmail.com>

Restoring old, correct comment for sk_filter_release, moving it to where it should actually be, and changing new comment into proper comment for sk_filter_rcu_free, where it actually makes sense.

The original fix submitted for this on Oct 23 mistakenly documented the wrong function.

Signed-off-by: Paul Bonser <misterpib@gmail.com>

---

diff --git a/include/net/sock.h b/include/net/sock.h
index ac286a3..9cdbae2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -883,18 +883,23 @@ static inline int sk_filter(struct sock 
 }
 
 /**
- *	sk_filter_release: Release a socket filter
- *	@rcu: rcu_head that contains the sk_filter info to remove
- *
- *	Remove a filter from a socket and release its resources.
+ * 	sk_filter_rcu_free: Free a socket filter
+ *	@rcu: rcu_head that contains the sk_filter to free
  */
- 
 static inline void sk_filter_rcu_free(struct rcu_head *rcu)
 {
 	struct sk_filter *fp = container_of(rcu, struct sk_filter, rcu);
 	kfree(fp);
 }
 
+/**
+ *	sk_filter_release: Release a socket filter
+ *	@sk: socket
+ *	@fp: filter to remove
+ *
+ *	Remove a filter from a socket and release its resources.
+ */
+
 static inline void sk_filter_release(struct sock *sk, struct sk_filter *fp)
 {
 	unsigned int size = sk_filter_len(fp);
