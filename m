Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E2C00454
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84502053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XYLgY2D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLJP57 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45299 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP57 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:59 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so19265866ioi.12
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhSL4npVc/kqo0YUgB2s1ND720X0uX5WcvuWbDF60s8=;
        b=XYLgY2D8zAjlfdQ9qE/B2mE/6zaxYM1Fxxmbx4VEYmYPj6BD5jejahfFwjO8338Ue1
         a8guKWqgvR8r+GtJVhHryppMB76kAlYsE5HuEx8CNnugWiJT19lfr8nnIp2kuaRUbfFH
         oGoFO/2HcozqtMP1NW4DCgJv3QcLPS0gRjpB+gzxMhkP6hka5WPEdhP/MEHu67dTYGqV
         kKz6uDILEh2GypD1rqsmTg64E1n/1FOsd+TLaxH7uHpttKFSOeJXZlc4CjXx6e5GsiFK
         Z9QChrrvD0aatqZA8jt7WlUxM2WO2ajqhXODgjTYbpCHl3RrOJxTJOGU/JGy7DmuODJu
         nB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhSL4npVc/kqo0YUgB2s1ND720X0uX5WcvuWbDF60s8=;
        b=TUpdUZeauh4cVjPCfGdNHw/PfI0DLFBdi2KRHZ/Vb4qsi8mQGULnFSbFXwai8j8y9v
         +PIWYEAFzktOf9hmwpqQ9ObPNcUv0r15MUFi4BXs8OnmSCTFgTqnHCY77hVtTcXBWS35
         43PbW+vCbJQNjJMHQV2IqmNXRrReJtiyAqK7WUFajW6/QHquSiIwDc5+MZsaz4MLZde3
         8hsOlALS072Ub9ja/ynPtaSKzH2soMeoTKTYMZB/Easpk3RETlDmDIGQ599FOqQ55Au7
         iKlJMXoL+0TJFc0sj3QBdAbG7ERO66ldqbbJEJ+AlpczZQk5QSL796NMgLb9/0OnXjN6
         K66w==
X-Gm-Message-State: APjAAAUVWY5APFf7ml3M2oD1ULPaLfxeElSXn7/wIip62gosc5OnqBo8
        isjeBedsEG5kghr7FefvtHujJBK/mAp8pA==
X-Google-Smtp-Source: APXvYqzhlx1BBbHLpi/bO6Z5kQuqbMNIPLq1zIm/pVUROGkaG9y4uJnGrqPun2rIGmCRv8AP20EA5Q==
X-Received: by 2002:a6b:6a0a:: with SMTP id x10mr26568306iog.48.1575993478505;
        Tue, 10 Dec 2019 07:57:58 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] io_uring: only hash regular files for async work execution
Date:   Tue, 10 Dec 2019 08:57:40 -0700
Message-Id: <20191210155742.5844-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We hash regular files to avoid having multiple threads hammer on the
inode mutex, but it should not be needed on other types of files
(like sockets).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4fd65ff230eb..8258a2f299e3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -581,7 +581,9 @@ static inline bool io_prep_async_work(struct io_kiocb *req,
 		switch (req->sqe->opcode) {
 		case IORING_OP_WRITEV:
 		case IORING_OP_WRITE_FIXED:
-			do_hashed = true;
+			/* only regular files should be hashed for writes */
+			if (req->flags & REQ_F_ISREG)
+				do_hashed = true;
 			/* fall-through */
 		case IORING_OP_READV:
 		case IORING_OP_READ_FIXED:
-- 
2.24.0

