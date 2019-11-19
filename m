Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8FCC432C3
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB58621D7F
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NBbGRSvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfKSPnR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:43:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39150 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfKSPnQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 10:43:16 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so20051532ild.6
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZV/iU0IKq0OZZa2fJOp8RIkQxtj+m45REoL7sfvGJ80=;
        b=NBbGRSvWFtQQmpaHsr3u1G+xb94rw/XbJslHbIGqGmADJLU2AhgolmQcudwkspyBNM
         34PpMPFJjm5uOhunrHQZ3lfAqT0QZDzp3A8Fj5Wy8TqOu3WGgsjTNWm5pOleMfHA9d/t
         8P3opDAtPM4MxiSZs4nWFl2EDhWkJPqsn3ape3KZ8VS2gothldpoKcPRzDM2GOAfQkhs
         /lppX46UGWl0i2x5Ybs/UK4XQv/LOnYn+5AA1GFDn3aOXDM3/Y+F/Q9bI6GKE4n4xuoO
         y8O4jMGY49fhAhzEqD3kIk1STJzOT4AmJWUw5og84mEjnI/LN/rhBbDvf+S1TEWFh+uY
         c63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZV/iU0IKq0OZZa2fJOp8RIkQxtj+m45REoL7sfvGJ80=;
        b=InS5aL+ZSfjXYXdUVvpR0bMsi2Wdnnz2LoNri4WsCfO89g1Ri1rdIXCq/oFQcDjtBV
         hUUpNOfywmI2tuNY5iWGgx5ZPZb3YoQySa6ov7F/bS76cqmHd2EKt0WMUxOHDG0fZD1Q
         UD5aV53SZqsuuQxaVgaHWGKBe0eik+IdRhbjhwFYg9VihD/z6EiojOhLO+wWvpzhyUBY
         uivAN/JayFHTcz9EGSNvBWQWTZ4hd+8+l8+qt83zyRNoA8Y9gY+Ae/Z7VyoEdiylrVWf
         hXrBWbmoe4c2YSOCT1A5O+Lr1dERoy7C+X0AsLv/qHR9p7tbtL08bHEMdG1PB8m6/AlB
         nr7g==
X-Gm-Message-State: APjAAAVyUNcSCngVkTL1mHpv2M9hfXoaS0Trk4KqnQhsbmuFb9PpwALl
        anY5Hj+T+GYwEliWCdc1D7lxM0PbEBI=
X-Google-Smtp-Source: APXvYqxIJphHEuMRUX2t6hGczT0SCc3kRZCqfd5zf1bs02axtWwUphgqvx39HnW450sAMaVK8IOJtQ==
X-Received: by 2002:a92:bac6:: with SMTP id t67mr21709726ill.21.1574178194964;
        Tue, 19 Nov 2019 07:43:14 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x8sm4198516iol.15.2019.11.19.07.43.13
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:43:14 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io-wq: wait for io_wq_create() to setup necessary workers
Message-ID: <aa32808a-5ab4-c66d-bcd2-8f1480d9dba2@kernel.dk>
Date:   Tue, 19 Nov 2019 08:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Jens Axboe

