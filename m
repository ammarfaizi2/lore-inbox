Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF079C432C3
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C7420643
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV9gs12Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKUUVl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:21:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39239 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUUVl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:21:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so5194717wmi.4
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bAJO4sXbhbiq7GTSBqzOEj80GR+hG0Aej7a+YeCOukQ=;
        b=VV9gs12QKlJ94fblw1xW+mHyHKUpwiWxk3v3ggzZ6GpHcpcUJoQMuMBI1dmlmQTNK9
         8rQCkZMigVAiSjqdy1qS2Z+NDFZFVCv9LTsi36qpGyqladJmAQmMgFcG7QWLlv1V/Ho1
         +CQs2JL0h2Pw4N+v4esdXHwt5kdple7/1MS73u6lhL6a35NF7V3Ihx4oxZ/8fG2rgNPj
         fOgchBw0J+bmmMDALOYux1fs5yKykr0cEhbImL1mhVo7+VyXFIqNfbv2EwT2jqc0DFkL
         GMYlGHH/q7UubtscVpg7hJf7Xkl70qOuEemF4xUFRAYMkXA3MVtNEmASAJPI1ZbWpeGn
         +UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAJO4sXbhbiq7GTSBqzOEj80GR+hG0Aej7a+YeCOukQ=;
        b=GkQZ1ATQMareAKgihLS5bSDV4Hks0NjOXobKTXDLBKG9Kopch43GuPCPjPcL21R9+c
         kT14dlIjBZWY8fip2UcrGbE/D2WFcY7DLfz7s1lPxYujoGNRUL/+f0sJOXNWoKTDul+0
         v9UiwNLz2LmAZt2WZHyyyesz4ckKnSGWaekU7ri9OakWzQr9AhAnhMYh0WRq/Bpg2TCD
         VX80TX8OvLNtrQUoO+fbDThPs5XGWJ8lNycPZG9hW8F2r+kHj7nstE5jXHvDE/k16JVE
         6C1JpBUmD1Kdbt3nnC6KTJ0N97Su47YIQ1TAUT1amxSCxh2FW95Uvbmcnabhf+V6KtWg
         1rLQ==
X-Gm-Message-State: APjAAAWcldU510lxc3Co3hM2fNtsySpIdKf02Yf1EOttozWoFlNqqscQ
        3YTjUenih6LJjnsrEPfPRY0=
X-Google-Smtp-Source: APXvYqx/y2mpQmKmcreq+5Y6V20epSmdTjp1UdGlbEkQ5+In57nkgonOqjk2w1CVqXBzHko8bFw6+g==
X-Received: by 2002:a1c:2186:: with SMTP id h128mr1128305wmh.14.1574367699262;
        Thu, 21 Nov 2019 12:21:39 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id w4sm4646112wrs.1.2019.11.21.12.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:21:38 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 3/4] io_uring: simplify io_req_link_next()
Date:   Thu, 21 Nov 2019 23:21:02 +0300
Message-Id: <03812c2171ebbbe58bf32d96cabe58763e82e605.1574366549.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574366549.git.asml.silence@gmail.com>
References: <cover.1574366549.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

"if (nxt)" is always true, as it was checked in the while's condition.
io_wq_current_is_worker() is unnecessary, as non-async callers don't
pass nxt, so io_queue_async_work() will be called for them anyway.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 63ef603d5fa0..1ab045e5d663 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -898,16 +898,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 			nxt->flags |= REQ_F_LINK;
 		}
 
-		/*
-		 * If we're in async work, we can continue processing the chain
-		 * in this context instead of having to queue up new async work.
-		 */
-		if (nxt) {
-			if (io_wq_current_is_worker())
-				*nxtptr = nxt;
-			else
-				io_queue_async_work(nxt);
-		}
+		*nxtptr = nxt;
 		break;
 	}
 
-- 
2.24.0

