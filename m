Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28636C47096
	for <io-uring@archiver.kernel.org>; Thu,  3 Jun 2021 05:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F99613E6
	for <io-uring@archiver.kernel.org>; Thu,  3 Jun 2021 05:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCFcU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 3 Jun 2021 01:32:20 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:33369 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFCFcU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 3 Jun 2021 01:32:20 -0400
Received: by mail-ej1-f42.google.com with SMTP id g20so7414542ejt.0
        for <io-uring@vger.kernel.org>; Wed, 02 Jun 2021 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUYH92bLLZMcczeVhqxSJDZB6B+nB7isQp+/JnDgiKo=;
        b=u+xpdzf2Y8Wl66Mm5LD5ihsc6BQamUYej3BJxFVBq6raj0TzoHtBMUTF69L4gaXFOG
         0ouWGoVaAveeY3euqHlBj6DR3oOI7LVbk5y1hn3hSanFELr8UBkjx1nEgM6VazspXFhx
         GxZqAzem9w5mHFw+U35zqL0M4dcEms6cv3GWpEJ+9Vfg+fLEN0mWwGZ9LBiDUIfJscPX
         J4tCeYsA8cdDafV2BEXDdm+BmyO4RtazomyBS9nhs17aZvztTA1QowUFtFd2jjZ3+xV2
         FkTpIauZfErX6val0PUX1f5uoaJym9Yj5J+lcyj1vnX2TQgeculChaq/i1pJFlT8vajl
         /vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUYH92bLLZMcczeVhqxSJDZB6B+nB7isQp+/JnDgiKo=;
        b=oxj/GbpR3aI9sNs7DX8q9uRaCXKhkYa1AdNg5cAuifSvtDbzQ2WMQLvOEcZl7TVw3f
         xd8vhsIkgmgHZT24aodfgqsn1Nl/RXz1JLFQjy+sFwJbuUUTlbAPE2Ufex1+alUdff7+
         nOdSspnst42M8LQcJlY6B4kehgsuf+yfMXST/SOr3zxzc9C6Kk01pGbkdePPBEea+7gM
         f5nb+hGL6xZ48FiFrDqEv8PozxPNeTOke/BVblqhMjH3/cxGP9tBd67Yk99RFjc2S0g+
         nLLmP0Q9PWv8tl4USOOIXyST7+TBeVZMbfZekQNmx1VwMLETFIbxiwzjL7eQPraS6nWf
         mbpA==
X-Gm-Message-State: AOAM531oPgyLalRBn13NHd70kV6Oiz1n2aTQQay/ZHfykXm9pND8GqE2
        3EXHXvejuLjkGjIhpzh10y8=
X-Google-Smtp-Source: ABdhPJwblpAu9LbxuIIZVj287HLOpVajVM1lD+3NX5ItY+4Jc/9jdL9TgUBii6zgkSxm+ISnYdwVIg==
X-Received: by 2002:a17:906:8041:: with SMTP id x1mr15345628ejw.81.1622698162149;
        Wed, 02 Jun 2021 22:29:22 -0700 (PDT)
Received: from carbon.v ([108.61.166.58])
        by smtp.googlemail.com with ESMTPSA id hr23sm943291ejc.101.2021.06.02.22.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 22:29:21 -0700 (PDT)
From:   Dmitry Kadashev <dkadashev@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        Dmitry Kadashev <dkadashev@gmail.com>
Subject: [PATCH liburing v2 01/11] liburing.h: add mkdirat prep helper
Date:   Thu,  3 Jun 2021 12:28:56 +0700
Message-Id: <20210603052906.2616489-2-dkadashev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603052906.2616489-1-dkadashev@gmail.com>
References: <20210603052906.2616489-1-dkadashev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Dmitry Kadashev <dkadashev@gmail.com>
---
 src/include/liburing.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/include/liburing.h b/src/include/liburing.h
index d3f8f91..b7f3bea 100644
--- a/src/include/liburing.h
+++ b/src/include/liburing.h
@@ -548,6 +548,12 @@ static inline void io_uring_prep_sync_file_range(struct io_uring_sqe *sqe,
 	sqe->sync_range_flags = flags;
 }
 
+static inline void io_uring_prep_mkdirat(struct io_uring_sqe *sqe, int dfd,
+					const char *path, mode_t mode)
+{
+	io_uring_prep_rw(IORING_OP_MKDIRAT, sqe, dfd, path, mode, 0);
+}
+
 /*
  * Returns number of unconsumed (if SQPOLL) or unsubmitted entries exist in
  * the SQ ring
-- 
2.30.2

