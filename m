Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUIWUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUIWUdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUIWUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:32:52 -0400
Received: from baikonur.stro.at ([213.239.196.228]:51180 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266879AbUIWU0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:26:06 -0400
Subject: [patch 26/26]  char/zftape-buffers: 	replace schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:26:06 +0200
Message-ID: <E1CAaAJ-0000VO-8z@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. There actually won't be a PATCH
33/33, because I dropped one that even I wouldn't approve :)

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 linux-2.6.9-rc2-bk7-max/drivers/char/ftape/zftape/zftape-buffers.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/ftape/zftape/zftape-buffers.c~msleep_interruptible-drivers_char_zftape-buffers drivers/char/ftape/zftape/zftape-buffers.c
--- linux-2.6.9-rc2-bk7/drivers/char/ftape/zftape/zftape-buffers.c~msleep_interruptible-drivers_char_zftape-buffers	2004-09-21 22:54:49.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/ftape/zftape/zftape-buffers.c	2004-09-21 22:55:52.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include <linux/zftape.h>
 
@@ -119,8 +120,7 @@ void *zft_kmalloc(size_t size)
 	void *new;
 
 	while ((new = kmalloc(size, GFP_KERNEL)) == NULL) {
-		current->state   = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/10);
+		msleep_interruptible(100);
 	}
 	memset(new, 0, size);
 	used_memory += size;
_
