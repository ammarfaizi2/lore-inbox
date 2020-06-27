Return-Path: <SRS0=GSA6=AI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6043C433E0
	for <io-uring@archiver.kernel.org>; Sat, 27 Jun 2020 11:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA12214D8
	for <io-uring@archiver.kernel.org>; Sat, 27 Jun 2020 11:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urKMwstd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgF0LGp (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgF0LGo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 27 Jun 2020 07:06:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D8C03E97A
        for <io-uring@vger.kernel.org>; Sat, 27 Jun 2020 04:06:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q15so11055329wmj.2
        for <io-uring@vger.kernel.org>; Sat, 27 Jun 2020 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf1W2MuAATVynekr9pcYMQihcgZs4wV39KH3lzxm6Qs=;
        b=urKMwstdZapS0TOtwh5XpcTB743qH4Fz5zGaoCdLzwAyg4GolIjFj3da5QirAXNKFW
         pG9o/os27b4fbbvPgzbxe+CnfUq+bpCQm3o1PYrNGazoeL76JydVxk3CIu4Uy4znuYhc
         fcr87OFiuH6W+Ehiy+luU4xLPnrFiYd8ExJCMRenmphefNAkOEJmtCyc+mT6EFGrmKef
         LuReuMSj9hmC3FzxGvBr+D9az0by4Dba7AYwM5stD//fDrG5+RNIGOiYfFo6ASM3WDcQ
         dsrsGrKNer7aycdWtQaKHVkQEqX3u/R4ZbZ95UMLdEwmPH26v29H3zfomLQ230/2d0xn
         qhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf1W2MuAATVynekr9pcYMQihcgZs4wV39KH3lzxm6Qs=;
        b=pi5C1cO2Pi1w1/TMb1+mD31dgBqrj8Zb3NxkJxsHzh1BXAE0kgA/pCYxkS6loonKXd
         NtUD1yUK5yZNqsoCntmJGmspefDNTsLKPsKwrEj6HmgRdtN/uhKcxpA6UfYcrgba3L3H
         wpkWSSsYuNzxB/rOtH90L5Rg/esZwWjDSJoe2kcGDywtocxrKVFSAM6smsyKZRxPkhrM
         1cb3XvSiFWNqxB0vgF4mXVi8MHW+JnCwS4dkYGi7k/Ji3UU6sCHZ77CTlUaVtNGnUJJV
         0OmDBa1smOjWhiOl6BnxUlN3TB2zaaaC4k5dZ/qM6zLgspZOKspMtyBm+Mi7UZx0rE+W
         ZHzg==
X-Gm-Message-State: AOAM531wHoOZUE8Xt7PZ921dYjWVKyFO9Z8ec9mHs0LD1ZNQoXrQTIpY
        dIhgZY/4Z3WZMGv383YZZbhtIU8y
X-Google-Smtp-Source: ABdhPJzGUt3QDQ0CQRpYhf/Jz8s3zVbtG4FV1H2O9++UDK77EAH5dAOJsZgJtDd6ux0JQWfIYbgPVQ==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr7778330wma.88.1593256000940;
        Sat, 27 Jun 2020 04:06:40 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.85])
        by smtp.gmail.com with ESMTPSA id x1sm14706721wrp.10.2020.06.27.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 04:06:40 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 0/5] "task_work for links" fixes
Date:   Sat, 27 Jun 2020 14:04:54 +0300
Message-Id: <cover.1593253742.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

All but [3/5] are different segfault fixes for
c40f63790ec9 ("io_uring: use task_work for links if possible")


Pavel Begunkov (5):
  io_uring: fix punting req w/o grabbed env
  io_uring: fix feeding io-wq with uninit reqs
  io_uring: don't mark link's head for_async
  io_uring: fix missing io_grab_files()
  io_ring: fix req->work corruption

 fs/io_uring.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

-- 
2.24.0

