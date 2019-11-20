Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDA7C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC92080F
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BRCD0G7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKTUKC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:10:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35847 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfKTUKC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:10:02 -0500
Received: by mail-io1-f65.google.com with SMTP id s3so655537ioe.3
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9csXmnuN0agQyn7UbYX2G674BKM6++VB6d08EsDK2As=;
        b=BRCD0G7NBUjaEPUpMqLG9zttgFwd7vRfJVjxGQqzvI/7N9E7JGBrxyvyiVn6lfxqLp
         XBkjeC6E7E0qZjouFJhPZq3Cyn/Etopf0rwZ7zn/bdTp4xC9zncffyWS+5CzC3jD5o61
         5l9zRQE1bakIIQgn3dWSTxC6U93oo/gfA5F5EdWuwhbXKoqepbZEQeUD3LYblwJAYleV
         FH4e6935BIYE+PCs38cB4VxDAcKg8RSOkGahj88NuyIigic+fTBzWi/23Ik4YAUzola4
         kX7Z2xPfPvusFmBLuXXoTuSefpBWLx4co/5WfigktWCv/4gFWUd9HyL9sOyNTQEB37Uf
         d/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9csXmnuN0agQyn7UbYX2G674BKM6++VB6d08EsDK2As=;
        b=q+RuUKqvBSoq+XoolB6Pt36OYxP2d4MPBBs9jt0tVF5CEfgrsnq/O5rcrAGxkVvugJ
         4n6X1Ag+rQvKEXBWJQ+CZSHS+LKErKiheAfd/JQSriJYSpddba2SFqc185HNEMQj1B6g
         0NhqjpQ33asGjR/XHw8wV0V/jKISh/QPmnZHa/gCQA5zYkff8V+Z205XZgbdmZzoHbay
         zYktIwAgQDrkxGRuXFoUqEtYvVF8mm2TUXcwjSWiS4ouKnBJmptG3XtesyavebIjnYsA
         mufEVun5AKrThezRdOkZdhg+PA7ydTE68LmWIQhUtZTz7fwcs3jqr/YE3QmKzPrDihIC
         OqoQ==
X-Gm-Message-State: APjAAAVRtsFpeBYqnAiIGyXBKuCi0fExMdWV/eD633c7VoAi0a7XnRjn
        9a5v3yW4zk3W8PbXfngzGd7HbnvhnNrziw==
X-Google-Smtp-Source: APXvYqzmCG0wKTiNVFG+VBxQ1jxR2ONpOWhzWRT6fcujH/T897dhXuGZ7qby5SVvYKb6lUCMl8CQ3Q==
X-Received: by 2002:a05:6602:2289:: with SMTP id d9mr3935862iod.136.1574280599226;
        Wed, 20 Nov 2019 12:09:59 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] io_uring: Fix leaking linked timeouts
Date:   Wed, 20 Nov 2019 13:09:35 -0700
Message-Id: <20191120200936.22588-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

let have a dependant link: REQ -> LINK_TIMEOUT -> LINK_TIMEOUT

1. submission stage: submission references for REQ and LINK_TIMEOUT
are dropped. So, references respectively (1,1,2)

2. io_put(REQ) + FAIL_LINKS stage: calls io_fail_links(), which for all
linked timeouts will call cancel_timeout() and drop 1 reference.
So, references after: (0,0,1). That's a leak.

Make it treat only the first linked timeout as such, and pass others
through __io_double_put_req().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8d25e157b4d8..a79ef43367b1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -937,6 +937,7 @@ static void io_fail_links(struct io_kiocb *req)
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
+			req->flags &= ~REQ_F_LINK_TIMEOUT;
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
 			__io_double_put_req(link);
-- 
2.24.0

