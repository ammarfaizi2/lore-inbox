Return-Path: <SRS0=AAoI=Z2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17334C43603
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9F120659
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 16:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="skiOILg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfLDQjz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:39:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37459 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQjz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 11:39:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so135133pga.4
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oG9+7ryxE/LrN1HXkcAk9ZKktbogA8wdLyHvYHsjuko=;
        b=skiOILg/t7cg4RanDelnPjl4LO+AutRzTgaIUCNJyacfs5tNNost6WNbtyQrNqdXYT
         hEJFMzJZuU4DMYZOd4h127iV4xKykK3AKTZ7QbJhrVW0fpoHSpxEZvW7SnoYN6/Qs3GC
         OQJveRpV5GkhhE2MdApa0fgg6VdkIpZIbSqAbY2CwfK2nUc6t5GEJDEvAj3lFC/jhLP7
         ePe+1oCUS+zkEoFxGH5Xp8TWV31/FuO3tLhgdV2ojmk8p871ux6b7w/nE7L6fa3mer9Z
         p8uBBTsHMiyrEsvSQDMQG1pNKarUvUZGZoKsE94TENUTxCUbqprWX+uAUvEVuTdSSkIG
         0foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oG9+7ryxE/LrN1HXkcAk9ZKktbogA8wdLyHvYHsjuko=;
        b=SZcSnI3z0dF5U4itQnuxXU2Vyo6pv8wXzLs2lFJJ1HgSXHB6HxqDl+gQNPKepqJ+83
         vMQugecgbT+/LowoocSSszhwNLUmmlI9enQGjYUags3ahXxLRaEAVJJTYisx9XYu/djg
         9PEJvkKsE3076yfglnM9GFpCODcWy5rROGKg9poNQ96CsYQyieR5ZG1kHBWsvXaJRpID
         YFlwSznjMJE+l56HLm/Tdv6Aa7m9854+1XZY1IzekGYm8w68DK4hHwL1rNHSFxknwzPC
         g/QVt0rjlm9QlQcJ8J8jH+qAVQgnTc/67TeFdPWJalm7RcL3yNU+ijmrzpS79Kl+TrM0
         kspg==
X-Gm-Message-State: APjAAAU9NltsMpx/PxxRYYz1+SwpxAi/JZbaohtgTdzahmpcnUwvbqrM
        oQFXGq/xCTxuZC/x1hU2LnNbRxIz/4i7rw==
X-Google-Smtp-Source: APXvYqzAexc9mIavUfN8g0KlIpAvvgaQSdOp8bgVSoDdX/GpkpM9Iqv2d96bHsvEoaCnCOMVj9ODOQ==
X-Received: by 2002:a62:cece:: with SMTP id y197mr4514219pfg.9.1575477594703;
        Wed, 04 Dec 2019 08:39:54 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id m6sm8082639pgl.42.2019.12.04.08.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 08:39:53 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
Cc:     carter.li@eoitek.com
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: allow IO_SQE_* flags on IORING_OP_TIMEOUT
Message-ID: <faa73da6-864c-574c-7feb-c51dbadcd152@kernel.dk>
Date:   Wed, 4 Dec 2019 09:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There's really no reason why we forbid things like link/drain etc on
regular timeout commands. Enable the usual SQE flags on timeouts.

Reported-by: 李通洲 <carter.li@eoitek.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6c22a277904e..00f119bdd8ff 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2703,9 +2703,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
  	int ret;
  
  	ret = io_timeout_setup(req);
-	/* common setup allows flags (like links) set, we don't */
-	if (!ret && sqe->flags)
-		ret = -EINVAL;
  	if (ret)
  		return ret;
  

-- 
Jens Axboe

