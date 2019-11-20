Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3399C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774BC2075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I+9wocZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKTUJw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43499 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTUJw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:52 -0500
Received: by mail-io1-f68.google.com with SMTP id r2so598447iot.10
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ik5XcjTy71gxzhPruo51C1MXiDESR5Nb2Gjfnjx5Ozo=;
        b=I+9wocZzmaPBcL8hUw9LAEJ1sOj3YRXdcxCACs0irvEmzH8Sw+9AduVCOyKKcTyE2/
         3iufeN0OPDYm7uXERFzK/o7JamUoKWZe7+XJ8itnc2Pd658bJpFdkmnasUimGODhYc5H
         WHoAyFAxiV84xhO3Jo1zgpCvLEBU3Vl5z1Jpdxa7n+ZfCqD06u2SGgKR60QQ4qSmIsdO
         3XscYVF0Zy5CleQZQaA0OATk/G9wcWWbOeUj8b26JC4GYfFZ+xrD9X1MMpckgux19hHJ
         wm+GSqkVFr2rlLYicK/SeRXYuM8DFp2ldGJUurZuY2rN/4Uj8QQEhdiyh9umrMdMnF33
         SHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ik5XcjTy71gxzhPruo51C1MXiDESR5Nb2Gjfnjx5Ozo=;
        b=TBh7FD6SlRSK0JhqL7SXIeawCYTeNT5gGKWHv9QzTR+YBPP9gwNPJel4851H1B6BV+
         eH2XVDWpr0LBOJizbY+qTAt6RDvCvPKFdQz/c7b0pTyUw23oeJmCfuTQibg27VMcGI0m
         1K5XR67zg9cTFDqVj5bspUciz1pOP3SMBipkIADCTcsFWwpwXXsytJkO1ZhtB6SkQ2bM
         G0STo/c4Qm1bnZILslkm9M2m1xmvkgmS1chrGOAUBHz2vOR8lgNtdnGgHUStO6tJuyBp
         3xH0ZObN3XnsSx/ZAO7BdHHHZiB6PQmMy60ab0l7p12svLwoU9VSjdfix0B5W7epelBz
         /s1g==
X-Gm-Message-State: APjAAAVK3B+QRdmhbeE4a/e29+wNs9FG/ZKMqhlk+f7UA27+chKu1UvL
        PXfvqNLuiKOhqdoeknXlsjDrkYe1r2+7aA==
X-Google-Smtp-Source: APXvYqyTSSjFccEYpOPDzKbT3YuyLDm5sz+laWGDoG9D27AT64Jb7Hq6YcEwmLz0mRCIn2rL60dEkA==
X-Received: by 2002:a02:c98e:: with SMTP id b14mr4835942jap.133.1574280590311;
        Wed, 20 Nov 2019 12:09:50 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
        syzbot+0f1cc17f85154f400465@syzkaller.appspotmail.com
Subject: [PATCH 1/7] io-wq: wait for io_wq_create() to setup necessary workers
Date:   Wed, 20 Nov 2019 13:09:29 -0700
Message-Id: <20191120200936.22588-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We currently have a race where if setup is really slow, we can be
calling io_wq_destroy() before we're done setting up. This will cause
the caller to get stuck waiting for the manager to set things up, but
the manager already exited.

Fix this by doing a sync setup of the manager. This also fixes the case
where if we failed creating workers, we'd also get stuck.

In practice this race window was really small, as we already wait for
the manager to start. Hence someone would have to call io_wq_destroy()
after the task has started, but before it started the first loop. The
reported test case forked tons of these, which is why it became an
issue.

Reported-by: syzbot+0f1cc17f85154f400465@syzkaller.appspotmail.com
Fixes: 771b53d033e8 ("io-wq: small threadpool implementation for io_uring")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 9174007ce107..1f640c489f7c 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -33,6 +33,7 @@ enum {
 enum {
 	IO_WQ_BIT_EXIT		= 0,	/* wq exiting */
 	IO_WQ_BIT_CANCEL	= 1,	/* cancel work on list */
+	IO_WQ_BIT_ERROR		= 2,	/* error on setup */
 };
 
 enum {
@@ -562,14 +563,14 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 	spin_unlock_irq(&wqe->lock);
 }
 
-static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
+static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 {
 	struct io_wqe_acct *acct =&wqe->acct[index];
 	struct io_worker *worker;
 
 	worker = kcalloc_node(1, sizeof(*worker), GFP_KERNEL, wqe->node);
 	if (!worker)
-		return;
+		return false;
 
 	refcount_set(&worker->ref, 1);
 	worker->nulls_node.pprev = NULL;
@@ -581,7 +582,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 				"io_wqe_worker-%d/%d", index, wqe->node);
 	if (IS_ERR(worker->task)) {
 		kfree(worker);
-		return;
+		return false;
 	}
 
 	spin_lock_irq(&wqe->lock);
@@ -599,6 +600,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 		atomic_inc(&wq->user->processes);
 
 	wake_up_process(worker->task);
+	return true;
 }
 
 static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
@@ -606,9 +608,6 @@ static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 {
 	struct io_wqe_acct *acct = &wqe->acct[index];
 
-	/* always ensure we have one bounded worker */
-	if (index == IO_WQ_ACCT_BOUND && !acct->nr_workers)
-		return true;
 	/* if we have available workers or no work, no need */
 	if (!hlist_nulls_empty(&wqe->free_list) || !io_wqe_run_queue(wqe))
 		return false;
@@ -621,10 +620,19 @@ static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 static int io_wq_manager(void *data)
 {
 	struct io_wq *wq = data;
+	int i;
 
-	while (!kthread_should_stop()) {
-		int i;
+	/* create fixed workers */
+	for (i = 0; i < wq->nr_wqes; i++) {
+		if (create_io_worker(wq, wq->wqes[i], IO_WQ_ACCT_BOUND))
+			continue;
+		goto err;
+	}
 
+	refcount_set(&wq->refs, wq->nr_wqes);
+	complete(&wq->done);
+
+	while (!kthread_should_stop()) {
 		for (i = 0; i < wq->nr_wqes; i++) {
 			struct io_wqe *wqe = wq->wqes[i];
 			bool fork_worker[2] = { false, false };
@@ -644,6 +652,10 @@ static int io_wq_manager(void *data)
 		schedule_timeout(HZ);
 	}
 
+	return 0;
+err:
+	set_bit(IO_WQ_BIT_ERROR, &wq->state);
+	complete(&wq->done);
 	return 0;
 }
 
@@ -982,7 +994,6 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 	wq->user = user;
 
 	i = 0;
-	refcount_set(&wq->refs, wq->nr_wqes);
 	for_each_online_node(node) {
 		struct io_wqe *wqe;
 
@@ -1020,6 +1031,10 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 	wq->manager = kthread_create(io_wq_manager, wq, "io_wq_manager");
 	if (!IS_ERR(wq->manager)) {
 		wake_up_process(wq->manager);
+		wait_for_completion(&wq->done);
+		if (test_bit(IO_WQ_BIT_ERROR, &wq->state))
+			goto err;
+		reinit_completion(&wq->done);
 		return wq;
 	}
 
@@ -1041,10 +1056,9 @@ void io_wq_destroy(struct io_wq *wq)
 {
 	int i;
 
-	if (wq->manager) {
-		set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	if (wq->manager)
 		kthread_stop(wq->manager);
-	}
 
 	rcu_read_lock();
 	for (i = 0; i < wq->nr_wqes; i++) {
-- 
2.24.0

