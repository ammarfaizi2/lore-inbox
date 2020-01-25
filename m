Return-Path: <SRS0=mvU7=3O=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518ADC35241
	for <io-uring@archiver.kernel.org>; Sat, 25 Jan 2020 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E5A2070A
	for <io-uring@archiver.kernel.org>; Sat, 25 Jan 2020 09:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvai70gM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAYJAp (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:00:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39719 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYJAp (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 25 Jan 2020 04:00:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so1842663wme.4;
        Sat, 25 Jan 2020 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GchmmZAhlU8Co5U1q3zcxajpizhbMQGLMHtACB5nzyQ=;
        b=Rvai70gMz3sVqPtPLTYrPnb42K/8SueeKq7npnqZMuKJnASRWGoDJoIj/A8Uaqa+Y1
         1PDCNXIHKq/xACnbdflJjMo7wW1j4GV2Em+7qzXL7T0eeYB2vEjZXCkCWD1mqDVygRv9
         MYRy37PbyKc9sL+szLOclJQiaDDuIxErBplqctLxJED+UAzz0Fm1F4vHf0dyNVeXjC9J
         UiQjlaz76FPCjSngXHPSolZP2zHl+HHnMi9bURixE7NBMmSqRhhBp/FGL8ylmyeigraJ
         CegQyplu9SK/MACWx4ZkEV/aroZr/UNOTKjNiMAgKxay1sHOOy+4OHQonX35nrdxJTut
         4OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GchmmZAhlU8Co5U1q3zcxajpizhbMQGLMHtACB5nzyQ=;
        b=B550Zhxo5m1kVLbTxp+QXjxfV1dm+v9fEBGBVUMZHZOh92GmrlTx3lKIDMh2ir8eiz
         FGRDbtNFMHqn3Dzy4qG0tPlKTruVmYqh7eKcuaU4EGTZHzn3E1I7uODvQ2SN+cPre+aN
         vT/2r7Mr3tI6D1Iu+v6Xv8+CKXLH+cpc4J37b91ip0vzwQnF0qe4mV5FTHkVgprJnX+X
         otMwFcYC9eeaJ5WZiPtOsGazCX3Gag1x70PhCIZDXu39X1G6PY1V/PhGYLT14huWmEoc
         /W9DcXKt6UxfSvncFz2IQRIEiL4zogdvdAAIkdUqhMd67TYtFn/4Nk2BzQBeUUFNp3S+
         BKjQ==
X-Gm-Message-State: APjAAAU06+IE7ACxBviogabFqdVGBVkP9Vw22Kjt9FS4NZMMQLIqc11W
        Kz0uW6aazgJaOA2R4s5mp0rOh6ax
X-Google-Smtp-Source: APXvYqwfIf3KOlD0xYres/MByZ2hWFZYxKFDhuoyIRk1vPfHTsjSVOYEMgdI2/iY6YAEAMEcQcv/vA==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr3450608wmi.119.1579942843388;
        Sat, 25 Jan 2020 01:00:43 -0800 (PST)
Received: from localhost.localdomain ([109.126.145.157])
        by smtp.gmail.com with ESMTPSA id a5sm9866897wmb.37.2020.01.25.01.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 01:00:42 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] io_uring: fix refcounting with OOM
Date:   Sat, 25 Jan 2020 11:59:30 +0300
Message-Id: <fa69cae513308ef3f681e13888a4f551c67ef3a2.1579942715.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

In case of out of memory the second argument of percpu_ref_put_many() in
io_submit_sqes() may evaluate into "nr - (-EAGAIN)", that is clearly
wrong.

Fixes: 2b85edfc0c90 ("io_uring: batch getting pcpu references")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a4b496815783..744e8a90b543 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4912,8 +4912,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			break;
 	}
 
-	if (submitted != nr)
-		percpu_ref_put_many(&ctx->refs, nr - submitted);
+	if (unlikely(submitted != nr)) {
+		int ref_used = (submitted == -EAGAIN) ? 0 : submitted;
+
+		percpu_ref_put_many(&ctx->refs, nr - ref_used);
+	}
 
 	io_submit_end(ctx);
 	if (nr > IO_PLUG_THRESHOLD)
-- 
2.24.0

