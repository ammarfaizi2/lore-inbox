Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B0C432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C12073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZPbDW2V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfKPBxa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41123 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfKPBxa (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so7494914pfq.8
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJM+2s4yx2e0W8rLb56RFcBD88noi8Pil7m6jkokdyY=;
        b=ZPbDW2V47op9KfXVfImwcoL+n1HJ9tNSTELMg5wCzs2rE0iDd5weEhi7RbmARiJZ5o
         H7oT+fMUP+NIbGaw21vhNUPlIbXdlXHMlt9EanBUg03nVf5ClGkmw7ARfkLW7gF6Mawk
         URQcpF1sTfwxv8V2857QdBDb0a7r70zuZOb8h6szWKuXKYFAyHELbXJHWErBlw1aiV7t
         f5xJxqD6bGs5ciPE7j11jVj18SXoXKOv84VbAAcevMsu6+RybGcga9JPhnOV3zsUJ8B+
         Mqv1vMoheCrey/WJglxH5nCu7wQg3HDa1TwyulCB6WkHXv/oq/4ooknbBV5a8KL8ym2X
         kjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJM+2s4yx2e0W8rLb56RFcBD88noi8Pil7m6jkokdyY=;
        b=h4ihsuf9Jr1t/smq+tzD7woImrZlq7c50OyrIZmlryXWMeY5Hhl0f7OdOGUlkcrJjK
         5oN1/PKOeZIzDLx2Vd0QurPhFFp1M4CX1Q0vkC+xDb/cULip5nzMG4nkhAXt2jh7XgL/
         PVTeuhCP416MVmnML3lTIXhwYLwBIJ/13RHExqh4LRkITDV8IJ98yRjNShj6RfvJzytG
         7BBofGArkRkoApiz+PNFXXzs7XQTnapxdSewTVvsO4Eu00bZmZ59NutMqsg3PFZARFwg
         k2XTsL7hUQN4HWwqAfqR0WIL1bB1/OS2qtEiP+Rsilj3r5WKmzNPi2/gjpqaOOlUInkK
         aAjg==
X-Gm-Message-State: APjAAAU4n9/6mMvs+xD/vvnvYSxOhZ4/onh6eHWe7lSrMq85tf85HxWe
        yyiuuij8hAaiI5gDWS3WjHWxbllLDdY=
X-Google-Smtp-Source: APXvYqwJRXsQE46SwtBAWFA8HDUJXzDyhfOMBbN72y7jHkv2djpkf+XlS3zeS9CIL0szMmuKdCxd7w==
X-Received: by 2002:a63:ed43:: with SMTP id m3mr2089234pgk.261.1573869208824;
        Fri, 15 Nov 2019 17:53:28 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] io_uring: cleanup return values from the queueing functions
Date:   Fri, 15 Nov 2019 18:53:10 -0700
Message-Id: <20191116015314.24276-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
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
index c60e0fa96d9f..56a9321a4232 100644
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

