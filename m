Return-Path: <SRS0=s7bN=4U=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50D0C3F2D8
	for <io-uring@archiver.kernel.org>; Tue,  3 Mar 2020 23:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69F820848
	for <io-uring@archiver.kernel.org>; Tue,  3 Mar 2020 23:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CxFTn8k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgCCXvD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:51:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44074 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCCXvC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 3 Mar 2020 18:51:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so55571pgb.11
        for <io-uring@vger.kernel.org>; Tue, 03 Mar 2020 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAMHY4TWVCdyCYEBN5cTvIsFzEJPMLGqZyL9Utyjg7s=;
        b=CxFTn8k/bLaJcOQp+xSE1/+NPNbG8CdJz9dtJ/l5CtEeClUvCQ+pcoHzn3K2TztjJ5
         NjURnUs04OKq440O1u6oSNtQ2YX2bD5Tlh57NqT81GHVqB+XHrM9BOYIEW82VlM9VPjk
         o0XPJZmphZjJ21b6vISjAJ1fxSwAwmw3/6LTa26l3Hk2yp9uPbyvHeN+bt5n5LJs29SX
         ICV55lXbV4NHbIC/yqg0AUXop2nKXSMA0gYB1PqsD96jllSyiMxCfe06ps8rwV4ynCkf
         YNK0jq/WTVqA6sRugX6gtpZvbDEPWyzrJSygWPYytnQ4PyI9WmiSyDzoLCagaxd6aPzj
         uDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAMHY4TWVCdyCYEBN5cTvIsFzEJPMLGqZyL9Utyjg7s=;
        b=q4wdHrxca4Lzhz3Tt+mYa6JPBWAFv+Ls9KE6imsguLo/7kIc3fql2rOSR02+TsDpfD
         LhTLyBfEHyAE7Iy7D1w+MF5pz1ncDsKUHZ2SrNk6OE9lNPOVhp8uDhTQAGlHebC7X1j6
         inwQAXvdnZ6MTY5tCZhl5ymFYoHYJABMf1JYK9tf0I955FIGcz2EIeQbGGag6t6REm7y
         PwKFi2wA0Wy7E46WbC3ifqdTpjwHpecJd5xcthj3UMwk0TL7uiEF76qYvu2pFMnmkMkZ
         h0WFnHzMwvIB3bZRX8163nT12R+BI5KI89Mm9vAssm77Vv7yJ62NLQSQOFLP83T/t8Wc
         rhCQ==
X-Gm-Message-State: ANhLgQ21vB2QkVHfeaWITt1JWYxgth8Rj/O4s/uh5F6ocomKBnJWRJ7v
        zFaq5gYPE8Y2/IXLLGOsByZjj2KXquc=
X-Google-Smtp-Source: ADFU+vswuhQ2Pr6PSnWxONSn57+/U3ylWuChc2Ph1lkwP8+DCuspP1bxpZT4fiBuw+6kJ/DCJqEmbw==
X-Received: by 2002:a62:e10b:: with SMTP id q11mr242730pfh.48.1583279460292;
        Tue, 03 Mar 2020 15:51:00 -0800 (PST)
Received: from x1.localdomain ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d24sm27041503pfq.75.2020.03.03.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:50:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     jlayton@kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] io_uring: add end-of-bits marker and build time verify it
Date:   Tue,  3 Mar 2020 16:50:50 -0700
Message-Id: <20200303235053.16309-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303235053.16309-1-axboe@kernel.dk>
References: <20200303235053.16309-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Not easy to tell if we're going over the size of bits we can shove
in req->flags, so add an end-of-bits marker and a BUILD_BUG_ON()
check for it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3df54dad9eae..0464efbeba25 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -511,6 +511,9 @@ enum {
 	REQ_F_OVERFLOW_BIT,
 	REQ_F_POLLED_BIT,
 	REQ_F_BUFFER_SELECTED_BIT,
+
+	/* not a real bit, just to check we're not overflowing the space */
+	__REQ_F_LAST_BIT,
 };
 
 enum {
@@ -8011,6 +8014,7 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 
 	BUILD_BUG_ON(ARRAY_SIZE(io_op_defs) != IORING_OP_LAST);
+	BUILD_BUG_ON(__REQ_F_LAST_BIT >= 8 * sizeof(int));
 	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 	return 0;
 };
-- 
2.25.1

