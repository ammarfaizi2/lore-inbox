Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4200C432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6852073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qug82hlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKPBxc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40593 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfKPBxc (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so5891192plt.7
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3ZUk7gdiO/yTY9SRzDZZum120//mvzLEhCS3IjMpfs=;
        b=qug82hlPAgx01D3aYCmrPWC7xPeD84JXb/m7Zu+puKRPysB1v8DMncoBZpy09CDAWS
         XpcB1oaNAd2W3j+99kUG+k6TpkKs1kUnR7kgC1VFaqYgNp3AZZfDYxqp414UaTHT/vaW
         EVqAfMUs5lMOOr3KN9pD29rAA7lllPlP/3UcA9lbKCtWRePY26jEM16nMJMVDoh3tApv
         iQIcgA4AZOP+vuHed3Ni/2yW2JfNGFRJIdEKE6V6E8MOxTIxuPM266D9eoj+pgdHL1ud
         EUMRU94iA1tRiIxGsdF3UJpcMr684tnubBnj+F+HLNK6dTxo4tKBIoQySz5qTv52CI7L
         yL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3ZUk7gdiO/yTY9SRzDZZum120//mvzLEhCS3IjMpfs=;
        b=GqxfYkALFWbHzSPzvUI4cQ34rFNK2td30vDQFqPv/d1khgAabzTojsj0hXd59OK1GO
         cEU4IwMn770MWi1haXTM0FLYweSHXfYtpm6e8UgTM5knIDsKoRveRyyC49PJBGJUwdzD
         MmcB2g/JYdmguzJV/6X/GIyxf7K7nt8Z2gdOW/NpYpiTHXAMFoU0kwvUOIGScW/wnW4P
         VZCH38gl5TgsC2FLUXrcoHEzt49nv92A3rrsL/vdTJvmPaB9b33QtFivi5/4d1791Q0E
         tRX5Ap2/POZGpL6ACgaKdzNI+Q4zgzqBh1B4lCyBmo/+yGqhJT2B+soSBoX4rzpJF0a8
         WXyQ==
X-Gm-Message-State: APjAAAVRDED9zmHjboSn/MGBSkI4OqBKUCGba8gqT7ieC3fyNQorqfyg
        sHNjT6Ymqk81czS8Whm5cIpCicN7tdc=
X-Google-Smtp-Source: APXvYqy+n65a76o7YFgn+clKBySvArC1NkHSyXVePnazh/HJmu0H8odIjPiZp1Xr6ntcTajaFntcOg==
X-Received: by 2002:a17:902:8ec4:: with SMTP id x4mr17520274plo.114.1573869210979;
        Fri, 15 Nov 2019 17:53:30 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] io_uring: make io_double_put_req() use normal completion path
Date:   Fri, 15 Nov 2019 18:53:11 -0700
Message-Id: <20191116015314.24276-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If we don't use the normal completion path, we may skip killing links
that should be errored and freed. Add __io_double_put_req() for use
within the completion path itself, other calls should just use
io_double_put_req().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 56a9321a4232..3f4d6641bea2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -382,6 +382,7 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res);
 static void __io_free_req(struct io_kiocb *req);
 static void io_put_req(struct io_kiocb *req);
 static void io_double_put_req(struct io_kiocb *req);
+static void __io_double_put_req(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
 
@@ -911,7 +912,7 @@ static void io_fail_links(struct io_kiocb *req)
 			io_link_cancel_timeout(link);
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
-			io_double_put_req(link);
+			__io_double_put_req(link);
 		}
 	}
 
@@ -985,13 +986,24 @@ static void io_put_req(struct io_kiocb *req)
 		io_free_req(req);
 }
 
-static void io_double_put_req(struct io_kiocb *req)
+/*
+ * Must only be used if we don't need to care about links, usually from
+ * within the completion handling itself.
+ */
+static void __io_double_put_req(struct io_kiocb *req)
 {
 	/* drop both submit and complete references */
 	if (refcount_sub_and_test(2, &req->refs))
 		__io_free_req(req);
 }
 
+static void io_double_put_req(struct io_kiocb *req)
+{
+	/* drop both submit and complete references */
+	if (refcount_sub_and_test(2, &req->refs))
+		io_free_req(req);
+}
+
 static unsigned io_cqring_events(struct io_ring_ctx *ctx, bool noflush)
 {
 	struct io_rings *rings = ctx->rings;
-- 
2.24.0

