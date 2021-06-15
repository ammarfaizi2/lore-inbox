Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52FC48BDF
	for <io-uring@archiver.kernel.org>; Tue, 15 Jun 2021 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D901C61490
	for <io-uring@archiver.kernel.org>; Tue, 15 Jun 2021 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFOOgb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:36:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFOOga (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 15 Jun 2021 10:36:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltA92-0004Xn-N6; Tue, 15 Jun 2021 14:34:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] io-wq: remove redundant initialization of variable ret
Date:   Tue, 15 Jun 2021 15:34:24 +0100
Message-Id: <20210615143424.60449-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read, the
assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/io-wq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 2c37776c0280..e221aaab585c 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -896,7 +896,7 @@ static int io_wqe_hash_wake(struct wait_queue_entry *wait, unsigned mode,
 
 struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 {
-	int ret = -ENOMEM, node;
+	int ret, node;
 	struct io_wq *wq;
 
 	if (WARN_ON_ONCE(!data->free_work || !data->do_work))
-- 
2.31.1

