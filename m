Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWGKQsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWGKQsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWGKQsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:48:08 -0400
Received: from mail.parknet.jp ([210.171.160.80]:21765 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751102AbWGKQsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:48:06 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix alloc_fdtable()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 12 Jul 2006 01:47:57 +0900
Message-ID: <87ac7gozpe.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current logic seems wrong, the result is always "8 * L1_CACHE_BYTES".
It's probably typo, we should use `nr + 1' instead of `nfds' here.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/file.c~alloc_fdtable-fix fs/file.c
--- linux-2.6/fs/file.c~alloc_fdtable-fix	2006-07-12 01:03:40.000000000 +0900
+++ linux-2.6-hirofumi/fs/file.c	2006-07-12 01:17:29.000000000 +0900
@@ -240,7 +240,7 @@ static struct fdtable *alloc_fdtable(int
 	if (!fdt)
   		goto out;
 
-	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nfds));
+	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nr + 1));
 	if (nfds > NR_OPEN)
 		nfds = NR_OPEN;
 
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
