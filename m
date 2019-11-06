Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C734C5DF62
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 03:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1122077B
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 03:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FHv1vBIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfKFDiX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:38:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35755 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKFDiX (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 22:38:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id q22so8553091pgk.2
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 19:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SjoP27lHR88FYKm4shB3004Uie/nn9CxC3Um/D8R2ec=;
        b=FHv1vBIUdaghEQEt5KhNdGEBHtttn/edORwuTHqby7FDLm/wVzsI5wbzRMl1rUt5lY
         zkzW2p1qXgFcecHPOmG6/6YkkJDd1BLXvoSPGNA0nnjnKAUphFiu+K/pH311Wv2OfZqH
         whQQN4tFxiRJVWSLz4L/UIiRxtUP/ka/7kNFsaR8RxAoAH7qcYSI0zYzxNuM7jYNp2Sn
         CFeh7yQSwg1LkE540Sb5TN5ZH/Pw+CmO/crWQuzHlAS2XPUNMhYLc574jXo72fUUUsfY
         CUoHMEPIQ4kCIZtDYIaYgz2Hg5sZjVxwKZSDd2pfHJfOlSMYb3G8m2T95tWYmsTAEOib
         KoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SjoP27lHR88FYKm4shB3004Uie/nn9CxC3Um/D8R2ec=;
        b=CxEkNXaAMjjjvSTqM9Q332xEWJaeRejjp6/VaAWASMmzhniEZJKftxz+LQT2yN+AMp
         1jFgLAJoFmHsndpfZ4D7Tot2v39nPvR3R7Tw/BKjEcsVSNK88E90e/ryVLNHBoJcpnwZ
         lX6hpXojtlBBEl8GOvEJmpwbB/ms5KyJQHmdKB0Uxihg28H5F8mYOTlI4Sgi9W/ijh2M
         UHvSHkUJ21Dxvt3pvO3XnI0OWGgNFSyAOlVE12RFfC21RkRXAFZcyYycCaPyZjfYioxS
         3m5t/H0Ff7kfHSbjvle70K4p+e3guKyQwmGZIx/6kL7zFQ2zHFeSwxtKHKJaX8mMdH4l
         VWtQ==
X-Gm-Message-State: APjAAAU6zgchw7OT/EgA7lZbxy4h1OnxALiQPUWg4Y2WvsueZ8aiWy7W
        rMAhs57Qk891gmRDTLF+gyLiLOoithE=
X-Google-Smtp-Source: APXvYqwMwIo5dMyod601KTfXGGjvrvVkOehYgj9sKQMWj0+tbUb776im45YSuhSV7di2oIaLyll1qg==
X-Received: by 2002:a63:a0f:: with SMTP id 15mr310909pgk.316.1573011167586;
        Tue, 05 Nov 2019 19:32:47 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 74sm21923652pgb.62.2019.11.05.19.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 19:32:46 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fixup a few spots where link failure isn't flagged
Message-ID: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>
Date:   Tue, 5 Nov 2019 20:32:44 -0700
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

If a request fails, we need to ensure we set REQ_F_FAIL_LINK on it if
REQ_F_LINK is set. Any failure in the chain should break the chain.

We were missing a few spots where this should be done. It might be nice
to generalize this somewhat at some point, as long as we factor in the
fact that failure looks different for each request type.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

--


diff --git a/fs/io_uring.c b/fs/io_uring.c
index bda27b52fd5b..4edc94aab17e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1672,6 +1672,8 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -1787,6 +1789,8 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, NULL);
 	return 0;
 }
@@ -1994,6 +1998,8 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	io_cqring_ev_posted(ctx);
+	if (req->flags & REQ_F_LINK)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, NULL);
 	return HRTIMER_NORESTART;
 }
@@ -2035,6 +2041,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 		io_commit_cqring(ctx);
 		spin_unlock_irq(&ctx->completion_lock);
 		io_cqring_ev_posted(ctx);
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
 		io_put_req(req, NULL);
 		return 0;
 	}
@@ -2328,6 +2336,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	io_put_req(req, NULL);
 
 	if (ret) {
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
 		io_cqring_add_event(ctx, sqe->user_data, ret);
 		io_put_req(req, NULL);
 	}

-- 
Jens Axboe

