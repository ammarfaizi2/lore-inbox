Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC2C4320A
	for <io-uring@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36D961008
	for <io-uring@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHKTgH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhHKTgE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 11 Aug 2021 15:36:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8BEC061798
        for <io-uring@vger.kernel.org>; Wed, 11 Aug 2021 12:35:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so11271429pji.5
        for <io-uring@vger.kernel.org>; Wed, 11 Aug 2021 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7nEJ4dK4R1jH+/WHvia5muthOy9g65ru5z/3wVHRoE=;
        b=tv9oqAVejrrGokNmOqO0Ms1rxAVj+vm5DTRXkCXDIf4klCeIBkEvJ4v9RTKTYG01WA
         iaLLB7o99dK5AjUtzEsxBZkzttLdIAjjtSIW+uyTyiwdB41IxGMfkoU4PCSOIHTNA2EK
         NhbodCJYjx9KFeGQLxfaaPnsGyLRVMVk+hFukuEpiTdpV87HWiUWWzfP/CxKJBCjdiwf
         IXQFAPHwzhu0JvR12tb3pNmvAhVSq20IdOALpL8AhfCR2ISSGR1Ay5lxUmnwHR83cyec
         2Reh+xVaziPbWMdEyAskXuFvzgHUUKcOloNiYL1YRE64KKOtZ22KNrazLzaLn9EElkm/
         Qj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7nEJ4dK4R1jH+/WHvia5muthOy9g65ru5z/3wVHRoE=;
        b=JNgUHCk0OvYdBF7yCU0PfU6x/YnqDY3BiTS4c4yJt05/j97mbmcRY/iIa3o1Y/wxRZ
         OYYPpoS7TI8PcI7RYmM/S4hXRB0zVbjiDn5XW0Vq+r7xZoV9gCpfT6pFTw66KMcRHt+x
         hV9PcP+9ZbSVgRia9bt9Ktk1nDTUs5RuUxJEd+w2dX3cZi7FhMiPxeVgtdyxrpGmqF+2
         iHxpV41TLEwBez0/iT+QHuUmNIXz05vluMfJ45v/0/kDVzFa2XnSFUImReoEqz6hWbKh
         DHqTwMOHqWiOj23DTMIytvOmhHctEt5Qgbod7FZUPpXGhbVQ0udS4yfUV/mAIvSt3r1V
         gP8w==
X-Gm-Message-State: AOAM531wrNh+uxzUE/g7SMVsdik5yo/U4G1QkPpzDD5jCgNe6Fb8yPu6
        p4q9YjBr+YqctDZqbpSlN+lOxB5rG+TI/j7U
X-Google-Smtp-Source: ABdhPJx7HRsnH9aZkRlFR+my4k725bNl8KLhfQEjijU09X1B1Ld8cYqbDcQuwAYKhjXdKQUPm5m19Q==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id m12mr153114pjd.107.1628710539670;
        Wed, 11 Aug 2021 12:35:39 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u20sm286487pgm.4.2021.08.11.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] bio: optimize initialization of a bio
Date:   Wed, 11 Aug 2021 13:35:28 -0600
Message-Id: <20210811193533.766613-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811193533.766613-1-axboe@kernel.dk>
References: <20210811193533.766613-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The memset() used is measurably slower in targeted benchmarks. Get rid
of it and fill in the bio manually, in a separate helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..0b1025899131 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -238,6 +238,35 @@ static void bio_free(struct bio *bio)
 	}
 }
 
+static inline void __bio_init(struct bio *bio)
+{
+	bio->bi_next = NULL;
+	bio->bi_bdev = NULL;
+	bio->bi_opf = 0;
+	bio->bi_flags = bio->bi_ioprio = bio->bi_write_hint = 0;
+	bio->bi_status = 0;
+	bio->bi_iter.bi_sector = 0;
+	bio->bi_iter.bi_size = 0;
+	bio->bi_iter.bi_idx = 0;
+	bio->bi_iter.bi_bvec_done = 0;
+	bio->bi_end_io = NULL;
+	bio->bi_private = NULL;
+#ifdef CONFIG_BLK_CGROUP
+	bio->bi_blkg = NULL;
+	bio->bi_issue.value = 0;
+#ifdef CONFIG_BLK_CGROUP_IOCOST
+	bio->bi_iocost_cost = 0;
+#endif
+#endif
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	bio->bi_crypt_context = NULL;
+#endif
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	bio->bi_integrity = NULL;
+#endif
+	bio->bi_vcnt = 0;
+}
+
 /*
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
@@ -246,7 +275,7 @@ static void bio_free(struct bio *bio)
 void bio_init(struct bio *bio, struct bio_vec *table,
 	      unsigned short max_vecs)
 {
-	memset(bio, 0, sizeof(*bio));
+	__bio_init(bio);
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
 
-- 
2.32.0

