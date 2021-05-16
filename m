Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03CCC433ED
	for <io-uring@archiver.kernel.org>; Sun, 16 May 2021 21:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8C36115C
	for <io-uring@archiver.kernel.org>; Sun, 16 May 2021 21:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEPV7n (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 16 May 2021 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEPV7n (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 16 May 2021 17:59:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41CC061573
        for <io-uring@vger.kernel.org>; Sun, 16 May 2021 14:58:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4432339wmc.1
        for <io-uring@vger.kernel.org>; Sun, 16 May 2021 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nX4+Pa8vr9R7lj/OPtdSpE9tHKTP4HE0j1ukObbyoag=;
        b=EbCPjUCUwvY3QlRHCLtSU8a+7SXcZBFmwitvkAt9wh/sWEVKMFU+mfnAoO1Gyv53kj
         4F+7oSqm8hxbrWZ9jNKgZx8QuOJsxFp8v917uXVJBubwId3g3WOixItbjZei2JHs7/B+
         r88nzaH8qYxqbSgcAEpbcNV3E9hC+saCJvCCl8Tx5CV9OKQuzdjHfFXn2SbNyEuN3Aw0
         S3G1bdIi0fwToBhacluFOpPOqn12C7zYm95wGwzkBdRU40ofrrveRiDzIAsE1n6d5+5T
         GocXo2e2DjZeyiDd4/GHjCQEfUQ+J1g1le2W12GBUxG4NIC4dROPbqXHS3rQvEM+pvoU
         NO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nX4+Pa8vr9R7lj/OPtdSpE9tHKTP4HE0j1ukObbyoag=;
        b=sRWUz+t43lT6Lg71RZcByuXvRlY2v1lRSSN0okfYM63Aldf2RlVwW2ehofrwP7TJmG
         JNG2wTDYbMwwk9HjO5/641V9f1SWyPLtfZMJzLpO9GHIOj49fumimrdMImoWG+QeCoHB
         9v7PqNXO0L5UDdqbJvxr6+32OWU4pPjnx1Z4Id3Wt5Dot+Kaftj0AVp/vuRCmKlrUuJ6
         nOOBku8sN/RhfuTRXWM/Mysyib9uFyBDtrFu/E6WUb0pC+1OYU6YElgN+w2BKb709yYQ
         zLoVNJ1Wr01+IUecUFPu26WUybpLsjc05Cb56P9Nlaqy0iYznZugM7zAPzJ3g3jB74D/
         Rlcw==
X-Gm-Message-State: AOAM532NCUM35d9MyzK2YkxV3/SvYu7MldBNgkSglIfOyPVjJsiL0Utf
        Zz6NmLspZS7YG8surBsCC8BCoy2pcdg=
X-Google-Smtp-Source: ABdhPJwlVn+hUOkU7HqjpdnqKw0URv+wBN9V46KMUF+mN7TikShlYWpCrlFrCCFhrbik7Zm8pipf1g==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr6047989wmq.164.1621202305570;
        Sun, 16 May 2021 14:58:25 -0700 (PDT)
Received: from localhost.localdomain ([148.252.128.7])
        by smtp.gmail.com with ESMTPSA id p10sm13666365wmq.14.2021.05.16.14.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 14:58:25 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH for-next 00/13] 5.14 cleanups
Date:   Sun, 16 May 2021 22:57:59 +0100
Message-Id: <cover.1621201931.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Various cleanups and resends of lost ones. Some are a bit bigger
due to find/replace.

7-13 are about optimising CPU caches use and things related.

Pavel Begunkov (13):
  io_uring: improve sqpoll event/state handling
  io_uring: improve sq_thread waiting check
  io_uring: remove unused park_task_work
  io_uring: simplify waking sqo_sq_wait
  io_uring: get rid of files in exit cancel
  io_uring: make fail flag not link specific
  io_uring: shuffle rarely used ctx fields
  io_uring: better locality for rsrc fields
  io_uring: remove dependency on ring->sq/cq_entries
  io_uring: deduce cq_mask from cq_entries
  io_uring: kill cached_cq_overflow
  io_uring: rename io_get_cqring
  io_uring: don't bounce submit_state cachelines

 fs/io_uring.c | 343 +++++++++++++++++++++++++-------------------------
 1 file changed, 171 insertions(+), 172 deletions(-)

-- 
2.31.1

