Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA91C5DF62
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B2B21A49
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lORbx4kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfKEVWl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:22:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfKEVWi (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 16:22:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id j15so2545755wrw.5;
        Tue, 05 Nov 2019 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yE/g1StzjTRv1LozWXzXyJOSSN2k4w9cmTMk4QzLLag=;
        b=lORbx4kkK1jCf4mnCvop3UcrcNHVsMQcK+FsIRZP5yTK+EOCXD5jQcY1yXYTubIvb1
         c1Q1m9DOcR92tOP1cafcFc2IbdFnv6tggNzLiKMSah784RcSTMS8GmTlVj2r+8bS8rbJ
         z4+ZhyqC8yM6pGgzPPp0+P+6Jhpn3gL4DuuhhCekKHyUhrvVjIMHcSNG/r7Ih2TWUTiV
         S9s4wBGMGh7tjU6ZQLdy8jMsEW+KeEsrNkNj1d/ocGS0wtebBqdYyRl+SejdjTazVL7L
         tGD256nUiP4cFNGa/paa6uetedfPvKg0jx13ex6kM8hg8JjHGDiX7R4H9Z+b59doACXP
         NKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yE/g1StzjTRv1LozWXzXyJOSSN2k4w9cmTMk4QzLLag=;
        b=IYiELGtyS66hzSpLDiiRkbhORkcSXoCkGlYXuF5YJ5eqQwOEIZpwKwWwiQDJ4dBcTb
         9+tDWsO65/ELoRBYqCcHZOXTfamuEcjleJa6SaZ6nta2Tswlnu3PLijaj/3k98XF4Is3
         2rP5l+xpdCgeo2HNOllYQQNjhUJcIUvq4L6yUCSh/KFfTkLRwutN3C2jka90i2hF/mSa
         UusOmELaRuAhr3e2ae9MOKQzmOVpNA1J9yQm211goTrKaDNeE1nQFxpBPTt1U/yIEEK5
         1hzFd2tgXgCUJbcVTgy+VMQoBG1Lss1Nxqfn+fDGaA7M/v1dfpb7DXNAYUi+qiIuN3Il
         iD2g==
X-Gm-Message-State: APjAAAXjSedXrHi4YYP64Mbx2eG8fMPaBfvxPDCrS6yWzIURNx/wtMf1
        SP5UzbI36JOu1CvyX0sOMeEqEzUj
X-Google-Smtp-Source: APXvYqz1aG3/HGqjz870SN9nJ0JRTp1mW/t2dzo1n8LsUrZ+hUk7eKBm1rToU8eSArtOfnD6B/SaEw==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr12794415wri.378.1572988956444;
        Tue, 05 Nov 2019 13:22:36 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id 16sm1061197wmf.0.2019.11.05.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:22:36 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] io_uring: io_queue_link*() right after submit
Date:   Wed,  6 Nov 2019 00:22:15 +0300
Message-Id: <85a316b577e1b5204d27a96a7ce452ed6be3c2ae.1572988512.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572988512.git.asml.silence@gmail.com>
References: <cover.1572988512.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

After a call to io_submit_sqe(), it's already known whether it needs
to queue a link or not. Do it there, as it's simplier and doesn't keep
an extra variable across the loop.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ebe2a4edd644..82c2da99cb5c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2687,7 +2687,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
 	struct io_kiocb *shadow_req = NULL;
-	bool prev_was_link = false;
 	int i, submitted = 0;
 	bool mm_fault = false;
 
@@ -2710,17 +2709,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			}
 		}
 
-		/*
-		 * If previous wasn't linked and we have a linked command,
-		 * that's the end of the chain. Submit the previous link.
-		 */
-		if (!prev_was_link && link) {
-			io_queue_link_head(ctx, link, &link->submit, shadow_req);
-			link = NULL;
-			shadow_req = NULL;
-		}
-		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
-
 		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
@@ -2741,6 +2729,16 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
 		io_submit_sqe(ctx, &s, statep, &link);
 		submitted++;
+
+		/*
+		 * If previous wasn't linked and we have a linked command,
+		 * that's the end of the chain. Submit the previous link.
+		 */
+		if (!(s.sqe->flags & IOSQE_IO_LINK) && link) {
+			io_queue_link_head(ctx, link, &link->submit, shadow_req);
+			link = NULL;
+			shadow_req = NULL;
+		}
 	}
 
 	if (link)
-- 
2.23.0

