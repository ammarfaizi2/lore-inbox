Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C685FC433DB
	for <io-uring@archiver.kernel.org>; Tue, 23 Feb 2021 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE464DF0
	for <io-uring@archiver.kernel.org>; Tue, 23 Feb 2021 02:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBWCA2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhBWCA1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 22 Feb 2021 21:00:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB2C061574
        for <io-uring@vger.kernel.org>; Mon, 22 Feb 2021 17:59:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r3so9350934wro.9
        for <io-uring@vger.kernel.org>; Mon, 22 Feb 2021 17:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5ZGMGglatm1prTnw/5c6TNGhAX5Or/GAVXc+fWQr2k=;
        b=fcgKn+XBIn6nf5vUKW0d4YFyOdD90FDQSalOaSYUzOwlxIxgqEiH9sob7wRCVFyzKv
         tiLd2FdHfEqfnROCy8M9+lJnRdDx4e5g0H4Y2t6EuQwxMaO1jARxqv2ogT1A7m7YmKUa
         52BhIuzx7hLsB1xGoFA2B8tnajUDCRAnNifxhgvvy19UYfGGhFz5gIbA4OPDD01n2z1Y
         h//C4vnyTg78bS9R98zptNfFfoMjZi1liAI+zYVINUhq6NJ4d5c0YkECPl4F+ykF7Rn0
         Xo7N4dGyX2CDWS+GUtAj/tjb4b2Pi0jtE8g+HMxLcnroCLRvJhaWj9CWBIF6kEWZhBO/
         R1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5ZGMGglatm1prTnw/5c6TNGhAX5Or/GAVXc+fWQr2k=;
        b=i/cVCvUKa30DYupgHznf+LRTqT/vqh0+XOGyjJIYz3lOQ5UYtItq0i6dfIcq5txdoc
         liCFyqv3S7oiY3EGNf+i8yVLjfY/TR3MVyO3eHnsWPaF11t4eqDaIMMifiAtuOWOW7QV
         ZndRuu+oKxKa8r5/Rg872Ucneo3upH4hGbpn4ADUBcwBxA+qCaLzBJpvvxSwowSwQueg
         6M2gYIq++Run9TqMEs/+1t3JRUh/EPaE7yyBe3ry2IPc6QJvvbSpsF3kwBH2KZMKTvy6
         0aD98j6y5MtG6KcUZNrp7azV8NxGA9nbl0V5SB6oGMQoeuPKXYI2lx0JaiIJLNNleGN9
         Fc0w==
X-Gm-Message-State: AOAM530dCljoGqhXHhLhxTrZ1VpiiD7K6Y8yZuX8KhDxgyMDpkydY0H8
        J0w+jJXSjAWe+mKvXtPrwGQ=
X-Google-Smtp-Source: ABdhPJygHIkpDyNURUZPee+KBkBL6fXUOx6hi8sT5GfkQzNZq7bECG7yG88hk2MCuCScLO7hnT5GGA==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr24285845wrw.298.1614045585711;
        Mon, 22 Feb 2021 17:59:45 -0800 (PST)
Received: from localhost.localdomain ([148.252.132.56])
        by smtp.gmail.com with ESMTPSA id 4sm32425501wrr.27.2021.02.22.17.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:59:45 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH for-next 00/13] simple 5.13 cleanups
Date:   Tue, 23 Feb 2021 01:55:35 +0000
Message-Id: <cover.1614045169.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

1-8 are just random stuff
9-13 are leftovers after prep_async patches, further cleaning it up

Pavel Begunkov (13):
  io_uring: introduce a new helper for ctx quiesce
  io_uring: avoid taking ctx refs for task-cancel
  io_uring: reuse io_req_task_queue_fail()
  io_uring: further deduplicate file slot selection
  io_uring: add a helper failing not issued requests
  io_uring: refactor provide/remove buffer locking
  io_uring: don't restirct issue_flags for io_openat
  io_uring: use better types for cflags
  io_uring: refactor out send/recv async setup
  io_uring: untie alloc_async_data and needs_async_data
  io_uring: rethink def->needs_async_data
  io_uring: merge defer_prep() and prep_async()
  io_uring: simplify io_resubmit_prep()

 fs/io_uring.c | 262 +++++++++++++++++++-------------------------------
 1 file changed, 97 insertions(+), 165 deletions(-)

-- 
2.24.0

