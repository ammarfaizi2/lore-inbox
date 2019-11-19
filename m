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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C4EC432C3
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA232240E
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP05K560"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfKSUdV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:33:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33180 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSUdV (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:33:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so25520874wrr.0
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TZl2fuArokIzW+crfZTlw68YG51jjGwo8sLrYYb6jPM=;
        b=FP05K5601rWLEcF/O59h9MIt83JYlkEjyc+t9XAS6kTo7TNm2gayX12N/NOhW2Vo2J
         ChkP5YuK5xDIGxaFOgm0wrP0Df+zqoAs84rdnqzysqVVEpj2pgnE9vnrn+cfhzqT8qmU
         ynGM07DeqaSo8QZ3NBvv5oGy0P+ZjFeTSItbuP2ro7FQ7keysTl1H4nC2g7C7M+KiXYv
         6d8ZIram+tREOCv9VlBV5OEAV9LthZbK3x6hKI5B5DlAqQ1iS/5+HSUtAUbQGRGuNe+O
         Xb6023B/awsTpVMpe1MWPbyCffZVl1IffZjAK935Fwez0nAIQIqrRW1YyvAvVJXjGw6Q
         zYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZl2fuArokIzW+crfZTlw68YG51jjGwo8sLrYYb6jPM=;
        b=tV//5VTQGV37SObTdCE93aNCBBTpkOnr3EjRO8lxxwy1UmJUemsF6hq+2Iy/+D7wou
         YBPI6j+Itt73YxisgmYn7QTGHFJ+WWnvIhO21Mw+v97y/YBkA1I5/OY+4d3v9EcooiGL
         BqbWpcSRPZS2Eq7iLbv/fKwvekngNwn3/c+Y7jxLmalv/3JhDUvfD9MW6qovuRmESf8T
         mCV24h5sC3zDSXmWe1sMs8r9vVN7iqlMNTvUTEhGGMWGh7i4kHrwIco4hfHSoh6+fXdE
         e1/vevLi4X4h0KuXiZhYWNe3BbG56aBPuhW5ydhJn+rtyChjVEg72Jq27jeB7pxxvUiJ
         /7fg==
X-Gm-Message-State: APjAAAWbri15d9Z/zJI03S4zqten/4f918J7XmIquijRUO6bEF6zP/jP
        9JCwLjxGX8EhFljPa/0De/XGzOCa
X-Google-Smtp-Source: APXvYqwMcL8WTmWO3/SCEsgxWqItStUF4b+6X754txTwZ1S0n4kGuLBr1BFFTbC6N0l+eQDtlBnSqw==
X-Received: by 2002:adf:d844:: with SMTP id k4mr38248687wrl.333.1574195599569;
        Tue, 19 Nov 2019 12:33:19 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id g184sm4605981wma.8.2019.11.19.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:33:19 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 4/4] io_uring: Fix leaking linked timeouts
Date:   Tue, 19 Nov 2019 23:32:50 +0300
Message-Id: <ad5bf929b713b8cc17813c6fdcf59c55cc2a589f.1574195129.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574195129.git.asml.silence@gmail.com>
References: <cover.1574195129.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

let have a dependant link: REQ -> LINK_TIMEOUT -> LINK_TIMEOUT

1. submission stage: submission references for REQ and LINK_TIMEOUT
are dropped. So, references respectively (1,1,2)

2. io_put(REQ) + FAIL_LINKS stage: calls io_fail_links(), which for all
linked timeouts will call cancel_timeout() and drop 1 reference.
So, references after: (0,0,1). That's a leak.

Make it treat only the first linked timeout as such, and pass others
through __io_double_put_req().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index aa6c9fb8f640..4de7d0192666 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -934,6 +934,7 @@ static void io_fail_links(struct io_kiocb *req)
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
+			req->flags &= ~REQ_F_LINK_TIMEOUT;
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
 			__io_double_put_req(link);
-- 
2.24.0

