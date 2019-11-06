Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49DBFC6194
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7DA2173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n5Jq4NTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKFWmF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:42:05 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40563 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWmF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:42:05 -0500
Received: by mail-il1-f195.google.com with SMTP id d83so23281284ilk.7
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jc9HLe4ELv5FZ7PDoVIK3zh5An7Po+SoFaOa1SXJRpA=;
        b=n5Jq4NTeUDEO7kMMRCB+lGSaOYSxWN8cKdblj7msyvK/GGa2k06nRv/jsBr/OxuJ5M
         IUQqM/dSl2TIP6MoHxLy/ZI5YHhLEshTMC70I8wilKy9867Nq15OaK/YBZdY1++yjPCR
         nol4GvYx1GWqDZXZ604h206zipgqp7o0YdzN5Gz4/GK8Azfx1pi3gIYe2dXRdA25CEdU
         ygbVTzlUfL0sH2m6Wpsd/Ban3VeFRPAXgaZKOVRT3yPJcB3fFl0KeeGndwYgPgqNTnrw
         fLc4UMRru57kgePQhNgmaKCYBq9B9lQsf41XSV8CevyIMy2/exnA4RuNSCIL9UWTYRO4
         Wpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jc9HLe4ELv5FZ7PDoVIK3zh5An7Po+SoFaOa1SXJRpA=;
        b=Oz/dfsLR0IUOVIpV5rES2Z6IDDaylsoq9MWzO/WMJGEcjZ9nsFXmnMo7f84thH1BaE
         kyOBeJpE5IQycXA9VeMBAZJUPnThbR90besL8Y/ddd+zXskpF1KLkGccHZiPj1VjJFQE
         pmPxkS9JKi9TZyJMmx7ub37lV0gg1P+OAy181wroByOYXOaYjxUcVzzBUppZhikZJGVk
         AsoXT/1d95v8qB48jQq7gwoIhLj3n54xxFRjb1e5TJMwy83oIYGHAZn0VBvr3jAAsBuO
         jXT9Ck8w6lthwPIS+XNjjyXAG3rBtPeAma/aJwUlcZPcmmWbeNrGB/JmoRE/VUKrCGlf
         XmDw==
X-Gm-Message-State: APjAAAVjPn2aHKTZrSARAUawb0ENPe140XLvrwdENA0Dk24UYWHPqFGb
        QOxze6Mf6GC8lFvWuo5KYmq3ZQ==
X-Google-Smtp-Source: APXvYqy9OUg1ExJxElg08SPiTosxITlEPCpNu/Sr+ezMDy9KxB1NkRFIsvPBdOPnkIRONIack1jTbw==
X-Received: by 2002:a92:d204:: with SMTP id y4mr240103ily.240.1573080122794;
        Wed, 06 Nov 2019 14:42:02 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g28sm10038iob.33.2019.11.06.14.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:42:02 -0800 (PST)
Subject: Re: [RFC] io_uring CQ ring backpressure
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
 <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
 <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
Message-ID: <cfd5e929-440b-caff-1969-5e59de49bed6@kernel.dk>
Date:   Wed, 6 Nov 2019 15:42:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 2:31 PM, Jens Axboe wrote:
> On 11/6/19 1:08 PM, Jens Axboe wrote:
>> On 11/6/19 12:51 PM, Jann Horn wrote:
>>> On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> Currently we drop completion events, if the CQ ring is full. That's fine
>>>> for requests with bounded completion times, but it may make it harder to
>>>> use io_uring with networked IO where request completion times are
>>>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>>>
>>>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>>>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>>>> simply stores backlog of completions that we weren't able to put into
>>>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>>>> backlog is non-empty, we apply back pressure on IO submissions. Any
>>>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>>>> return from the kernel.
>>>>
>>>> I think that makes for a pretty sane API in terms of how the application
>>>> can handle it. With CQ_NODROP enabled, we'll never drop a completion
>>>> event (well unless we're totally out of memory...), but we'll also not
>>>> allow submissions with a completion backlog.
>>> [...]
>>>> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
>>>> +                              long res)
>>>> +       __must_hold(&ctx->completion_lock)
>>>> +{
>>>> +       struct cqe_drop *drop;
>>>> +
>>>> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
>>>> +log_overflow:
>>>> +               WRITE_ONCE(ctx->rings->cq_overflow,
>>>> +                               atomic_inc_return(&ctx->cached_cq_overflow));
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
>>>> +       if (!drop)
>>>> +               goto log_overflow;
>>>> +
>>>> +       drop->user_data = ki_user_data;
>>>> +       drop->res = res;
>>>> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
>>>> +}
>>>
>>> This could potentially consume moderately large amounts of atomic
>>> memory quickly and without any guarantee that the memory will be freed
>>> anytime soon, right? That seems moderately bad. Is there no way to
>>> e.g. pre-reserve memory for completion events, or something like that?
>>
>> As soon as there's even one entry in that backlog, the ring won't accept
>> anymore new IO. So I don't think it's a huge concern. If we pre-reserve,
>> we haven't really made much progress in making sure we don't drop events,
>> and we'll be tying up that memory all the time.
>>
>> The alternative, as Pavel also mentioned, is to re-use the io_kiocb
>> for this. But that'll tie up more memory, and it's a bit tricky with
>> the life times. Just because the request has completed doesn't mean
>> that someone isn't still holding a reference to it, and who knows
>> what they will do.
> 
> OK, I took a stab at it, here's a brain dump of the "complications"
> 
> 1) Some places now use __io_free_req() to drop both references, if we
>     know we haven't issued a request yet. Needs double drop, not a big
>     deal.
> 2) Some ordering changes between io_put_req() and the fill/add event
>     logic. Again not a huge deal, easy to spot.
> 3) We have one failure case that does not have a request, exactly because
>     we failed to allocate one. Don't look at that part in the below patch,
>     I think what we should do here is just reserve a request for that case.
>     It won't help with the submission, but it'll get it logged correctly
>     for the overflow backlog. Any new submission can't proceed with that
>     request in the overflow backlog anyway, so we need just the one.
>     Not super pretty, but at least we can keep this out of the fast path,
>     as the only one that will free this request is the overflow flush
>     path.
> 
> I'll do a prep patch that makes the fill/add event path deal in requests,
> then we can build the backpressure on top.

On top of Pavel's cleanup and using io_kiocb instead. Turned out much
nicer that way. Totally untested, will go through the motions with all
of it now.

commit 38d95aad728b139160359ff519ec4b2262c90121
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Nov 6 11:31:17 2019 -0700

    io_uring: add support for backlogged CQ ring
    
    Currently we drop completion events, if the CQ ring is full. That's fine
    for requests with bounded completion times, but it may make it harder to
    use io_uring with networked IO where request completion times are
    generally unbounded. Or with POLL, for example, which is also unbounded.
    
    This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
    for CQ ring overflows. First of all, it doesn't overflow the ring, it
    simply stores a backlog of completions that we weren't able to put into
    the CQ ring. To prevent the backlog from growing indefinitely, if the
    backlog is non-empty, we apply back pressure on IO submissions. Any
    attempt to submit new IO with a non-empty backlog will get an -EBUSY
    return from the kernel. This is a signal to the application that it has
    backlogged CQ events, and that it must reap those before being allowed
    to submit more IO.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fb621a564dcf..22373b7b3db0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -207,6 +207,7 @@ struct io_ring_ctx {
 
 		struct list_head	defer_list;
 		struct list_head	timeout_list;
+		struct list_head	cq_overflow_list;
 
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
@@ -413,6 +414,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
+	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	init_completion(&ctx->ctx_done);
 	init_completion(&ctx->sqo_thread_started);
 	mutex_init(&ctx->uring_lock);
@@ -587,6 +589,72 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	return &rings->cqes[tail & ctx->cq_mask];
 }
 
+static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+{
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
+	if (ctx->cq_ev_fd)
+		eventfd_signal(ctx->cq_ev_fd, 1);
+}
+
+static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
+{
+	struct io_rings *rings = ctx->rings;
+	struct io_uring_cqe *cqe;
+	struct io_kiocb *req;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	if (list_empty_careful(&ctx->cq_overflow_list))
+		return;
+	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
+	    rings->cq_ring_entries)
+		return;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+
+	while (!list_empty(&ctx->cq_overflow_list)) {
+		cqe = io_get_cqring(ctx);
+		if (!cqe && !force)
+			break;
+
+		req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
+						list);
+		list_move(&req->list, &list);
+		if (cqe) {
+			WRITE_ONCE(cqe->user_data, req->user_data);
+			WRITE_ONCE(cqe->res, req->result);
+			WRITE_ONCE(cqe->flags, 0);
+		}
+	}
+
+	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	io_cqring_ev_posted(ctx);
+
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct io_kiocb, list);
+		list_del(&req->list);
+		io_put_req(req, NULL);
+	}
+}
+
+static void io_cqring_overflow(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			       long res)
+	__must_hold(&ctx->completion_lock)
+{
+	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
+		WRITE_ONCE(ctx->rings->cq_overflow,
+				atomic_inc_return(&ctx->cached_cq_overflow));
+	} else {
+		refcount_inc(&req->refs);
+		req->result = res;
+		list_add_tail(&req->list, &ctx->cq_overflow_list);
+	}
+}
+
 static void io_cqring_fill_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -600,26 +668,15 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
 	 * the ring.
 	 */
 	cqe = io_get_cqring(ctx);
-	if (cqe) {
+	if (likely(cqe)) {
 		WRITE_ONCE(cqe->user_data, req->user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
-		WRITE_ONCE(ctx->rings->cq_overflow,
-				atomic_inc_return(&ctx->cached_cq_overflow));
+		io_cqring_overflow(ctx, req, res);
 	}
 }
 
-static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
-{
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
-	if (waitqueue_active(&ctx->sqo_wait))
-		wake_up(&ctx->sqo_wait);
-	if (ctx->cq_ev_fd)
-		eventfd_signal(ctx->cq_ev_fd, 1);
-}
-
 static void io_cqring_add_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -864,6 +921,9 @@ static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
 	struct io_rings *rings = ctx->rings;
 
+	if (ctx->flags & IORING_SETUP_CQ_NODROP)
+		io_cqring_overflow_flush(ctx, false);
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -2863,6 +2923,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
+	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
+	    !list_empty(&ctx->cq_overflow_list))
+		return -EBUSY;
+
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
@@ -2951,6 +3015,7 @@ static int io_sq_thread(void *data)
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
 		unsigned int to_submit;
+		int ret;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -3035,8 +3100,9 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
-					   true);
+		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
+		if (ret > 0)
+			inflight += ret;
 	}
 
 	set_fs(old_fs);
@@ -4100,8 +4166,10 @@ static int io_uring_flush(struct file *file, void *data)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	io_uring_cancel_files(ctx, data);
-	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
+	if (fatal_signal_pending(current) || (current->flags & PF_EXITING)) {
+		io_cqring_overflow_flush(ctx, true);
 		io_wq_cancel_all(ctx->io_wq);
+	}
 	return 0;
 }
 
@@ -4402,7 +4470,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 	}
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
-			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE))
+			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
+			IORING_SETUP_CQ_NODROP))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f1a118b01d18..3d8517eb376e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -56,6 +56,7 @@ struct io_uring_sqe {
 #define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
 #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
 #define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
+#define IORING_SETUP_CQ_NODROP	(1U << 4)	/* no CQ drops */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1

-- 
Jens Axboe

