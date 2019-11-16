Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3CCC432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F349B2073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TiNx25bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKPBxZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35856 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBxZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so5897829pls.3
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FEYkN2RTPzcIHwrESdV5leReo4MshP+1Mj2d5eZJiw=;
        b=TiNx25bbiJuBwFDkNWGXLuR6fn7YNlPLDndHjd5GnDQAHK6ug1tJ9XzvDWx2DTNV4a
         IfH4I1dkEFEev368CTCyVrcLr0mPov+pJWD6qHkOtl5s/GrWHN8vKGTihgMlJBSE3j+j
         hHm88pjemI6tgu8zZzo9oClJDEcm5yM/FXADpNwFNX7leJL+9PxFkx8DyWEMPmsNz1L+
         vXjEO7XxqIbEN8l/lyqurYHt+6RtKsPjqBkMjd24Ti6mOTGDVLQb+lS94hTohKZyZWaq
         taVcc/Q/GS9wu3N8z4XuArale7Mh8CLwBFAtCOZwiJvDTd3Z4AJMQg3Af3iFbnbdWdyQ
         vRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FEYkN2RTPzcIHwrESdV5leReo4MshP+1Mj2d5eZJiw=;
        b=B5Q3Z714QIqLTqiB2/ka9hFb1uojXJygiLJ0C1wUMww9FyjR/2Xzdon6kiMymey+ri
         M1fRf9hZAvUmkw+H+MFEy7KUek9JHBaxaXhd/2/9A95FNtIFPDd9TCilTpI6ZOa88ZYB
         mnREvJjctVqwAmH/0OP+0T7u4CZ9QzYIkEQDi+dnsZEyU87Vsh/zQDwrvlu7wqhgUQzL
         6EgI1Lq+O1L7N5ncIVGTALdPFcLUrpQ0YXJ2Sr0wZQOEkXocatnhrqxZju0iNA46N6Ff
         zb6crFTnhGjmzZ6YAjjXZOIre2KUriyIa4dT8+y5JgRuDojo5rkfqvCnrFqx56A04AWa
         l5dw==
X-Gm-Message-State: APjAAAVaDr6A2PZGQ/Exiiy2GVXBIYJkQ76tJkfOJBP9Y10eNkb6VBv3
        VcryGDeUxb7Lv/OR6leAgTGC+i+YmKk=
X-Google-Smtp-Source: APXvYqx4aGUN5C3TorCF8IqzYtvNEQWJFM8J4DVqqvA71WoBFNxKGuwFj8yg8WUonntfCvR6dVxW+Q==
X-Received: by 2002:a17:902:8ec6:: with SMTP id x6mr18196323plo.151.1573869203147;
        Fri, 15 Nov 2019 17:53:23 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] io-wq: remove now redundant struct io_wq_nulls_list
Date:   Fri, 15 Nov 2019 18:53:07 -0700
Message-Id: <20191116015314.24276-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Since we don't iterate these lists anymore after commit:

e61df66c69b1 ("io-wq: ensure free/busy list browsing see all items")

we don't need to retain the nulls value we use for them. That means it's
pretty pointless to wrap the hlist_nulls_head in a structure, so get rid
of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index fcb6c74209da..9174007ce107 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -59,11 +59,6 @@ struct io_worker {
 	struct files_struct *restore_files;
 };
 
-struct io_wq_nulls_list {
-	struct hlist_nulls_head head;
-	unsigned long nulls;
-};
-
 #if BITS_PER_LONG == 64
 #define IO_WQ_HASH_ORDER	6
 #else
@@ -95,8 +90,8 @@ struct io_wqe {
 	int node;
 	struct io_wqe_acct acct[2];
 
-	struct io_wq_nulls_list free_list;
-	struct io_wq_nulls_list busy_list;
+	struct hlist_nulls_head free_list;
+	struct hlist_nulls_head busy_list;
 	struct list_head all_list;
 
 	struct io_wq *wq;
@@ -249,7 +244,7 @@ static bool io_wqe_activate_free_worker(struct io_wqe *wqe)
 	struct hlist_nulls_node *n;
 	struct io_worker *worker;
 
-	n = rcu_dereference(hlist_nulls_first_rcu(&wqe->free_list.head));
+	n = rcu_dereference(hlist_nulls_first_rcu(&wqe->free_list));
 	if (is_a_nulls(n))
 		return false;
 
@@ -325,8 +320,7 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 	if (worker->flags & IO_WORKER_F_FREE) {
 		worker->flags &= ~IO_WORKER_F_FREE;
 		hlist_nulls_del_init_rcu(&worker->nulls_node);
-		hlist_nulls_add_head_rcu(&worker->nulls_node,
-						&wqe->busy_list.head);
+		hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->busy_list);
 	}
 
 	/*
@@ -365,8 +359,7 @@ static bool __io_worker_idle(struct io_wqe *wqe, struct io_worker *worker)
 	if (!(worker->flags & IO_WORKER_F_FREE)) {
 		worker->flags |= IO_WORKER_F_FREE;
 		hlist_nulls_del_init_rcu(&worker->nulls_node);
-		hlist_nulls_add_head_rcu(&worker->nulls_node,
-						&wqe->free_list.head);
+		hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
 	}
 
 	return __io_worker_unuse(wqe, worker);
@@ -592,7 +585,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	}
 
 	spin_lock_irq(&wqe->lock);
-	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list.head);
+	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	if (index == IO_WQ_ACCT_BOUND)
@@ -617,7 +610,7 @@ static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND && !acct->nr_workers)
 		return true;
 	/* if we have available workers or no work, no need */
-	if (!hlist_nulls_empty(&wqe->free_list.head) || !io_wqe_run_queue(wqe))
+	if (!hlist_nulls_empty(&wqe->free_list) || !io_wqe_run_queue(wqe))
 		return false;
 	return acct->nr_workers < acct->max_workers;
 }
@@ -665,7 +658,7 @@ static bool io_wq_can_queue(struct io_wqe *wqe, struct io_wqe_acct *acct,
 		return true;
 
 	rcu_read_lock();
-	free_worker = !hlist_nulls_empty(&wqe->free_list.head);
+	free_worker = !hlist_nulls_empty(&wqe->free_list);
 	rcu_read_unlock();
 	if (free_worker)
 		return true;
@@ -1009,10 +1002,8 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 		wqe->wq = wq;
 		spin_lock_init(&wqe->lock);
 		INIT_LIST_HEAD(&wqe->work_list);
-		INIT_HLIST_NULLS_HEAD(&wqe->free_list.head, 0);
-		wqe->free_list.nulls = 0;
-		INIT_HLIST_NULLS_HEAD(&wqe->busy_list.head, 1);
-		wqe->busy_list.nulls = 1;
+		INIT_HLIST_NULLS_HEAD(&wqe->free_list, 0);
+		INIT_HLIST_NULLS_HEAD(&wqe->busy_list, 1);
 		INIT_LIST_HEAD(&wqe->all_list);
 
 		i++;
-- 
2.24.0

