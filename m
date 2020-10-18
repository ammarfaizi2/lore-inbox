Return-Path: <SRS0=4IE2=DZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B8C433E7
	for <io-uring@archiver.kernel.org>; Sun, 18 Oct 2020 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8195A21D41
	for <io-uring@archiver.kernel.org>; Sun, 18 Oct 2020 09:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfa9WPnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgJRJUw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 18 Oct 2020 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgJRJUv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 18 Oct 2020 05:20:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE82C0613CE
        for <io-uring@vger.kernel.org>; Sun, 18 Oct 2020 02:20:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so8097722wrq.2
        for <io-uring@vger.kernel.org>; Sun, 18 Oct 2020 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GmJONCtUDCocCX708rkSzcCDDElS1xy5FRbYRvL+eLo=;
        b=Tfa9WPnTrtbUG8Sflj7g9cQh3PhL3ZvzKy0l9sSLhOdqqM17K9Axw1wFsPNifYxpkC
         vef78voN1KVAladPGBluqaJXw26LvoQlv1FyhWwIZCM2mNcwvrLggxhCvBT5zfN+f6+s
         LE+wn3dvcKzhZrckhEoHKf54A4e9wENbif6aKw7GxN+AZ3xBvG2jHZEEU2SggWgGHdl/
         65euUXBBBepkjPkzaB6AGZg1pT556oMOOlKww2NgaWV76wtU5wKQDfPW9WgO+0/wGmOS
         viPsQ12yVMvI+AuhA/vXS6ALZt+eysGFrxdOpvutebMEn+fUAW1n51SE2idOVgQgOwSF
         0rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmJONCtUDCocCX708rkSzcCDDElS1xy5FRbYRvL+eLo=;
        b=PYhCxg3Ph+u940+s7mqOOWDr8XyovmcVIc8MCkpSZ71dfYgKI4JtEdM0BUSdu1hHKE
         aA/EytWietAx28DJBKc27hYOuJjzag82vHDS7cnOVUcd/TPpdjZ1uSII6y8m1SHl3Sh5
         hw6rh2PHozDdF7saCS+0eS7emi8F066zhBP7b3rFXD1luFmqvGuz0mUkJjaSx2blu/fc
         JMGw49N+iJYY7PsRZfZ/nTP8nTYMmD7x7U7KorbzspjvQ7Pw/gvzbE36EemolxZtZPVd
         fcZo17cHDBJst+By+F09MS64rztckHq8a0eFef98piFpDowXnkiwrJ6YKdzoHfQJblHQ
         c4TA==
X-Gm-Message-State: AOAM532q4xYRoyoFnSDVRlot2TzB5fvLHPS+LmfHbs5m3S9/W4INbaxp
        N1KidupZ+UpIU4zdLtCxLnE=
X-Google-Smtp-Source: ABdhPJw7w399yQDjHbdglweBoRpD38fXFR7VqSRvgI1ZXT4cfSNYBsdvj+huKkcI/NppDGQRuLnz4Q==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr13994292wro.135.1603012850136;
        Sun, 18 Oct 2020 02:20:50 -0700 (PDT)
Received: from localhost.localdomain (host109-152-100-164.range109-152.btcentralplus.com. [109.152.100.164])
        by smtp.gmail.com with ESMTPSA id w11sm12782984wrs.26.2020.10.18.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 02:20:49 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 7/7] io_uring: do poll's hash_node init in common code
Date:   Sun, 18 Oct 2020 10:17:43 +0100
Message-Id: <a2a03d41d389ccddb174e645d5b0e93a979bbf6f.1603011899.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1603011899.git.asml.silence@gmail.com>
References: <cover.1603011899.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Move INIT_HLIST_NODE(&req->hash_node) into __io_arm_poll_handler(), so
that it doesn't duplicated and common poll code would be responsible for
it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 81b0b38ee506..95d2bb7069c6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5096,6 +5096,7 @@ static __poll_t __io_arm_poll_handler(struct io_kiocb *req,
 	struct io_ring_ctx *ctx = req->ctx;
 	bool cancel = false;
 
+	INIT_HLIST_NODE(&req->hash_node);
 	io_init_poll_iocb(poll, mask, wake_func);
 	poll->file = req->file;
 	poll->wait.private = req;
@@ -5157,7 +5158,6 @@ static bool io_arm_poll_handler(struct io_kiocb *req)
 
 	req->flags |= REQ_F_POLLED;
 	req->apoll = apoll;
-	INIT_HLIST_NODE(&req->hash_node);
 
 	mask = 0;
 	if (def->pollin)
@@ -5350,7 +5350,6 @@ static int io_poll_add(struct io_kiocb *req)
 	struct io_poll_table ipt;
 	__poll_t mask;
 
-	INIT_HLIST_NODE(&req->hash_node);
 	ipt.pt._qproc = io_poll_queue_proc;
 
 	mask = __io_arm_poll_handler(req, &req->poll, &ipt, poll->events,
-- 
2.24.0

