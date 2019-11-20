Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5519FC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189282075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a9EA3xTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKTUJz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:55 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35394 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTUJy (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:54 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so883843ilp.2
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9QuBzMb9jMf97vC76NVXe78Wgt8Q5xENKCgDNdvVnw=;
        b=a9EA3xTLBpBgzcVX9mYrgTQSrk5G6NVcmL4EH7IihH5WYjMF7qIJzZ/yxCzOWs7z7s
         2KlTEVeaO3ey9kfR3Ke/syRpoTG5hMT3TlBYcvS87X4awhLC3XFHtpNc4PfwDNjBWphN
         ewPgzih2Uo2F8sBSXJg4iZQ633nP0ddXsscBW0h/qHgvVBZEjZYXrpY6+qjJofqDPVAk
         CR/xcfLgiloWotAc8yP5xE2EOktIENU8ccc7heTApUe7PPHPZ+wmSjVkNUoKuQg8DaJt
         rOq/cjEjf0uStEjmHkXjGPYz2cvh7bnFxgYPlyC+F1eQAywPZvO6JPOEDX/Tu5lwkQdw
         LCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9QuBzMb9jMf97vC76NVXe78Wgt8Q5xENKCgDNdvVnw=;
        b=VySnhMB3j0uBaHNg//tq76wRPawO050VD2bSpvPY9I6jmguIXME5uEMxJCgBF4hTxf
         kJYZTgOdqLfoxStzWbTrkDKjX3MvHMdTLVAlybMwSmcTUj0R0nzAVX8qhNABsabn6s8d
         IfkkmR1PHYBKjzkVUAnC1U62QKrGljvq2Ucm8CbJNyjHI8+/YLyW79yHfU6Ikbonn4YP
         Fr3L+5Xso5gMxa+p4VvHQr9+qlDxkirhsDYSE4RGoR6dfPSnLOiHyvT8eRvXooe51K4D
         YzjMvsU8Jl7WDFlL1dXxd+OLAWICnIfmCOlDwrtVAEGJ8yi6qliu+UWGVsWBe4lz98Ya
         sWKw==
X-Gm-Message-State: APjAAAXYDxzY1MkYoYekjz09wYUPgh5N3ZP/q5H4kDEY3X3B9gnUa8eg
        V1A+iJqwSRc49zkoOeokTSIppIRf2OhYXw==
X-Google-Smtp-Source: APXvYqzesRV3H7KWhkfQTUnDmmPz2IHoAUyw9b/dLEfKpZhgS4NV+jx73LJSJu/GN5ol7zU+fvwM6g==
X-Received: by 2002:a92:d484:: with SMTP id p4mr5719242ilg.52.1574280593548;
        Wed, 20 Nov 2019 12:09:53 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] io-wq: remove extra space characters
Date:   Wed, 20 Nov 2019 13:09:31 -0700
Message-Id: <20191120200936.22588-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

These lines are indented an extra space character.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 1f640c489f7c..81b2a456d1ce 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -328,9 +328,9 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 	 * If worker is moving from bound to unbound (or vice versa), then
 	 * ensure we update the running accounting.
 	 */
-	 worker_bound = (worker->flags & IO_WORKER_F_BOUND) != 0;
-	 work_bound = (work->flags & IO_WQ_WORK_UNBOUND) == 0;
-	 if (worker_bound != work_bound) {
+	worker_bound = (worker->flags & IO_WORKER_F_BOUND) != 0;
+	work_bound = (work->flags & IO_WQ_WORK_UNBOUND) == 0;
+	if (worker_bound != work_bound) {
 		io_wqe_dec_running(wqe, worker);
 		if (work_bound) {
 			worker->flags |= IO_WORKER_F_BOUND;
-- 
2.24.0

