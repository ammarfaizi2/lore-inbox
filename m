Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTFJPSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFJPRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:17:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3361 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263150AbTFJPRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:17:33 -0400
Date: Tue, 10 Jun 2003 16:33:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 5/9 remove an IV
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101633010.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused IV from loop_make_request (loop_transfer_bio does that).

--- loop4/drivers/block/loop.c	Mon Jun  9 15:58:48 2003
+++ loop5/drivers/block/loop.c	Mon Jun  9 15:57:31 2003
@@ -544,7 +544,6 @@
 {
 	struct bio *new_bio = NULL;
 	struct loop_device *lo = q->queuedata;
-	unsigned long IV;
 	int rw = bio_rw(old_bio);
 
 	if (!lo)
@@ -580,7 +579,6 @@
 	 * piggy old buffer on original, and submit for I/O
 	 */
 	new_bio = loop_get_buffer(lo, old_bio);
-	IV = loop_get_iv(lo, old_bio->bi_sector);
 	if (rw == WRITE) {
 		if (loop_transfer_bio(lo, new_bio, old_bio))
 			goto err;

