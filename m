Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FFCC43603
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1482053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tTIGMbDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLJP56 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43022 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP56 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:58 -0500
Received: by mail-io1-f68.google.com with SMTP id s2so19297723iog.10
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wi62UlHOCyKbyZ0f7CVBWeUQsWhaFtlspMBp3QzcR+E=;
        b=tTIGMbDcicopL2bvqEIkroIMFYzt6BVZCbd70yQpFhzRUTF6phZoH54b1ueZUiJg6q
         K9+xi83dg2kxZv78PnS7ZvAZOG4RgEguKrgx1dYayVndPajR7vcbWt6llVOk/CvDHW/O
         VzMu3me+b9lGs37SBjGy/RHHnBjEGQEpwDVzd6NHPgFs7NgS059CMO9Q5siYTi8Lz1Ev
         r+pxM4zL3On6CDyTTlAGOz3lbHiSjaw6DWWbv75zgQyLajLLqhsAC8L4iOUIv1VeKg6i
         +R2OHgDein9noLoWLIF5xA/1dxOSrCftedh0w549A+00kFK24xUQi0LA8FhUTMIjmpSg
         O4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wi62UlHOCyKbyZ0f7CVBWeUQsWhaFtlspMBp3QzcR+E=;
        b=lEwLg70wHUn929IqMgAcs23yOAOw+pPz8EqgyWPRB6xEd9ZttjI21HgO1HnqAJalr1
         EkgSn/6f9Nk1yjiE97ii+snJDYRg/XvTyc/GpHMp8SCiBrN8UU2PJq0eSBEMyE3MIIlK
         h+KBaRyO5d/U2mlChGSPKe3Aly+S20x7rcu3L3nalXWDyFqQ6E7eEr1j8lcqoAFKl2Xn
         K6k1bZEPF5NRKf9mZI4Iv7CCwgejNWoNouWbLeC5Zac8DQIca8fMs9NTv0LiGbIg6C1n
         wMTUS1D8yqVX/DTyD6bBZQZGJo5svipJ/KcfS2LD2V1nxKyHGP0I3yRM7Hr84yupfMvK
         1fGg==
X-Gm-Message-State: APjAAAUTDo9mSdgKDcJAIf1aBGkZxU7pQPBLN9J5lgLV/kyoLyiKJ/D0
        t8GCDhHQvOLml/0BndcOtFpMB5KqqlElPA==
X-Google-Smtp-Source: APXvYqwte0eQBXYoGlHFeDK8G02NhqwMBUX31oqPBk8d1LoH0qntyF9iRaKUvsNL+T/6YSY/nJt4yg==
X-Received: by 2002:a02:9f06:: with SMTP id z6mr31682223jal.2.1575993477217;
        Tue, 10 Dec 2019 07:57:57 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] io_uring: run next sqe inline if possible
Date:   Tue, 10 Dec 2019 08:57:39 -0700
Message-Id: <20191210155742.5844-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

One major use case of linked commands is the ability to run the next
link inline, if at all possible. This is done correctly for async
offload, but somewhere along the line we lost the ability to do so when
we were able to complete a request without having to punt it. Ensure
that we do so correctly.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 05419a152b32..4fd65ff230eb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3230,13 +3230,14 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 
 static void __io_queue_sqe(struct io_kiocb *req)
 {
-	struct io_kiocb *linked_timeout = io_prep_linked_timeout(req);
+	struct io_kiocb *linked_timeout;
 	struct io_kiocb *nxt = NULL;
 	int ret;
 
+again:
+	linked_timeout = io_prep_linked_timeout(req);
+
 	ret = io_issue_sqe(req, &nxt, true);
-	if (nxt)
-		io_queue_async_work(nxt);
 
 	/*
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
@@ -3255,7 +3256,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
 		 * submit reference when the iocb is actually submitted.
 		 */
 		io_queue_async_work(req);
-		return;
+		goto done_req;
 	}
 
 err:
@@ -3275,6 +3276,12 @@ static void __io_queue_sqe(struct io_kiocb *req)
 		req_set_fail_links(req);
 		io_put_req(req);
 	}
+done_req:
+	if (nxt) {
+		req = nxt;
+		nxt = NULL;
+		goto again;
+	}
 }
 
 static void io_queue_sqe(struct io_kiocb *req)
-- 
2.24.0

