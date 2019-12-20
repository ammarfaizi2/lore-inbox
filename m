Return-Path: <SRS0=7ph7=2K=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB5C43603
	for <io-uring@archiver.kernel.org>; Fri, 20 Dec 2019 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E6206CB
	for <io-uring@archiver.kernel.org>; Fri, 20 Dec 2019 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jm2nNHTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLTRrp (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:47:45 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:33586 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLTRrp (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 20 Dec 2019 12:47:45 -0500
Received: by mail-io1-f46.google.com with SMTP id z8so10232391ioh.0
        for <io-uring@vger.kernel.org>; Fri, 20 Dec 2019 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fsz/ZdUQaVrZT265+oslwY0r8Fpjk524GUuiIsvk1hY=;
        b=Jm2nNHThFETvk44lg0txT6vGI35hRO8Zs5tu03lelPmSzFt1BrIqs4aId/3qlvgF5a
         53071DX20M4woENOz7UuEtZDlAtRGS++f0BmVik2JfqjpTg4jIhTjWiZ0DaQZaoV1Kr+
         xki4IO7u2UXGVnEeWcgRE5osMfvovOmMiDKVw+mPFtkjJUKqjgKv1EScyatkUlDA8gTA
         hZ4WTk2Id8R5QPpFLdXVpragnzomWG3WwxuktvM7p319x9Ks1Py1j2gRyD/pxq8cbJxe
         lA6isujEaGss0aTVTVS8GxUkQFjLGYoj9dr1ExwKJvBl+5X5gHomSaaz0DMGSmjhQA5M
         KGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fsz/ZdUQaVrZT265+oslwY0r8Fpjk524GUuiIsvk1hY=;
        b=nkxU5IPuTnik6MIASVYB8xrIP7UQDA3sj0jlC4h8NsaREjVa7jEJHL0pFI9YpYdetk
         6nfUuNZVaIs9eBVFh62T9NRbvF4gPyG1vll5BFTICSzG7UlQmJGshvVkbfNMXueGRwwo
         vSjQyCCOfCtaxyiN/1EIxZhhceJjg8CcDkp5lmaf8JJ5tE23KAIaHYrGJluDSNLKhae7
         bK803O4J+/4HxyfhcjyHxhbqY5J5DCLSHZ4eKrdtmv732tvCqm4k7wm2XxN0qz8fZacQ
         nZeqvPbCSVSHhn1q570Y+/NPUUIfeZr3HgqiJjm1jzEX7LW8Uu4n3SolUA4I5GlvWfmD
         tXKA==
X-Gm-Message-State: APjAAAUIOZOr8TXPZLplUyG+Yq6h+EGg1KGVA4N6CU0713aTjK5UrDSM
        eK5MiDgNY7D3d0qYjcHrcHbgC0JmgRElIQ==
X-Google-Smtp-Source: APXvYqynUvd2ttzEYC3zH8TNd0e4oVXlwJVoiMe0IcP+XDQncK8fywr1OX46fSDc26SgzyYDe9jSkw==
X-Received: by 2002:a02:c7c2:: with SMTP id s2mr1891592jao.16.1576864064362;
        Fri, 20 Dec 2019 09:47:44 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j88sm4969677ilf.83.2019.12.20.09.47.43
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 09:47:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET] Cleanup io_uring sqe handling
Date:   Fri, 20 Dec 2019 10:47:35 -0700
Message-Id: <20191220174742.7449-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This series contains some prep work, then two patches that once and for
all cleanup the sqe handling. After this patchset, the prep and issue
handling is fully split, so each opcode has a prep handler that is called
in the same way, and an issue handler that doesn't call the prep handler.

The sqe pointer is removed from io_kiocb, so there cannot be any
accidental dereference after we've done prep. Prep is always done in the
original context, so we can have no reuse issues either.

I've rebased for-5.6/io_uring to have this series first, so this series
applies on top of io_uring-5.5. Ideally we'd put this into 5.5, but...

In any case, please take a look, I think this is a massive improvement
in terms of verifying that we're doing the right thing.

 fs/io_uring.c | 690 ++++++++++++++++++++++++++------------------------
 1 file changed, 355 insertions(+), 335 deletions(-)

-- 
Jens Axboe


