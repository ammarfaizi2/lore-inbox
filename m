Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbRHGPN7>; Tue, 7 Aug 2001 11:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbRHGPNt>; Tue, 7 Aug 2001 11:13:49 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:50591 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S267615AbRHGPNn>; Tue, 7 Aug 2001 11:13:43 -0400
Date: Tue, 7 Aug 2001 16:15:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] 8pre5 sync_old_buffers oops
Message-ID: <Pine.LNX.4.21.0108071610120.927-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.8-pre5/fs/buffer.c	Tue Aug  7 12:52:59 2001
+++ linux/fs/buffer.c	Tue Aug  7 16:01:49 2001
@@ -2581,7 +2581,7 @@
 
 			spin_lock(&lru_list_lock);
 			bh = lru_list[BUF_DIRTY];
-			if (!time_before(jiffies, bh->b_flushtime))
+			if (bh && !time_before(jiffies, bh->b_flushtime))
 				continue;
 			spin_unlock(&lru_list_lock);
 		}

