Return-Path: <SRS0=o5Q3=Z7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21881C43603
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED28C2068E
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d3XqD6rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLIXTC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:19:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40236 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXTC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 9 Dec 2019 18:19:02 -0500
Received: by mail-pj1-f65.google.com with SMTP id s35so6540317pjb.7
        for <io-uring@vger.kernel.org>; Mon, 09 Dec 2019 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMutxQeEjT6mYjCG1qkKliOKLKwi42stgjBSmyL0vvg=;
        b=d3XqD6rvEMVNcYinqEgJcbxb1kNiOOerBAyXyiR0AWaMPgWCebNbOBp43H/6rCqlYt
         84ubZTxMDcP5Alh2jCqRWQZwpcGaBME3No2rIhf26bqriA7XTgI62pHc6XT9poSvQ+fJ
         b6U4RB1Ac6f5SN1/YzJlfVnSs77ZFjN2HEUwu8DBlAZOHcp42AgYPevm4Lw2cHyXem92
         y46qjkji15KujYiBodYsiAdAg8FcM1/Pp8Mi9upptz4AnHZR+NIHQe0Nz4W0Cf0Pbl3R
         zADsf7AR4M7S6MsUqCU6ALDKBE58hS7bWq3CQaMk1zXMoHlpbi8gW01BL1J8ttpBrp+m
         ullA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMutxQeEjT6mYjCG1qkKliOKLKwi42stgjBSmyL0vvg=;
        b=abUH4uzEru7A/nuUoiYXODsPJjVulacClyGXxAJzgLJUKdpw/MfadZNnt+q8YF2ddH
         sCrQAs8JxCLRBVXjqx6KxbNS6RGjibO3T4Rtjx3ulA9vzwVKj6ufmnRF8Rvx/VURWBx1
         hWz4nyyKHi8nkx/Bisej05aD9y+SILfXecxaYOxRFi873xiyssdy6hh6cUf65jDzpOZs
         MyQ7xn0PRBQFhcPzTm7pScE7Y2x9L2OpO4ICQAah+nIERKjhlpMBePOPtY4q2ijlYiMk
         nER9p/ct3tvp4rwxBINoH3zHk/N9dr7Hea8SF3x4OdLHxD5Ij2TaptMzg73C9Q034gBD
         3iyw==
X-Gm-Message-State: APjAAAViUSH5eqoscYl5e1HcM5etGd2dDpALPuPtG1e94gVc0auJBU1e
        /FPIRlYiE9C/uUp93ScJEt8M07f/m+0=
X-Google-Smtp-Source: APXvYqzIbucsNiCATzphPS387WrCa1diHqZqLPV7yBj6Hh+TMWsrC071WlJxW3i5saJ/ZkIrXuhYpA==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr31852801pla.108.1575933541279;
        Mon, 09 Dec 2019 15:19:01 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::e5cf])
        by smtp.gmail.com with ESMTPSA id 16sm515662pfh.182.2019.12.09.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:19:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] io-wq: briefly spin for new work after finishing work
Date:   Mon,  9 Dec 2019 16:18:53 -0700
Message-Id: <20191209231854.3767-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209231854.3767-1-axboe@kernel.dk>
References: <20191209231854.3767-1-axboe@kernel.dk>
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

