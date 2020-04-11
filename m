Return-Path: <SRS0=Io5O=53=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5698C2BB86
	for <io-uring@archiver.kernel.org>; Sat, 11 Apr 2020 23:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB744206E9
	for <io-uring@archiver.kernel.org>; Sat, 11 Apr 2020 23:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlIWOHkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgDKXnm (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:43:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43255 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgDKXGQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 11 Apr 2020 19:06:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id i10so6262387wrv.10;
        Sat, 11 Apr 2020 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WYRSJTfq6AnurzwIFdVL9Jv0SE1zF9pQuRzb6RhgZuk=;
        b=KlIWOHkTCXXMdpeMalRuRMYkdxAPQ51jMafiNH86Jsp+MJFF2TeOSdH9N56mVr2X4c
         KdcSljz2a4kMfFIIKd4dSeUzJsyGyXrHo7qd3KhK25A07pm0bJuamtBDEfF3G1PscP7h
         claD39bvS68+B0QYkW4ExHy9Td57ELdFndormLHrIoCDe6i30pUUnlT/MLWgVVx7Yd0r
         TsvRQ7uHX8L63cbtv2eykRWpfbbGGUsTqaHMXyYHr61VI2QvvIoXLUt7oHVeP5LGONfR
         jTPc+AX2Rw8rhGvleozRR3hILjLD9G4lZy4C4oN3hFLNfVfWgcgUNroLFTvkYNZhcp+l
         QhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYRSJTfq6AnurzwIFdVL9Jv0SE1zF9pQuRzb6RhgZuk=;
        b=suAzNJI1dKaRA5m58jwymmp7aCoiRGHr53fxZrye8tC3XlmZZDK1bJrbTR9NVEugu7
         Fh2GcCM8Kb6wQKzebHdpxgaxSwq1uA/BshFAXJQ2XpuZkUht/jYqd9NUZ0ddpS6rCihA
         J1bkndLJgQmvOQhgURyoYIlTygr75z+K0SuSf3Wdw1w6aL2x1DAPeZXZ98RuV6nK43hD
         QXZCDI1Z8OHRZHo2dEsiKdvM8Xjv0/fNCWWz/CqY6UumIhBHxu4mr3YaHNfvjPjucmFb
         LvoiDknWklPLXy93jz9l5xdYL88ZqN489t1mqwg4uCP8tfnd5jiELsenz49R17x5PQL3
         Ed9Q==
X-Gm-Message-State: AGi0PuZejKft9lLrZQC/X+tYqrNVsFKBrB/m/NIG6gHTXdNfUPe6vr7d
        QTfV26BuZ9rkkNST8FjaUa3oY3kX
X-Google-Smtp-Source: APiQypJJHKyGKUnZi4/Ak8rryO6toHMb7XkAjXNdF6Arn2qP9DgVgxHrE3lxEwayvgHUOFZYufwuKA==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr3775368wru.153.1586646376028;
        Sat, 11 Apr 2020 16:06:16 -0700 (PDT)
Received: from localhost.localdomain ([109.126.129.227])
        by smtp.gmail.com with ESMTPSA id k133sm8992741wma.0.2020.04.11.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 16:06:15 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] io_uring: remove obsolete @mm_fault
Date:   Sun, 12 Apr 2020 02:05:01 +0300
Message-Id: <805c435030f6f4e4332f57a252b901125c5423d0.1586645520.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1586645520.git.asml.silence@gmail.com>
References: <cover.1586645520.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If io_submit_sqes() can't grab an mm, it fails and exits right away.
There is no need to track the fact of the failure. Remove @mm_fault.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index be65eda059ac..343899915465 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5816,7 +5816,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
 	int i, submitted = 0;
-	bool mm_fault = false;
 
 	/* if we have a backlog and couldn't flush it all, return BUSY */
 	if (test_bit(0, &ctx->sq_check_overflow)) {
@@ -5870,8 +5869,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		}
 
 		if (io_op_defs[req->opcode].needs_mm && !*mm) {
-			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
-			if (unlikely(mm_fault)) {
+			if (unlikely(!mmget_not_zero(ctx->sqo_mm))) {
 				err = -EFAULT;
 				goto fail_req;
 			}
-- 
2.24.0

