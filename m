Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965388AbWI0GhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965388AbWI0GhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965389AbWI0GhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:37:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:65492 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965388AbWI0GhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:37:09 -0400
Date: Wed, 27 Sep 2006 07:37:07 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __percpu_alloc_mask() has to be __always_inline in UP case
Message-ID: <20060927063707.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... or we'll end up with cpu_online_map being evaluated on UP.
In modules.  cpumask.h is very careful to avoid that, and for a
very good reason.  So should we...

PS: yes, it really triggers (on alpha).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/percpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 3835a96..46ec72f 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -74,7 +74,7 @@ static inline int __percpu_populate_mask
 	return 0;
 }
 
-static inline void *__percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t *mask)
+static __always_inline void *__percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t *mask)
 {
 	return kzalloc(size, gfp);
 }
-- 
1.4.2.GIT

