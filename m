Return-Path: <SRS0=6TZJ=ED=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D8C5DF9D
	for <io-uring@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C54F22202
	for <io-uring@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6hPC3g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJ1Bie (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36162 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833004AbgJ0X2o (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 27 Oct 2020 19:28:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id x7so3746651wrl.3
        for <io-uring@vger.kernel.org>; Tue, 27 Oct 2020 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEd5Sng6fxjwa8IrqV2D/C8IXRLYC5dOgBz//K4pi3M=;
        b=c6hPC3g67Wb0o9PMkjdw2wc9B7Ix1k78NarPL0MLqnaRJJWqqJftrUXsoURcGWZAB/
         tULo+xrMyfTca81IJRTP2gyk0dIEb1Acb4UHrhH/GMAkyUnyFJxufnQYCxLd8ePfeQHX
         yEmzIj+SSX0GtwU0/RQo/9FmaPxHserazXwhx3oE4O+VfKhPOvgyQaKbKaFhHBkvPAg5
         +GtRI3FT5Zv0xC1GUyCbmO3th1ddbE/bvagFhpxIuAXN0RQoJbHXWUrd8uiXmcJ5A+ta
         95GJGl1TIjrvNCFIIV0w6jx0ILb/WKuCm9Rb5viPkmp4RNCDjsGzdBJhtJBok+md97/g
         +lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEd5Sng6fxjwa8IrqV2D/C8IXRLYC5dOgBz//K4pi3M=;
        b=J7IL5i6fLdaN5ALIh+hPBInzx6gU7hRgD5ijS6KOWotQUg+9lGeENoVLpM/Eo2eMVo
         X2wh3sc6cTAGOuO8CivQwRPQ62RyCVIO1TC7ZragR9wxZqF3cUtTg0NZa4kgJXg4pv36
         Q39F70L4ASGyR1ghx3AHcNceq1hJ+BFWtiUxZ7C6LPnwtVQfUwzBT7H+XtaIAA8UcR2J
         d94KIpkYu0/cBA9ylWa/l9Sxq0kndg9AkWmN+41O1vqRV6YFk75odanDwT2qmXrH/IDa
         doV1BpBMUmbIGIVTXQCOWtBxcoYTN1Y/Z0i9KCmfu9VtIVTJYD/4XJRVgvHHPsAg18fU
         +uJw==
X-Gm-Message-State: AOAM533cpZ2jB1nmRiEOeie7iwFePV5jrgjjY65WsJPYySsNSO0bA+nP
        CUpUm/7QXda0nGcH1J6PQ1c=
X-Google-Smtp-Source: ABdhPJwFvfQTfhK9IqJpnGgNvJMkbKLJifq8eyGj6bQQC90knF7fS6WQVWo0uQUOvDTFd1n18cz46g==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr4011934wrm.80.1603841320977;
        Tue, 27 Oct 2020 16:28:40 -0700 (PDT)
Received: from localhost.localdomain (host109-152-100-164.range109-152.btcentralplus.com. [109.152.100.164])
        by smtp.gmail.com with ESMTPSA id a15sm4336990wrp.90.2020.10.27.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 16:28:40 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH v2 0/4] singly linked list for chains
Date:   Tue, 27 Oct 2020 23:25:34 +0000
Message-Id: <cover.1603840701.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

v2: split the meat patch.

I did not re-benchmark it, but as stated before: 5030 vs 5160 KIOPS by a
naive (consistent) nop benchmark that submits 32 linked nops and then
submits them in a loop. Worth trying with some better hardware.

Pavel Begunkov (4):
  io_uring: track link's head and tail during submit
  io_uring: track link timeout's master explicitly
  io_uring: link requests with singly linked list
  io_uring: toss io_kiocb fields for better caching

 fs/io_uring.c | 181 ++++++++++++++++++++++----------------------------
 1 file changed, 80 insertions(+), 101 deletions(-)

-- 
2.24.0

