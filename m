Return-Path: <SRS0=R86o=DV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A80C433DF
	for <io-uring@archiver.kernel.org>; Wed, 14 Oct 2020 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC9B21D7F
	for <io-uring@archiver.kernel.org>; Wed, 14 Oct 2020 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp9M2qSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgJNTrZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNTrZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 14 Oct 2020 15:47:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C94C061755
        for <io-uring@vger.kernel.org>; Wed, 14 Oct 2020 12:47:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so473298wrq.2
        for <io-uring@vger.kernel.org>; Wed, 14 Oct 2020 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bI+F6mKXKM2BbZFIVjNsVDbc3PfMNYzB2dEJaU8BdUY=;
        b=Rp9M2qSQZlsiZhLddUtYrWtrTMdm59uwc5Y23E05cwN2RDGpMMloOx9fQb09ZLHx68
         XRvNieJjt9qtOpt0dkwZM24I9DTrULRqu+UcLtNvpUOwSOik5paPPkKWlNPZMnjAG/vp
         jiOnTQphTFryj0Z/Rcgwe01LtLuBB7jpkyYwXfhkzRoTgEfW92g4UgTIrUF6xZFL3M8d
         1AcR4AePh7BuYmQo+zun5/aBQpY7TSdJegHm2f2GZr8Vz1q2w1NPQAR8fWt4W+cRapkR
         tl49MnPOruzoYq3xP1tyWfZyXPNA7YJaQvNSm/t1d4xAZsULIOXtKdAoPGbqIcj9bfAR
         xm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bI+F6mKXKM2BbZFIVjNsVDbc3PfMNYzB2dEJaU8BdUY=;
        b=NzK4yEps3YaB8g7fyIvXNcTZaAXPZ1/HGI/o3ZWONNQcEdsHv44tI7Jf2fucTKttDH
         +VPGQZ+44jY5dRPa1i6lBfiu6fv6fSrl0kHX+N3xUo2hKBtOtsMxPLUiL1mN59kG4n9U
         wpU+naViysyeh3LyCWMnkoyQudBzFBViV0aduDbOhCIWV/n8OtjHwvy30hhQhjRrsYHU
         6f7aVtMGO23T6ttapFwLSWS0UC7yMgjDrnNlP4MZZM5uRmeAvoPiurD3IGkWiENNP4AC
         IKCfRfgaQ+B8oJXckz4vNnw6/Vei9Z/Klx3ZtxGKm0Ca+6JC7CxB4zxaPOEfWyCn2+DV
         CgVg==
X-Gm-Message-State: AOAM533FCDJ5c+PHCUKWzOlcLEi7FAtJIO+bDspQapI1RY9UByZRifvz
        4y1wlzfF/YNt4FUJ1Xch6yyXhsUS6oICZg==
X-Google-Smtp-Source: ABdhPJyv+PHyFqq2mY/MjMh6wG5evni096iLFROHmkfYIY3QuLPJbLbj93i7PpOwa1+9rUX7fdj6nA==
X-Received: by 2002:adf:9361:: with SMTP id 88mr364497wro.37.1602704843499;
        Wed, 14 Oct 2020 12:47:23 -0700 (PDT)
Received: from localhost.localdomain (host109-152-100-164.range109-152.btcentralplus.com. [109.152.100.164])
        by smtp.gmail.com with ESMTPSA id 1sm526985wre.61.2020.10.14.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 12:47:23 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 1/2] io_uring: optimise COMP_LOCK-less flush_completion
Date:   Wed, 14 Oct 2020 20:44:21 +0100
Message-Id: <f8a664391b4d327c05a2ff8b6386ed81bb098201.1602703669.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1602703669.git.asml.silence@gmail.com>
References: <cover.1602703669.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

After removing REQ_F_COMP_LOCKED io_submit_flush_completions() was left
deferring completions via task_work_add() in the hot path, that might
end up in a performance regression.

io_put_req() takes ->completion_lock only when at least one of
REQ_F_FAIL_LINK or REQ_F_LINK_TIMEOUT is set. There is also
REQ_F_WORK_INITIALIZED, freeing which while holding the lock have to be
avoided because it may deadlock with work.fs->lock. And if none of them
is set we can put under ->completion_lock and save an extra unlock/lock.

That actually works even better because it also works for most linked
requests unlike it was before.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cb2640f6fdb2..f61af4d487fd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1601,12 +1601,19 @@ static void io_submit_flush_completions(struct io_comp_state *cs)
 		req = list_first_entry(&cs->list, struct io_kiocb, compl.list);
 		list_del(&req->compl.list);
 		__io_cqring_fill_event(req, req->result, req->compl.cflags);
-		if (!(req->flags & REQ_F_LINK_HEAD)) {
-			io_put_req_deferred(req, 1);
-		} else {
+
+		/*
+		 * io_free_req() doesn't care about completion_lock unless one
+		 * of these flags is set. REQ_F_WORK_INITIALIZED is in the list
+		 * because of a potential deadlock with req->work.fs->lock
+		 */
+		if (req->flags & (REQ_F_FAIL_LINK|REQ_F_LINK_TIMEOUT
+				 |REQ_F_WORK_INITIALIZED)) {
 			spin_unlock_irq(&ctx->completion_lock);
 			io_put_req(req);
 			spin_lock_irq(&ctx->completion_lock);
+		} else {
+			io_put_req(req);
 		}
 	}
 	io_commit_cqring(ctx);
-- 
2.24.0

