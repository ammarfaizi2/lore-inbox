Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C81C63777
	for <io-uring@archiver.kernel.org>; Mon, 30 Nov 2020 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6AC2076E
	for <io-uring@archiver.kernel.org>; Mon, 30 Nov 2020 19:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwiTtfBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgK3TPV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgK3TPT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 30 Nov 2020 14:15:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8CC0613CF
        for <io-uring@vger.kernel.org>; Mon, 30 Nov 2020 11:14:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v14so438729wml.1
        for <io-uring@vger.kernel.org>; Mon, 30 Nov 2020 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5yy6P6p4lAIX2/xVplz0L3qZvJUPanqtim/08flQJI=;
        b=OwiTtfBhdTKvS84e8AFaKh349LGxOint1y01PGulflj44XF/93qAsapJdePz/fYbJd
         bRvsiFcjzy6wnAbjrOUnk4/821xZkmRr95YGl/ZmPEAJDynz+IjIbKis9WXq0wdct/+A
         FU78B4ivpxuW+gnXSEJttDyk+eYsdlm19pxS0nv2Gr4g83QeAJgfU/+8mEfwTAM5uswD
         3hYiBlOT4DV7SeyGT9HNIAOMfno9a+Eoq7Hkyc8YqMro9c2fsWO26kwt/DGPwpiR1YCv
         xBWpPCXyx38mhItVttpJ8x7QxzJcYbA9dgo/Cj2dWYHMHrhg4wZ+3tfBIDBH5jnWOqwC
         ggPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5yy6P6p4lAIX2/xVplz0L3qZvJUPanqtim/08flQJI=;
        b=eo5rvkZuqkBMfXmj92zI7dr4pF7wDXQKEMGCZgoClOW29JoOruMArgOxk5jnr/SNZv
         jDEZslaZDzYV0NgoMvBAEQgqxYYsLvF2nfZGFX75q753kG8gg9OPNIkC6tsLUFDXY4tU
         SRVrgGszY9Xtfbs8ctsY+Pk4cbUczh8JQDbpkQj8vJahp881+YzWueeY71FS6SmM1kRq
         U6X4vdo2vjpWnzuxhR8zqBKCiIDWVt9SJL+v9sPH7tZC5sKJ3thcBGpxzMJKfbC3hu3v
         GmQVXEWQMtQMBDzjUp+hSJoxjYqlko6deE3LpqggQuW82BpeLVg+7jgsiv9QMIZIukft
         kg3w==
X-Gm-Message-State: AOAM530wJ7OCEplhNHDFVuXvRS5ABGy2CWPUS4lv6WFcBywA5roJMVj4
        XuAILPiuANjLeRa5SLbS1v/H435HnFxrEg==
X-Google-Smtp-Source: ABdhPJxi0lIdK4JVaa2+fhumO9Lfq0SxVfcosLXM5ZZC/Bj9pnh7ndhflLpHrBW0s2orI2rZ9RFgGg==
X-Received: by 2002:a7b:c198:: with SMTP id y24mr295911wmi.151.1606763677751;
        Mon, 30 Nov 2020 11:14:37 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id d3sm28690657wrr.2.2020.11.30.11.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:14:36 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH v2 0/2] implement timeout update
Date:   Mon, 30 Nov 2020 19:11:14 +0000
Message-Id: <cover.1606763415.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Timeout update is a IORING_OP_TIMEOUT_REMOVE request with timeout_flags
containing a new IORING_TIMEOUT_UPDATE flag. Even though naming may be
confusing, but update and remove are very similar both code and
functionality wise, so doesn't seem necessary to add a new opcode.

Updates don't support offsets, but I don't see a need either. Can
be implemented in the future by passing it in sqe->len.

v2: nits for [2/2] (Jens)

Pavel Begunkov (2):
  io_uring: restructure io_timeout_cancel()
  io_uring: add timeout update

 fs/io_uring.c                 | 93 +++++++++++++++++++++++++++--------
 include/uapi/linux/io_uring.h |  1 +
 2 files changed, 73 insertions(+), 21 deletions(-)

-- 
2.24.0

