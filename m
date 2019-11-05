Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E986CC47E49
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF45321D6C
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 22:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bgi11lEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfKEWXO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:23:14 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40953 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbfKEWXO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 17:23:14 -0500
Received: by mail-pf1-f173.google.com with SMTP id r4so17074781pfl.7
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TVLm4ruVrX8m9Bhwx5HW6bMmrVvPWmbb8Gqhs5MfeNs=;
        b=Bgi11lEuEOS+w9rsnGfF77p4I75nfBpRYsFnZnrqL6sqHdBID1krIKgFOu/TgrCI24
         tcwQId6MCv69QykHqZmtGi5fX1HTVlDjGccoU7SLJQnP7+exjgfJjM5jgIgdJDgC/8gp
         xE8HqgBWLgjfISvOtJPXLUY1Je9X+zRM6d34ifBhkfH+is2B/a1CPs+p5RN3/lUKUudw
         RIG5QqyacodeChrPtIrSDwhEabduk83M6cdxExq74X7Y3yjOTIbJk367YH1pxsAtS+BD
         Jto2RZayMj9c+wk4/kNptWuaLhRYgETDoNchRRcNKg7LWdD4QbjiM+4nFZ6IHq6nHgWT
         topQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TVLm4ruVrX8m9Bhwx5HW6bMmrVvPWmbb8Gqhs5MfeNs=;
        b=k1gQ7wDyG7g3YSqq3w7/8viBTNFVfVp1S8O8TS6jhQrRTJGVNQsx51zdLxuxiXzxJA
         u+Piw2cH7BM7xKOrlSmdLDVZre7yMGJj4zaTung72poy+nCOrZT2cEyN0ZT+AHcoyzER
         5FbnbhnD0Z8RH7IqWeD0hfiZ7dmEakhXyps/D67vgI1utUk80xUcaBv9KJNBY3zngpn+
         emzLy8NdzuG2CnV0Q2s1vbXHtLnt0OV++dg+TBacQs4gp2vohlwc3Qw6Jcjx+lgrGelG
         MAQm91bg+5po1oSZaVrjfoTub8bKlBo+CaTKiHFY2j8wL78/QLg/VBGcJLfJxee7wUTu
         mgtA==
X-Gm-Message-State: APjAAAWwNNsqvHcnyJ+ac7UtP+sCC7m9jx4Cxza/6kSBcKgxe1RHJBi+
        6USxiUl30Qb6WI6mPTsuDpjdH4omtCs=
X-Google-Smtp-Source: APXvYqyx8Op2DRbHgtWfoPFe/S38sygF+vsfA/uCiFpgEbnFBFeC7Ee9Y8l96iMMyBn8UzL9XAqBIQ==
X-Received: by 2002:a62:2942:: with SMTP id p63mr33610614pfp.110.1572992592827;
        Tue, 05 Nov 2019 14:23:12 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z23sm20163625pgu.16.2019.11.05.14.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:23:11 -0800 (PST)
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: enable optimized link handling for
 IORING_OP_POLL_ADD
Message-ID: <615f6b1e-a8a3-1a9d-16b6-a3145a767b51@kernel.dk>
Date:   Tue, 5 Nov 2019 15:23:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

As introduced by commit:

ba816ad61fdf ("io_uring: run dependent links inline if possible")

enable inline dependent link running for poll commands.
io_poll_complete_work() is the most important change, as it allows a
linked sequence of { POLL, READ } (for example) to proceed inline
instead of needing to get punted to another async context. The
submission side only potentially matters for sqthread, but may as well
include that bit.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d4ff3e49a78c..d074f3f04a63 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1862,6 +1862,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	struct io_poll_iocb *poll = &req->poll;
 	struct poll_table_struct pt = { ._key = poll->events };
 	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *nxt = NULL;
 	__poll_t mask = 0;
 
 	if (work->flags & IO_WQ_WORK_CANCEL)
@@ -1888,7 +1889,10 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_ev_posted(ctx);
-	io_put_req(req, NULL);
+
+	io_put_req(req, &nxt);
+	if (nxt)
+		*workptr = &nxt->work;
 }
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -1942,7 +1946,8 @@ static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->req->poll.wait);
 }
 
-static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		       struct io_kiocb **nxt)
 {
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_ring_ctx *ctx = req->ctx;
@@ -2005,7 +2010,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (mask) {
 		io_cqring_ev_posted(ctx);
-		io_put_req(req, NULL);
+		io_put_req(req, nxt);
 	}
 	return ipt.error;
 }
@@ -2303,7 +2308,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_fsync(req, s->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_POLL_ADD:
-		ret = io_poll_add(req, s->sqe);
+		ret = io_poll_add(req, s->sqe, nxt);
 		break;
 	case IORING_OP_POLL_REMOVE:
 		ret = io_poll_remove(req, s->sqe);

-- 
Jens Axboe

