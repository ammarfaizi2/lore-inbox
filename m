Return-Path: <SRS0=b5Ms=CF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448FC433E7
	for <io-uring@archiver.kernel.org>; Thu, 27 Aug 2020 22:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5C320848
	for <io-uring@archiver.kernel.org>; Thu, 27 Aug 2020 22:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FyfwXvGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0WwB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgH0WwA (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 27 Aug 2020 18:52:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66161C061264
        for <io-uring@vger.kernel.org>; Thu, 27 Aug 2020 15:52:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so4385995pgd.12
        for <io-uring@vger.kernel.org>; Thu, 27 Aug 2020 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NR3FBoYgz2/aSwjStmlglDRsJ7qeatEgECJE4KoKkXo=;
        b=FyfwXvGdAEhVU0rckv0IM6v/x4qYd7q0b4mdN51TsiM2PHchMJ6HKKmEjGQy2PiJY9
         lJWd8XJ/CLrsQ1U28Ndfy/q7ETp0WiYLYXZcDYvdXuPpiEs/OVkiYUepSoVvFQmrcmEz
         x+pgO4Vgo+a2DS2bNceVMK3IPdXM4Nc8Oi926dKUrIAjuNnlt6n5v08Z2LcLymHqW6vM
         pAuSvD7IABAI30gQAd4RZQDufHPz1cAVn91F1RWvRbaxItfaJDifl9rzpJEKUnAma6pu
         0UQQfdXa0/Br+UYAx+cwH0pvjsF0mxr6RYVte+nEWO1Xi+gEj8uw4hzQAshbV5IuuCQk
         JxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NR3FBoYgz2/aSwjStmlglDRsJ7qeatEgECJE4KoKkXo=;
        b=B5rI4EmXpLsko3eKPHXbH00ZLs7uubEEChdKg3UtcAgC470mgP2GtpzKrEKcangu/C
         aEV/LUr29OffRb+B2F63K6gAvoY3B9BYvDMQrKKUhY3QsnDBtRxQ0egEBPdf6DqiLUDC
         dZtv9G/T6vYII/S6wahKFrckSLotdf4Vny+0liYgDt6fJptrXk2VZyVoZQNA0y9ONAIx
         j2qTwOM+kKsnxr58BANtBDMUyJqUbGuJ3OFIR7TtGvdw7seM/3VcLZ9spxEMsGStVvRU
         7dazbaRfqJlhapBpqLXFjbMlMoftMeL0OXG81u51MPPhPQJptw1tdwWydpk+2dx16CVp
         STkQ==
X-Gm-Message-State: AOAM533Z5AYBlTupeCxCczT42GrEkwLJNJOlV/BrONJzAcLHlvu+B1k9
        SaiQxujgrtHPGOdmH2/QlYCukTyBzQXmFhDH
X-Google-Smtp-Source: ABdhPJxupCjFBU6ABXwKXunH0hLcppzhmx4jYcDsnqLUFu6gFXw51CsuYs2gpbt5iHHVnR5qNUP5XQ==
X-Received: by 2002:a63:fa01:: with SMTP id y1mr15969149pgh.284.1598568719655;
        Thu, 27 Aug 2020 15:51:59 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id js19sm3087868pjb.33.2020.08.27.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:51:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Andres Freund <andres@anarazel.de>
Subject: [PATCH 1/2] io_uring: fix IOPOLL -EAGAIN retries
Date:   Thu, 27 Aug 2020 16:49:54 -0600
Message-Id: <20200827224955.642443-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827224955.642443-1-axboe@kernel.dk>
References: <20200827224955.642443-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This normally isn't hit, as polling is mostly done on NVMe with deep
queue depths. But if we do run into request starvation, we need to
ensure that retries are properly serialized.

Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6df08287c59e..d27fe2b742d8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1150,7 +1150,7 @@ static void io_prep_async_work(struct io_kiocb *req)
 	io_req_init_async(req);
 
 	if (req->flags & REQ_F_ISREG) {
-		if (def->hash_reg_file)
+		if (def->hash_reg_file || (req->ctx->flags & IORING_SETUP_IOPOLL))
 			io_wq_hash_work(&req->work, file_inode(req->file));
 	} else {
 		if (def->unbound_nonreg_file)
@@ -3157,7 +3157,8 @@ static int io_read(struct io_kiocb *req, bool force_nonblock,
 		ret = 0;
 		goto out_free;
 	} else if (ret == -EAGAIN) {
-		if (!force_nonblock)
+		/* IOPOLL retry should happen for io-wq threads */
+		if (!force_nonblock && !(req->ctx->flags & IORING_SETUP_IOPOLL))
 			goto done;
 		/* some cases will consume bytes even on error returns */
 		iov_iter_revert(iter, iov_count - iov_iter_count(iter));
@@ -3301,11 +3302,14 @@ static int io_write(struct io_kiocb *req, bool force_nonblock,
 	if (ret2 == -EOPNOTSUPP && (kiocb->ki_flags & IOCB_NOWAIT))
 		ret2 = -EAGAIN;
 	if (!force_nonblock || ret2 != -EAGAIN) {
+		/* IOPOLL retry should happen for io-wq threads */
+		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && ret2 == -EAGAIN)
+			goto copy_iov;
 		kiocb_done(kiocb, ret2, cs);
 	} else {
+copy_iov:
 		/* some cases will consume bytes even on error returns */
 		iov_iter_revert(iter, iov_count - iov_iter_count(iter));
-copy_iov:
 		ret = io_setup_async_rw(req, iovec, inline_vecs, iter, false);
 		if (!ret)
 			return -EAGAIN;
-- 
2.28.0

