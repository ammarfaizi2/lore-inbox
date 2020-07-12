Return-Path: <SRS0=0kNa=AX=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A53C433E7
	for <io-uring@archiver.kernel.org>; Sun, 12 Jul 2020 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DF72070B
	for <io-uring@archiver.kernel.org>; Sun, 12 Jul 2020 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzYU+ynx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGLJnS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 12 Jul 2020 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGLJnR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 12 Jul 2020 05:43:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381FC061794
        for <io-uring@vger.kernel.org>; Sun, 12 Jul 2020 02:43:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so10879238ejq.6
        for <io-uring@vger.kernel.org>; Sun, 12 Jul 2020 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hERDq9zEYBq5a9P0a0NQGJDMh0W1tgDHewSUpcBownY=;
        b=fzYU+ynxbLRDuHvE9OGpOs1X7k+On9LxMe2ujrhve5pPCGrYRPal615H1uAWGJL3F9
         +9jW7FGsSsVzD+90bh1XSlxG/Ymim1n08iNcExiDKCc4CBmOMYaeYvBwH8yUBtqcMeUV
         lrOIGrhVLjhH5aAShkYzaMhGboY+B5pXoUL6YK1eSAm1ifNdg/8pAg3AMAdNnVeKNKWk
         KrTrvst8bdun8SekR74fABMPbLhFAsT3NDC5o6MUrY3bFV5MSOKXQoSN+ExUCwWYbavC
         LJ5meTQwA1zdXf+xzf30kpQEhnRoBvMLNsdQiy29wD0eMpW5MUkxVFgUtLGPhHdRFgoz
         NQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hERDq9zEYBq5a9P0a0NQGJDMh0W1tgDHewSUpcBownY=;
        b=JAeJ7pQFE/lCzYihkixXWEd3XmBF6kjq710W0zb0UAkOTbxywzpSwa0sPfJq92ExVH
         6jpL+smFVDFBSTXUrlxtB5GMha6pd8t3Pg3a0lvFvWqj1YGWDTMyBi+VAIXd9wHJRo9W
         q0ApxEgk2NKDSdHkqilLK3XiBFg2RYxykyFoM9Y0o4kbcpYC6BCgnni1lV+hhgZ7iDtT
         3NFQ2BKlylhA+QmUM8ol4D1NZqOsigA5Ku/ytlUL0n2TkwKUIpa/Pu1ZDJfiKN4xwxWz
         LgTI6BcIUI9SxzIhWzMZNl1fm11bR5WGXIn2C/HHYAj+OsGM83w4prus/ByKDzrvKvFk
         dcrA==
X-Gm-Message-State: AOAM532CiKgMCpOgRl4GYeDIRHnlJRw7xnKlxmaxSwZVG8exgWOb/9CI
        wRkZ/X6XLz8CqIKKxMXzygWRTh99
X-Google-Smtp-Source: ABdhPJxWbNaQCY3aCOVTPrbHZY1euLw8alMcw4Bk9ClU/RG1tNrVKRZc9NZzs9hXCtQuDbFtn34zcg==
X-Received: by 2002:a17:906:3789:: with SMTP id n9mr6114107ejc.512.1594546996167;
        Sun, 12 Jul 2020 02:43:16 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id a8sm7283718ejp.51.2020.07.12.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 02:43:15 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 6/9] io_uring: remove init for unused list
Date:   Sun, 12 Jul 2020 12:41:12 +0300
Message-Id: <f409d6120a9099792a2d1b634c08649bfea6b76b.1594546078.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594546078.git.asml.silence@gmail.com>
References: <cover.1594546078.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

poll*() doesn't use req->list, don't init it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 81e7bb226dbd..38ffcfca9b34 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4973,7 +4973,6 @@ static int io_poll_add(struct io_kiocb *req)
 	__poll_t mask;
 
 	INIT_HLIST_NODE(&req->hash_node);
-	INIT_LIST_HEAD(&req->list);
 	ipt.pt._qproc = io_poll_queue_proc;
 
 	mask = __io_arm_poll_handler(req, &req->poll, &ipt, poll->events,
-- 
2.24.0

