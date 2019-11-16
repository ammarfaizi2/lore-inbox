Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84557C43215
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC72073B
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HvXHPXYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfKPBx2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKPBx2 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so6786975pgm.6
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3UG4vS5AOAAkK5RqdfJ+JSjW9TMfqyy7pp+fdBouik=;
        b=HvXHPXYLECFDcj9kad1dMVZ1gmFRaIuOa0WAw63SUozZB6FEAUSsYvCTi2QjgYx3X6
         jLPlhJeJIRd1jOXXzXFsUns422sAo3/A8EmLXLpzkeon4T3FCSpPpOjT7Dzf1rPYWmoS
         azO8uuWNACJ+sR8b6A1KdkVUC4ueG+1XVuV+eynW/jpvi65p+ToE4qfQVvS2RRpdRUbe
         YKlX2eGMXw4erWK3iXa+/BLtK8myhiJ43ZYyHP533XlkCuZ6js+QTVtBUaE9d0xjIDTD
         MtH6wsE45wPXMT5lU0244USpF9gTGun5EZBnHmcyvixESH7Y/xQ7HVWgbqfhzPJnNG2s
         wIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3UG4vS5AOAAkK5RqdfJ+JSjW9TMfqyy7pp+fdBouik=;
        b=jNeYlWopBAKS4JRVCzVWPF1X64mFnP+Uc58djxPrgVDR945s57xEcHrl9O+gMd2sju
         l7VKIMP1PiGAC514Lbjq5oS3+eiPTa+agOo+h+QdmUMDIgKBTTUYnC1YSNpBjHNHuWut
         ERbgOG1NosmSTV7l1eI5mONiqIb+FUa7SsQ6joUFEqEMu/iohBmg58DwEUaRbaGbHB30
         OlvcFZHT838OmUVu9cjPutDAHLT8KJs2QcmYUG6ikB4H0UZCTIomb+dsrjZiOmkfsj9T
         vH+eNXSO+MOPoj3rwU6S9w63yEE2mVXSDQr55rNOiDFG0Q7IDb7Y3S3u/3Xqt624Lu+y
         a7Wg==
X-Gm-Message-State: APjAAAU2LE2nwlcc38NcUXNQBX6Ql/DNlfi2vp3pd5fe1RuGjIppqJ1Q
        qQyajuYD7PUbICsF6QTPjJRkKXIeoZw=
X-Google-Smtp-Source: APXvYqxTJ2KWIa9QgDg+WLstCrKiZMc7U1ifIlIXO52WyBoANPkjtFEOjIhLRmAIi+TujBTfVKX+4A==
X-Received: by 2002:a63:644:: with SMTP id 65mr9790390pgg.306.1573869206885;
        Fri, 15 Nov 2019 17:53:26 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:26 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] io_uring: io_async_cancel() should pass in 'nxt' request pointer
Date:   Fri, 15 Nov 2019 18:53:09 -0700
Message-Id: <20191116015314.24276-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If we have a linked request, this enables us to pass it back directly
without having to go through async context.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5ad652fa24b8..c60e0fa96d9f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2465,7 +2465,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	    sqe->cancel_flags)
 		return -EINVAL;
 
-	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), NULL);
+	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), nxt);
 	return 0;
 }
 
-- 
2.24.0

