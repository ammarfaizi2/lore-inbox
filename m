Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD47CC433E6
	for <io-uring@archiver.kernel.org>; Mon, 11 Jan 2021 04:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C747225A9
	for <io-uring@archiver.kernel.org>; Mon, 11 Jan 2021 04:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAKEEw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Jan 2021 23:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAKEEw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Jan 2021 23:04:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D06C061786
        for <io-uring@vger.kernel.org>; Sun, 10 Jan 2021 20:04:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r3so14943800wrt.2
        for <io-uring@vger.kernel.org>; Sun, 10 Jan 2021 20:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eU3GDSUl8WKPqUky0kIVYegMjSXXMNUC2IzxDqFe3IM=;
        b=mNyEc406s0bjNDcItrYNogiZEu+Re3YV05TTE6rbrZ1sjFmPmIB+ZNJsdxw4y0NmLO
         Z5REHVcq4xqV53HeHwineXI9ijslXlcds3Lb/PtgrEMlYzh7/dvFqldk35EUBXgR2UBO
         0HbJdtIiAKCPb5ytlnmnY01vJwMAP6sm1oczeMghUNtVkrCSb/YOCLhCmbAOp5EDewUp
         6Gmgksjqwk3WWmGVBd025BnXDTqdO6NWEhJsmuYUsqfluV4ebHBM8RuRQDxqLb7i+uA0
         GxHckqNnaWYngoU+89UhpbRFCaeDQtGBTbB3mKFJ0jksYAE4mBM63180o/M+6D8aSHYM
         /WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eU3GDSUl8WKPqUky0kIVYegMjSXXMNUC2IzxDqFe3IM=;
        b=WGExOVJc9E9L3lCENewdM6ARzceg7eM0qEInU0/UnDFyXOjGOFe4jNThCZ5ADSRmGj
         hNFDRIQKSXQHqOlAr9DBZAVZLUmPyJ7tZwEZ1BO2wkJtLd5v/Z8hc0tUqbaK8uBjiOqZ
         PRuG7C3R37bKx9gJ+fuBYH6FrnW8mlmRu7p1M8bJqDHEywAaPONr17CEcCqkxjX1gATl
         eGoCUlkZ5pWa4BKvRndSjwohQS28pX8heMPGouFDnVO6p8ULJ30arE/3/uyvsKvo6N0+
         AcYZiFld1L8tqMtvJ+usv0/DRoP/82tlvVSgAlHyv2x2rHw7ojm1ZPZtMuezBuCg549O
         hglA==
X-Gm-Message-State: AOAM533dHalQ1pnBzMO56UNmtp51cZcB0XAXN0gyCITP6jQufoN29XmC
        kzh278q027p4v5RnotyEUJafDDsSSRc=
X-Google-Smtp-Source: ABdhPJz31hTIlKqDStf+FrosKhatnaNa+sHjHAjnUr08h3XJUUtaP5SwqX9DXKN9sxhtCeFdE5oNCg==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr13963201wrv.417.1610337851019;
        Sun, 10 Jan 2021 20:04:11 -0800 (PST)
Received: from localhost.localdomain ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id o8sm22658061wrm.17.2021.01.10.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 20:04:10 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH for-current 0/2] sqo files/mm fixes
Date:   Mon, 11 Jan 2021 04:00:29 +0000
Message-Id: <cover.1610337318.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Neither of issues is confirmed, but should be a good hardening in any
case. Inefficiencies will be removed for-next.

Pavel Begunkov (2):
  io_uring: drop mm and files after task_work_run
  io_uring: don't take files/mm for a dead task

 fs/io_uring.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.24.0

