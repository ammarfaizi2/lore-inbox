Return-Path: <SRS0=AAoI=Z2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19AC2BC73
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8414920674
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rRgS+Nxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfLDSKk (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:10:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46193 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfLDSKk (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 13:10:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id y14so209500pfm.13
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0Dq5CLUtpEWReQbrJGKfNuw7uDjFETZU0hkDKQXNIPY=;
        b=rRgS+Nxi6ect6IAtIOHUtMVnu21k+aT5L06p43HHjRIpKt+MeiDDsj+xslSrYE469y
         z3BssazSgOs2BFKYnOnJYYt2SxZgxj5PN7/Mqb90juVbVMynpRCGggellb1c2eXDZnZY
         JSox3XD8B5txSP4xWH6VLwjlLLqFWrGKumnGBUi7nb6XZkvi28G7oEZcjMAssd9/ENzD
         i3xoSUCMSE/HzoZzhuspTJ/NlPex6Js3vQU5YvTa5IqIx1RpjtWfHS54a2tLvIxBRe/P
         r0gxYo9O/L2ViIBXjLpEkKa/jWvzC/c8itiS/4PZRo44bpMcbCzfb84LTLShP0uwD+he
         geIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0Dq5CLUtpEWReQbrJGKfNuw7uDjFETZU0hkDKQXNIPY=;
        b=iDmcbSQdGbxYt6iLGgS/RrSo4cAGuSS8xMuDkccjnWIvHl9XYz57HFQyYiEMUA3XW0
         iCBPCM5I+KuOepF6CAb8yeTbDWrMqdoHTPB4FgC1sFgA3aQQdktr/qCJ3tyFW6GMkktV
         ezKi+R8Jhc/BZ6Ldt9n4Zob2J/AU4y1zMRVpadTkIAAF+bArZJg6jcmH4BLrwCcFFgsU
         t6Z21rskXTtjGa7q1oR9Tpj8X1vCBIvhLc3M/A5eHDXJ02Od8YSmi5SOlaetbiEnMDwD
         SRRtwKEPFWE9TLoz5KsRNBxevpBGQ+NCmYlr2+2K1fvWtmCEKVTGXm6S/ksl8tfZMwHE
         2OwA==
X-Gm-Message-State: APjAAAUXcG1hQ7xuXUEA0k7Cw0Bfbtrf6Zzj0tSX4frvEr5r2+LHTFt2
        +f7GEotEDDpA6wpY+Aik0NEfgLkQxf4=
X-Google-Smtp-Source: APXvYqzbIkr2HGDYq0ZUrD4y3ttpGeHukexinCEKf8Rwbess3/LbgdhOCPAIKh+L9lAMetSDEFcnRg==
X-Received: by 2002:a65:4387:: with SMTP id m7mr4685795pgp.449.1575483038795;
        Wed, 04 Dec 2019 10:10:38 -0800 (PST)
Received: from ?IPv6:2600:380:773a:5b02:6cdc:2b6b:f076:1745? ([2600:380:773a:5b02:6cdc:2b6b:f076:1745])
        by smtp.gmail.com with ESMTPSA id i5sm4423144pgj.58.2019.12.04.10.10.37
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:10:37 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: ensure deferred timeouts copy necessary data
Message-ID: <dc8f2c01-2156-95db-3a42-89b6ff8661e4@kernel.dk>
Date:   Wed, 4 Dec 2019 11:10:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If we defer a timeout, we should ensure that we copy the timespec
when we have consumed the sqe. This is similar to commit f67676d160c6
for read/write requests. We already did this correctly for timeouts
deferred as links, but do it generally and use the infratructure added
by commit 1a6b74fc8702 instead of having the timeout deferral use its
own.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 00f119bdd8ff..01e75a37652a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -303,11 +303,6 @@ struct io_timeout_data {
 	u32				seq_offset;
 };
 
-struct io_timeout {
-	struct file			*file;
-	struct io_timeout_data		*data;
-};
-
 struct io_async_connect {
 	struct sockaddr_storage		address;
 };
@@ -332,6 +327,7 @@ struct io_async_ctx {
 		struct io_async_rw	rw;
 		struct io_async_msghdr	msg;
 		struct io_async_connect	connect;
+		struct io_timeout_data	timeout;
 	};
 };
 
@@ -346,7 +342,6 @@ struct io_kiocb {
 		struct file		*file;
 		struct kiocb		rw;
 		struct io_poll_iocb	poll;
-		struct io_timeout	timeout;
 	};
 
 	const struct io_uring_sqe	*sqe;
@@ -619,7 +614,7 @@ static void io_kill_timeout(struct io_kiocb *req)
 {
 	int ret;
 
-	ret = hrtimer_try_to_cancel(&req->timeout.data->timer);
+	ret = hrtimer_try_to_cancel(&req->io->timeout.timer);
 	if (ret != -1) {
 		atomic_inc(&req->ctx->cq_timeouts);
 		list_del_init(&req->list);
@@ -877,8 +872,6 @@ static void __io_free_req(struct io_kiocb *req)
 			wake_up(&ctx->inflight_wait);
 		spin_unlock_irqrestore(&ctx->inflight_lock, flags);
 	}
-	if (req->flags & REQ_F_TIMEOUT)
-		kfree(req->timeout.data);
 	percpu_ref_put(&ctx->refs);
 	if (likely(!io_is_fallback_req(req)))
 		kmem_cache_free(req_cachep, req);
@@ -891,7 +884,7 @@ static bool io_link_cancel_timeout(struct io_kiocb *req)
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
-	ret = hrtimer_try_to_cancel(&req->timeout.data->timer);
+	ret = hrtimer_try_to_cancel(&req->io->timeout.timer);
 	if (ret != -1) {
 		io_cqring_fill_event(req, -ECANCELED);
 		io_commit_cqring(ctx);
@@ -2618,7 +2611,7 @@ static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
 	if (ret == -ENOENT)
 		return ret;
 
-	ret = hrtimer_try_to_cancel(&req->timeout.data->timer);
+	ret = hrtimer_try_to_cancel(&req->io->timeout.timer);
 	if (ret == -1)
 		return -EALREADY;
 
@@ -2660,25 +2653,27 @@ static int io_timeout_remove(struct io_kiocb *req,
 	return 0;
 }
 
-static int io_timeout_setup(struct io_kiocb *req)
+static int io_timeout_prep(struct io_kiocb *req, struct io_async_ctx *io,
+			   bool is_timeout_link)
 {
 	const struct io_uring_sqe *sqe = req->sqe;
 	struct io_timeout_data *data;
 	unsigned flags;
 
+	BUG_ON(req->io);
+
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (sqe->ioprio || sqe->buf_index || sqe->len != 1)
 		return -EINVAL;
+	if (sqe->off && is_timeout_link)
+		return -EINVAL;
 	flags = READ_ONCE(sqe->timeout_flags);
 	if (flags & ~IORING_TIMEOUT_ABS)
 		return -EINVAL;
 
-	data = kzalloc(sizeof(struct io_timeout_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	data = &io->timeout;
 	data->req = req;
-	req->timeout.data = data;
 	req->flags |= REQ_F_TIMEOUT;
 
 	if (get_timespec64(&data->ts, u64_to_user_ptr(sqe->addr)))
@@ -2690,6 +2685,7 @@ static int io_timeout_setup(struct io_kiocb *req)
 		data->mode = HRTIMER_MODE_REL;
 
 	hrtimer_init(&data->timer, CLOCK_MONOTONIC, data->mode);
+	req->io = io;
 	return 0;
 }
 
@@ -2698,13 +2694,24 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	unsigned count;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_timeout_data *data;
+	struct io_async_ctx *io;
 	struct list_head *entry;
 	unsigned span = 0;
-	int ret;
 
-	ret = io_timeout_setup(req);
-	if (ret)
-		return ret;
+	io = req->io;
+	if (!io) {
+		int ret;
+
+		io = kmalloc(sizeof(*io), GFP_KERNEL);
+		if (!io)
+			return -ENOMEM;
+		ret = io_timeout_prep(req, io, false);
+		if (ret) {
+			kfree(io);
+			return ret;
+		}
+	}
+	data = &req->io->timeout;
 
 	/*
 	 * sqe->off holds how many events that need to occur for this
@@ -2720,7 +2727,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 
 	req->sequence = ctx->cached_sq_head + count - 1;
-	req->timeout.data->seq_offset = count;
+	data->seq_offset = count;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
@@ -2731,7 +2738,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
 		unsigned nxt_sq_head;
 		long long tmp, tmp_nxt;
-		u32 nxt_offset = nxt->timeout.data->seq_offset;
+		u32 nxt_offset = nxt->io->timeout.seq_offset;
 
 		if (nxt->flags & REQ_F_TIMEOUT_NOSEQ)
 			continue;
@@ -2764,7 +2771,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	req->sequence -= span;
 add:
 	list_add(&req->list, entry);
-	data = req->timeout.data;
 	data->timer.function = io_timeout_fn;
 	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 	spin_unlock_irq(&ctx->completion_lock);
@@ -2872,6 +2878,10 @@ static int io_req_defer_prep(struct io_kiocb *req, struct io_async_ctx *io)
 	case IORING_OP_CONNECT:
 		ret = io_connect_prep(req, io);
 		break;
+	case IORING_OP_TIMEOUT:
+		return io_timeout_prep(req, io, false);
+	case IORING_OP_LINK_TIMEOUT:
+		return io_timeout_prep(req, io, true);
 	default:
 		req->io = io;
 		return 0;
@@ -2899,17 +2909,18 @@ static int io_req_defer(struct io_kiocb *req)
 	if (!io)
 		return -EAGAIN;
 
+	ret = io_req_defer_prep(req, io);
+	if (ret < 0) {
+		kfree(io);
+		return ret;
+	}
+
 	spin_lock_irq(&ctx->completion_lock);
 	if (!req_need_defer(req) && list_empty(&ctx->defer_list)) {
 		spin_unlock_irq(&ctx->completion_lock);
-		kfree(io);
 		return 0;
 	}
 
-	ret = io_req_defer_prep(req, io);
-	if (ret < 0)
-		return ret;
-
 	trace_io_uring_defer(ctx, req, req->user_data);
 	list_add_tail(&req->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
@@ -3198,7 +3209,7 @@ static void io_queue_linked_timeout(struct io_kiocb *req)
 	 */
 	spin_lock_irq(&ctx->completion_lock);
 	if (!list_empty(&req->list)) {
-		struct io_timeout_data *data = req->timeout.data;
+		struct io_timeout_data *data = &req->io->timeout;
 
 		data->timer.function = io_link_timeout_fn;
 		hrtimer_start(&data->timer, timespec64_to_ktime(data->ts),
@@ -3345,17 +3356,6 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 		if (req->sqe->flags & IOSQE_IO_DRAIN)
 			(*link)->flags |= REQ_F_DRAIN_LINK | REQ_F_IO_DRAIN;
 
-		if (READ_ONCE(req->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
-			ret = io_timeout_setup(req);
-			/* common setup allows offset being set, we don't */
-			if (!ret && req->sqe->off)
-				ret = -EINVAL;
-			if (ret) {
-				prev->flags |= REQ_F_FAIL_LINK;
-				goto err_req;
-			}
-		}
-
 		io = kmalloc(sizeof(*io), GFP_KERNEL);
 		if (!io) {
 			ret = -EAGAIN;
@@ -3363,8 +3363,11 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 		}
 
 		ret = io_req_defer_prep(req, io);
-		if (ret)
+		if (ret) {
+			kfree(io);
+			prev->flags |= REQ_F_FAIL_LINK;
 			goto err_req;
+		}
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (req->sqe->flags & IOSQE_IO_LINK) {

-- 
Jens Axboe

