Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVJ2D3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVJ2D3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVJ2D3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:29:31 -0400
Received: from mail19.bluewin.ch ([195.186.18.65]:63924 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S1751119AbVJ2D3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:29:30 -0400
Date: Fri, 28 Oct 2005 23:29:16 -0400
To: akpm@osdl.org
Cc: chris@zankel.net, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: struct semaphore.sleepers initialization
Message-ID: <20051029032916.GB1870@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No one may sleep on us until we've been down()'d. So on allocation,
initialize `sleepers' to 0, just like everyone else does.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 include/asm-xtensa/semaphore.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

30304537ba5143b13071e4d62ecbd1edcf526f41
diff --git a/include/asm-xtensa/semaphore.h b/include/asm-xtensa/semaphore.h
--- a/include/asm-xtensa/semaphore.h
+++ b/include/asm-xtensa/semaphore.h
@@ -38,6 +38,7 @@ struct semaphore {
 static inline void sema_init (struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
+	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
 
