Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261C4C5DF61
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6593214D8
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 03:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GQqv/0/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKGDUT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:20:19 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33428 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGDUT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 22:20:19 -0500
Received: by mail-pg1-f169.google.com with SMTP id h27so923708pgn.0
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 19:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uKd7u+7fz0EmtGn8D5PsLAhw/g5A3kmsV25lqETTuvA=;
        b=GQqv/0/nLoIMVjhFjOzbLZSPnVxpxj3u0BV6KRUMDVzW5mbLQkK8cn6D671CdpO8e/
         9DbrA1q9Wmbs1EdVCq8FDVo7SK2wc8uUtHgebLIlIh2faehHmjAo71IKIph4gjjXqV/t
         N79Lpq9clfceef7a2J6qSg6j1vEA3sbALbNVoWHDnhc7fAYXPB/g2bHxwqnhKlOLCpwN
         1rNKJYhdwchOcgB8UXJAG5gOMQ5BE8FDJrjvGer1lTH4VyVBraHRlIC9dfnOTpQEtAZ0
         IzDtZcGmLIlJfHP4G5yF9zD3fHQsAViNnwXoO22x84dneXMevMyBVdan8cZvAPrvfXZP
         xvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uKd7u+7fz0EmtGn8D5PsLAhw/g5A3kmsV25lqETTuvA=;
        b=cRtAmZWMW2mXS2C1r8jOuIEa9i+6HUOWUUp4ZWpDeSGeSivraPYzQgOala/6SiKijj
         4HF0kAXqqruc8mtQ3LLbJvhpL6Uiu/70BPMFjmzv0CSrgW0LSEiLVDlrCs9fswIxr/En
         firYhBEm6D2N+joKQMSXlbGi3Qr7xVUa00g7fLTI8zIYhVmYp/P9iwLd8h2fgwOJciul
         at7+BitVCAIehNuKw62yCWhN/OkD8ak47VG/rUpVHPFKWU3wl+p+VK+oEu1tT9BFsXmE
         oc/N8uFySwgNId/ROJmljb7soQ18k1d2VA3QXu3lYJ3/hJRpSE/Gp38zeAOg1suWMLQw
         EcIw==
X-Gm-Message-State: APjAAAXyWkXf2C2+29OP/rOfAagrZSRpOEZBsenO4rrUlrtZnQasxHs4
        Cjt7STe5S9Kfgtc9w+Kr1e5AawlB3Mc=
X-Google-Smtp-Source: APXvYqyIwuCsmJ9PINxoKiClUDylJO8rhIXYDhdMJhacM1n9Y45aIfCi8fMivwZ52N8ZZnW5MDmWkg==
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr1960862pjp.48.1573096817106;
        Wed, 06 Nov 2019 19:20:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f13sm449270pfa.57.2019.11.06.19.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:20:16 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: fixup for "io_uring: allocate io_kiocb upfront"
Message-ID: <4e41bfad-d7ec-6381-741c-0261f321617a@kernel.dk>
Date:   Wed, 6 Nov 2019 20:20:14 -0700
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

Pavel,

I didn't read this one closely enough for the latest change, we
can't just return -EAGAIN if we don't submit anything, we have to
explicitly do it for just the failure case of not getting a request.
I'm going to fold in this incremental:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 951fd09612ec..af8a673c618f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2978,8 +2978,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		unsigned int sqe_flags;
 
 		req = io_get_req(ctx, statep);
-		if (unlikely(!req))
+		if (unlikely(!req)) {
+			if (!submitted)
+				submitted = -EAGAIN;
 			break;
+		}
 		if (!io_get_sqring(ctx, &req->submit)) {
 			__io_free_req(req);
 			break;
@@ -4316,8 +4319,6 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		cur_mm = ctx->sqo_mm;
 		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
 					   &cur_mm, false);
-		if (!submitted)
-			submitted = -EAGAIN;
 		mutex_unlock(&ctx->uring_lock);
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {

-- 
Jens Axboe

