Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80255C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 23:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67E2070C
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 23:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k+kp9ubw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKTX6v (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:58:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33021 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTX6u (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 18:58:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id o14so578159pjr.0
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kOW4rMQOy2zQiqQrj6VLLAXpfAZv7hVYSWHKfiG0Zw4=;
        b=k+kp9ubwuoE3e0P0yLqjHDifnKD2zzItD1+m9H9K+ft7pRa5A2YAYrFkMFCEpqFVKJ
         fLmVkl+6n6pOUw0JRJ2ohr4UlZsWdhH4IbkkmFt+i9Ja0bhZR1rdDKaEue7LzSZbpjSc
         bMZTRxAuAs007r6CHvS0HIyjkYCSdovgm+Bq2c8lh3STY3/SwHRe4Xh29NMsZ/jjqil4
         1LYm78Bln6EiCYA+af7GJIp8DMSgOn+x1EGyOKetUjFARM/y91kuvwxf1Gg7QC0+VhvF
         Ym/lrGWXuL+xn+CArIfkfbQZgnQGMK150lscAufO5KV5TWOzbjqDsvZ9PoR52Nkg25Mw
         Y+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOW4rMQOy2zQiqQrj6VLLAXpfAZv7hVYSWHKfiG0Zw4=;
        b=fYMJc+077yBGworWQ0sBhER1NnPRuLjKHzsNpLZJzEn08qXxCRcETz8pqLc1me+7qn
         4xGTHONvr/qm4dn9HERBhxMR+vDhjkhqWMlIbp7LIz+BQhUtqDprsa0N2EFwa/vt4UDc
         uCSmnvTMVB0rppYiB9m7u4wqhnXbF0HCDWhdM2Z0Cn97i3m6NbhtHVaHZn0VoiqHnrjA
         fHIoBMfXlVRwlvXfne37RkTTm/Hg9y64CoA6znjFilrwN2B0aeVnwcvdss7esjVrn33d
         bAUgM9zUroKNlMo69PZqBI2qEnrAnm+E2SeMrTnZRSs5qUyzwuk403SOoIRYzau6IWsY
         r5tA==
X-Gm-Message-State: APjAAAU2SbZnooSOBknL3W6Nld+jO6oN5+vvIZ+n4Ou6Ic80cnxceeiw
        37qlMntLU2qhIhaEMtKH6QntpHmpDSBnLQ==
X-Google-Smtp-Source: APXvYqwELUmmIxiZwGMmjz3p7OiJwrZo+1ORDHO7o1NrIzKEthyCrqrROAyTFNm0BxCJe0ZOhbp5YA==
X-Received: by 2002:a17:90a:353:: with SMTP id 19mr7839730pjf.128.1574294328591;
        Wed, 20 Nov 2019 15:58:48 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h4sm360145pjs.24.2019.11.20.15.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 15:58:47 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix race with shadow drain deferrals
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jackie Liu <liuyun01@kylinos.cn>
References: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
Message-ID: <cabb202a-a405-9f36-0363-1548f1b4dfd4@kernel.dk>
Date:   Wed, 20 Nov 2019 16:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 4:07 PM, Jens Axboe wrote:
> When we go and queue requests with drain, we check if we need to defer
> based on sequence. This is done safely under the lock, but then we drop
> the lock before actually inserting the shadow. If the original request
> is found on the deferred list by another completion in the mean time,
> it could have been started AND completed by the time we insert the
> shadow, which will stall the queue.
> 
> After re-grabbing the completion lock, check if the original request is
> still in the deferred list. If it isn't, then we know that someone else
> already found and issued it. If that happened, then our job is done, we
> can simply free the shadow.
> 
> Cc: Jackie Liu <liuyun01@kylinos.cn>
> Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

BTW, the other solution here is to not release the completion_lock if
we're going to return -EIOCBQUEUED, and let the caller do what it needs
before releasing it. That'd look something like this, with some sparse
annotations to keep things happy.

I think the original I posted here is easier to follow, and the
deferral list is going to be tiny in general so it won't really add
any extra overhead.

Let me know what you think and prefer.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6175e2e195c0..0d1f33bcedc0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2552,6 +2552,11 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+/*
+ * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
+ * the caller can make decisions based on the deferral without worrying about
+ * the request being found and issued in the mean time.
+ */
 static int io_req_defer(struct io_kiocb *req)
 {
 	const struct io_uring_sqe *sqe = req->submit.sqe;
@@ -2579,7 +2584,7 @@ static int io_req_defer(struct io_kiocb *req)
 
 	trace_io_uring_defer(ctx, req, false);
 	list_add_tail(&req->list, &ctx->defer_list);
-	spin_unlock_irq(&ctx->completion_lock);
+	__release(&ctx->completion_lock);
 	return -EIOCBQUEUED;
 }
 
@@ -2954,6 +2959,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
 
 static void io_queue_sqe(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
 	ret = io_req_defer(req);
@@ -2963,6 +2969,9 @@ static void io_queue_sqe(struct io_kiocb *req)
 			if (req->flags & REQ_F_LINK)
 				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
+		} else {
+			__acquire(&ctx->completion_lock);
+			spin_unlock_irq(&ctx->completion_lock);
 		}
 	} else
 		__io_queue_sqe(req);
@@ -3001,16 +3010,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 				__io_free_req(shadow);
 			return;
 		}
+		__acquire(&ctx->completion_lock);
 	} else {
 		/*
 		 * If ret == 0 means that all IOs in front of link io are
 		 * running done. let's queue link head.
 		 */
 		need_submit = true;
+		spin_lock_irq(&ctx->completion_lock);
 	}
 
 	/* Insert shadow req to defer_list, blocking next IOs */
-	spin_lock_irq(&ctx->completion_lock);
 	trace_io_uring_defer(ctx, shadow, true);
 	list_add_tail(&shadow->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);

-- 
Jens Axboe

