Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F7FA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06544206BA
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ln49KVBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfKHPv4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:51:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44516 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfKHPv4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 10:51:56 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so6583592ioo.11
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ewnQLBOtmqxRtitCK2+xDFF2M+e/JWMxe99Hmp/P9aw=;
        b=Ln49KVBuaDfgR4tkoY9r58fl6XO1896zqppO72YOLN1GaquGPQ9LPBcDvoqRtpluT2
         aN7htIZp0Gi39lANHlb9Us0/C7VXKoMVGHhMGXGVtjiWXGPl4t8SPpEBpEVRrmj8ofv6
         eWpQS9NoLk36dsV8X0q+5WsQpklhFjM1/jHWW+JgmAjXTRo/PMtIRgjfdzazcnly+0Lj
         KxXAcEMDQkFrBjy3AiTLWPD5tCJAiMsdi7znux9Z/N5eCgFc3AKkDS/zKpUuFv2ab6/X
         FD6uSQ9jLyTJAL8TULuN9irCV3ygyigfxzkSfJ1XoC/5t+bMczb8ItW6Fd+F/bRUWMch
         qsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ewnQLBOtmqxRtitCK2+xDFF2M+e/JWMxe99Hmp/P9aw=;
        b=cpfH6AWVXUI7+9rxsdSI6OIdJF80FPjDSCS7nCkmR6XBysYDs9aOWJhhqytHu6IV/j
         JyzPZAONa6IPIBj9KLndTjQ6T00JODQkMbKCLrXtF2E9dowS40HavPH6MDhRdthfmXEB
         FVQnSsRNHbTK87gtiASmriJI2m8j3sRGun9fWbWYlSe0nCjgsQUqrZqdY97q2+MGg521
         UBve5nCasu0wmcsoey0k9KoYW0yLZVFNKZjuslCoF6ilCJAnVSa2L+jPOwkJeEEJzn16
         dPO5dZKiKhUR8vUix+lGZZNYLVk3Bf58DTmA2JEwrsCJHrSZWW03i4ATBgds0hrQtAbw
         389Q==
X-Gm-Message-State: APjAAAUTfu4/jMz8cUptVsGt2eJUOTFOmSTz3Tw8XixRSbG60kzlD/1W
        3m6Zb6UO1HFldzQAf/Yy4/CjFJ1JDXk=
X-Google-Smtp-Source: APXvYqwB/yIwafwPojYaUaQGTIP2QZgQLIrSa2zowy1DR4bOqe9t1QMik/hPFDCd/bomvPYYWClhBQ==
X-Received: by 2002:a6b:18d:: with SMTP id 135mr10849998iob.201.1573228313877;
        Fri, 08 Nov 2019 07:51:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y5sm819593ill.86.2019.11.08.07.51.52
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 07:51:53 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: account overflows even with IORING_SETUP_CQ_NODROP
Message-ID: <16c996fa-61e9-74b9-bc61-b31ecc085c87@kernel.dk>
Date:   Fri, 8 Nov 2019 08:51:52 -0700
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

It's useful for the application to know if the kernel had to dip into
using the backlog to prevent overflows. Let's keep on accounting any
overflow in cq_ring->overflow, even if we handled it correctly. As it's
impossible to get dropped events with IORING_SETUP_CQ_NODROP, overflow
with CQ_NODROP enabled simply provides a hint to the application that it
may reconsider using a bigger ring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since this hasn't been released yet, we can tweak the behavior a bit. I
think it makes sense to still account the overflows, even if we handled
it correctly. If the application doesn't care, it simply doesn't need to
look at cq_ring->overflow if it is using CQ_NODROP. But it may care, as
it is less efficient than a suitably sized ring.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 94ec44caac00..aa3b6149dfe9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -666,10 +666,10 @@ static void io_cqring_overflow(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			       long res)
 	__must_hold(&ctx->completion_lock)
 {
-	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
-		WRITE_ONCE(ctx->rings->cq_overflow,
-				atomic_inc_return(&ctx->cached_cq_overflow));
-	} else {
+	WRITE_ONCE(ctx->rings->cq_overflow,
+			atomic_inc_return(&ctx->cached_cq_overflow));
+
+	if (ctx->flags & IORING_SETUP_CQ_NODROP) {
 		refcount_inc(&req->refs);
 		req->result = res;
 		list_add_tail(&req->list, &ctx->cq_overflow_list);

-- 
Jens Axboe

