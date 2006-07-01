Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWGAX3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWGAX3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWGAX3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:29:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:24257 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932085AbWGAX3y (ORCPT
	<rfc822;linux-kernel@VGER.KERNEL.ORG>);
	Sat, 1 Jul 2006 19:29:54 -0400
Date: Sat, 1 Jul 2006 07:45:35 +0200
From: Willy Tarreau <w@1wt.eu>
To: marcelo@kvack.org
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Vasily Averin <vvs@sw.ru>, Andrey Savochkin <saw@sawoct.com>,
       Dmitry Monakhov <dmonakhov@sw.ru>, Roberto Nibali <ratz@drugphish.ch>
Subject: [PATCH-2.4] EXT3: ext3 block bitmap leakage
Message-ID: <20060701054535.GA1459@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

we missed this patch sent by Kirill Korotaev on LKML. Fortunately, Roberto
noticed it and forwarded it to me.

Since it's been there for a very long time, there's no emergency, but the
problem looks real and the fix seems to be confirmed, so if you have not
closed 2.4.33 yet, it might be worth merging it too.

Here it is as a git patch, but I've queued it in -upstream if you prefer.

Cheers,
Willy


>From nobody Mon Sep 17 00:00:00 2001
From: Kirill Korotaev <dev@openvz.org>
Date: Fri, 30 Jun 2006 13:41:05 +0400
Subject: [PATCH] EXT3: ext3 block bitmap leakage

This patch fixes ext3 block bitmap leakage,
which leads to the following fsck messages on
_healthy_ filesystem:
Block bitmap differences:  -64159 -73707

All kernels up to 2.6.17 have this bug.

Found by
   Vasily Averin <vvs@sw.ru> and Andrey Savochkin <saw@sawoct.com>
Test case triggered the issue was created by
   Dmitry Monakhov <dmonakhov@sw.ru>

Signed-Off-By: Vasiliy Averin <vvs@sw.ru>
Signed-Off-By: Andrey Savochkin <saw@sawoct.com>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>
CC: Dmitry Monakhov <dmonakhov@sw.ru>

---

 fs/ext3/inode.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

8c6f6cf38bc9b04edc69c2869ae1e6c584584b4f
diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index bcd86f6..d8f5a9b 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -570,6 +570,7 @@ static int ext3_alloc_branch(handle_t *h
 
 	branch[0].key = cpu_to_le32(parent);
 	if (parent) {
+		keys = 1;
 		for (n = 1; n < num; n++) {
 			struct buffer_head *bh;
 			/* Allocate the next block */
-- 
1.3.3

