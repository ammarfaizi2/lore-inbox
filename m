Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D7DC2D0BF
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6B72053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y7ITHrZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJP5u (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34091 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJP5u (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:50 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so19313176iof.1
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNqUpqw7O74f1dMrv2LeoxqBlPeqbctKOiYYE2ughno=;
        b=Y7ITHrZustAYHnzJZc9xQ/uEZJY3pZa1l3d6geo+YywD2v2uYHZHtQsLkxfkjTx7DG
         cmabmDEmmXVWZ9jg2f4heIG/jTB2MGVcd+L5WOb1DuG7Tgg5si1EWQFqz9rccnZhMgd8
         7arIwQ6lcxeb3w23nkMmLYNzQSNC4Zs4Nc+b/XlW8BwuGGp0dwOW0GSfQaqkgCJjuPNn
         lefh0D9GWjlu1jVftJ87SkcJ8qS6oUtgVUyIx8LD1iDN3ANBgHDjk3iOfpysaIM9z1vH
         JiTDHpLT5zD5GFVwkCsOLLB2gzr5JaCDYSG8MWGmz2pJbATXgABsrFLBdRVu8Rfdu8iA
         G4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNqUpqw7O74f1dMrv2LeoxqBlPeqbctKOiYYE2ughno=;
        b=V2Z5TdrxLTgPInzjI6xHgb91bmPi3VsZyHpif7T80bIdBWUXJcsaPB4Z9sMp3MQUdR
         BGKQzsIYzlqMpwpc4KQTuT0kBRHXLaZTrXpdH/WgRVea1qC/GjlMhhUFX6+KVji6fQVH
         dO77H+b7bKKQ/429Xm2CZaNYadxt9qXlKGO0vLikNRNS9fH3GjB7fu5VdnqMZM9YjdfT
         mrCiE6/uvoLSlZED/J4jcTQiPG4YxBoaXURv/S5hWjFRc4e4iOSC5cjdkT1NdYLSg2qj
         ExRxQq5uAtQ/eaWWeog4YyGNFh55LQ2nFv2pVVsKvFBVIl2KuVqAFPQHSWu9iP7i5u+B
         Ou/A==
X-Gm-Message-State: APjAAAUTBJABx3dGGmcloSIGlCohSKaobungwStiShAWiohFPjG7cpi2
        IrNWbXu4Kk8e+Vfv3Po4Wq0QW41LFbfmaA==
X-Google-Smtp-Source: APXvYqxl/AXlBVmyRCnD6hEdEO3cadWFU318XzrN1U64A0MvEAqPlSAONc49i8Et1rabcPOWWWSSaQ==
X-Received: by 2002:a5e:d616:: with SMTP id w22mr24987714iom.57.1575993468864;
        Tue, 10 Dec 2019 07:57:48 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] io-wq: remove worker->wait waitqueue
Date:   Tue, 10 Dec 2019 08:57:33 -0700
Message-Id: <20191210155742.5844-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We only have one cases of using the waitqueue to wake the worker, the
rest are using wake_up_process(). Since we can save some cycles not
fiddling with the waitqueue io_wqe_worker(), switch the work activation
to task wakeup and get rid of the now unused wait_queue_head_t in
struct io_worker.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 74b40506c5d9..6b663ddceb42 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -49,7 +49,6 @@ struct io_worker {
 	struct hlist_nulls_node nulls_node;
 	struct list_head all_list;
 	struct task_struct *task;
-	wait_queue_head_t wait;
 	struct io_wqe *wqe;
 
 	struct io_wq_work *cur_work;
@@ -258,7 +257,7 @@ static bool io_wqe_activate_free_worker(struct io_wqe *wqe)
 
 	worker = hlist_nulls_entry(n, struct io_worker, nulls_node);
 	if (io_worker_get(worker)) {
-		wake_up(&worker->wait);
+		wake_up_process(worker->task);
 		io_worker_release(worker);
 		return true;
 	}
@@ -497,13 +496,11 @@ static int io_wqe_worker(void *data)
 	struct io_worker *worker = data;
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
-	DEFINE_WAIT(wait);
 
 	io_worker_start(wqe, worker);
 
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
-		prepare_to_wait(&worker->wait, &wait, TASK_INTERRUPTIBLE);
-
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irq(&wqe->lock);
 		if (io_wqe_run_queue(wqe)) {
 			__set_current_state(TASK_RUNNING);
@@ -526,8 +523,6 @@ static int io_wqe_worker(void *data)
 			break;
 	}
 
-	finish_wait(&worker->wait, &wait);
-
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		spin_lock_irq(&wqe->lock);
 		if (!wq_list_empty(&wqe->work_list))
@@ -589,7 +584,6 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 
 	refcount_set(&worker->ref, 1);
 	worker->nulls_node.pprev = NULL;
-	init_waitqueue_head(&worker->wait);
 	worker->wqe = wqe;
 	spin_lock_init(&worker->lock);
 
-- 
2.24.0

