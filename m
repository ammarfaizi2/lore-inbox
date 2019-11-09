Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EAC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AB520869
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fsDtIgAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKIOUw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:20:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46041 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfKIOUw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:20:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so6022279pga.12
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+J0TIHAU/h4U5QOiy6//7+OXhxUGaPDeOukNgI2tVVo=;
        b=fsDtIgAj5mpCYVrFmWyFXSoPnW/I9F+r4F8Y+PkwB17t5YF53mnrcwoIUNibjk9knw
         bqdk//rNP8wuZd9iEmdPNcl6bsnOGri+BTB/GptwClHWUVmTwPwLS/fmfXPRT+Ic2s+f
         /etNr7lP6zH1NFzH00FYdlNdj9RB52EJxez3Yp1Z8Vy/1LYf5/U0NoVrBV2aepP7QmKs
         45l1qFyfRVpFeUcElIi4SnzM95si/IlXovp/X2XdJtqCoKyROgsxOp2q0g8k4Y75xyIG
         JFl6IVIMGyZN//BK+r6Ns8oi1bBlYFrGbCnOTJqCvA4VSMLPrsKE/drKX0MZ14CduFmq
         6gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+J0TIHAU/h4U5QOiy6//7+OXhxUGaPDeOukNgI2tVVo=;
        b=juW7r0HSf+9P+Xses4jRbmFkCKQXkpYxvZ7dk0ZXd4+Wm/vKG+hWAx2Z7OU8vLELlO
         FlwT8n3uouYFtHkVCrzLAbAW40Dbhe7VHxoSBvVexwdTui5zwbv571KkDJr7BmurgsDe
         681NRh1kgJXRvCCiYlI3iTV577dK3QVHeuN4H1YyJH/phJgPpaGLhyus3r/3DTzWAUS5
         TW1kIXVPG6K8j2msXwUO57EsVOogSl3Z4qk5ElDWdUS5r7uTAB15xZ+5t+9KgyNEvhnm
         gW9hhanBmKyIBYX1EYk6WNaEl12ifGcfwNg7+/ltP17waIUh3Sn6WxYbhXe0on82JHvu
         yvag==
X-Gm-Message-State: APjAAAVwbwfVsvZT3VA4lD7LGtTok2eWZsz7PBK+l6WDS8NhNSa0j3aO
        DDrsdvPYAsKiPVuNSDXDCcRlww==
X-Google-Smtp-Source: APXvYqzb/86f5B5xECJYGNnXpdgOwbR2r30ALBUQxchhnOByu9Cu78O45D1cSlajQ1A1lq29Ak8UBw==
X-Received: by 2002:a63:1703:: with SMTP id x3mr18855118pgl.263.1573309249328;
        Sat, 09 Nov 2019 06:20:49 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e1sm9098762pgv.82.2019.11.09.06.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:20:48 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix accounting of dropped CQEs in backlog flush
Message-ID: <1031d393-b7b0-f2e3-9c7b-82142895e13a@kernel.dk>
Date:   Sat, 9 Nov 2019 07:20:47 -0700
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

We really should increment the overflow count if we drop events from
the overflow backlog, even if we only do this from the path where
either the task or the ring is going way.

Fixes: c28f37817b7c ("io_uring: add support for backlogged CQ ring")
Reported-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 321ccc38397c..f2769f5f9662 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -628,6 +628,9 @@ static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 			WRITE_ONCE(cqe->user_data, req->user_data);
 			WRITE_ONCE(cqe->res, req->result);
 			WRITE_ONCE(cqe->flags, 0);
+		} else {
+			WRITE_ONCE(ctx->rings->cq_overflow,
+				atomic_inc_return(&ctx->cached_cq_overflow));
 		}
 	}
 
-- 
Jens Axboe

