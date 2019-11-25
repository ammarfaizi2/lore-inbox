Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B52C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 22:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8767E20740
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 22:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5DtnVtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKYWKB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:10:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45437 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfKYWKB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 17:10:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id 30so19045303qtz.12
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoaEl+GQR2yFWmkWhQRTKyLL+QebAe24MOqvuMmpR4o=;
        b=e5DtnVtXqMYkiDGi4isws34K6lSpkRqT60s2O0c1r9ZB56Y4tiJBkORf0xQ5c+O0Fz
         IWRbXco9P5OoWDfaAqRk6S/jo/BQw8q0ccThPw7SJkxLEJ4p5IxKxYv9QK7VUS0PqQF9
         3VTUlNzW3I7pXFJvWky5KbZdaiKUH+U+VqBAan7zoOHV1s61refn9i9SgGMjdkVSuije
         2frtki0rahmuts0wdpoO/fABE4IuRqAIZ+/a1i94dXjEosAuLmWkq57p9K+2Gsuco+7/
         Qq6syEO9Vo3H94KmtRCnNFhG2GHwXxhmkenx6WalSZjBke06Pf/GfTCBUh9qi5j2ele+
         PFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoaEl+GQR2yFWmkWhQRTKyLL+QebAe24MOqvuMmpR4o=;
        b=jlR10NU6xw3x9UJBgJGfJTB10WYAWu/YCtiHlWCdXJFzkyedIPGwqQPoYTyDKHXj3p
         B6EPpYUV++89MQrCKdQ4BLx0gEfDsQZ5CV7L/DJmr728GOghhdo3jIycf1jGNmWOWcx1
         Gt03S4S8nKVUk3amjgo/Z2AaQUQ9LLTDILSm6/AQq/V+nN2Ne9zFsHnlkOJhF4z/2Gca
         lhJgIW9qL426qZ1I+7AOnzPVTwVlUtHP4+ieBNjRMB+v1vV+q7e9tsSl2AVfTnZlwLG5
         Aju8PC3dMzyKnHrixluLmR5e6BiQP+HLuWDsM1t3wmLVXXQfUHi/cPVCxaMiT1IstE9r
         6fDg==
X-Gm-Message-State: APjAAAV3fdC/RId04jl49RATMW9cS4OIea2rSv/2MQKIv0pbazoJOu0X
        BNv3pADWLIiF/5rRtCIKL4NCIm827nE=
X-Google-Smtp-Source: APXvYqweJLwPXcfiZIx6EnP4qvABnSutISgxN1N5tq007NGRcDeHCs3XsiNzqOOMniAFyNPl9Y0KaQ==
X-Received: by 2002:ac8:2441:: with SMTP id d1mr21205803qtd.386.1574719799809;
        Mon, 25 Nov 2019 14:09:59 -0800 (PST)
Received: from bigtwo.lan ([2604:6000:150e:c9aa::fed])
        by smtp.gmail.com with ESMTPSA id k3sm4080969qkj.119.2019.11.25.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:59 -0800 (PST)
From:   Hrvoje Zeba <zeba.hrvoje@gmail.com>
To:     io-uring@vger.kernel.org
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
Subject: [PATCH] io_uring: Remove superfluous check for sqe->off in io_connect()
Date:   Mon, 25 Nov 2019 17:09:56 -0500
Message-Id: <20191125220956.167347-1-zeba.hrvoje@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This field contains addrlen value and checking to see if it's set
returns -EINVAL.

Signed-off-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8cb8f3898c77..f5e81b5511e1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1998,7 +1998,7 @@ static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (unlikely(req->ctx->flags & (IORING_SETUP_IOPOLL|IORING_SETUP_SQPOLL)))
 		return -EINVAL;
-	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index ||
+	if (sqe->ioprio || sqe->len || sqe->buf_index ||
 	    sqe->rw_flags)
 		return -EINVAL;
 
-- 
2.24.0

