Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVL0Dii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVL0Dii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 22:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVL0Dih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 22:38:37 -0500
Received: from [218.25.172.144] ([218.25.172.144]:38416 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932208AbVL0Dih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 22:38:37 -0500
Date: Tue, 27 Dec 2005 11:36:52 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch] elevator: elv_try_merge() cleanup
Message-ID: <20051227033652.GA12214@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup: make elv_try_merge() static, kill the dead declaration of elv_try_last_merge().

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/block/elevator.c b/block/elevator.c
index 6c3fc8a..b7b3f7e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -64,7 +64,7 @@ inline int elv_rq_merge_ok(struct reques
 }
 EXPORT_SYMBOL(elv_rq_merge_ok);
 
-inline int elv_try_merge(struct request *__rq, struct bio *bio)
+static inline int elv_try_merge(struct request *__rq, struct bio *bio)
 {
 	int ret = ELEVATOR_NO_MERGE;
 
@@ -80,7 +80,6 @@ inline int elv_try_merge(struct request 
 
 	return ret;
 }
-EXPORT_SYMBOL(elv_try_merge);
 
 static struct elevator_type *elevator_find(const char *name)
 {
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index a74c27e..325ee07 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -114,8 +114,6 @@ extern ssize_t elv_iosched_store(request
 extern int elevator_init(request_queue_t *, char *);
 extern void elevator_exit(elevator_t *);
 extern int elv_rq_merge_ok(struct request *, struct bio *);
-extern int elv_try_merge(struct request *, struct bio *);
-extern int elv_try_last_merge(request_queue_t *, struct bio *);
 
 /*
  * Return values from elevator merger
