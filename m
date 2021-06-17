Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F15C2B9F4
	for <io-uring@archiver.kernel.org>; Thu, 17 Jun 2021 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45262613C1
	for <io-uring@archiver.kernel.org>; Thu, 17 Jun 2021 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFQRQu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhFQRQu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 17 Jun 2021 13:16:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56072C061574
        for <io-uring@vger.kernel.org>; Thu, 17 Jun 2021 10:14:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d11so5247127wrm.0
        for <io-uring@vger.kernel.org>; Thu, 17 Jun 2021 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BC8Y6n2mo8Z0n0GeS9Wd+qfND9sTg6VoFPGp7FFPgyc=;
        b=IKfX+i8XHM9SKCWPYaaXFnoLQ2OOVCqbX8FAVS777PSU/Xqa1TC8pUNoCcbAvDt/mc
         Y+FkqsLuBgKho5i1oogTZGGQY+zwokugm1PLldPfsDcvDxmLGUonXRoch7M04zTmOAMk
         /awlZeAJchUQl2GYJSaZ0wdhCDmoACPe1k7wfWHIVqV+pcGGn/N/+T0yj4HTnUc1owAQ
         UnA4d4J1ArmCoRWc5u8PHZy2M+N+HAQ1Z20PAYpx/UFNk5YHlX6JXpLNl7qAT1qpcRW7
         62+KuB1E1mhoqPKMXtacIHeVxHOuUZ6+V/5f/XkiYNU3I+Veg/28Gj5Ftz81fqWNl7TD
         gFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BC8Y6n2mo8Z0n0GeS9Wd+qfND9sTg6VoFPGp7FFPgyc=;
        b=X4JX3TIcYK7XUEcH74TdFhy65oNGRBsjxtzzZkzdVc2njt43r9Rm7pEURNrBjYaN8c
         rx8749AJOk8of+4KLP3hojR79gtMYGtqouHKMI6Z81O6EMfkRCHYX0iUSaYZS6B9N0af
         i8OdXv1j2y7mCZvsA95bUxoBAYaUdo3Xy8A1WC48mlNAG3MrWnCT8IJfwN3Tvz1XIh+1
         ncsV8DDPuaSMKzZ7T+prlshlyw2O5mFEMXVjLQ2fKn/ilnadRwd4nP3B9RqB19qKoXrr
         JkFmPvHdXN7HoG5p23Tjw5snE0wwPMNowW5Y1H8Gy/a3YRM3zLrEqnRTfF4/ygxeV/85
         U4ww==
X-Gm-Message-State: AOAM532VwlkgHQGQl5JRvjNBhQ5Fan4vbivRUMuFWNJlNF27UxnycPok
        pV4eoZrL5+8d0gyTKg6ibpY=
X-Google-Smtp-Source: ABdhPJxUT+sxRzIbPlMUwBJOFjSfLStgFjAUA4+PBPqIeC14sLQr+vmedQAkF6UAjqVzA4pb3sU05A==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr7059873wrt.12.1623950080060;
        Thu, 17 Jun 2021 10:14:40 -0700 (PDT)
Received: from localhost.localdomain ([148.252.132.93])
        by smtp.gmail.com with ESMTPSA id g17sm6208033wrp.61.2021.06.17.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:14:39 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 07/12] io_uring: refactor io_get_sequence()
Date:   Thu, 17 Jun 2021 18:14:05 +0100
Message-Id: <f55dc409936b8afa4698d24b8677a34d31077ccb.1623949695.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623949695.git.asml.silence@gmail.com>
References: <cover.1623949695.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Clean up io_get_sequence() and add a comment describing the magic around
sequence correction.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 98932f3786d5..54838cdb2536 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5993,13 +5993,12 @@ static int io_req_prep_async(struct io_kiocb *req)
 
 static u32 io_get_sequence(struct io_kiocb *req)
 {
-	struct io_kiocb *pos;
-	struct io_ring_ctx *ctx = req->ctx;
-	u32 nr_reqs = 0;
+	u32 seq = req->ctx->cached_sq_head;
 
-	io_for_each_link(pos, req)
-		nr_reqs++;
-	return ctx->cached_sq_head - nr_reqs;
+	/* need original cached_sq_head, but it was increased for each req */
+	io_for_each_link(req, req)
+		seq--;
+	return seq;
 }
 
 static bool io_drain_req(struct io_kiocb *req)
-- 
2.31.1

