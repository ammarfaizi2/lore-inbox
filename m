Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69E4C432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E8020674
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uQTEfzUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCCyx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:54:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39375 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLCCyx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 21:54:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so1040958plk.6
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okXYS9Bvzgs6w0Dl8MEYitY5Gk4Jf55fV8EJ0S99mYk=;
        b=uQTEfzUKrmZfCfXBU4Squ5ngO8Q4AO9s5u7QfXyQHlni5gFSb5W6SOm3YSH85Rcc2L
         8N+759G1zbT0NaXR3N/wuGEDzsDrRoIsbQbwz3IY0uudThdJN1r5MM8njEaI84SbmX4r
         kCRCazugKkro0oOJBWgrSiDxeFkd8HD1yc2egWTmiKC8B3dYWJHhEGUEeMscfA86BxZ6
         7Nomld/a6/r9BPZQUhNOrk9NE2saFbRnpWsZ8v8BTiiLySNULUIWDz9Qbm2XOvf6EkrO
         Dd5axIq/jntit1ZzBv05XB/Nrli7bpNRmy7Hzs+DJrxYXWFuRKmNu/3E3sQDkz7JsXtu
         YOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okXYS9Bvzgs6w0Dl8MEYitY5Gk4Jf55fV8EJ0S99mYk=;
        b=qAtB5cOSjCfwVMBWfSm9wOOl5UvFv6eXtUcGLi2M9bSFp5JpC2kOC5LP+DH3tN9Dm+
         izvZN+3ApboTDb7DHMknvxFvrpNQbMr6qQ3soLWFEk+2KZ5cb/N4c1+c2Jyi51UGvQaH
         tZnP7moZDt+wWwYc98jTwoRCbBEhPDFFeFkh6k9wed+0V9XlnbcULYnJ+61+1D0Z4CrT
         v7ImU0Cu2zjDdDuk0ZtHeTQ61qmsSq7dR6+NcVIyVYrTtS1H4i756wF3kADKnX12VDl/
         puSRAqeaFXB4FtTNmYvF5wcEL7T5mJK59Q/5GPhpLnFF6o7S8t3IX7hT01txzNJY/+L3
         dtPg==
X-Gm-Message-State: APjAAAVSBKuwc8sM0STQInBQHHIo2CMYubeXSDnu/61eusbf/Hl5Gp52
        U+CiHAdfeaAx5ycoDPrm/qjiMEsKDkx3Pw==
X-Google-Smtp-Source: APXvYqwmWGPRZNRdCaUznRAQan1sro8jF5CWj9fHVgEnXWVTRwaZIU9uJb2vJnvCfO5LER4iKD+r6g==
X-Received: by 2002:a17:902:7286:: with SMTP id d6mr2856270pll.59.1575341692139;
        Mon, 02 Dec 2019 18:54:52 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z7sm959364pfk.41.2019.12.02.18.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 18:54:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     netdev@vger.kernel.org
Subject: [PATCHSET v2 0/5] io_uring: ensure all needed read/write data is stable
Date:   Mon,  2 Dec 2019 19:54:39 -0700
Message-Id: <20191203025444.29344-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we don't copy the associated iovecs when we punt to async
context, and this can prove problematic if the caller only ensures
the iovec is valid for the submission. This is a perfectly valid
assumption, and I think io_uring should make sure that this is safe
to do.

First patch is a prep patch, the following patches add support for
the various opcodes that need it.

Also see: https://github.com/axboe/liburing/issues/27

 fs/io_uring.c                 | 466 ++++++++++++++++++++++++++--------
 include/linux/socket.h        |  20 +-
 include/uapi/linux/io_uring.h |   1 +
 net/socket.c                  |  76 ++----
 4 files changed, 406 insertions(+), 157 deletions(-)

Changes since v1:

- Get rid of REQ_F_PREPPED, just use req->io
- Add sendmsg/recvmsg and connect
- Add IORING_FEAT_SUBMIT_STABLE to userspace can tell kernels with this
  "feature" apart from older ones

-- 
Jens Axboe


