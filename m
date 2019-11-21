Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46EC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D1320692
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZBJwPrCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUQC4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:02:56 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:45962 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUQC4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 11:02:56 -0500
Received: by mail-il1-f171.google.com with SMTP id o18so3734739ils.12
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 08:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/twDdVTXBZXtwCGb928orwrW9Aaq2OhPpJySWQrw7ac=;
        b=ZBJwPrCJrLzqZdfrc8/4pIMLqrY7lsNKGmSOlA7DUu1xlpi1YWUBy/2CT1psP3cr2H
         4r3Niuk4I03F2OTwzZYXrbu9mjmRf2+SxDPASXFUaKGVP22ML9gct5Y78U1jZog+mAik
         MDQrI36eeV3b2TosqfvyttUNV3/cCfCfrNRVr1WxuevB0zPz7J8vjvryC3bFCcvGd3L3
         LXWO15NoDsXiXamy/+WLhLybW1Sj6YwAM516E5YE9eG8R8ujUfHXPYjRbY3zBvt4nC4T
         2q55oeLY9vJZSMJXZ/EObbb7W/mKtz2nJTE6u3M6hMlCw3/CRQfI+LlsmLLOLCItp1IS
         i/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/twDdVTXBZXtwCGb928orwrW9Aaq2OhPpJySWQrw7ac=;
        b=HBTgnme6k1u91jQLs2IOlGVPsH7kwjM8sH+aZ0u1M5te7Q1WU716CsH7Rb48AuBP2U
         AB79KGulgFTaeu5MSlsUf/bTuKAAWmoTP44mQmCFvsv2bNNZ+l6/iW2bLMEoGyhdg31q
         cJYSEnCQsTaqCiQN2Fy+4693p8tgAfV8gaaW8KGrlhKx6Gr4LmXuqMskzg/NYls/zoGs
         eaFZsWfqjabNcO8UrXtvH5VhyMZZQwrxKt7JSlsQXnAgjjzguRopR2weorZweDjWaBfz
         vNitzEkMMcMEtjVy/oDduBpwB00Cl6pH/CLRH4RFU1weU/NdwqMTblkCLQOrBxibevbV
         dTyg==
X-Gm-Message-State: APjAAAVVwzOQ259nlCSGJR8XXWGtlhXzfjIkOjQXqAz0sU73PoxIsj/r
        mwGbBwHcrFn746j9q1odd0/PWA==
X-Google-Smtp-Source: APXvYqzG+q9nYEtZUJD/I/9VS0clJId1uzWbqUXSlRIv6UHj/h8kenhSEiTeVLmQM/LZx/5eznEdJw==
X-Received: by 2002:a92:8459:: with SMTP id l86mr11136759ild.236.1574352174451;
        Thu, 21 Nov 2019 08:02:54 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j5sm1277741ilc.10.2019.11.21.08.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:02:53 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: improve trace_io_uring_defer() trace point
Message-ID: <1fda8293-fd13-f712-40c4-439236f25abb@kernel.dk>
Date:   Thu, 21 Nov 2019 09:02:52 -0700
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

We don't have shadow requests anymore, so get rid of the shadow
argument. Add the user_data argument, as that's often useful to easily
match up requests, instead of having to look at request pointers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index dd220f415c39..cde1c28200ce 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2573,7 +2573,7 @@ static int io_req_defer(struct io_kiocb *req)
 	req->flags |= REQ_F_FREE_SQE;
 	req->submit.sqe = sqe_copy;
 
-	trace_io_uring_defer(ctx, req, false);
+	trace_io_uring_defer(ctx, req, req->user_data);
 	list_add_tail(&req->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
 	return -EIOCBQUEUED;
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 72a4d0174b02..b352d66b5d51 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -163,35 +163,35 @@ TRACE_EVENT(io_uring_queue_async_work,
 );
 
 /**
- * io_uring_defer_list - called before the io_uring work added into defer_list
+ * io_uring_defer - called when an io_uring request is deferred
  *
  * @ctx:	pointer to a ring context structure
  * @req:	pointer to a deferred request
- * @shadow: whether request is shadow or not
+ * @user_data:	user data associated with the request
  *
  * Allows to track deferred requests, to get an insight about what requests are
  * not started immediately.
  */
 TRACE_EVENT(io_uring_defer,
 
-	TP_PROTO(void *ctx, void *req, bool shadow),
+	TP_PROTO(void *ctx, void *req, unsigned long long user_data),
 
-	TP_ARGS(ctx, req, shadow),
+	TP_ARGS(ctx, req, user_data),
 
 	TP_STRUCT__entry (
 		__field(  void *,	ctx		)
 		__field(  void *,	req		)
-		__field(  bool,		shadow	)
+		__field(  unsigned long long, data	)
 	),
 
 	TP_fast_assign(
 		__entry->ctx	= ctx;
 		__entry->req	= req;
-		__entry->shadow	= shadow;
+		__entry->data	= user_data;
 	),
 
-	TP_printk("ring %p, request %p%s", __entry->ctx, __entry->req,
-			  __entry->shadow ? ", shadow": "")
+	TP_printk("ring %p, request %p user_data %llu", __entry->ctx,
+			__entry->req, __entry->data)
 );
 
 /**

-- 
Jens Axboe

