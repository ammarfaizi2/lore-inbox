Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978AC433F5
	for <io-uring@archiver.kernel.org>; Sat, 11 Sep 2021 13:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60B561206
	for <io-uring@archiver.kernel.org>; Sat, 11 Sep 2021 13:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhIKNx5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 11 Sep 2021 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhIKNx5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 11 Sep 2021 09:53:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6BBC061574
        for <io-uring@vger.kernel.org>; Sat, 11 Sep 2021 06:52:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n5so6918109wro.12
        for <io-uring@vger.kernel.org>; Sat, 11 Sep 2021 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0vHZfMZ2HO2ODIaiU8V7KdV9AHTbrFPND0k/qqGMNc=;
        b=Kw4oNz4069p64le959JCH5ZJF6r45PyHrMYsHkrnVo8ehBhkx9R7hYU70P5gdj5MQy
         oR9beMTxQ1eP2Narll5q/faOQMDDaoz5ZeHn7paFNHQduA/LdWbjumXlQU2cO1pr2AhM
         2uQvuQmxm/ZeVFrzTZYuRzMo2hoI6FumOsF8Bt5gKBTcvUOGedWfLG0jIS+Hhp7TLn7X
         zx7SYXiowZj79HL2ifiDfZnLXPs7GxRLL9ymJIQrnPNu0/FvbUEz95jkEwXh5w36x+R9
         6aDrA3ZTsBElwG2dXPhjlMEvZ/wJtwNAsc9zgUcXEHTEY03vaXoFLUANYNMM+VJxL8dm
         bvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0vHZfMZ2HO2ODIaiU8V7KdV9AHTbrFPND0k/qqGMNc=;
        b=8L/HKI6tI5ocY1M8LKUDVdj2sqocVBm/q6AGRgCT/0tjvRY7a93BShWK0V2+ZRJjos
         T7qssj7Xg7pN2yq9fDqRteNk+WhfRUIP3x5kShEMYNyYL9IIRGEto3eNcdm5TT3PkmhW
         lfMnfVd2lnhj/zrfr4MlAaBeTrQW+Hf8ZB4Zyj8TBrZJqFV7fCJ4ndcPAei4rDt75zRb
         /IIJh49S70Sa3jShkdLwjlYffcmlaitBNd0sXCgmlXf08ovjFY+TVqVsjJHPNNx/WanI
         14s3yTIjNhBopKu866e5yts2weiGv4aVKe036vllCk2/GIbtEENmTMIkMcdIsv6LaKe2
         a4VQ==
X-Gm-Message-State: AOAM5329B0zNaQoY5qGf6zwKchqNY1g6xzvxv9bMKXwbTCAfg1dXviVH
        OLepnYkax1hRiHu6giAw3/jCA90aFU4=
X-Google-Smtp-Source: ABdhPJxAvrSxIahRxc8HMdS1BJvEFEF8WT9d/Q9TbHbARDMDApl0MiDru9yOpTTpepZoW5qbEhoSMA==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr3287717wrk.125.1631368363042;
        Sat, 11 Sep 2021 06:52:43 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.175])
        by smtp.gmail.com with ESMTPSA id n10sm1774928wrt.78.2021.09.11.06.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:52:42 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [RFC][PATCH 0/3] allow to skip CQE posting
Date:   Sat, 11 Sep 2021 14:51:59 +0100
Message-Id: <cover.1631367587.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

It's expensive enough to post an CQE, and there are other
reasons to want to ignore them, e.g. for link handling and
it may just be more convenient for the userspace.

Try to cover most of the use cases with one flag. The overhead
is one "if (cqe->flags & IOSQE_CQE_SKIP_SUCCESS)" check per
requests and a bit bloated req_set_fail(), should be bearable.

See 2/3 for the actual description of the flag.

Pavel Begunkov (3):
  io_uring: clean cqe filling functions
  io_uring: add option to skip CQE posting
  io_uring: don't spinlock when not posting CQEs

 fs/io_uring.c                 | 103 ++++++++++++++++++++++------------
 include/uapi/linux/io_uring.h |   3 +
 2 files changed, 70 insertions(+), 36 deletions(-)

-- 
2.33.0

