Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7797FC432BE
	for <io-uring@archiver.kernel.org>; Tue, 27 Jul 2021 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585E86101C
	for <io-uring@archiver.kernel.org>; Tue, 27 Jul 2021 16:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhG0Q6Q (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0Q6Q (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 27 Jul 2021 12:58:16 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C8C061757
        for <io-uring@vger.kernel.org>; Tue, 27 Jul 2021 09:58:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so3227919ooa.11
        for <io-uring@vger.kernel.org>; Tue, 27 Jul 2021 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8MyldbATmj30SfQiMDDbHxNgEGx/fMmtLadIJbuYBA=;
        b=bAnOa1WAa6/s1f39xSkFVuQrJjpzbm0+jupmZmlU+N7GVt8emiv7EGDjDpc2DQZ0oS
         ouOnO4zbNGpbM+AIiSU8DNtrRnhqHc+wjWeOv2kd+pS3EDnRRJ+JnKWISKSVKjFVL5Nt
         6HsRlYCBZSW6zZSXj5vHJYCDXoCruFaImc1yaGlg4wpGqOvBXAQP7tGPFnvFnyug0KDb
         1/xK9oqNUx5pa8Aoq97He8yve4k3S0DOK8cNndN85v2EV9d6oO6bs2J7eLrenfMVFIXh
         5Jjj794IXNPEJv9iXs5Onh+JW2W1sIKpi75F7E8daNI32uE2PynGaMa743HD623VtSbY
         UgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8MyldbATmj30SfQiMDDbHxNgEGx/fMmtLadIJbuYBA=;
        b=TvTiS2pCfgEZNLSaqfjDDoQkFZhikBwJDByBMEef9O7QnpV5Y/msjvYeeC+GfXAsWY
         Ablqp/7VFkAD5BgFVBDPkAoIOe4GfHiiCjtVjBlZ6daXa3gKeDE4HyRDLsaycACLzZJT
         quuBobt8XY7gdKd0nRGC31CKN9LWBkKTbw0boUcIZFt52Wa4taaHf1Bs8orQwUjgdbMa
         lQI3LNuUe8qh5tD3mbqkHx4Nrp//AJD8rJBNeyDvk+zXNEhht7KNRqUpt6lIo/t2z/pk
         SGThQMiqjyiBiLkEjFi5kFBGmYg+DAUEYy1tventryo5xoY4ZW4FWJLG0MKAAxY/3Nv/
         jXjA==
X-Gm-Message-State: AOAM533MgizVhRPXBWE/4DC4nCUsm5moYaR6d4q5ZCOkiwX8NTS/8LI8
        wkhq1cV9dFdpamum8YeEOj3R3Ji625SAybDY
X-Google-Smtp-Source: ABdhPJxa/R1nRVrwa2g1gNWy21e2zXu+UnC84b3xD4DT64tbxhzb5m4c42vi0L9po80AvwF85yqImA==
X-Received: by 2002:a4a:98b0:: with SMTP id a45mr14533443ooj.22.1627405095332;
        Tue, 27 Jul 2021 09:58:15 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c21sm637922oiw.16.2021.07.27.09.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:58:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     f.ebner@proxmox.com, Jens Axboe <axboe@kernel.dk>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring: don't block level reissue off completion path
Date:   Tue, 27 Jul 2021 10:58:11 -0600
Message-Id: <20210727165811.284510-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727165811.284510-1-axboe@kernel.dk>
References: <20210727165811.284510-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Some setups, like SCSI, can throw spurious -EAGAIN off the softirq
completion path. Normally we expect this to happen inline as part
of submission, but apparently SCSI has a weird corner case where it
can happen as part of normal completions.

This should be solved by having the -EAGAIN bubble back up the stack
as part of submission, but previous attempts at this failed and we're
not just quite there yet. Instead we currently use REQ_F_REISSUE to
handle this case.

For now, catch it in io_rw_should_reissue() and prevent a reissue
from a bogus path.

Cc: stable@vger.kernel.org
Reported-by: Fabian Ebner <f.ebner@proxmox.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6ba101cd4661..83f67d33bf67 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2447,6 +2447,12 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
 	 */
 	if (percpu_ref_is_dying(&ctx->refs))
 		return false;
+	/*
+	 * Play it safe and assume not safe to re-import and reissue if we're
+	 * not in the original thread group (or in task context).
+	 */
+	if (!same_thread_group(req->task, current) || !in_task())
+		return false;
 	return true;
 }
 #else
-- 
2.32.0

