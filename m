Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93024C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 04:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA2B2072A
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 04:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Hw4ZgiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKOE4N (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:56:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKOE4N (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 23:56:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so5817782pfp.5
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 20:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhOke5wvRP/7DgON51HkDIu73DknFItjSDhvQUCh3Yc=;
        b=1Hw4ZgiLokq/qCUm4Rmgu75G2IB3EPmDcSlpHwBz19ZRa3FI4DgSja9Ah+Dt9up4ea
         zAZI3XubAYcCy6Fyo8A7LXC07qG/46RNdzx6va3oOVGGa/TeBkBLBiynFemQBHMG+psY
         6nBFApZLAyWbBHWmszWpJMAoIky57AN9BRc1JHMuD1EqVjqdhihuqCtBb0lat83pIPsq
         HgsEUsbiK2/+wKuzyi1YiYYXbIqP9oszo2kX9Ae1BF7IJBxkd+6qP8sILctuWi1/m6oX
         RYBlge6eplbNJ8/ncI29U3cQId26qM//6g2+NP9FNxRaWYkahGmxm/YC/IBvQT2lcGDT
         HhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhOke5wvRP/7DgON51HkDIu73DknFItjSDhvQUCh3Yc=;
        b=O+giUcwgBdHhoEJ+cJAkZ9JldyhV/BFGee4eMyKzJkmcXM0XwmEzKaVMV8rJ61S9ea
         YjtIraTHFHeHzAXLfThXbYpQkEFBX7jC/X74YIfYoL++aZGkNxiJET47I0O9fRxDF0BO
         JOEyIoOsR9QK2jJOZVV8YiiHu9IlVSToyE3peLswZIaEXJ11k6imkXD8qKDQAcyv/HTQ
         eF8x/xPuT9/3TEm8Vd4jIhz6F9UBCccUp9ka3/l3cBvLXUdMICfKdPp/yFjIiw0/Qqia
         6pLQR4zN2INGfxeZaWQY+DWobqSLS2MS8hNZNf6fjKMvt8X17A4Tfx2j6GuC8SMnb3qU
         7jyg==
X-Gm-Message-State: APjAAAWfTe8KPVpX2ZDVQv2UODBFoNo+/HZmeNDktrzXL4DIw5ZKQtEf
        3Hl2Kki/+jH0ERmQK61lslpujhyLoiQ=
X-Google-Smtp-Source: APXvYqw+YEo77SKrw7n09WjPtweaxxyMY4aPi2yZ780cb4ekNMB2wgFQaSu9U+Qdgl5lZNYqvMWRDg==
X-Received: by 2002:a63:134f:: with SMTP id 15mr6591726pgt.141.1573793770265;
        Thu, 14 Nov 2019 20:56:10 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id w7sm9192366pfb.101.2019.11.14.20.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 20:56:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: cleanup return values from the queueing functions
Date:   Thu, 14 Nov 2019 21:56:02 -0700
Message-Id: <20191115045603.15158-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115045603.15158-1-axboe@kernel.dk>
References: <20191115045603.15158-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

__io_queue_sqe(), io_queue_sqe(), io_queue_link_head() all return 0/err,
but the caller doesn't care since the errors are handled inline. Clean
these up and just make them void.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5ad652fa24b8..b9965f2f69ca 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2825,7 +2825,7 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req,
 	return nxt;
 }
 
-static int __io_queue_sqe(struct io_kiocb *req)
+static void __io_queue_sqe(struct io_kiocb *req)
 {
 	enum hrtimer_mode mode;
 	struct io_kiocb *nxt;
@@ -2870,7 +2870,7 @@ static int __io_queue_sqe(struct io_kiocb *req)
 			if (nxt)
 				io_queue_linked_timeout(nxt, &ts, &mode);
 
-			return 0;
+			return;
 		}
 	}
 
@@ -2892,11 +2892,9 @@ static int __io_queue_sqe(struct io_kiocb *req)
 			req->flags |= REQ_F_FAIL_LINK;
 		io_put_req(req);
 	}
-
-	return ret;
 }
 
-static int io_queue_sqe(struct io_kiocb *req)
+static void io_queue_sqe(struct io_kiocb *req)
 {
 	int ret;
 
@@ -2906,20 +2904,20 @@ static int io_queue_sqe(struct io_kiocb *req)
 			io_cqring_add_event(req, ret);
 			io_double_put_req(req);
 		}
-		return 0;
-	}
-
-	return __io_queue_sqe(req);
+	} else
+		__io_queue_sqe(req);
 }
 
-static int io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
+static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 {
 	int ret;
 	int need_submit = false;
 	struct io_ring_ctx *ctx = req->ctx;
 
-	if (!shadow)
-		return io_queue_sqe(req);
+	if (!shadow) {
+		io_queue_sqe(req);
+		return;
+	}
 
 	/*
 	 * Mark the first IO in link list as DRAIN, let all the following
@@ -2933,7 +2931,7 @@ static int io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 			io_cqring_add_event(req, ret);
 			io_double_put_req(req);
 			__io_free_req(shadow);
-			return 0;
+			return;
 		}
 	} else {
 		/*
@@ -2950,9 +2948,7 @@ static int io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	if (need_submit)
-		return __io_queue_sqe(req);
-
-	return 0;
+		__io_queue_sqe(req);
 }
 
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
-- 
2.24.0

