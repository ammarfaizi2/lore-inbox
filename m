Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED51C433DB
	for <io-uring@archiver.kernel.org>; Thu, 11 Feb 2021 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BF364E66
	for <io-uring@archiver.kernel.org>; Thu, 11 Feb 2021 18:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBKSfP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhBKSdF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 11 Feb 2021 13:33:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428BC06178B
        for <io-uring@vger.kernel.org>; Thu, 11 Feb 2021 10:32:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z6so5124684wrq.10
        for <io-uring@vger.kernel.org>; Thu, 11 Feb 2021 10:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CihO+/qTgVBhS/aM/IGKw5xk4szb5pD2QeRuaZvKjOg=;
        b=NuEpCzLJykIWd8UM/2fWwf5v3q6U0WTTHuIQXHBHo6y/eBJn+orfYcaWaViZsfswx2
         5iHzQwZVGlNkzJt/hkprG6UdipeI4IWVfDMdDhaCKWYa7aV1VSKha15OB55OgPxHMMvz
         QEFcBFf6srbFlehPp1Ocj0jDaAbbU48aq2lM7IWrbUIhsquW4M3KqT5BmLoXKFqpEvNe
         dOqhpCSgJo9+mpWzzNQIvK5gFSSfneK7R8fI8xMqPYcJszmth14fNka9u3HCFGUIUkh2
         gp8B1sHhyNCsqc7CvsmPsURdsqpKOkov9+/9CsSEQ4UiMmk+fBJtz3P35oM4OHHz5jEx
         Qm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CihO+/qTgVBhS/aM/IGKw5xk4szb5pD2QeRuaZvKjOg=;
        b=nCDLAW4QsEfuFVjOfm4ALypDp2YVw3ONLNgcCE8zzVD6wjF1jZcehfwKS0P/sVjNeP
         lhMvG/Z43Bqx8V47L6erd5I9H4cE44MoHXeNAj1vIlYFGfP9G4OVzGK9GtZEddm7X9DI
         6qYaaY1CBWrB9+Bly/b5qeV2nPhk2kOPEFQZfzhv96oNrVJprNcIPZTR97O3IsthoDOL
         oMgqB8y47ZCgELQHArni/WFWwz9ab4MuQEtZ2qD5MrE7R8jqzZIiQSI4W2bbsQLg50K+
         8npijyqflI/9Cysdd8g3MXqtVL03wP75wS65sLye34qUsLdUZEyk0UadqNARng4km0BX
         7QYw==
X-Gm-Message-State: AOAM530YlVKINlWQhNxCryC6vTbpq7j/A/hwC9OjUo6y43/6k6CUverG
        aqeHW/isDAGauCFy48xCoi8=
X-Google-Smtp-Source: ABdhPJxH8YsAjd4m6Ec6C4gtj2COmfAncMCz8TqsjUYFfTqagBR+yygCf+BXDxef0NoZmhc36k29VQ==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr6794727wrq.136.1613068338848;
        Thu, 11 Feb 2021 10:32:18 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.228])
        by smtp.gmail.com with ESMTPSA id a17sm6501595wrx.63.2021.02.11.10.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 10:32:18 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 4/4] io_uring: inline io_complete_rw_common()
Date:   Thu, 11 Feb 2021 18:28:23 +0000
Message-Id: <45b309d7d1ec54f34c429997a18f7743b98a6632.1613067783.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1613067782.git.asml.silence@gmail.com>
References: <cover.1613067782.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

__io_complete_rw() casts request to kiocb for it to be immediately
contaier_of()'ed by io_complete_rw_common(). And the last function's
name doesn't do a great job of illuminating about its purposes, so just
inline it in its only user.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 81f674f7a97a..c8b2b4c257c2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2758,22 +2758,6 @@ static void kiocb_end_write(struct io_kiocb *req)
 	file_end_write(req->file);
 }
 
-static void io_complete_rw_common(struct kiocb *kiocb, long res,
-				  unsigned int issue_flags)
-{
-	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
-	int cflags = 0;
-
-	if (kiocb->ki_flags & IOCB_WRITE)
-		kiocb_end_write(req);
-
-	if (res != req->result)
-		req_set_fail_links(req);
-	if (req->flags & REQ_F_BUFFER_SELECTED)
-		cflags = io_put_rw_kbuf(req);
-	__io_req_complete(req, issue_flags, res, cflags);
-}
-
 #ifdef CONFIG_BLOCK
 static bool io_resubmit_prep(struct io_kiocb *req)
 {
@@ -2837,10 +2821,18 @@ static bool io_rw_reissue(struct io_kiocb *req)
 static void __io_complete_rw(struct io_kiocb *req, long res, long res2,
 			     unsigned int issue_flags)
 {
+	int cflags = 0;
+
 	if ((res == -EAGAIN || res == -EOPNOTSUPP) && io_rw_reissue(req))
 		return;
+	if (res != req->result)
+		req_set_fail_links(req);
 
-	io_complete_rw_common(&req->rw.kiocb, res, issue_flags);
+	if (req->rw.kiocb.ki_flags & IOCB_WRITE)
+		kiocb_end_write(req);
+	if (req->flags & REQ_F_BUFFER_SELECTED)
+		cflags = io_put_rw_kbuf(req);
+	__io_req_complete(req, issue_flags, res, cflags);
 }
 
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
-- 
2.24.0

