Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD0C43141
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1CA2073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2A5AhQV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKPBxi (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35488 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfKPBxh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so5902720plp.2
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkLKuB2X3qUbtcZGQGb+iYsnayJo87eqeNfGqMNtsno=;
        b=2A5AhQV9zSlgOGDmVka5kPex0b6h6dWKhZDyuCQQcOBBj/uTptmXsgod1JGQ7Yf/JG
         bnF4/Tjmo3x20pnES2XqAPgg2RTku8RhSWe924FN8s/hpTV1ApxvQ/W4f22lT5IrSLEK
         fOweygBt1xOWh6AzyVmVWjTlCyOVj3yQ+vDdUQyb9oGUgTNv2tZkLRDhCHI0p0GpiYm8
         84aNs29x+AcgS1h6fmOfImqHuyPhwU1U3BFefFnsu7JhTjYkMWRzdNvQ/KMd5uK9FseO
         p8pTNS5Yb5F7gx5DqjGPYX22KiM25k3CUOKcDtwK5xY8okfw34Zd7syrGPjMF906m9C9
         hDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkLKuB2X3qUbtcZGQGb+iYsnayJo87eqeNfGqMNtsno=;
        b=UFw+LUh0p/R99JEJ6gLeXOhCONsgp6CFfw57N2vAzKhFBesPRfPhCaTTqZ4zoZ8DBE
         U6qJJW7WkS5At5grFvoLfhqUqmt3U6YhueZd+F2GIgZNJJ9A/uVo5EX1hc2S3W9vEi/G
         TQyC2wIe390jfgtBKm2oe8zmYEWHW2Qjn0SSfz3UQf+xmmx3BxyRj7xmwLJT48lzCs13
         dD4T5yzvK6pQFLngqFMrkChdLklU3F1kngO+gBSKs/MCCPzPCOsFRxhKMDDMRTv1NgUc
         ClHkArix2KCtIsjWvTj7MB19YXFK8VB57Ll3V1J/6Af+dCnBVeb+0Bsfc7AZuBJ2X/0V
         ezEA==
X-Gm-Message-State: APjAAAVFjzOyOrGOXD5QAuLnUIzNi79M4XD9Oi7zdtQr9i44PbApRtNt
        j9XhHxZNexaLnZle1gtDBzHlfJy1uyk=
X-Google-Smtp-Source: APXvYqyPSWVkUeEZDSFBFfLinQ82waUJpba5u0W3FuWP23HwvZ6NHkeUkQavwbgRQJ63I6Xw1O0MrQ==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr22994666pjc.3.1573869216655;
        Fri, 15 Nov 2019 17:53:36 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/8] io_uring: remove dead REQ_F_SEQ_PREV flag
Date:   Fri, 15 Nov 2019 18:53:14 -0700
Message-Id: <20191116015314.24276-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

With the conversion to io-wq, we no longer use that flag. Kill it.

Fixes: 561fb04a6a22 ("io_uring: replace workqueue usage with io-wq")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b88bd65c9848..824ddd1fd3f0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -340,7 +340,6 @@ struct io_kiocb {
 #define REQ_F_NOWAIT		1	/* must not punt to workers */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
-#define REQ_F_SEQ_PREV		8	/* sequential with previous */
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
 #define REQ_F_LINK		64	/* linked sqes */
-- 
2.24.0

