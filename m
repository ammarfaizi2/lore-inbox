Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3AC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0052067D
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC9/jJ6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUSZv (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:25:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52133 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSZv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 13:25:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so4581837wme.1
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfA0SCYXdN2acEe2b65BI5Es4ROaInL2gRStnmNYr2E=;
        b=eC9/jJ6Um+z+PVoZcDDG8iQfV78WUkHVRQd9XMGK1wXiO/Qfozhh9ltBWCo9fDmYpF
         WtA+TRRzAbHFkB7ETxkjwww5/aqD3dE+vm6r08rA6fRWW92DaQQt5jY6XhyZF9ipyojd
         DebmtkbK8JWyVKb+VJwbod/Oqfv2kLjMTw2y3Fb4PiKss8d//pUOcrXTFBQCERMjDhSs
         MrDZXPXB7qUK2IYgUAEf21VqX0TLz5VJbqiYYT7kO2xkKGQcs81cNTHVCDZnQYNPP6ZB
         TQJU9N4Ju2VAVBwtbO1sSAIwnZuDymtyDffq72HXDLG6Z/RWjZg8aIixaqOIyXA5mwbT
         dvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfA0SCYXdN2acEe2b65BI5Es4ROaInL2gRStnmNYr2E=;
        b=W2n+eFImFW27Oy1GlGT460xpmkxYg8zckfRcBotWs6hndxOg+Qja4mbDF4M37NH1Nc
         JBeeWAR/WF+bm2xMDReDTy17uzEpn43KIw8Ymv0waVQHhLDgXDm/q5dAWxe/s88osUte
         3g9znQrtVqlbbQyiZz5j/i4Gmjte1Cz1XymB3FGW0L8AVJ22S6HCRyZFMYaVyx1spLLz
         d/pB5KKlecThxe2ymLeo4n1MxQYC73icPsTwqiprNS2JyD+AwwgFzwr9JiXIZsDdisq8
         J7AQucywknjXc+2+X1jZ18raGXSiAKN9gtlmAlGlaCgcShXjksqon56edksQC9R4Rl6X
         0ngg==
X-Gm-Message-State: APjAAAVdqfIOCZt0CTsiyjgcABIYeHmOV85r9eBa6eg1+HjQmlv1bwZn
        VN9wYkFWJgJB6pYrc7cCsGCv1QxY
X-Google-Smtp-Source: APXvYqwCdBQtcsHulNQgxFvm6WRw1eHa3TLJIu+ebw52gQua1I3z/rGpqn+mQG5soCDYywqOAF3v1A==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr11480381wmd.63.1574360748739;
        Thu, 21 Nov 2019 10:25:48 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id b3sm443964wmj.44.2019.11.21.10.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:25:48 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: add likely/unlikely in io_get_sqring()
Date:   Thu, 21 Nov 2019 21:24:56 +0300
Message-Id: <50ff6f8b7262870f78377b0b7fa0e19804652c62.1574360627.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The number of SQEs to submit is specified by a user, so io_get_sqring()
in most of the cases succeeds. Hint compilers about that.

Checking ASM genereted by gcc 9.2.0 for x64, there is one branch
misprediction.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fa1cf7263959..86d1d8f272ae 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3112,11 +3112,11 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	 */
 	head = ctx->cached_sq_head;
 	/* make sure SQ entry isn't read before tail */
-	if (head == smp_load_acquire(&rings->sq.tail))
+	if (unlikely(head == smp_load_acquire(&rings->sq.tail)))
 		return false;
 
 	head = READ_ONCE(sq_array[head & ctx->sq_mask]);
-	if (head < ctx->sq_entries) {
+	if (likely(head < ctx->sq_entries)) {
 		s->ring_file = NULL;
 		s->sqe = &ctx->sq_sqes[head];
 		s->sequence = ctx->cached_sq_head;
-- 
2.24.0

