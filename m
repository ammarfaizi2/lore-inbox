Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C7C433F5
	for <io-uring@archiver.kernel.org>; Fri, 10 Sep 2021 18:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62B0611C5
	for <io-uring@archiver.kernel.org>; Fri, 10 Sep 2021 18:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhIJS07 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJS04 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 10 Sep 2021 14:26:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4AC061756
        for <io-uring@vger.kernel.org>; Fri, 10 Sep 2021 11:25:44 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a20so2970925ilq.7
        for <io-uring@vger.kernel.org>; Fri, 10 Sep 2021 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXqLAV2nHQSRvb7ZpTv11qb8Cadrv15U6bJT2tEZrTA=;
        b=C9n592YCvQVMPC3QJJq8doHR8zymsLndJY7D9sFC7MPjcHYXietRyHeBqWGrPNd8Eh
         Ramev7MeNwgQevFyw9xHgFNGVl+TJBPmb5KYDOH9lMFERBfoQHZgGUyqarBbcdfsS/bs
         RIcHmf/0TIdWttSAMJEJYaLIbfSJLyO1Ts8HsHDOQswciqFc+KmOa5B6V3iSrx5qfJMZ
         LQXRIqmc1XOYT6gHnhua2GK1eRKuJ1puUPfOA3daLzgT2ui441hg6bDnm0DOfFZ+/3PN
         1rj1n7m88iN14EDYdY9D/VQhHQsM/f9WNlv7FL4ZJxMb7Vexn2RDYE4wLhL97X+qxyFo
         UR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXqLAV2nHQSRvb7ZpTv11qb8Cadrv15U6bJT2tEZrTA=;
        b=yeRvEcQUUfQKG1rQ0ZwWFZon4H9Ihijlhfb0i17GvpkTe4bW0h1zHSv9xIn+I1553e
         9jHl4RL4XA140kHmULXCqmZv0EY4z8byIvdoB/j/vfRdj7KK11XcKCV9I2WYiCx4GyAO
         c4tiLd232+a8Hh+Wn5atPrchRsVXDxFWO7jhCk2ZXYOEfVMsbqSEWystAxPfHBvt+b6D
         V4xRe7yrTUTw26BN+1LpAq/jxGcgMAOyWuMYF2UBYmyytg/U9ElZBRxJNInNf3R/MDwx
         Ke6DHuxsYtUXNcwg05jcCkpIq1FzCWT/HP0mH5QjAAaNoPoFtE6Dwkuk7DpiRviO3pXV
         /SQg==
X-Gm-Message-State: AOAM531HytFdcCA4t8gDEfky3H//2uClvZGGZVlSSJbMIl+dzjdlmu2F
        1DD14Wh5YK/V9oXYQvBPNF2iBWwN52I54ckrwJ0=
X-Google-Smtp-Source: ABdhPJx8Mme/uzeOQpl1RzbdA7+VQ+YAp0SgCmqt948wv5waJl2kT5lV9BmbUv+0u+x7l5dlVBPYrg==
X-Received: by 2002:a05:6e02:1044:: with SMTP id p4mr7281793ilj.227.1631298344198;
        Fri, 10 Sep 2021 11:25:44 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c20sm2575149ili.42.2021.09.10.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:25:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] Revert "iov_iter: track truncated size"
Date:   Fri, 10 Sep 2021 12:25:36 -0600
Message-Id: <20210910182536.685100-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910182536.685100-1-axboe@kernel.dk>
References: <20210910182536.685100-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This reverts commit 2112ff5ce0c1128fe7b4d19cfe7f2b8ce5b595fa.

We no longer need to track the truncation count, the one user that did
need it has been converted to using iov_iter_restore() instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6eaedae5ea2f..7c8aeacc6fa7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -53,7 +53,6 @@ struct iov_iter {
 		};
 		loff_t xarray_start;
 	};
-	size_t truncated;
 };
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
@@ -271,10 +270,8 @@ static inline void iov_iter_truncate(struct iov_iter *i, u64 count)
 	 * conversion in assignement is by definition greater than all
 	 * values of size_t, including old i->count.
 	 */
-	if (i->count > count) {
-		i->truncated += i->count - count;
+	if (i->count > count)
 		i->count = count;
-	}
 }
 
 /*
@@ -283,7 +280,6 @@ static inline void iov_iter_truncate(struct iov_iter *i, u64 count)
  */
 static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 {
-	i->truncated -= count - i->count;
 	i->count = count;
 }
 
-- 
2.33.0

