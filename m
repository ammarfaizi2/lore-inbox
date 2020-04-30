Return-Path: <SRS0=Pkpm=6O=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18EC47253
	for <io-uring@archiver.kernel.org>; Thu, 30 Apr 2020 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E8220870
	for <io-uring@archiver.kernel.org>; Thu, 30 Apr 2020 19:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMWPuwWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD3Tc1 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3Tc0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 30 Apr 2020 15:32:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54AC035494;
        Thu, 30 Apr 2020 12:32:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x17so8556949wrt.5;
        Thu, 30 Apr 2020 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xkkHwFQ19iN2paG5II0H4LFKpXCVVtIZHKxGDe/DGdE=;
        b=QMWPuwWHwyGhM+Z8OztMwkro7HkzwZQrHpHTEsv1d+HNgO0sKT90VzakZvHsu1CQKe
         R/mc5c6LK5CGAr08ra5NJEwOrNd5Eo17+hJNiy+A7aZzVUNiTjf2mP8g3xS8QUAymmhZ
         QENxn2od8hpMG/0Z4AWNos/3P6CV61fMYZEUA3ISj5XgpraEPvSkb7sgNeaL6D3lkRAL
         aQBBUVk6eqHz2Oj+alF7jJRwTSypPgXwLk2tOepW248k312SJaTfrhkN523mV+jcpIVW
         JVVllz1pcHcEaW6IsUEqe6XOhWq3jmRAu66wRBNfZlamcJ75tDHTSiDwM44jlTBqsOF6
         hpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkkHwFQ19iN2paG5II0H4LFKpXCVVtIZHKxGDe/DGdE=;
        b=FR8M8nOR3Ysk0Uh+r46GBH+tfYZ+3divlrjSo0sKxf+5E17R5gJR34Xz5HTXPZLI5R
         TzTon0z/JFyjNSsQbLQskp9hskGtzJ8N+Em2h98c6EzjO5lvArgmPefBlkMV06UTRjSa
         AZNMajE9g1nPNUeggek4AedYK7JMJNcxayLxvoLOxzHhnLWcS1AkkoX4vWcobW7nPDcQ
         VrLfNcay606E2FIaDoxZgvB6JYkWiIpm/bvNJXKu2f+LjZwsUijdzPfIr3iWyYcDZ0u/
         kjSgmh21REbepT4CWmzIAnMeElch/Gy4SgF+P/kmbxjPHs5bzW+Ze5DSXEGPuYiTMaQU
         Eicg==
X-Gm-Message-State: AGi0PubBGwPmiQ5LxPlhrzb4OFA5LvfQFuWNa51kLHkcoHNKIEzr23hL
        jk3gh4iz5SmpNTAFgvcvlLgZKAuM
X-Google-Smtp-Source: APiQypKihMyi3EiNjTiOXrPT4OKpYf3U9FKAYiuzDEsVtCF+rhqQ4k1bChEpb8SMKirseab9H03lEA==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr142681wra.196.1588275144553;
        Thu, 30 Apr 2020 12:32:24 -0700 (PDT)
Received: from localhost.localdomain ([109.126.131.64])
        by smtp.gmail.com with ESMTPSA id h188sm917002wme.8.2020.04.30.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:32:23 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] io_uring: pass nxt from sync_file_range()
Date:   Thu, 30 Apr 2020 22:31:07 +0300
Message-Id: <c06c539bcc31437299b9dc25423d282c5ec3d699.1588253029.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1588253029.git.asml.silence@gmail.com>
References: <cover.1588253029.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Make io_sync_file_range_finish() use io_steal_work()
to pass its nxt work.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6b4d3d8a6941..8fff427345d5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3502,7 +3502,7 @@ static void io_sync_file_range_finish(struct io_wq_work **workptr)
 	if (io_req_cancelled(req))
 		return;
 	__io_sync_file_range(req);
-	io_put_req(req); /* put submission ref */
+	io_steal_work(req, workptr);
 }
 
 static int io_sync_file_range(struct io_kiocb *req, bool force_nonblock)
-- 
2.24.0

