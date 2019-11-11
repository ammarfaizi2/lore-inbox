Return-Path: <SRS0=oqI+=ZD=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2836DC43331
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 03:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6C7206DF
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 03:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vYPCT5kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKDfu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:35:50 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44089 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfKKDfu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 22:35:50 -0500
Received: by mail-pg1-f172.google.com with SMTP id f19so8517157pgk.11
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 19:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kLUSWsH8QegzP6d+5guBnReR4DGOIVo2UB6Arv9VEeI=;
        b=vYPCT5kIdsdHtVzK7VirPSFYlUKYO2kuTOE7JFiXCmxp06b7f8n8oky6IAm+dWiQgm
         wFzsGybOPKqIzkCrGLOd0n2FbnpqrwJ887OCqKAO3/+ZOMGRAx6Ywa+ZiANT6foNeVq+
         QP5fIPrHjW1u4eIihTBjEElFfTw+XMShmsC/MZifM1tbKkFRNF/0qgOg1zxHK7GXmfmq
         KlmilnWa47p1Si6ZMLw3zvIIQEt0dtyaZRcoO7oVmtPGNdFVJwIrvtBnrkoHet/ltnwP
         bl6veo9S+ZD34r280cq3R6zU1YbAuilCeXpXfCoqf+A6Hud6pQLvH99+rL58hEql9Dv4
         /C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kLUSWsH8QegzP6d+5guBnReR4DGOIVo2UB6Arv9VEeI=;
        b=jm8BGAdTOfhPnjnTcUBNhkg2tB+L5IHghE11KaXMY8p9DJ16J7d55jUU6WB1XkzPSS
         lgR4gLOpdAtYMZMawJ2B9wFeimisYBr56zcqpDrIAxES8jB+eZCKZIjcxAP+o53IMznv
         MAfuNGD3tFw3rbcyP372VL5wrBnHHEj10g9E647NAkYZDsedk17kOYSz2Kp+RtDZUlih
         BgWxGqWkNXszQhnMRBWOP2IzJNzE05OHqKmp7Y0Mb+x527PkVMonvfrxkmCBCy05pC42
         0cowxbrjqUOpQfsdyZ5rtKBLXhdp1Q/ROK8pifvWO/MkaBLjL7nyTOyJnSIgXwOdwqEC
         puUg==
X-Gm-Message-State: APjAAAW/ah9SKTJ0PgYZsmaOVQoDWseKKYgraRS4AyyFb2wARiL19XUG
        u7wtAUDh7xeVyi4IljA+UDryAmDhG5E=
X-Google-Smtp-Source: APXvYqyMFtoylyvvIo9Hlgptc65tfTD9ntiFnYILKCGinRL3VtOgOA78BE30vEGfI4mGkpuN8EqQ1A==
X-Received: by 2002:a63:de08:: with SMTP id f8mr26086438pgg.107.1573443348861;
        Sun, 10 Nov 2019 19:35:48 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id f10sm4335708pfd.28.2019.11.10.19.35.47
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 19:35:47 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: don't do flush cancel under inflight_lock
Message-ID: <308dd126-bcf5-39e2-cd3f-a572683b3c44@kernel.dk>
Date:   Sun, 10 Nov 2019 19:35:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We can't safely cancel under the inflight lock. If the work hasn't been
started yet, then io_wq_cancel_work() simply marks the work as cancelled
and invokes the work handler. But if the work completion needs to grab
the inflight lock because it's grabbing user files, then we'll deadlock
trying to finish the work as we already hold that lock.

Instead grab a reference to the request, if it isn't already zero. If
it's zero, then we know it's going through completion anyway, and we
can safely ignore it. If it's not zero, then we can drop the lock and
attempt to cancel from there.

This also fixes a missing finish_wait() at the end of
io_uring_cancel_files().

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cc38f872dbf0..bb81cc11d287 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4276,38 +4276,39 @@ static int io_uring_release(struct inode *inode, struct file *file)
 static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 				  struct files_struct *files)
 {
-	struct io_kiocb *req;
+	struct io_kiocb *req, *cancel_req;
 	DEFINE_WAIT(wait);
 
 	while (!list_empty_careful(&ctx->inflight_list)) {
 		enum io_wq_cancel ret = IO_WQ_CANCEL_NOTFOUND;
+		struct io_kiocb *cancel_req = NULL;
 
 		spin_lock_irq(&ctx->inflight_lock);
 		list_for_each_entry(req, &ctx->inflight_list, inflight_entry) {
-			if (req->work.files == files) {
-				ret = io_wq_cancel_work(ctx->io_wq, &req->work);
-				break;
-			}
+			if (req->work.files != files)
+				continue;
+			/* req is being completed, ignore */
+			if (!refcount_inc_not_zero(&req->refs))
+				continue;
+			cancel_req = req;
+			break;
 		}
-		if (ret == IO_WQ_CANCEL_RUNNING)
+		if (cancel_req)
 			prepare_to_wait(&ctx->inflight_wait, &wait,
-					TASK_UNINTERRUPTIBLE);
-
+						TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(&ctx->inflight_lock);
 
-		/*
-		 * We need to keep going until we get NOTFOUND. We only cancel
-		 * one work at the time.
-		 *
-		 * If we get CANCEL_RUNNING, then wait for a work to complete
-		 * before continuing.
-		 */
-		if (ret == IO_WQ_CANCEL_OK)
-			continue;
-		else if (ret != IO_WQ_CANCEL_RUNNING)
+		if (cancel_req) {
+			ret = io_wq_cancel_work(ctx->io_wq, &cancel_req->work);
+			io_put_req(cancel_req);
+		}
+
+		/* We need to keep going until we don't find a matching req */
+		if (!cancel_req)
 			break;
 		schedule();
 	}
+	finish_wait(&ctx->inflight_wait, &wait);
 }
 
 static int io_uring_flush(struct file *file, void *data)

-- 
Jens Axboe

