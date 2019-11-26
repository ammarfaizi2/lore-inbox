Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02BC432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13252080F
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 19:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jf9sE3ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKZTCM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:02:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43906 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKZTCM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 14:02:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id q16so4371067plr.10
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 11:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jie7PVnC0hxvSR+WInEZ62bfcYOuoQzIZ5qpMtN3sDM=;
        b=Jf9sE3keAzhQfFOD7vhxL+ig/05wQqb+W3y3N0Wvu2y7qVXi0twWuIyx2azpSO+e8F
         wRfopiR5qY3mVfwSgxUFeO4oqWHMOo10etLwYpT9UtsOuVYPXqp940sYxmmIiaLIypWD
         aH5xi+brKIxfUyzM2/d8ZGE21rutTK6uM/gBp4l/FFx0x3/DLHeB6k9SVXMx2qWfSNej
         waMRBfDyd5C9EIxcZQ1ncsObSBZZP0X9jRRV8/ua0Pzc6OLr7YfWvmyGScF+sfoEel8Y
         eRxhpV/LPGFl9l9yKcb8vyIDVunjmFts2ZrJsN8Bc5SVPFsRI2md9h01oAndB/ktnQVL
         xttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jie7PVnC0hxvSR+WInEZ62bfcYOuoQzIZ5qpMtN3sDM=;
        b=ff/JPc3foJGuBVEoU7qBPdCVN0dwzQwHurjvl1eAkjBARgBwo+VZ3dOPrXOUWzgyKl
         A4/Z6r8V9AUiL71SdN2cyXz63pN18QNzkVN0lLpUD4Uwzc2TOsETO31iuM8v+eOVK+bM
         0FzCwES4NIcygXpudbOK8XIpTHAISaDohnYeOoTzV7cHE5Gcs7fS1+8wQchonkDOPvrx
         k6tjxA9QFsGkhAUGeeb9X7YpJ6WSXSRVjzOSsxDbbZ7B+BnwJ3l6yJn/LIBNZRSozHus
         jtqYLuGsYsU6j2TVNOuKFU5xL+fIE/zUrcOpatrftebX3LhDD1RSsxTkP7+qQD2Z1WdD
         tXyw==
X-Gm-Message-State: APjAAAUEWzL83PmRQg6MNDi1jz8S1+l9DsVdqp6BdKgMBWu7BM7oAAio
        46OCw8vOELe9fUBedIK/UJu3s3bpsE3jpQ==
X-Google-Smtp-Source: APXvYqzcvMmsOsaXtcQ5ib0qItdGJVAU50/nHt09cSKIngHElt2mqIIPUNZhiEiM4Fx34lQmcCmF2Q==
X-Received: by 2002:a17:902:bf06:: with SMTP id bi6mr22427759plb.168.1574794929267;
        Tue, 26 Nov 2019 11:02:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c84sm14056104pfc.112.2019.11.26.11.02.07
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 11:02:08 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io-wq: shrink io_wq_work a bit
Message-ID: <00b28378-efa9-a2c4-727a-7673832e764c@kernel.dk>
Date:   Tue, 26 Nov 2019 12:02:07 -0700
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

Currently we're using 40 bytes for the io_wq_work structure, and 16 of
those is the doubly link list node. We don't need doubly linked lists,
we always add to tail to keep things ordered, and any other use case
is list traversal with deletion. For the deletion case, we can easily
support any node deletion by keeping track of the previous entry.

This shrinks io_wq_work to 32 bytes, and subsequently io_kiock from
io_uring to 216 to 208 bytes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io-wq.c b/fs/io-wq.c
index d3e8907cc182..91b85df0861e 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -84,7 +84,7 @@ enum {
 struct io_wqe {
 	struct {
 		spinlock_t lock;
-		struct list_head work_list;
+		struct io_wq_work_list work_list;
 		unsigned long hash_map;
 		unsigned flags;
 	} ____cacheline_aligned_in_smp;
@@ -236,7 +236,8 @@ static void io_worker_exit(struct io_worker *worker)
 static inline bool io_wqe_run_queue(struct io_wqe *wqe)
 	__must_hold(wqe->lock)
 {
-	if (!list_empty(&wqe->work_list) && !(wqe->flags & IO_WQE_FLAG_STALLED))
+	if (!wq_list_empty(&wqe->work_list) &&
+	    !(wqe->flags & IO_WQE_FLAG_STALLED))
 		return true;
 	return false;
 }
@@ -375,12 +376,15 @@ static bool __io_worker_idle(struct io_wqe *wqe, struct io_worker *worker)
 static struct io_wq_work *io_get_next_work(struct io_wqe *wqe, unsigned *hash)
 	__must_hold(wqe->lock)
 {
+	struct io_wq_work_node *node, *prev;
 	struct io_wq_work *work;
 
-	list_for_each_entry(work, &wqe->work_list, list) {
+	wq_list_for_each(node, prev, &wqe->work_list) {
+		work = container_of(node, struct io_wq_work, list);
+
 		/* not hashed, can run anytime */
 		if (!(work->flags & IO_WQ_WORK_HASHED)) {
-			list_del(&work->list);
+			wq_node_del(&wqe->work_list, node, prev);
 			return work;
 		}
 
@@ -388,7 +392,7 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe, unsigned *hash)
 		*hash = work->flags >> IO_WQ_HASH_SHIFT;
 		if (!(wqe->hash_map & BIT_ULL(*hash))) {
 			wqe->hash_map |= BIT_ULL(*hash);
-			list_del(&work->list);
+			wq_node_del(&wqe->work_list, node, prev);
 			return work;
 		}
 	}
@@ -416,7 +420,7 @@ static void io_worker_handle_work(struct io_worker *worker)
 		work = io_get_next_work(wqe, &hash);
 		if (work)
 			__io_worker_busy(wqe, worker, work);
-		else if (!list_empty(&wqe->work_list))
+		else if (!wq_list_empty(&wqe->work_list))
 			wqe->flags |= IO_WQE_FLAG_STALLED;
 
 		spin_unlock_irq(&wqe->lock);
@@ -526,7 +530,7 @@ static int io_wqe_worker(void *data)
 
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		spin_lock_irq(&wqe->lock);
-		if (!list_empty(&wqe->work_list))
+		if (!wq_list_empty(&wqe->work_list))
 			io_worker_handle_work(worker);
 		else
 			spin_unlock_irq(&wqe->lock);
@@ -714,7 +718,7 @@ static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
 	}
 
 	spin_lock_irqsave(&wqe->lock, flags);
-	list_add_tail(&work->list, &wqe->work_list);
+	wq_list_add_tail(&work->list, &wqe->work_list);
 	wqe->flags &= ~IO_WQE_FLAG_STALLED;
 	spin_unlock_irqrestore(&wqe->lock, flags);
 
@@ -829,14 +833,17 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 		.cancel = cancel,
 		.caller_data = cancel_data,
 	};
+	struct io_wq_work_node *node, *prev;
 	struct io_wq_work *work;
 	unsigned long flags;
 	bool found = false;
 
 	spin_lock_irqsave(&wqe->lock, flags);
-	list_for_each_entry(work, &wqe->work_list, list) {
+	wq_list_for_each(node, prev, &wqe->work_list) {
+		work = container_of(node, struct io_wq_work, list);
+
 		if (cancel(work, cancel_data)) {
-			list_del(&work->list);
+			wq_node_del(&wqe->work_list, node, prev);
 			found = true;
 			break;
 		}
@@ -894,6 +901,7 @@ static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 					    struct io_wq_work *cwork)
 {
+	struct io_wq_work_node *node, *prev;
 	struct io_wq_work *work;
 	unsigned long flags;
 	bool found = false;
@@ -906,9 +914,11 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 	 * no completion will be posted for it.
 	 */
 	spin_lock_irqsave(&wqe->lock, flags);
-	list_for_each_entry(work, &wqe->work_list, list) {
+	wq_list_for_each(node, prev, &wqe->work_list) {
+		work = container_of(node, struct io_wq_work, list);
+
 		if (work == cwork) {
-			list_del(&work->list);
+			wq_node_del(&wqe->work_list, node, prev);
 			found = true;
 			break;
 		}
@@ -1023,7 +1033,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		wqe->node = node;
 		wqe->wq = wq;
 		spin_lock_init(&wqe->lock);
-		INIT_LIST_HEAD(&wqe->work_list);
+		INIT_WQ_LIST(&wqe->work_list);
 		INIT_HLIST_NULLS_HEAD(&wqe->free_list, 0);
 		INIT_HLIST_NULLS_HEAD(&wqe->busy_list, 1);
 		INIT_LIST_HEAD(&wqe->all_list);
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 5cd8c7697e88..600e0158cba7 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -22,18 +22,60 @@ enum io_wq_cancel {
 	IO_WQ_CANCEL_NOTFOUND,	/* work not found */
 };
 
+struct io_wq_work_node {
+	struct io_wq_work_node *next;
+};
+
+struct io_wq_work_list {
+	struct io_wq_work_node *first;
+	struct io_wq_work_node *last;
+};
+
+static inline void wq_list_add_tail(struct io_wq_work_node *node,
+				    struct io_wq_work_list *list)
+{
+	if (!list->first) {
+		list->first = list->last = node;
+	} else {
+		list->last->next = node;
+		list->last = node;
+	}
+}
+
+static inline void wq_node_del(struct io_wq_work_list *list,
+			       struct io_wq_work_node *node,
+			       struct io_wq_work_node *prev)
+{
+	if (node == list->first)
+		list->first = node->next;
+	if (node == list->last)
+		list->last = prev;
+	if (prev)
+		prev->next = node->next;
+}
+
+#define wq_list_for_each(pos, prv, head)			\
+	for (pos = (head)->first, prv = NULL; pos; prv = pos, pos = (pos)->next)
+
+#define wq_list_empty(list)	((list)->first == NULL)
+#define INIT_WQ_LIST(list)	do {				\
+	(list)->first = NULL;					\
+	(list)->last = NULL;					\
+} while (0)
+
 struct io_wq_work {
 	union {
-		struct list_head list;
+		struct io_wq_work_node list;
 		void *data;
 	};
 	void (*func)(struct io_wq_work **);
-	unsigned flags;
 	struct files_struct *files;
+	unsigned flags;
 };
 
 #define INIT_IO_WORK(work, _func)			\
 	do {						\
+		(work)->list.next = NULL;		\
 		(work)->func = _func;			\
 		(work)->flags = 0;			\
 		(work)->files = NULL;			\

-- 
Jens Axboe

