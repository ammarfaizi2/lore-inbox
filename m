Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWAORLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWAORLx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWAORLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:11:53 -0500
Received: from cabal.ca ([134.117.69.58]:58782 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S932089AbWAORLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:11:52 -0500
Date: Sun, 15 Jan 2006 12:10:55 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use atomic64_set for 64-bit case of atomic_long_set
Message-ID: <20060115171055.GD21721@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, the BITS_PER_LONG == 64 case of atomic_long_set
was using atomic_set instead of atomic64_set. This does not jive
with architectures which use an inline instead of a #define to
implement their atomic_set() primitives.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

All 64-bit architectures I checked {powerpc,ia64,alpha,sparc64,x86_64}
also #define atomic64_set, so there should be no visible difference
to them.

 include/asm-generic/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e653aabb9c3dbc63d2876bd0e8c31c8ad3f6179b
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 0fada8f..42a95d9 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -35,7 +35,7 @@ static inline void atomic_long_set(atomi
 {
 	atomic64_t *v = (atomic64_t *)l;
 
-	atomic_set(v, i);
+	atomic64_set(v, i);
 }
 
 static inline void atomic_long_inc(atomic_long_t *l)
-- 
1.0.GIT

