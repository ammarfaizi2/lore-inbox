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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14DAC432C3
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F51A20643
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd9uWChR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUUVi (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:21:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKUUVi (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:21:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so5975131wrn.11
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UQq6+UuW9SsAEykAN6ROfUpSJCvP/bQOdE64XBSyfvM=;
        b=kd9uWChR9BE3v/ofPxnDix6TyoEo7YsRYi5DHqzKFj/wmVRjUrxoPsYQt7jdamED5Q
         bnmRK3tE1Xyin8KbLVy75sNuAEnaS4rA1BU6PySrbBKTB3ftNPo5fJdDjLABZ/sEY2Ep
         4SfLau+vMfTRJVnTiMfbZqNc1l/LGB1ujwt1g0x8G3MMKKBrHvKLndW2SCSWme6UU322
         tHYJ0oDC9mnrxLokoxYuv5bFyD1kFnu0iRNFWs8gvQQAqD6b8gV0ru50a1clvahg2kGT
         uv793wY/+tUxGKoGzouQD+YzlysE/XNuAPE6X8Ml3kHGnjicRE5BanrnQAng5baGIxju
         L/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQq6+UuW9SsAEykAN6ROfUpSJCvP/bQOdE64XBSyfvM=;
        b=Uxk07eakIvrViZvzVMccBi0HYLFl3+EX0WAVUO4h7dHJjd5BanFaqQzo9NDlaz5jtV
         qlIB85vgMfEtEUZVIJz+Ac6tFVNHkjBgVxcwMuVgAZAL1783NZDcUDs6bvp6YtykJVHz
         xzmg98cIk5s27+1wJgxvDvrZTx9tvMEiVdJBUaFmqFO8gdDV1HcrNfi4aYi24gT1oFHr
         AUTFclXOCHKJMERN/OLoTvtId324FllObkxT2qL2mfdbGU7F+rp6dcNC3NvGyCJMBZj5
         lZAk8bmwvLhyy/PWunk4MZDhW0E34NYoFeUsuflxWb2zceOqHMSEzpI8K3KYi80mXOUR
         AFTA==
X-Gm-Message-State: APjAAAXg5sZh33txCcxZkmv1M4sNKEHLyJLVxw0pJnDX6rpylI6Jdqd5
        2/q/OjTRXzwUibwc0yOXaD0=
X-Google-Smtp-Source: APXvYqxmh9TmgSbe9sdUSAp0raeRueCtexguoL7U56Q9wN/gHTOd0NuktBJhr2DbGomUOtGETuZY2A==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr13726043wrq.185.1574367696058;
        Thu, 21 Nov 2019 12:21:36 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id w4sm4646112wrs.1.2019.11.21.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:21:35 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 1/4] io_uring: remove io_free_req_find_next()
Date:   Thu, 21 Nov 2019 23:21:00 +0300
Message-Id: <19efdbc1458d114f87088863e2ce63ef1e46c942.1574366549.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574366549.git.asml.silence@gmail.com>
References: <cover.1574366549.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There is only one one-liner user of io_free_req_find_next(). Inline it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 86d1d8f272ae..07b48ce3ccab 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -979,15 +979,10 @@ static void io_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
 	}
 }
 
-static void io_free_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
-{
-	io_req_find_next(req, nxt);
-	__io_free_req(req);
-}
-
 static void io_free_req(struct io_kiocb *req)
 {
-	io_free_req_find_next(req, NULL);
+	io_req_find_next(req, NULL);
+	__io_free_req(req);
 }
 
 /*
-- 
2.24.0

