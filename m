Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAPH3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAPH3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWAPH3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:29:51 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:42054 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932215AbWAPH3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:29:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=ByPvcYmbdSqmlthIUciyTV4jYII1WZLQbSZ96KINGU4d/1X2/k0mEmvxVcVqtsc1fFPlUMRBGVBii37s7p49WvhsimFwyvUX7iLM5DP4v0yQZLASu/XIJLrpCda7PmaJKmu61XhwkvnlGLy2I8vbHbxnQab9Anj9fivLhMt7xxg=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] block: request_queue->ordcolor must not be flipped on SOFTBARRIER
In-Reply-To: <1137396584971-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Mon, 16 Jan 2006 16:29:44 +0900
Message-Id: <11373965843398-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

q->ordcolor must not be flipped on SOFTBARRIER.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 block/elevator.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

56261a6b475696b0ff97a3df6c8fbcec9760b514
diff --git a/block/elevator.c b/block/elevator.c
index f905e47..4c0fe1c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -336,7 +336,8 @@ void __elv_add_request(request_queue_t *
 		/*
 		 * toggle ordered color
 		 */
-		q->ordcolor ^= 1;
+		if (blk_barrier_rq(rq))
+			q->ordcolor ^= 1;
 
 		/*
 		 * barriers implicitly indicate back insertion
-- 
1.0.6


