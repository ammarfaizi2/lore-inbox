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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127CC432C3
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 19:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2972075C
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5odDJwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfKYTkf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:40:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46116 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYTkf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 14:40:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id h15so13842601qka.13
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7FFVcJGbBMyDOlivffaEbZ8MzUE5uRL3The8b6/Diw=;
        b=j5odDJwCiQiymKmruk9opkYfY00mv7gf8JlT+K2HHeRz9Y5W1BHwZ3r+dvybKmne3U
         kvium0ZURUx9X9WGdj4hAcd4ofwNTmKE9IOC5gDlrrJqge9qjuxihkRwFl6hVKymOv2Y
         vwCfSjGjOJeAnABPDJC+bkLqtaXwrKKu9cgAmr7maQG8Uqds0MtlJ8iUG+L/0q08Mrq7
         VZ6OcsAFhlhD77VW+iDImJKl8W9zzeldIa3y88GjJr3+xHsGV81veaceuV1TpfKy75WX
         2H/YtcKwI4+Y1IOr2Ip1UXXxFHhPj4a6lRfJXDCopcHePdoTBKOoZyaKolM+ZcWWeZLE
         VHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7FFVcJGbBMyDOlivffaEbZ8MzUE5uRL3The8b6/Diw=;
        b=MYhrOE1I0cn9UhW7afUEe6yrr+bNRCtub0myzJhfhTohGDdTRjPvotFrol7F70hYtY
         pWpHklCG1BMw4Blpn9ghzfYBM4ZS1OVkHY5nSIeuY26icBrkRKAO4i+rJyvIFoQpuVV1
         y6m/7nmYY7XvAFvUQa+mP1QpyqEtMkfzuIq04xN/Lc/uiTPU++Bay5UDCLWb3DP68/oo
         Zu9ND+RC/TxOK3vHi3Fe3SuSnp+2vKwW/t+4Ws0oYN7eEQhXoJcIHZT1zChxh6ASDTDZ
         +a3npoGyUJibVa+UguiJvM//8+sKjxRBoIRr86kQMtgg4n5pdz0G6ijsh2NYYW4RDQ5k
         pt5g==
X-Gm-Message-State: APjAAAVyMERRrnukW/tSx9XZPH1iDQglImYzYG2p86Ge31itre0nBPOg
        xNYOS/pwIYBl8u1Qy5rpXRYYZJipmPE=
X-Google-Smtp-Source: APXvYqwNknMSTq8lWet1HMyhRH+zcEz/pxrf+RLQq87b3qpALXxPHt7rLzi7T1o2hLFOVIclckCS9A==
X-Received: by 2002:a05:620a:1011:: with SMTP id z17mr28017620qkj.39.1574710833953;
        Mon, 25 Nov 2019 11:40:33 -0800 (PST)
Received: from bigtwo.lan ([2604:6000:150e:c9aa::fed])
        by smtp.gmail.com with ESMTPSA id n198sm3910297qke.0.2019.11.25.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 11:40:33 -0800 (PST)
From:   Hrvoje Zeba <zeba.hrvoje@gmail.com>
To:     io-uring@vger.kernel.org
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
Subject: [PATCH] Remove superfluous check for sqe->off in io_accept()
Date:   Mon, 25 Nov 2019 14:40:22 -0500
Message-Id: <20191125194022.441739-1-zeba.hrvoje@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This field contains a pointer to addrlen and checking to see if it's set
returns -EINVAL if the caller sets addr & addrlen pointers.

Signed-off-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e5bff60f61d6..8cb8f3898c77 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1963,7 +1963,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (unlikely(req->ctx->flags & (IORING_SETUP_IOPOLL|IORING_SETUP_SQPOLL)))
 		return -EINVAL;
-	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index)
+	if (sqe->ioprio || sqe->len || sqe->buf_index)
 		return -EINVAL;
 
 	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
-- 
2.24.0

