Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB1C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C420E20869
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hb+bY0l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfKFTks (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:40:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43116 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKFTks (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 14:40:48 -0500
Received: by mail-il1-f195.google.com with SMTP id r9so6195184ilq.10
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 11:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpXSGKQxRQoGOXn6wQCl4ajg6gRDD0w1jwQM/eWxsW4=;
        b=Hb+bY0l8j5NYpY6DvqttZ/wltt/ZyvzDmt3I/XuBnEXRvRdwowQxhSyOWBxRVgVTjO
         dtEbV78dWZT/mTe9H5AiAcgyD0r4BOLGGjIuNvvLpZTqu/QnX38Eqf7HwfWaPvstcdjx
         pAJoRs1ah0P0gawjygeZDrkG/iARSAePSiJlUJlw0QJmwsKsLezc+bCjHb37ZDfoOxeQ
         T/xQT8aBWfS8E/BfkV/iMLL64YLatPB1NgcgjoYVz6lh52KJ/fJZ2kgpfyfGQgdf+QEI
         T/YQrY/hrNo9GYLNPLf4QNmf9hyLMrPUmwC79fLGJLVVsn92+e1IBPiGocEg+qehSrFo
         zHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpXSGKQxRQoGOXn6wQCl4ajg6gRDD0w1jwQM/eWxsW4=;
        b=OJ13/buu1gyGXhZ/lCS0jI7PdQ8x20Gg5K8mP4X23NLYCZFMeyWsjq28b6XF1DVFks
         KKQdxFGvTf4m8tx5+xFMLkgNpGHs5VzJe12FKHpnWgaWmboEspdlrsax4FLjiN8wu2EE
         kSuYSTPzQXs8SLWCWf7fcCgtHndvbqLBB5/M333tkeLOaWXlvJ8n+ig1kH4LkZ6eqdmR
         NFRhQEJtTFl+vr3q2kyLQltXSkVKbJO8awZzCKhfKbBa9PNKCW/KE9YTjUmgG4x1Zm3s
         9rQEXR9E3XjniVcJ68U8IlbgDuQ7S1FXav/L5m2h0kg+XrUU7o5gN+vvtxEGG0O3IQEj
         YYyg==
X-Gm-Message-State: APjAAAWSPmWpd5arqCpyAecbBAlpVsR5fRMHncO2fTbzP9F9dotjwbu5
        m5xeAPFqH/Drsdrr4BwZScyp0yuUVx0=
X-Google-Smtp-Source: APXvYqwVvpb8EJlpCAfjgjJ0PkA6s9MYAo5ZN/Wolxw+beiLk1ejzU3AyZLEsVJbzlQqy/x+FAT3hg==
X-Received: by 2002:a92:5cdd:: with SMTP id d90mr5002115ilg.48.1573069245978;
        Wed, 06 Nov 2019 11:40:45 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k22sm911298iot.34.2019.11.06.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:40:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io-wq: pass in io_wq to work handler
Date:   Wed,  6 Nov 2019 12:40:39 -0700
Message-Id: <20191106194040.26723-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106194040.26723-1-axboe@kernel.dk>
References: <20191106194040.26723-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is the io_wq that the work is executing on. No functional changes
in this patch, we'll need this in a future patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 8 ++++----
 fs/io-wq.h    | 2 +-
 fs/io_uring.c | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index ba40a7ee31c3..4ebbdd068ebf 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -318,7 +318,7 @@ static void io_worker_handle_work(struct io_worker *worker)
 			work->flags |= IO_WQ_WORK_HAS_MM;
 
 		old_work = work;
-		work->func(&work);
+		work->func(wq, &work);
 
 		spin_lock_irq(&wqe->lock);
 		worker->cur_work = NULL;
@@ -685,7 +685,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 
 	if (found) {
 		work->flags |= IO_WQ_WORK_CANCEL;
-		work->func(&work);
+		work->func(wqe->wq, &work);
 		return IO_WQ_CANCEL_OK;
 	}
 
@@ -757,7 +757,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 
 	if (found) {
 		work->flags |= IO_WQ_WORK_CANCEL;
-		work->func(&work);
+		work->func(wqe->wq, &work);
 		return IO_WQ_CANCEL_OK;
 	}
 
@@ -801,7 +801,7 @@ struct io_wq_flush_data {
 	struct completion done;
 };
 
-static void io_wq_flush_func(struct io_wq_work **workptr)
+static void io_wq_flush_func(struct io_wq *wq, struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_wq_flush_data *data;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 3de192dc73fc..9fe8c97bcbd2 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -21,7 +21,7 @@ enum io_wq_cancel {
 
 struct io_wq_work {
 	struct list_head list;
-	void (*func)(struct io_wq_work **);
+	void (*func)(struct io_wq *, struct io_wq_work **);
 	unsigned flags;
 	struct files_struct *files;
 };
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6c13411896b5..ad452be9f3bc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -369,7 +369,7 @@ struct io_submit_state {
 	unsigned int		ios_left;
 };
 
-static void io_wq_submit_work(struct io_wq_work **workptr);
+static void io_wq_submit_work(struct io_wq *wq, struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
@@ -1930,7 +1930,7 @@ static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	io_commit_cqring(ctx);
 }
 
-static void io_poll_complete_work(struct io_wq_work **workptr)
+static void io_poll_complete_work(struct io_wq *wq, struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
@@ -2436,7 +2436,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return 0;
 }
 
-static void io_wq_submit_work(struct io_wq_work **workptr)
+static void io_wq_submit_work(struct io_wq *wq, struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-- 
2.24.0

