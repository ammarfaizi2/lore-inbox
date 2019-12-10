Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489CBC00454
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED152053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="am7YFZ6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJP5v (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39121 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP5v (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:51 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so19308247ioh.6
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMutxQeEjT6mYjCG1qkKliOKLKwi42stgjBSmyL0vvg=;
        b=am7YFZ6R9vyxvp1UE9xJWBa8eKgn4ynhuNfGDRuSb+Bvd3do4TX0UfvwWqEkRXTX0p
         6ZCF/c/+A0xHvkY+jG41WrCZ5wdFGri6cAOE0KOEjHEjDR1bCKNgr3nVhXB7NDjjoBhy
         N56QV0g9Dgns3D9luk0u3KUKG+ibYDpmnYnKsdn2/Glhar3GWB/1567B3aPh+Tw8JsHp
         o27GI9OQeUpPeNJNPi7W7OrxxL0ZiZqdU25kXILmZvR4KOGpbQrvXyspIY7lOESrOpaK
         FUkuXR21qeclttY9A0ZrDa+tvYWdUszALUyy1kKGz3Odn36bxZICxNA/B/xiZkvHLMCm
         EqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMutxQeEjT6mYjCG1qkKliOKLKwi42stgjBSmyL0vvg=;
        b=j5FAEMsDHn+XNXEOf8WjXTyyG2wpQlhFFb1by/udXR15xRuOHS0cdfoL72jJ/St3EP
         kSSjfR/uxY+RYZx+22G2+luUwvbj9Sgifhsr6ri5INcBxQ9AsqjVSYIEyEUEpW6Ysg2O
         8zMzLEpFiSxAYtFV2gX+vu0KhRezF8bpfZRkOqE6RI8kxxvuCpVzOp+7OZZeV3Ke3HBM
         EUIGypN1ZpKRv4/KHHqWqwsLZZNf70pmEuS0PQB269dgvhJ5+GCvlKq2v2lIuiMYvoLy
         JrenXYBb6EBo57UojIMV6czgcBZj1txO4ci0A9uBD8VICsbihaP2drjHQj2vlaUxgEh5
         Kq8Q==
X-Gm-Message-State: APjAAAWguPlFxy1YHuFoYGKevOswal9V2j6ALAksRinKwrsbLjrftJbI
        XkpprJZbiZTfwK35MpkiDWJpFckRCVH7nw==
X-Google-Smtp-Source: APXvYqwjYXpo5WJQrdA9eAzowqSD91vS+3bfBakD4eBotfkYa43X0bzkzcHmyo0jfEvShfvJi5RlRA==
X-Received: by 2002:a02:cb4d:: with SMTP id k13mr32235257jap.89.1575993470366;
        Tue, 10 Dec 2019 07:57:50 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] io-wq: briefly spin for new work after finishing work
Date:   Tue, 10 Dec 2019 08:57:34 -0700
Message-Id: <20191210155742.5844-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

To avoid going to sleep only to get woken shortly thereafter, spin
briefly for new work upon completion of work.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 24 ++++++++++++++++++++++--
 fs/io-wq.h |  7 ++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 6b663ddceb42..90c4978781fb 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -491,26 +491,46 @@ static void io_worker_handle_work(struct io_worker *worker)
 	} while (1);
 }
 
+static inline void io_worker_spin_for_work(struct io_wqe *wqe)
+{
+	int i = 0;
+
+	while (++i < 1000) {
+		if (io_wqe_run_queue(wqe))
+			break;
+		if (need_resched())
+			break;
+		cpu_relax();
+	}
+}
+
 static int io_wqe_worker(void *data)
 {
 	struct io_worker *worker = data;
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
+	bool did_work;
 
 	io_worker_start(wqe, worker);
 
+	did_work = false;
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		set_current_state(TASK_INTERRUPTIBLE);
+loop:
+		if (did_work)
+			io_worker_spin_for_work(wqe);
 		spin_lock_irq(&wqe->lock);
 		if (io_wqe_run_queue(wqe)) {
 			__set_current_state(TASK_RUNNING);
 			io_worker_handle_work(worker);
-			continue;
+			did_work = true;
+			goto loop;
 		}
+		did_work = false;
 		/* drops the lock on success, retry */
 		if (__io_worker_idle(wqe, worker)) {
 			__release(&wqe->lock);
-			continue;
+			goto loop;
 		}
 		spin_unlock_irq(&wqe->lock);
 		if (signal_pending(current))
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 7c333a28e2a7..fb993b2bd0ef 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -35,7 +35,8 @@ static inline void wq_list_add_tail(struct io_wq_work_node *node,
 				    struct io_wq_work_list *list)
 {
 	if (!list->first) {
-		list->first = list->last = node;
+		list->last = node;
+		WRITE_ONCE(list->first, node);
 	} else {
 		list->last->next = node;
 		list->last = node;
@@ -47,7 +48,7 @@ static inline void wq_node_del(struct io_wq_work_list *list,
 			       struct io_wq_work_node *prev)
 {
 	if (node == list->first)
-		list->first = node->next;
+		WRITE_ONCE(list->first, node->next);
 	if (node == list->last)
 		list->last = prev;
 	if (prev)
@@ -58,7 +59,7 @@ static inline void wq_node_del(struct io_wq_work_list *list,
 #define wq_list_for_each(pos, prv, head)			\
 	for (pos = (head)->first, prv = NULL; pos; prv = pos, pos = (pos)->next)
 
-#define wq_list_empty(list)	((list)->first == NULL)
+#define wq_list_empty(list)	(READ_ONCE((list)->first) == NULL)
 #define INIT_WQ_LIST(list)	do {				\
 	(list)->first = NULL;					\
 	(list)->last = NULL;					\
-- 
2.24.0

