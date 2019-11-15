Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13BCC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 02:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A1820659
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 02:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tjwhi+mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKOCgO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:36:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36028 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKOCgO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 21:36:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so3613604pls.3
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 18:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=n2mEvMleLNIK63RuXCen2fcIlVSLv0i+DKb9eUb9PY8=;
        b=tjwhi+mOufl2DGem5GviXsSDvW+JYtZtv0mP8hI63XQjcSbWBeUDUpevC5HziLn+k+
         fz7lZY9gf2R+AWeitY7HUeZ+rzAvrPbezNH/3IglsaCxnrHA4HuP2KSifuaH0uHtM79H
         MT0MmjkVhhHCW/CRci9SBbDg2u/YYqzdKsGVpAPlI/yl2xa9XkVOQloNlTrzzkh+GGVE
         URCnwe+EsiYN7531CB8ug1uaiUr8FG4U0s/SmF4eSlGyPtPMmM17xByZIs4N5j7TwN7S
         vLwi0FPJSKD1BW4C/kPHDNAxlE7E6hdqG57h9Q2Uq25NcO2LKjrdf2c28ZF87kgf7pBc
         8Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2mEvMleLNIK63RuXCen2fcIlVSLv0i+DKb9eUb9PY8=;
        b=Y8keRMMBQUEgJXiFGmZM+7BsmHA/mq/yY7MxHCyohcahjmYC75Aj97hj/qqx/iLzC/
         mNLlZZHLEOZ44IOInLkioDYh43DdtBJ11BaXEnUtDSxEO5+UpvbH8Z0uwVboP37pwhI9
         qvXU/yjN/JyeTgjBll3o5GA5cXIbWSQEwL553FirCGem9w8tdUFoaEJqnwZgJZSkqDJS
         kVTxk/l2UjbFODyHFOJ8UwPHrbJFjGZmKUguSb0THmXsgVKqFIvs79jdd2laudX7C+0P
         SumfP0S0R1gnoVo0kngeavwXoDZvKpkG6b+jDkq7Guoth88p0mQdmQXvPUnyMWZ6ojkG
         ssKQ==
X-Gm-Message-State: APjAAAXbIDvwKVATjY5hjISuvOtTrEu5l2JhSakGLLiRh+0ueyO9gmEk
        vx3MQHpSWfF3UA9bye2eLEbVx0NYYd0=
X-Google-Smtp-Source: APXvYqxGfacsdAjMeLPxAyoSXvkU+H2A/v/+uSelqF6SZUbpqZ4xGIdPTZhaC+5aRaCfPvkQaj9NCg==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr12705097plk.136.1573785371259;
        Thu, 14 Nov 2019 18:36:11 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id n8sm10467509pgs.44.2019.11.14.18.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 18:36:10 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix LINK_TIMEOUT checks
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
 <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
 <ea4f23f3-4751-2074-f553-d3db8b3c2bda@kernel.dk>
Message-ID: <5c01de81-47db-3275-f08a-e8e376171e64@kernel.dk>
Date:   Thu, 14 Nov 2019 19:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ea4f23f3-4751-2074-f553-d3db8b3c2bda@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/14/19 5:12 PM, Jens Axboe wrote:
> On 11/14/19 2:25 PM, Jens Axboe wrote:
>> On 11/14/19 2:20 PM, Pavel Begunkov wrote:
>>> If IORING_OP_LINK_TIMEOUT request is a head of a link or an individual
>>> request, pass it further through the submission path, where it will
>>> eventually fail in __io_submit_sqe(). So respecting links and drains.
>>>
>>> The case, which is really need to be checked, is if a
>>> IORING_OP_LINK_TIMEOUT request is 3rd or later in a link, that is
>>> invalid from the user API perspective (judging by the code). Moreover,
>>> put/free and friends will try to io_link_cancel_timeout() such request,
>>> even though it wasn't initialised.
>>
>> Care to add a test case for these to liburings test/link-timeout.c?
> 
> Wrote some test cases, I think that io_req_link_next() is just wrong.
> The below should correct it. We shouldn't loop here at all, just find
> the first one. That'll start that guy, sequence will continue, etc.

Well that was crap, I sent an earlier unfinished version. Here's the
right one:


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5ad652fa24b8..31adee55e153 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -858,30 +858,26 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * safe side.
 	 */
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	while (nxt) {
+	if (nxt) {
 		list_del_init(&nxt->list);
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
 			list_splice(&req->link_list, &nxt->link_list);
 			nxt->flags |= REQ_F_LINK;
+		} else if (req->flags & REQ_F_LINK_TIMEOUT) {
+			wake_ev = io_link_cancel_timeout(nxt);
+			nxt = NULL;
 		}
 
 		/*
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (req->flags & REQ_F_LINK_TIMEOUT) {
-			wake_ev = io_link_cancel_timeout(nxt);
-
-			/* we dropped this link, get next */
-			nxt = list_first_entry_or_null(&req->link_list,
-							struct io_kiocb, list);
-		} else if (nxtptr && io_wq_current_is_worker()) {
-			*nxtptr = nxt;
-			break;
-		} else {
-			io_queue_async_work(nxt);
-			break;
+		if (nxt) {
+			if (nxtptr && io_wq_current_is_worker())
+				*nxtptr = nxt;
+			else
+				io_queue_async_work(nxt);
 		}
 	}
 
@@ -2465,7 +2461,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	    sqe->cancel_flags)
 		return -EINVAL;
 
-	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), NULL);
+	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), nxt);
 	return 0;
 }
 
@@ -2741,10 +2737,12 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	 */
 	if (!list_empty(&req->list)) {
 		prev = list_entry(req->list.prev, struct io_kiocb, link_list);
-		if (refcount_inc_not_zero(&prev->refs))
+		if (refcount_inc_not_zero(&prev->refs)) {
+			prev->flags &= ~REQ_F_LINK_TIMEOUT;
 			list_del_init(&req->list);
-		else
+		} else {
 			prev = NULL;
+		}
 	}
 
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);

-- 
Jens Axboe

