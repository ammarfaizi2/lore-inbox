Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5DC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C819E2080F
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1y3ltMPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKTUJ7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35107 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfKTUJ7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:59 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so665893ior.2
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dm77mG4kf0e0z1km8pPt2ZmGUSeePekdNjeee5Mg+0M=;
        b=1y3ltMPJhmlPUtaHBqqR41C8TNhM761dj62YVXh3MrFB0p4fwqiDXmkknY4VJDOCcP
         rk2D52ksrMxEELwB8oBSXy0RDiJT6oL445bh9doaVt7NjHKzi9k3F/gbn2915LrnOw8x
         RO/yCVu51FilawfSNlM8kzBO1ziI7wGLMAeEwN01iKF8KgeDg+oL7tTNs1MiarOO0D6D
         fMhwv8jteXYweedRtjLi/q1bj3ZIM1/lc++pO2NiEB+gkr09CIU8FsMAY3ZPhRR+9OKi
         gJcx7TXSblD+Uz+IX6PyxHkVutcC8fcNY3oSAls2PRwZSt6nqgO16C6axXswYPpubOX7
         rQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dm77mG4kf0e0z1km8pPt2ZmGUSeePekdNjeee5Mg+0M=;
        b=he7rbKUPwCGsvWgLQ5MABOJJaRZ8GhVV9uMJA3oPa03/MtezqiPZYmskEO9rCF8tc2
         wHwgkctZ+ELHyoS1V82djf7BNoixgS4x5+MADPPP5OLxYaA9s5p3UhkYUgRuhMvpmoON
         4bpvXiKMGdgK0Yvudp/wtlBLWkD159xG9D2rwMvaW5uN7rETrbc65X1iCvADSgax9Snv
         U7l0GQQ43YHuVyAY/BwUWcXOXLBsU93tiJnjoXIDfyYWmhDXeEBCfk7Yq2s2fc0ogMJe
         fhWWKtQGVp3b6plCaqGHz136kdglyqZwjRAPGpEYov0utwP53eMTyC3ozmW5vYfnCFDu
         373w==
X-Gm-Message-State: APjAAAVkjyqyzKmHJwAopgF2JlUOAvYwd/IYX5sNl+tt5JsUH1x5bvST
        E9UFF3fIdy5mS18QVPQXHgB3IgUWtpkcXA==
X-Google-Smtp-Source: APXvYqx/YMAXM0RvzoN6rDe+9KGPH4Abtsutie9rmvB2su1ErciAmLh+2cKkbyeu7L1q+/NNNqgOuQ==
X-Received: by 2002:a6b:3b03:: with SMTP id i3mr3927653ioa.199.1574280596510;
        Wed, 20 Nov 2019 12:09:56 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] io_uring: break links for failed defer
Date:   Wed, 20 Nov 2019 13:09:33 -0700
Message-Id: <20191120200936.22588-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

If io_req_defer() failed, it needs to cancel a dependant link.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ebc58f896088..7b9bd6ad4fb9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2943,6 +2943,8 @@ static void io_queue_sqe(struct io_kiocb *req)
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(req, ret);
+			if (req->flags & REQ_F_LINK)
+				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
 		}
 	} else
@@ -2975,6 +2977,8 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 		if (ret != -EIOCBQUEUED) {
 err:
 			io_cqring_add_event(req, ret);
+			if (req->flags & REQ_F_LINK)
+				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
 			if (shadow)
 				__io_free_req(shadow);
-- 
2.24.0

