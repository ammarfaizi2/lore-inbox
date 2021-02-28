Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB3C433DB
	for <io-uring@archiver.kernel.org>; Sun, 28 Feb 2021 22:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC37364E31
	for <io-uring@archiver.kernel.org>; Sun, 28 Feb 2021 22:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhB1Wkl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 28 Feb 2021 17:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhB1Wkk (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 28 Feb 2021 17:40:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47204C06178C
        for <io-uring@vger.kernel.org>; Sun, 28 Feb 2021 14:39:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u125so12631036wmg.4
        for <io-uring@vger.kernel.org>; Sun, 28 Feb 2021 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xec2aMce6R+0TvDM5NwXERiuzfjmRrHCzC+VnRQPDHE=;
        b=uor94PjH8PvSXWqyA1fgRw6V5JhymQx/B381sgYA0aabfGbyN2SCws9gAJ8ag5knTB
         +7uc3EfKZh41BuZO9yz1QiIkdIVLesK219AHWkzKzgkRCmtiMOt7Ep5AdtuN2IUCQ2nE
         d9tFFyPIkMNk8Df8H6mia49Ry64tS7OJCX/mYoHtoPctR6zDWZlr+MSQNoS9SCXcMEd8
         hcwNK6cMJQN3Drn1c576Ca0JyCWd8jAu2RHgkIzo4PSfCQjMgAKYSNpXTNF8huyXIqEs
         2Y21pZGcUwAjILvDo2MJv1X5B0hsnz7FSvhis+anh61JuAh2IXF1C+R/NDklvUvXfX8i
         qJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xec2aMce6R+0TvDM5NwXERiuzfjmRrHCzC+VnRQPDHE=;
        b=r5zroOIvKmGDV1Qul5xLl0TFTFu/U7gKFzWOuFP64HM2O7aR9mdfDZ5Xh9OLNaAg91
         4w0PsxQ9DG94vtdUf0IFbz6Xs8HWYNkpV71F1PpCT2UjANZQ6i0gLVzjJR3FlAizHe2g
         LcvNs8eF2Yolh/niRFyPWagyuLZuSXQCuEezghgRFu7Lq3EE5HpGsOEwaCzNjL7dq22n
         QV2juSjBH/dv3NzNcpe/T/PcBw9w+b1kCR/5ffc+j/HImWJ3r3WAjQowjBlu958sFs17
         y7V5ml6mB2GvAaIcZ5sy9C2PFB3UHjfa1jaV9PTK7rOPCvovRrscgs/xTUMvPkSLuP1g
         zEqA==
X-Gm-Message-State: AOAM530LryEjZtvUc0B/e6srzlpHl4QvhDTwx0bk3d/5b2I0Ajbsz7jK
        f5RqTI3pKGBLgdAmh4VrjtEZqP95wJ6BjQ==
X-Google-Smtp-Source: ABdhPJxhuC23xFBE/9wCgl+YZxaAvMAq21mOyK8nd03Cu5bDvpUYJt5CXlo340jy1Mt5KgItKnythA==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr12555060wmd.40.1614551964131;
        Sun, 28 Feb 2021 14:39:24 -0800 (PST)
Received: from localhost.localdomain ([85.255.232.38])
        by smtp.gmail.com with ESMTPSA id y62sm22832576wmy.9.2021.02.28.14.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 14:39:23 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 06/12] io_uring: don't restirct issue_flags for io_openat
Date:   Sun, 28 Feb 2021 22:35:14 +0000
Message-Id: <5d247ec8821ae598a2482b3622d543591180fd04.1614551467.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1614551467.git.asml.silence@gmail.com>
References: <cover.1614551467.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

45d189c606292 ("io_uring: replace force_nonblock with flags") did
something strange for io_openat() slicing all issue_flags but
IO_URING_F_NONBLOCK. Not a bug for now, but better to just forward the
flags.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c40c7fb7fc2e..5b1b43c091c8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3826,7 +3826,7 @@ static int io_openat2(struct io_kiocb *req, unsigned int issue_flags)
 
 static int io_openat(struct io_kiocb *req, unsigned int issue_flags)
 {
-	return io_openat2(req, issue_flags & IO_URING_F_NONBLOCK);
+	return io_openat2(req, issue_flags);
 }
 
 static int io_remove_buffers_prep(struct io_kiocb *req,
-- 
2.24.0

