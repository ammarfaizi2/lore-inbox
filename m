Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5595C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D37520659
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLVOZsdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfKIMZI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 07:25:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46218 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfKIMZH (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 07:25:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id e9so8933825ljp.13;
        Sat, 09 Nov 2019 04:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cqZWDexuhPPuiGCF/N9j/OA63pBQXUccM1dtWhxED8s=;
        b=cLVOZsdZuw0Lyfp6gL7weqVy3YWnrOLlR1/zqhpKJROEIcLyhZgE+4HVInU3uyzGLs
         enXoCIlHdvN5PHBq4hFfGvlJWJTM0My0NeHNqx1CFCQnr69Axxq0z8980pUIgiKBt24S
         d3Bn+qvDIp/pfGDt7PpwqAy4KgCoCZPUagJCVVhhRfpIW9rnXX718EWGSjB0Sxl8VtxH
         AYd9vL3sGZHmz+m9yAHCzyE5r68K3ko9cFiHrxN8NyTeAeQA69TCzPr/uiiUmedwnHWO
         TRpIWfxMeyVS8y4DatiCNMsWIViXEAPvgNzQEkQIyFTtZoyTKPOu4qMStf3s5BFeCFeS
         mdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cqZWDexuhPPuiGCF/N9j/OA63pBQXUccM1dtWhxED8s=;
        b=gPDa0eN08RRQuIlQMmw6eVeDZ2BKpCW+0KG4DhzAVUDQ7JCureifwOssb5Ysu35T+W
         F5erl+pMCMiMSiHpabdAMh6fHk3sT1q+9ncHfrnCBHm/R/5NFpmSzxlxM298EmMnHu//
         /L6fGaIRyDv4Y77v3iClKaVv0n6L39hNq5kSqsee3gvcq+rE1XTv0IqgYqrNv7a/elMr
         YDeQQ/2BtV8//elxHtac4sOJJSljWT3e9qlnBub4RXChJbGhnc+dNjXMS6ibPyjPYbjn
         kdbxVIapwNSo1B0f5ch1NKiyq03Qoq9IdLWjZd0D1edsskeLUtW4DGNwPkTTg5qx6M0f
         1d7Q==
X-Gm-Message-State: APjAAAWOLwVQErBQELxLd29e7jvCqKyWW7GMjgIqFWjq6dAY4WzHDYA7
        2eG4JhstrEXnj/Ws/j6FN60=
X-Google-Smtp-Source: APXvYqzm6lQaDL8GCHjpR2Ze9j/wVnAfHcfD50s+ZHQGbSTaI/6f1stKkEdmYD8euEsGgOr8AAgYpg==
X-Received: by 2002:a2e:9151:: with SMTP id q17mr5304795ljg.156.1573302304417;
        Sat, 09 Nov 2019 04:25:04 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id u5sm4274436ljg.68.2019.11.09.04.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 04:25:03 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add support for backlogged CQ ring
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, jannh@google.com
References: <20191107160043.31725-1-axboe@kernel.dk>
 <20191107160043.31725-4-axboe@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <e9469ed1-dec0-c8ee-ee0a-5e81ee10d1bc@gmail.com>
Date:   Sat, 9 Nov 2019 15:25:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107160043.31725-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/2019 7:00 PM, Jens Axboe wrote:
> Currently we drop completion events, if the CQ ring is full. That's fine
> for requests with bounded completion times, but it may make it harder to
> use io_uring with networked IO where request completion times are
> generally unbounded. Or with POLL, for example, which is also unbounded.
> 
> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
> for CQ ring overflows. First of all, it doesn't overflow the ring, it
> simply stores a backlog of completions that we weren't able to put into
> the CQ ring. To prevent the backlog from growing indefinitely, if the
> backlog is non-empty, we apply back pressure on IO submissions. Any
> attempt to submit new IO with a non-empty backlog will get an -EBUSY
> return from the kernel. This is a signal to the application that it has
> backlogged CQ events, and that it must reap those before being allowed
> to submit more IO.>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/io_uring.c                 | 103 ++++++++++++++++++++++++++++------
>  include/uapi/linux/io_uring.h |   1 +
>  2 files changed, 87 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f69d9794ce17..ff0f79a57f7b 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -207,6 +207,7 @@ struct io_ring_ctx {
>  
>  		struct list_head	defer_list;
>  		struct list_head	timeout_list;
> +		struct list_head	cq_overflow_list;
>  
>  		wait_queue_head_t	inflight_wait;
>  	} ____cacheline_aligned_in_smp;
> @@ -414,6 +415,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>  
>  	ctx->flags = p->flags;
>  	init_waitqueue_head(&ctx->cq_wait);
> +	INIT_LIST_HEAD(&ctx->cq_overflow_list);
>  	init_completion(&ctx->ctx_done);
>  	init_completion(&ctx->sqo_thread_started);
>  	mutex_init(&ctx->uring_lock);
> @@ -588,6 +590,72 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
>  	return &rings->cqes[tail & ctx->cq_mask];
>  }
>  
> +static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
> +{
> +	if (waitqueue_active(&ctx->wait))
> +		wake_up(&ctx->wait);
> +	if (waitqueue_active(&ctx->sqo_wait))
> +		wake_up(&ctx->sqo_wait);
> +	if (ctx->cq_ev_fd)
> +		eventfd_signal(ctx->cq_ev_fd, 1);
> +}
> +
> +static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
> +{
> +	struct io_rings *rings = ctx->rings;
> +	struct io_uring_cqe *cqe;
> +	struct io_kiocb *req;
> +	unsigned long flags;
> +	LIST_HEAD(list);
> +
> +	if (list_empty_careful(&ctx->cq_overflow_list))
> +		return;
> +	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
> +	    rings->cq_ring_entries)
> +		return;
> +
> +	spin_lock_irqsave(&ctx->completion_lock, flags);
> +
> +	while (!list_empty(&ctx->cq_overflow_list)) {
> +		cqe = io_get_cqring(ctx);
> +		if (!cqe && !force)
> +			break;> +
> +		req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
> +						list);
> +		list_move(&req->list, &list);
> +		if (cqe) {
> +			WRITE_ONCE(cqe->user_data, req->user_data);
> +			WRITE_ONCE(cqe->res, req->result);
> +			WRITE_ONCE(cqe->flags, 0);
> +		}

Hmm, second thought. We should account overflow here.

> +	}
> +
> +	io_commit_cqring(ctx);
> +	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> +	io_cqring_ev_posted(ctx);
> +
> +	while (!list_empty(&list)) {
> +		req = list_first_entry(&list, struct io_kiocb, list);
> +		list_del(&req->list);
> +		io_put_req(req, NULL);
> +	}
> +}
> +
> +static void io_cqring_overflow(struct io_ring_ctx *ctx, struct io_kiocb *req,
> +			       long res)
> +	__must_hold(&ctx->completion_lock)
> +{
> +	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
> +		WRITE_ONCE(ctx->rings->cq_overflow,
> +				atomic_inc_return(&ctx->cached_cq_overflow));
> +	} else {
> +		refcount_inc(&req->refs);
> +		req->result = res;
> +		list_add_tail(&req->list, &ctx->cq_overflow_list);
> +	}
> +}
> +
>  static void io_cqring_fill_event(struct io_kiocb *req, long res)
>  {
>  	struct io_ring_ctx *ctx = req->ctx;
> @@ -601,26 +669,15 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
>  	 * the ring.
>  	 */
>  	cqe = io_get_cqring(ctx);
> -	if (cqe) {
> +	if (likely(cqe)) {
>  		WRITE_ONCE(cqe->user_data, req->user_data);
>  		WRITE_ONCE(cqe->res, res);
>  		WRITE_ONCE(cqe->flags, 0);
>  	} else {
> -		WRITE_ONCE(ctx->rings->cq_overflow,
> -				atomic_inc_return(&ctx->cached_cq_overflow));
> +		io_cqring_overflow(ctx, req, res);
>  	}
>  }
>  
> -static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
> -{
> -	if (waitqueue_active(&ctx->wait))
> -		wake_up(&ctx->wait);
> -	if (waitqueue_active(&ctx->sqo_wait))
> -		wake_up(&ctx->sqo_wait);
> -	if (ctx->cq_ev_fd)
> -		eventfd_signal(ctx->cq_ev_fd, 1);
> -}
> -
>  static void io_cqring_add_event(struct io_kiocb *req, long res)
>  {
>  	struct io_ring_ctx *ctx = req->ctx;
> @@ -877,6 +934,9 @@ static unsigned io_cqring_events(struct io_ring_ctx *ctx)
>  {
>  	struct io_rings *rings = ctx->rings;
>  
> +	if (ctx->flags & IORING_SETUP_CQ_NODROP)
> +		io_cqring_overflow_flush(ctx, false);
> +
>  	/* See comment at the top of this file */
>  	smp_rmb();
>  	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
> @@ -2876,6 +2936,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  	int i, submitted = 0;
>  	bool mm_fault = false;
>  
> +	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
> +	    !list_empty(&ctx->cq_overflow_list))
> +		return -EBUSY;
> +
>  	if (nr > IO_PLUG_THRESHOLD) {
>  		io_submit_state_start(&state, ctx, nr);
>  		statep = &state;
> @@ -2967,6 +3031,7 @@ static int io_sq_thread(void *data)
>  	timeout = inflight = 0;
>  	while (!kthread_should_park()) {
>  		unsigned int to_submit;
> +		int ret;
>  
>  		if (inflight) {
>  			unsigned nr_events = 0;
> @@ -3051,8 +3116,9 @@ static int io_sq_thread(void *data)
>  		}
>  
>  		to_submit = min(to_submit, ctx->sq_entries);
> -		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
> -					   true);
> +		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
> +		if (ret > 0)
> +			inflight += ret;
>  	}
>  
>  	set_fs(old_fs);
> @@ -4116,8 +4182,10 @@ static int io_uring_flush(struct file *file, void *data)
>  	struct io_ring_ctx *ctx = file->private_data;
>  
>  	io_uring_cancel_files(ctx, data);
> -	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
> +	if (fatal_signal_pending(current) || (current->flags & PF_EXITING)) {
> +		io_cqring_overflow_flush(ctx, true);
>  		io_wq_cancel_all(ctx->io_wq);
> +	}
>  	return 0;
>  }
>  
> @@ -4418,7 +4486,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
>  	}
>  
>  	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
> -			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE))
> +			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
> +			IORING_SETUP_CQ_NODROP))
>  		return -EINVAL;
>  
>  	ret = io_uring_create(entries, &p);
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index f1a118b01d18..3d8517eb376e 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -56,6 +56,7 @@ struct io_uring_sqe {
>  #define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
>  #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
>  #define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
> +#define IORING_SETUP_CQ_NODROP	(1U << 4)	/* no CQ drops */
>  
>  #define IORING_OP_NOP		0
>  #define IORING_OP_READV		1
> 
