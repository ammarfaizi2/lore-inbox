Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVDIBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVDIBih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDIBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:38:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:40080 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261201AbVDIBif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:38:35 -0400
Date: Sat, 9 Apr 2005 03:41:07 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       ecashin@noserose.net, Greg K-H <greg@kroah.com>,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] make mempool_destroy resilient against NULL pointers.
Message-ID: <Pine.LNX.4.62.0504090334490.2455@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


General rule (as I understand it) is that functions that free resources 
should handle being passed NULL pointers - mempool_destroy() will 
currently explode if passed a NULL pointer, the patch below makes it safe 
to pass it NULL.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 mempool.c |    2 ++
 1 files changed, 2 insertions(+)


--- linux-2.6.12-rc2-mm2-orig/mm/mempool.c	2005-04-05 21:21:56.000000000 +0200
+++ linux-2.6.12-rc2-mm2/mm/mempool.c	2005-04-09 03:33:58.000000000 +0200
@@ -176,6 +176,8 @@ EXPORT_SYMBOL(mempool_resize);
  */
 void mempool_destroy(mempool_t *pool)
 {
+	if (!pool)
+		return;
 	if (pool->curr_nr != pool->min_nr)
 		BUG();		/* There were outstanding elements */
 	free_pool(pool);


