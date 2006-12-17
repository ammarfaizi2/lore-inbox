Return-Path: <linux-kernel-owner+w=401wt.eu-S1752390AbWLQK7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbWLQK7K (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbWLQK7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:59:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35229 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbWLQK7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:59:09 -0500
Date: Sun, 17 Dec 2006 10:59:07 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fallout from atomic_long_t patch
Message-ID: <20061217105907.GE17561@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 5e7cd45..4cec1a8 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -135,8 +135,7 @@ static int cn_call_callback(struct cn_ms
 	spin_lock_bh(&dev->cbdev->queue_lock);
 	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
-			if (likely(!test_bit(WORK_STRUCT_PENDING,
-					     &__cbq->work.work.management) &&
+			if (likely(!work_pending(&__cbq->work.work) &&
 					__cbq->data.ddata == NULL)) {
 				__cbq->data.callback_priv = msg;
 
