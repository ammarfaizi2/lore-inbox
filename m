Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVHYIiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVHYIiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVHYIiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:38:12 -0400
Received: from cncln.online.ln.cn ([218.25.172.144]:10502 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S964874AbVHYIiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:38:12 -0400
Date: Thu, 25 Aug 2005 16:37:51 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] alloc_buffer_head() cleanup
Message-ID: <20050825083751.GA4076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This cleanups up alloc_buffer_head(), by using a single get_cpu_var().
Boot tested.

	Coywolf


Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

 buffer.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- 2.6.13-rc6-mm2/fs/buffer.c~orig	2005-08-23 13:42:04.000000000 +0800
+++ 2.6.13-rc6-mm2/fs/buffer.c	2005-08-25 14:14:22.000000000 +0800
@@ -3049,10 +3049,9 @@ struct buffer_head *alloc_buffer_head(un
 {
 	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
 	if (ret) {
-		preempt_disable();
-		__get_cpu_var(bh_accounting).nr++;
+		get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
-		preempt_enable();
+		put_cpu_var(bh_accounting);
 	}
 	return ret;
 }
