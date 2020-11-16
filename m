Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB345C63697
	for <io-uring@archiver.kernel.org>; Mon, 16 Nov 2020 05:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524D2222C4
	for <io-uring@archiver.kernel.org>; Mon, 16 Nov 2020 05:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DROM5OSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgKPFKb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 16 Nov 2020 00:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKPFKb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 16 Nov 2020 00:10:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52CC0613CF
        for <io-uring@vger.kernel.org>; Sun, 15 Nov 2020 21:10:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j205so23417751lfj.6
        for <io-uring@vger.kernel.org>; Sun, 15 Nov 2020 21:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSGSIRLeqIMuGeG6RTM08wPtRBlAKYFentXMsYcytM8=;
        b=DROM5OSE5ljGVleZgsWprzcHDwADE0l5M81Tei7qJctkhitPhU00gEEzRvnbxaD/KG
         A8SLFYi+hQyBhVX5P5JgYqpGGce9S0ETBX8jXmxyXxgGjEjPo16iCzFYtccTwZUgCSgJ
         pvTDHshRzEYlXMd5FSWL7ozs+xwlDWqHLvE/IvxV/WUiVt4YQF6aAvToN7a4Mtt2Rp9w
         zUy7XTG8kVyhKYsUl3oquYIzU63ijF3NuNDkhtWG18Mq4MXU0Dwrsz43dj9xwlrd69Wg
         GkxySmlxg0nLVzBW1x5xecuSIwH6Lx/pg1nl32ftJ8AxhK4+tjGjXs/ejWi8HlgdycIS
         BffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSGSIRLeqIMuGeG6RTM08wPtRBlAKYFentXMsYcytM8=;
        b=VQT31cL0IfRMnjWWdiioHfFraRmOFy6n7dmwlORh2gU3WTUzahvELrFT/6/uIHu7L7
         WMZA/FmONJ1pSTFuQmWI0qZspMmwgLJOiPdnT0jw6VqYOAmDisKNTbhK8D81bqpMKDUg
         +hQX5yUl3YOM3XXU6OytGDRqLzQYsOMBO+QfFpuMmON22Psqbhrmtv9LyHrUVqKZm/Gd
         Os13HuwCPXGLqdZF8hKY+AbJrTW9nbJ/+ZPbP3qGlN4+u/4Oar7UAJrZOVu1ITZAfePL
         l4+l5YXv+DxuxNtGNWM6Wpkyrel4Pu5WMWgoHhqPQmEDUJyIt9fByh9V7AO4iElKahQJ
         hMhA==
X-Gm-Message-State: AOAM530tuvCWfCJoI7Ajw0SC/8DB6yO4fUZqziZO67Df58JvSDapHUrn
        j4BxZjgfHsLFrh4yegAsIhPMDWP5hn+pvA==
X-Google-Smtp-Source: ABdhPJzyn6wTM9jnMT1GJjgezArzc9wFaWiMArxzjwX0ORfrdLcLj64V+xppb9BLde8joCAthLR7UA==
X-Received: by 2002:a19:844a:: with SMTP id g71mr5295543lfd.414.1605503425533;
        Sun, 15 Nov 2020 21:10:25 -0800 (PST)
Received: from carbon.v ([94.143.149.146])
        by smtp.googlemail.com with ESMTPSA id b79sm2595909lfg.243.2020.11.15.21.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 21:10:25 -0800 (PST)
From:   Dmitry Kadashev <dkadashev@gmail.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, Dmitry Kadashev <dkadashev@gmail.com>
Subject: [PATCH liburing 1/3] io_uring.h: add mkdirat opcode
Date:   Mon, 16 Nov 2020 12:10:03 +0700
Message-Id: <20201116051005.1100302-2-dkadashev@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116051005.1100302-1-dkadashev@gmail.com>
References: <20201116051005.1100302-1-dkadashev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Dmitry Kadashev <dkadashev@gmail.com>
---
 src/include/liburing/io_uring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/include/liburing/io_uring.h b/src/include/liburing/io_uring.h
index e52ad2d..23a699c 100644
--- a/src/include/liburing/io_uring.h
+++ b/src/include/liburing/io_uring.h
@@ -141,6 +141,7 @@ enum {
 	IORING_OP_SHUTDOWN,
 	IORING_OP_RENAMEAT,
 	IORING_OP_UNLINKAT,
+	IORING_OP_MKDIRAT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.29.2

