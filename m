Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83024C43215
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF302240E
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqRzkoZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKSUdT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:33:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45996 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSUdT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:33:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so25482663wrs.12
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YRAvCcz2IE5N/POB/KNzdmSNokt/49QkZvLwYvXaWPE=;
        b=tqRzkoZW7sqRMDLsOtYhQdHCmJRCy4pqOq+7Xud0CWot8jDN+r8MUiE93M3CtDsEF8
         eFA3AgOs9OhVOOB8nI9RAdqtbYfpPUxbpAsT298vMy5LmGx3vpopo1ptLSz3jfXZ0HE3
         BlrQ1uKA2arE3myoEvhKSj/SmRanP8gumTh0S1rXx9T3rkdLR9VbIBzPyWEYpWqpPNzt
         3NOvppFgpogtXrTV5qwWyKORpB8V4fOPQh5x/L05L7HQ9O/y6HSseQqVm4beN1qFMw1w
         M7ScwO27f+EBn/ka6anjNDlaWVowHCUf0QQHGHC/CSdr6kr4igUZoq7VkorKGQzmsut1
         lV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRAvCcz2IE5N/POB/KNzdmSNokt/49QkZvLwYvXaWPE=;
        b=JtTrQ+OHlpAHTr0xKMuHRernhN9hH9tGPl/jUJwCalSJQ+RFZNxCLcQLuI7COsYV4G
         m2e7twbXl4aQHYArssEY9/antRTZeiQH+P1xFXg+cocurAvkXiKoWhfWADJhzxf2xsj4
         W7wpemm6w72v/GIFN///LK5fl2c5zvdigVpFaUTCb6PzhZRDiXypN2Dipt2IX6YAd75E
         U/q56kO9HQ0N3c0plkz8a3eocHYb87ULgmxaDuJCLcC8Bt7AdpnWwMxsC96qQjMqW528
         69fhXI/ghNb7C3EZFPaPqqpbry4B8rwSZ4PRLe7ZdF76/f2l3T8e7TB75tiPLwZPW7gF
         p/Bg==
X-Gm-Message-State: APjAAAXDXnqDCURSAA1joTItDTdUS4VOMng/TxvsTSh6ElWHKrPyRBpF
        z7r6gSvPRzZ9Y9O+jyKiucDlFF2I
X-Google-Smtp-Source: APXvYqw9MP1aQNJPs1TZRlQhRKrUHNQe9uiRy1YYhjdj7melhDPi9bfbVXSVLUnMysk5Wa9RW7pV/g==
X-Received: by 2002:adf:e987:: with SMTP id h7mr38374443wrm.373.1574195596979;
        Tue, 19 Nov 2019 12:33:16 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id g184sm4605981wma.8.2019.11.19.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:33:16 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 2/4] io_uring: break links for failed defer
Date:   Tue, 19 Nov 2019 23:32:48 +0300
Message-Id: <e0129a98dcc7802b40b3d468ef93e378d367c515.1574195129.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574195129.git.asml.silence@gmail.com>
References: <cover.1574195129.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If io_req_defer() failed, it needs to cancel a dependant link.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ca3c5e979918..637818cc3e5b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2938,6 +2938,8 @@ static void io_queue_sqe(struct io_kiocb *req)
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(req, ret);
+			if (req->flags & REQ_F_LINK)
+				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
 		}
 	} else
@@ -2970,6 +2972,8 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 		if (ret != -EIOCBQUEUED) {
 err:
 			io_cqring_add_event(req, ret);
+			if (req->flags & REQ_F_LINK)
+				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
 			if (shadow)
 				__io_free_req(shadow);
-- 
2.24.0

