Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4069C4338F
	for <io-uring@archiver.kernel.org>; Tue, 24 Aug 2021 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AC661183
	for <io-uring@archiver.kernel.org>; Tue, 24 Aug 2021 11:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhHXLkw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbhHXLkv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 24 Aug 2021 07:40:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7343C061757
        for <io-uring@vger.kernel.org>; Tue, 24 Aug 2021 04:40:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e5so14272939wrp.8
        for <io-uring@vger.kernel.org>; Tue, 24 Aug 2021 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7PyGAzAJuKhGw/TYKWtTH96kyhMBO6CK3yNDbDLG1c=;
        b=uXsXjQS6JAYlaADXRYCBBuCaoCtR7V9dYJcbuttrT3ryxIW6y3K4Yv2J3Xwgf7N0FI
         dUN/9HyskA+pBXn/Hm7GCBul7BYAR37/0oxXpGy3v/kNxldSVC5EoODCmW4FoiX4y2Gh
         FKKQxPk1kbw26QNFA/XaJc4YTXGnh72Bk0JZGmkNJ7ECdJ27stocTu7Q8XL4eFGB+zNn
         PqPtq1lGCZ67z20u5NaijTQ3iGQSznDI0Ba4G+ehBZL0lZXGzhThyqFpdvntCUmy5NzB
         bEjWK81BBhILeSr6E1hIbW7Xwr7Dx6AkaUR+/TFR3g4vArvBow9jatPdCaO+/7v7a6vu
         nEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7PyGAzAJuKhGw/TYKWtTH96kyhMBO6CK3yNDbDLG1c=;
        b=KbeKHeTN1SCo314cP7soK9URR+mALCVfOV1gLxSVeJnkL9m+bPZaBoC4MFx5BD5+AN
         jx78pF+jurCw6EK7W7KB3PNGiaMivc60XMFq6ikVlTmKi+g4nvtBiexwxAPiUOxebMUw
         x7nO9URQQ+FovPng3f6M4fKO9q0kxRolFYEqN03wxyUiId0AAZH4Z8qsdLzqH1NU+byx
         ts7PsFlXoK19/G7ARPfd21XnKfUicbX0hAjgOtxyfLMIcrxfl+a7HTOsLXdh7+YO9LUo
         rZrW0s8jQX/5C3z7sWRl2XRqc3bD1Vv8Trz5f3deliFirtE3lRRtg5f2eCDlsGl2Lefe
         za3g==
X-Gm-Message-State: AOAM530KM5Esd3WE+uf7Wm/xIn7e+BxYrsJI9/f9kiNUL2i0Dx50eSha
        8rOhucKLg7+rNo0fU0YZ6u4=
X-Google-Smtp-Source: ABdhPJwnbuCUqvtp4795CH2ZmKbQ9AR6DMWHzVrUYz9f+HdCr/G5vKDr+ENWjIChlEGp7vWJOgpLfQ==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr14043401wrq.147.1629805205422;
        Tue, 24 Aug 2021 04:40:05 -0700 (PDT)
Received: from localhost.localdomain ([85.255.232.113])
        by smtp.gmail.com with ESMTPSA id m4sm2126869wml.28.2021.08.24.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:40:04 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH liburing 0/2] non-privileged tests
Date:   Tue, 24 Aug 2021 12:39:26 +0100
Message-Id: <cover.1629805109.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Two more fixes making it work (partially) with non-privileged users.

Pavel Begunkov (2):
  tests: non-privileged defer test
  tests: non-privileged io_uring_enter

 test/defer.c          | 39 +++++++++++++++++++--------------------
 test/io_uring_enter.c |  3 +++
 2 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.32.0

