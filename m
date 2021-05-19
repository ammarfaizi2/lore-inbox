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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC6C433B4
	for <io-uring@archiver.kernel.org>; Wed, 19 May 2021 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0E61355
	for <io-uring@archiver.kernel.org>; Wed, 19 May 2021 14:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354096AbhESORT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 19 May 2021 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354091AbhESOP4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 19 May 2021 10:15:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD1C061355;
        Wed, 19 May 2021 07:14:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3530533wmh.4;
        Wed, 19 May 2021 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuX2UeSUBJXSqowr6KYhrEXkA8BKdQuekr2AsyWJdb0=;
        b=tiJ2uAMrHeGJgJ5dBPzFwXDO6Xyhclb0qIZUs474IgaSEzRB7/qKoK+MFMR9uk+fIo
         MQXzN6T/nGnZOX7yXuhhMl4ID6wkGrI+PgmhGasm58yc6nosW/VU1Jp6PRT8piAks/lO
         Y/cuTiY+RWWo6rKPrtOdHaeAVJvIoWrqDeFlDQo647WpC1uNmi2qsl1pQrIoU6C7MiJy
         1j501N4kj6U0LOQa8jISThh7Kyc6bii2aZojPqsm8QwWiGrzW685Rluz1tOiNgCmpjQX
         XkX6PIHl5/DQ39ehuJNOycTWbQbA44Xlg2q8zhq2JmVczVE+a5dVCIaRb+BgT9sztWNZ
         QHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuX2UeSUBJXSqowr6KYhrEXkA8BKdQuekr2AsyWJdb0=;
        b=e1yoyYJH/m+qaeeHlUc3kBN6pwpaBp59MGVKaFc0ZZzx0N2D5qGi0HlUGcI2bZh4Kz
         ZzcFe4ReEAK6Q4UReIP2M6KL90ot9KfN1VQT3jp02U0jRm+Dvm82rwauEBkqB/VdvcyO
         nbBZl1jFAq6xwY9bF3yitvb3jCgQVOIvvbmGLI1w7iamJ9D4qzvAlgiStdl0FaSkdeNw
         D28BIdcHKbu0/MKwWPom4FKtY14Tfx39G8CkeBv/z0xPb60GKphe/W2M2erkdG/tiGW5
         /Xs8Zog7jlvLFJRIA0Gehn/JocAhv8hZ2BxIg1LQJ7coqT8tXFdVDq+bvoDWQ6Q2RQro
         hB+A==
X-Gm-Message-State: AOAM533FhXNWm3OGC/LL/YF4Hl9QpxVEPrdUrONdxHOtmq1rFABICapL
        eLfulK7+rMq7JGgFAt7YCj5zMzm9xpt4xJqq
X-Google-Smtp-Source: ABdhPJzwYCrvP5SAP3gbFSnQVCGBYTtY4mzfb5GE4HPC83YVjuJr5c1TewlinV1TEx271xO8VHRWCA==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr11116021wmi.75.1621433657076;
        Wed, 19 May 2021 07:14:17 -0700 (PDT)
Received: from localhost.localdomain ([85.255.235.154])
        by smtp.gmail.com with ESMTPSA id z3sm6233569wrq.42.2021.05.19.07.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:14:16 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     io-uring@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Franz-B . Tuneke" <franz-bernhard.tuneke@tu-dortmund.de>,
        Christian Dietrich <stettberger@dokucode.de>
Subject: [PATCH 22/23] io_uring: don't wait on CQ exclusively
Date:   Wed, 19 May 2021 15:13:33 +0100
Message-Id: <d2e5339476d3cd9c5b738196e8771868ac3c3208.1621424513.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621424513.git.asml.silence@gmail.com>
References: <cover.1621424513.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

It doesn't make much sense for several tasks to wait on a single CQ, it
would be racy and involve rather strange code flow with synchronisation,
so we don't really care optimising this case.

Don't do exclusive CQ waiting and wake up everyone in the queue, it will
be handy for implementing waiting non-default CQs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c4682146afa4..805c10be7ea4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7085,7 +7085,7 @@ static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
 	 */
 	if (io_should_wake(iowq) || test_bit(0, &iowq->ctx->cq_check_overflow))
 		return autoremove_wake_function(curr, mode, wake_flags, key);
-	return -1;
+	return 0;
 }
 
 static int io_run_task_work_sig(void)
@@ -7176,8 +7176,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			ret = -EBUSY;
 			break;
 		}
-		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
-						TASK_INTERRUPTIBLE);
+		prepare_to_wait(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
 		ret = io_cqring_wait_schedule(ctx, &iowq, &timeout);
 		finish_wait(&ctx->wait, &iowq.wq);
 		cond_resched();
-- 
2.31.1

