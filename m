Return-Path: <SRS0=EEhg=AY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C9C433E1
	for <io-uring@archiver.kernel.org>; Mon, 13 Jul 2020 23:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0354A2137B
	for <io-uring@archiver.kernel.org>; Mon, 13 Jul 2020 23:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBa3zh8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGMXnx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMXnw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 13 Jul 2020 19:43:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE90C061755;
        Mon, 13 Jul 2020 16:43:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e22so15318938edq.8;
        Mon, 13 Jul 2020 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KeWQ1zmwnCGeSFmZkNh22mp9FY3EEORcVlV54nSLWg=;
        b=lBa3zh8pAY5TFzsY0/VFb/jl7N/tSYtZ0hUM4cY2YeewiXpT2IPdc+MkoFFc9T9irx
         EIUlVCmlzmjlopWG9Nl8BgTmqFXYKEZrqmeCht2Dmp41046LDoAMa2ZwrGKQRQshimL/
         122ST+ok5YK7wLp2eGJCc9BX8dV7ImYazmouiZVRQX2Hl6e7p4+nyXqVZpCnKHxttngG
         9MxkRCt2qd45CKEP9WTiEszr8XuvzgJ0Wo8vLkArjhQooGldcu1SW8DYFR8DJ8ATB8QC
         RBAYK7JZwjtOq9VMRvjBlDIjs6kJQEzwH7b7FaXpCXnDyJrqW+aGqcmfUlj6jV4p6jJ5
         jZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KeWQ1zmwnCGeSFmZkNh22mp9FY3EEORcVlV54nSLWg=;
        b=GlNZQ5M5BB1GWNM+dr9gBsyC1MTgY72eLHfGMgDqZguIkO/cqzNYOHaiGe/m0Aqgy2
         AD6NRNIDOQPlOYEy9zeI2ryOlf6iBHnh7M1xg3K7UTAZtCKkRRF4ZLmjJWKAxeisK0V0
         a9yzl1EXBJAX0D/LHzJ9Jl25NOfGy6xY3p2IReiqohcAO9IKCD4vfaoJhY+afY+WjakF
         jOQ5Js99VWHK5Wmur9TIx/Cf6vwTwUKUgk+ifd6faTjgH8BFDOyVmf3m2Or6rts10A9C
         qzJD8Ign378TPnDfnIKuLRfMaKH1XVCSq7fsqIEELQc4B9OtV3UQcoTN45jopAn+rcKU
         4ASA==
X-Gm-Message-State: AOAM530OBlcufxTxI/qDyydqQfZjD9HIZpltbRZlCYNs6Yt86YV7CmSt
        4v3rOsNW1rCx3RQN7HHrI3/E2y86
X-Google-Smtp-Source: ABdhPJx8ozTuI9yV1iazQFUMtYeoEvMNeyZt0x8IJ0kXeuhhQwFeZygd58qgyK5lUCh85TBehpNdBQ==
X-Received: by 2002:a50:d0cc:: with SMTP id g12mr1798169edf.57.1594683830898;
        Mon, 13 Jul 2020 16:43:50 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id a13sm12964712edk.58.2020.07.13.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:43:50 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] batch completion + freeing improvements
Date:   Tue, 14 Jul 2020 02:41:51 +0300
Message-Id: <cover.1594683622.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Different batching improvements, that's it.

Unfortunately, I don't have a decent SSD/setup at hand to
benchmark it properly.

p.s. if extra 32 pointers on stack would be a problem, I wanted for
long to put submit_state into ctx itself.

Pavel Begunkov (5):
  io_uring: move io_req_complete() definition
  io_uring: replace list with array for compl batch
  io_uring: batch free in batched completion
  tasks: add put_task_struct_many()
  io_uring: batch put_task_struct()

 fs/io_uring.c              | 129 ++++++++++++++++++++++---------------
 include/linux/sched/task.h |   6 ++
 2 files changed, 82 insertions(+), 53 deletions(-)

-- 
2.24.0

