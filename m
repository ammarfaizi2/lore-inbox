Return-Path: <SRS0=0kNa=AX=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49058C433E3
	for <io-uring@archiver.kernel.org>; Sun, 12 Jul 2020 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4B62063A
	for <io-uring@archiver.kernel.org>; Sun, 12 Jul 2020 17:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlQiIMwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgGLRnC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLRnC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 12 Jul 2020 13:43:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0BC061794
        for <io-uring@vger.kernel.org>; Sun, 12 Jul 2020 10:43:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so12167009ejb.2
        for <io-uring@vger.kernel.org>; Sun, 12 Jul 2020 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rEqrlaKi+eSGo0hp5NvPc/EaorWjirLEicC0DphJsX4=;
        b=OlQiIMwJpZDRxlJJuqfaK3kSuBSSjYfmELUtdQHGd+VOftIG59XsVPFPG3Srk/zTcV
         2DhsXsqsgxZ/MRK7Wc1mkn+6vJVdUP0OtFB4OuN8MPL6CPA70OeOAFMy6FG3HCINmf1/
         OsSv7kepLVefkXl1DlTTSJSUxFPKKYsfUK6uxZdgJxiDTG5yK5BeuXudV0lFLqxtU/c/
         SmhIXyoAlBDl/jrsXhL1UPRTShKOVt0LqCgU274PCAmbTGLtAn6Jp4AA6RoHxYQ12K1Y
         5osPKf5Sje6oP/N8BD0rD/wFeJRDNiKi36WswgFAyDyV4QPuQCaD8kZPtiL+aY4U0pPO
         iD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEqrlaKi+eSGo0hp5NvPc/EaorWjirLEicC0DphJsX4=;
        b=V4eQPPZUUnNW89gkwYmVooJ1SmLYIfCuoZ4LeU434fDuu9++7P0lAqqtiAUVkZLpOx
         UUrqKz6prfueOeGnyOvLm0zksNNBL1qwSPqJFT2J2RBtlbqJtF/KiUbWhelTl6bs1Tjy
         kl/g52EfrLI6cenBk7jC2J0jKw1UrXLuuNWng9Sr0r3xk4IF2PM1WkSbe9fiyuqHRIQS
         39yB91SXFpL5XRcuqi25xFMXRGNaRJkd3xjiTsOdw9NDDPI1vmHV9qxOXZnOgmz5hSL8
         O4fwUNge7mEaU5JMP+2ZrWotMGv3BLtsjc5x3VqK7Y6EQHRYJc4Yw504WGrYumZXXfFX
         eNkg==
X-Gm-Message-State: AOAM530QuF973a7ZG0JpSaybhPZQFw8hO6N/jCdUmc3RoL9so7NciWaW
        AfetsFWKpqwH/Z6hcUFEtqQ=
X-Google-Smtp-Source: ABdhPJxwJXMdM1l31rV6384fRjeaTxB+9avxx495MSLrQRKCdiomhozvs4kkuErIra1M8jzX1LgK6A==
X-Received: by 2002:a17:906:7d9:: with SMTP id m25mr69268516ejc.25.1594575780952;
        Sun, 12 Jul 2020 10:43:00 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id q7sm7957349eja.69.2020.07.12.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 10:43:00 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 3/3] io_uring: extract io_sendmsg_copy_hdr()
Date:   Sun, 12 Jul 2020 20:41:06 +0300
Message-Id: <b69243e4f5016746f5af932a54dfda0216e8ed0e.1594571075.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594571075.git.asml.silence@gmail.com>
References: <cover.1594571075.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Don't repeat send msg initialisation code, it's error prone.
Extract and use a helper function.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b496aebd6285..d87751f7b5ba 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3889,6 +3889,15 @@ static int io_setup_async_msg(struct io_kiocb *req,
 	return -EAGAIN;
 }
 
+static int io_sendmsg_copy_hdr(struct io_kiocb *req,
+			       struct io_async_msghdr *iomsg)
+{
+	iomsg->iov = iomsg->fast_iov;
+	iomsg->msg.msg_name = &iomsg->addr;
+	return sendmsg_copy_msghdr(&iomsg->msg, req->sr_msg.umsg,
+				   req->sr_msg.msg_flags, &iomsg->iov);
+}
+
 static int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_sr_msg *sr = &req->sr_msg;
@@ -3913,10 +3922,7 @@ static int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (req->flags & REQ_F_NEED_CLEANUP)
 		return 0;
 
-	io->msg.msg.msg_name = &io->msg.addr;
-	io->msg.iov = io->msg.fast_iov;
-	ret = sendmsg_copy_msghdr(&io->msg.msg, sr->umsg, sr->msg_flags,
-					&io->msg.iov);
+	ret = io_sendmsg_copy_hdr(req, &io->msg);
 	if (!ret)
 		req->flags |= REQ_F_NEED_CLEANUP;
 	return ret;
@@ -3942,12 +3948,7 @@ static int io_sendmsg(struct io_kiocb *req, bool force_nonblock,
 				kmsg->iov = kmsg->fast_iov;
 			kmsg->msg.msg_iter.iov = kmsg->iov;
 		} else {
-			struct io_sr_msg *sr = &req->sr_msg;
-
-			iomsg.msg.msg_name = &iomsg.addr;
-			iomsg.iov = iomsg.fast_iov;
-			ret = sendmsg_copy_msghdr(&iomsg.msg, sr->umsg,
-					sr->msg_flags, &iomsg.iov);
+			ret = io_sendmsg_copy_hdr(req, &iomsg);
 			if (ret)
 				return ret;
 			kmsg = &iomsg;
-- 
2.24.0

