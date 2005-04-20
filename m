Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVDTLoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVDTLoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDTLn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:43:59 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:9186 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261392AbVDTLlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:41:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=cV1TnW0To4Aa7xZgQnG+8qX7+ArfVc6cFVmkBymyXdmKf7KBO78TRQHUhm1EhOZYN/sKaCV2fBfVQhqaI7xcMy/4jirOeW8hnLq/h/YvAmRvvzTICjKGjf/RlFJO3id5pd0HD9pUJyDKnQAZOWef3LbzJEFGQDUqbQs3eP0azTc=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050420114041.F2FA00DB@htj.dyndns.org>
In-Reply-To: <20050420114041.F2FA00DB@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc2 03/04] blk: remove BLK_TAGS_{PER_LONG|MASK}
Message-ID: <20050420114041.DB148521@htj.dyndns.org>
Date: Wed, 20 Apr 2005 20:41:47 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_blk_tag_map_remove_BLK_TAGS_PER_LONG.patch

	Replace BLK_TAGS_PER_LONG with BITS_PER_LONG and remove unused
	BLK_TAGS_MASK.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |    4 ++--
 include/linux/blkdev.h    |    3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-04-20 20:36:37.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-04-20 20:36:38.000000000 +0900
@@ -788,7 +788,7 @@ init_tag_map(request_queue_t *q, struct 
 	if (!tag_index)
 		goto fail;
 
-	nr_ulongs = ALIGN(depth, BLK_TAGS_PER_LONG) / BLK_TAGS_PER_LONG;
+	nr_ulongs = ALIGN(depth, BITS_PER_LONG) / BITS_PER_LONG;
 	tag_map = kmalloc(nr_ulongs * sizeof(unsigned long), GFP_ATOMIC);
 	if (!tag_map)
 		goto fail;
@@ -879,7 +879,7 @@ int blk_queue_resize_tags(request_queue_
 		return -ENOMEM;
 
 	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
-	nr_ulongs = ALIGN(max_depth, BLK_TAGS_PER_LONG) / BLK_TAGS_PER_LONG;
+	nr_ulongs = ALIGN(max_depth, BITS_PER_LONG) / BITS_PER_LONG;
 	memcpy(bqt->tag_map, tag_map, nr_ulongs * sizeof(unsigned long));
 
 	kfree(tag_index);
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-04-20 20:36:37.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-04-20 20:36:38.000000000 +0900
@@ -285,9 +285,6 @@ enum blk_queue_state {
 	Queue_up,
 };
 
-#define BLK_TAGS_PER_LONG	(sizeof(unsigned long) * 8)
-#define BLK_TAGS_MASK		(BLK_TAGS_PER_LONG - 1)
-
 struct blk_queue_tag {
 	struct request **tag_index;	/* map of busy tags */
 	unsigned long *tag_map;		/* bit map of free/busy tags */

