Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33699C5DF60
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5A5218AE
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RQh4yxO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfKGS3a (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:29:30 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:32994 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKGS3a (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 13:29:30 -0500
Received: by mail-il1-f195.google.com with SMTP id m5so2735856ilq.0
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mIpShIh/AqpfvUwiIQCsObLKPQqpScWhbkwquQTgcw=;
        b=RQh4yxO+dKPoDVPLPDXoA0zf4MZ70NuTL1wFXG+hckmVghy9jW7gCJnYIo+WM98a77
         NxXxPwk5JVITrqlqtNZ7p0OtKqZ4miFUMjIDQQwu42QUX0aGRh+saP6at5q+n/91tZDk
         vXyJNjsknK595LFz6/WheKotkkILviyKcQvzbIo2a2cSXknkXpf75TABkRiYt7JrSSHc
         jeqPX1YbmwlRBZvvZAUPVx49+aSywfioUqwL77KwuXXbndgZO7lDVhj+v244+1L8sLlJ
         i6dQu+uiGa98aYM8eG5A6POihKNh0IuqSVReDIX8ROTa8LrsP/DTxAqoQZGj/lMd4k31
         KZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mIpShIh/AqpfvUwiIQCsObLKPQqpScWhbkwquQTgcw=;
        b=e4Hih1nVUWUvwa93+Bid77jVeMHyuq5GKBGOFUWPtj+IXA57YYOQV7KM6PqGynKFCX
         ygFdLcncr4n4xLr44fbT09cm6vxOwjz4gwd9Qgr+VPkuaYX8X1NzpcFzJbYqZmzFHzVk
         L10cPVI50xfoS2wyNCv2BAgX2tNWzBuu4KRZvLFPBBqKNMHsD8FpcTjRHhyUSS7d32oK
         Ar5HJMXj0xVc4WWGLXBxyHsbAwFZSoECHlUpbscQ9c9QOyhsgQAnMoCbJFJeOTZO7Q7U
         cDetIDFfOn2zXPYrYxwE9tm3ZKf1AMoMu0QYWFLEiYoVUSbdsi0Krt56FWF2FiYkrZCz
         xuiQ==
X-Gm-Message-State: APjAAAXEPBvClx4pYeOeTyulYIZqOfT8g+oCG4ftP9JKFJWYVgLo1LFR
        q2sBsojifoD9zNbSc67PemAvVmUOY8Y=
X-Google-Smtp-Source: APXvYqwUdLL2brhJat8mk5zZ8T7oYh3q0zH66otrPIIJM52M6/vhM8hs0GhvQMPkH3+XqPVu58856A==
X-Received: by 2002:a92:7ece:: with SMTP id q75mr6432321ill.164.1573151368503;
        Thu, 07 Nov 2019 10:29:28 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm243727iog.55.2019.11.07.10.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:29:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] io_wq: add support for bounded vs unbunded work
Date:   Thu,  7 Nov 2019 11:29:19 -0700
Message-Id: <20191107182920.21196-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107182920.21196-1-axboe@kernel.dk>
References: <20191107182920.21196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

io_uring supports request types that basically have two different
lifetimes:

1) Bounded completion time. These are requests like disk reads or writes,
   which we know will finish in a finite amount of time.
2) Unbounded completion time. These are generally networked IO, where we
   have no idea how long they will take to complete. Another example is
   POLL commands.

This patch provides support for io-wq to handle these differently, so we
don't starve bounded requests by tying up workers for too long. In this
patch, io_uring passes in bounded and unbounded counts, but doesn't
utilize them yet.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 242 ++++++++++++++++++++++++++++++++++----------------
 fs/io-wq.h    |   4 +-
 fs/io_uring.c |   8 +-
 3 files changed, 170 insertions(+), 84 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 9b375009a553..2c9705f0a25d 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -27,6 +27,7 @@ enum {
 	IO_WORKER_F_FREE	= 4,	/* worker on free list */
 	IO_WORKER_F_EXITING	= 8,	/* worker exiting */
 	IO_WORKER_F_FIXED	= 16,	/* static idle worker */
+	IO_WORKER_F_BOUND	= 32,	/* is doing bounded work */
 };
 
 enum {
@@ -66,6 +67,17 @@ struct io_wq_nulls_list {
 #define IO_WQ_HASH_ORDER	5
 #endif
 
+struct io_wqe_acct {
+	unsigned nr_workers;
+	unsigned max_workers;
+	atomic_t nr_running;
+};
+
+enum {
+	IO_WQ_ACCT_BOUND,
+	IO_WQ_ACCT_UNBOUND,
+};
+
 /*
  * Per-node worker thread pool
  */
@@ -78,9 +90,7 @@ struct io_wqe {
 	} ____cacheline_aligned_in_smp;
 
 	int node;
-	unsigned nr_workers;
-	unsigned max_workers;
-	atomic_t nr_running;
+	struct io_wqe_acct acct[2];
 
 	struct io_wq_nulls_list free_list;
 	struct io_wq_nulls_list busy_list;
@@ -152,10 +162,29 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
 	return dropped_lock;
 }
 
+static inline struct io_wqe_acct *io_work_get_acct(struct io_wqe *wqe,
+						   struct io_wq_work *work)
+{
+	if (work->flags & IO_WQ_WORK_UNBOUND)
+		return &wqe->acct[IO_WQ_ACCT_UNBOUND];
+
+	return &wqe->acct[IO_WQ_ACCT_BOUND];
+}
+
+static inline struct io_wqe_acct *io_wqe_get_acct(struct io_wqe *wqe,
+						  struct io_worker *worker)
+{
+	if (worker->flags & IO_WORKER_F_BOUND)
+		return &wqe->acct[IO_WQ_ACCT_BOUND];
+
+	return &wqe->acct[IO_WQ_ACCT_UNBOUND];
+}
+
 static void io_worker_exit(struct io_worker *worker)
 {
 	struct io_wqe *wqe = worker->wqe;
-	bool all_done = false;
+	struct io_wqe_acct *acct = io_wqe_get_acct(wqe, worker);
+	unsigned nr_workers;
 
 	/*
 	 * If we're not at zero, someone else is holding a brief reference
@@ -169,7 +198,7 @@ static void io_worker_exit(struct io_worker *worker)
 	preempt_disable();
 	current->flags &= ~PF_IO_WORKER;
 	if (worker->flags & IO_WORKER_F_RUNNING)
-		atomic_dec(&wqe->nr_running);
+		atomic_dec(&acct->nr_running);
 	worker->flags = 0;
 	preempt_enable();
 
@@ -179,17 +208,82 @@ static void io_worker_exit(struct io_worker *worker)
 		__release(&wqe->lock);
 		spin_lock_irq(&wqe->lock);
 	}
-	wqe->nr_workers--;
-	all_done = !wqe->nr_workers;
+	acct->nr_workers--;
+	nr_workers = wqe->acct[IO_WQ_ACCT_BOUND].nr_workers +
+			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers;
 	spin_unlock_irq(&wqe->lock);
 
 	/* all workers gone, wq exit can proceed */
-	if (all_done && refcount_dec_and_test(&wqe->wq->refs))
+	if (!nr_workers && refcount_dec_and_test(&wqe->wq->refs))
 		complete(&wqe->wq->done);
 
 	kfree_rcu(worker, rcu);
 }
 
+static inline bool io_wqe_run_queue(struct io_wqe *wqe)
+	__must_hold(wqe->lock)
+{
+	if (!list_empty(&wqe->work_list) && !(wqe->flags & IO_WQE_FLAG_STALLED))
+		return true;
+	return false;
+}
+
+/*
+ * Check head of free list for an available worker. If one isn't available,
+ * caller must wake up the wq manager to create one.
+ */
+static bool io_wqe_activate_free_worker(struct io_wqe *wqe)
+	__must_hold(RCU)
+{
+	struct hlist_nulls_node *n;
+	struct io_worker *worker;
+
+	n = rcu_dereference(hlist_nulls_first_rcu(&wqe->free_list.head));
+	if (is_a_nulls(n))
+		return false;
+
+	worker = hlist_nulls_entry(n, struct io_worker, nulls_node);
+	if (io_worker_get(worker)) {
+		wake_up(&worker->wait);
+		io_worker_release(worker);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We need a worker. If we find a free one, we're good. If not, and we're
+ * below the max number of workers, wake up the manager to create one.
+ */
+static void io_wqe_wake_worker(struct io_wqe *wqe, struct io_wqe_acct *acct)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = io_wqe_activate_free_worker(wqe);
+	rcu_read_unlock();
+
+	if (!ret && acct->nr_workers < acct->max_workers)
+		wake_up_process(wqe->wq->manager);
+}
+
+static void io_wqe_inc_running(struct io_wqe *wqe, struct io_worker *worker)
+{
+	struct io_wqe_acct *acct = io_wqe_get_acct(wqe, worker);
+
+	atomic_inc(&acct->nr_running);
+}
+
+static void io_wqe_dec_running(struct io_wqe *wqe, struct io_worker *worker)
+	__must_hold(wqe->lock)
+{
+	struct io_wqe_acct *acct = io_wqe_get_acct(wqe, worker);
+
+	if (atomic_dec_and_test(&acct->nr_running) && io_wqe_run_queue(wqe))
+		io_wqe_wake_worker(wqe, acct);
+}
+
 static void io_worker_start(struct io_wqe *wqe, struct io_worker *worker)
 {
 	allow_kernel_signal(SIGINT);
@@ -198,7 +292,7 @@ static void io_worker_start(struct io_wqe *wqe, struct io_worker *worker)
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 	worker->restore_files = current->files;
-	atomic_inc(&wqe->nr_running);
+	io_wqe_inc_running(wqe, worker);
 }
 
 /*
@@ -209,6 +303,8 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 			     struct io_wq_work *work)
 	__must_hold(wqe->lock)
 {
+	bool worker_bound, work_bound;
+
 	if (worker->flags & IO_WORKER_F_FREE) {
 		worker->flags &= ~IO_WORKER_F_FREE;
 		hlist_nulls_del_init_rcu(&worker->nulls_node);
@@ -216,6 +312,26 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 						&wqe->busy_list.head);
 	}
 	worker->cur_work = work;
+
+	/*
+	 * If worker is moving from bound to unbound (or vice versa), then
+	 * ensure we update the running accounting.
+	 */
+	 worker_bound = (worker->flags & IO_WORKER_F_BOUND) != 0;
+	 work_bound = (work->flags & IO_WQ_WORK_UNBOUND) == 0;
+	 if (worker_bound != work_bound) {
+		io_wqe_dec_running(wqe, worker);
+		if (work_bound) {
+			worker->flags |= IO_WORKER_F_BOUND;
+			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers--;
+			wqe->acct[IO_WQ_ACCT_BOUND].nr_workers++;
+		} else {
+			worker->flags &= ~IO_WORKER_F_BOUND;
+			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers++;
+			wqe->acct[IO_WQ_ACCT_BOUND].nr_workers--;
+		}
+		io_wqe_inc_running(wqe, worker);
+	 }
 }
 
 /*
@@ -335,14 +451,6 @@ static void io_worker_handle_work(struct io_worker *worker)
 	} while (1);
 }
 
-static inline bool io_wqe_run_queue(struct io_wqe *wqe)
-	__must_hold(wqe->lock)
-{
-	if (!list_empty(&wqe->work_list) && !(wqe->flags & IO_WQE_FLAG_STALLED))
-		return true;
-	return false;
-}
-
 static int io_wqe_worker(void *data)
 {
 	struct io_worker *worker = data;
@@ -391,46 +499,6 @@ static int io_wqe_worker(void *data)
 	return 0;
 }
 
-/*
- * Check head of free list for an available worker. If one isn't available,
- * caller must wake up the wq manager to create one.
- */
-static bool io_wqe_activate_free_worker(struct io_wqe *wqe)
-	__must_hold(RCU)
-{
-	struct hlist_nulls_node *n;
-	struct io_worker *worker;
-
-	n = rcu_dereference(hlist_nulls_first_rcu(&wqe->free_list.head));
-	if (is_a_nulls(n))
-		return false;
-
-	worker = hlist_nulls_entry(n, struct io_worker, nulls_node);
-	if (io_worker_get(worker)) {
-		wake_up(&worker->wait);
-		io_worker_release(worker);
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * We need a worker. If we find a free one, we're good. If not, and we're
- * below the max number of workers, wake up the manager to create one.
- */
-static void io_wqe_wake_worker(struct io_wqe *wqe)
-{
-	bool ret;
-
-	rcu_read_lock();
-	ret = io_wqe_activate_free_worker(wqe);
-	rcu_read_unlock();
-
-	if (!ret && wqe->nr_workers < wqe->max_workers)
-		wake_up_process(wqe->wq->manager);
-}
-
 /*
  * Called when a worker is scheduled in. Mark us as currently running.
  */
@@ -444,7 +512,7 @@ void io_wq_worker_running(struct task_struct *tsk)
 	if (worker->flags & IO_WORKER_F_RUNNING)
 		return;
 	worker->flags |= IO_WORKER_F_RUNNING;
-	atomic_inc(&wqe->nr_running);
+	io_wqe_inc_running(wqe, worker);
 }
 
 /*
@@ -465,13 +533,13 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 	worker->flags &= ~IO_WORKER_F_RUNNING;
 
 	spin_lock_irq(&wqe->lock);
-	if (atomic_dec_and_test(&wqe->nr_running) && io_wqe_run_queue(wqe))
-		io_wqe_wake_worker(wqe);
+	io_wqe_dec_running(wqe, worker);
 	spin_unlock_irq(&wqe->lock);
 }
 
-static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe)
+static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 {
+	struct io_wqe_acct *acct =&wqe->acct[index];
 	struct io_worker *worker;
 
 	worker = kcalloc_node(1, sizeof(*worker), GFP_KERNEL, wqe->node);
@@ -493,24 +561,28 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe)
 	spin_lock_irq(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list.head);
 	worker->flags |= IO_WORKER_F_FREE;
-	if (!wqe->nr_workers)
+	if (index == IO_WQ_ACCT_BOUND)
+		worker->flags |= IO_WORKER_F_BOUND;
+	if (!acct->nr_workers && (worker->flags & IO_WORKER_F_BOUND))
 		worker->flags |= IO_WORKER_F_FIXED;
-	wqe->nr_workers++;
+	acct->nr_workers++;
 	spin_unlock_irq(&wqe->lock);
 
 	wake_up_process(worker->task);
 }
 
-static inline bool io_wqe_need_new_worker(struct io_wqe *wqe)
+static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 	__must_hold(wqe->lock)
 {
-	if (!wqe->nr_workers)
-		return true;
-	if (hlist_nulls_empty(&wqe->free_list.head) &&
-	    wqe->nr_workers < wqe->max_workers && io_wqe_run_queue(wqe))
-		return true;
+	struct io_wqe_acct *acct = &wqe->acct[index];
 
-	return false;
+	/* always ensure we have one bounded worker */
+	if (index == IO_WQ_ACCT_BOUND && !acct->nr_workers)
+		return true;
+	/* if we have available workers or no work, no need */
+	if (!hlist_nulls_empty(&wqe->free_list.head) || !io_wqe_run_queue(wqe))
+		return false;
+	return acct->nr_workers < acct->max_workers;
 }
 
 /*
@@ -525,13 +597,18 @@ static int io_wq_manager(void *data)
 
 		for (i = 0; i < wq->nr_wqes; i++) {
 			struct io_wqe *wqe = wq->wqes[i];
-			bool fork_worker = false;
+			bool fork_worker[2] = { false, false };
 
 			spin_lock_irq(&wqe->lock);
-			fork_worker = io_wqe_need_new_worker(wqe);
+			if (io_wqe_need_worker(wqe, IO_WQ_ACCT_BOUND))
+				fork_worker[IO_WQ_ACCT_BOUND] = true;
+			if (io_wqe_need_worker(wqe, IO_WQ_ACCT_UNBOUND))
+				fork_worker[IO_WQ_ACCT_UNBOUND] = true;
 			spin_unlock_irq(&wqe->lock);
-			if (fork_worker)
-				create_io_worker(wq, wqe);
+			if (fork_worker[IO_WQ_ACCT_BOUND])
+				create_io_worker(wq, wqe, IO_WQ_ACCT_BOUND);
+			if (fork_worker[IO_WQ_ACCT_UNBOUND])
+				create_io_worker(wq, wqe, IO_WQ_ACCT_UNBOUND);
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ);
@@ -542,15 +619,19 @@ static int io_wq_manager(void *data)
 
 static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
 {
+	struct io_wqe_acct *acct;
 	unsigned long flags;
 
+	/* Do this before queueing work, as work could finish anytime */
+	acct = io_work_get_acct(wqe, work);
+
 	spin_lock_irqsave(&wqe->lock, flags);
 	list_add_tail(&work->list, &wqe->work_list);
 	wqe->flags &= ~IO_WQE_FLAG_STALLED;
 	spin_unlock_irqrestore(&wqe->lock, flags);
 
-	if (!atomic_read(&wqe->nr_running))
-		io_wqe_wake_worker(wqe);
+	if (!atomic_read(&acct->nr_running))
+		io_wqe_wake_worker(wqe, acct);
 }
 
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work)
@@ -828,7 +909,8 @@ void io_wq_flush(struct io_wq *wq)
 	}
 }
 
-struct io_wq *io_wq_create(unsigned concurrency, struct mm_struct *mm)
+struct io_wq *io_wq_create(unsigned bounded, unsigned unbounded,
+			   struct mm_struct *mm)
 {
 	int ret = -ENOMEM, i, node;
 	struct io_wq *wq;
@@ -854,7 +936,10 @@ struct io_wq *io_wq_create(unsigned concurrency, struct mm_struct *mm)
 			break;
 		wq->wqes[i] = wqe;
 		wqe->node = node;
-		wqe->max_workers = concurrency;
+		wqe->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
+		atomic_set(&wqe->acct[IO_WQ_ACCT_BOUND].nr_running, 0);
+		wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers = unbounded;
+		atomic_set(&wqe->acct[IO_WQ_ACCT_UNBOUND].nr_running, 0);
 		wqe->node = node;
 		wqe->wq = wq;
 		spin_lock_init(&wqe->lock);
@@ -863,7 +948,6 @@ struct io_wq *io_wq_create(unsigned concurrency, struct mm_struct *mm)
 		wqe->free_list.nulls = 0;
 		INIT_HLIST_NULLS_HEAD(&wqe->busy_list.head, 1);
 		wqe->busy_list.nulls = 1;
-		atomic_set(&wqe->nr_running, 0);
 
 		i++;
 	}
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 3de192dc73fc..affd215f247f 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -9,6 +9,7 @@ enum {
 	IO_WQ_WORK_HASHED	= 4,
 	IO_WQ_WORK_NEEDS_USER	= 8,
 	IO_WQ_WORK_NEEDS_FILES	= 16,
+	IO_WQ_WORK_UNBOUND	= 32,
 
 	IO_WQ_HASH_SHIFT	= 24,	/* upper 8 bits are used for hash key */
 };
@@ -33,7 +34,8 @@ struct io_wq_work {
 		(work)->files = NULL;			\
 	} while (0)					\
 
-struct io_wq *io_wq_create(unsigned concurrency, struct mm_struct *mm);
+struct io_wq *io_wq_create(unsigned bounded, unsigned unbounded,
+				struct mm_struct *mm);
 void io_wq_destroy(struct io_wq *wq);
 
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index ff0f79a57f7b..c48b891b962f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3689,7 +3689,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
-	unsigned concurrency;
+	unsigned bounded;
 	int ret;
 
 	init_waitqueue_head(&ctx->sqo_wait);
@@ -3733,9 +3733,9 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
-	/* Do QD, or 4 * CPUS, whatever is smallest */
-	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
-	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm);
+	/* Do QD, or 2 * CPUS, whatever is smallest */
+	bounded = min(ctx->sq_entries, 2 * num_online_cpus());
+	ctx->io_wq = io_wq_create(bounded, ctx->cq_entries, ctx->sqo_mm);
 	if (IS_ERR(ctx->io_wq)) {
 		ret = PTR_ERR(ctx->io_wq);
 		ctx->io_wq = NULL;
-- 
2.24.0

