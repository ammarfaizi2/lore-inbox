Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB44C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F9206E3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fyE7KE4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMVcM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:32:12 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:36921 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVcL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:32:11 -0500
Received: by mail-io1-f45.google.com with SMTP id 1so4311339iou.4
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+VCA9no/Ln2NNk2FWtJDPMM11nAYWPOAuLaSKJuSRE=;
        b=fyE7KE4jVov6vEUehoaXaCVtiI53cTFsY5U1jweRzoOldJf5CxFepX3zIkzDU6BFnh
         iDBhiR7izroIohvLg/o3Qi8WkBN8eXCRlisRn8q5CyKnicv6drxwpGO8nccudHaeELr+
         Z7pZpAiw2VhGT6J7fexsCbEi2LwFiuNxTvNTTLjTNaS54GUKeT47LjTzIChWIyRpwkYB
         Fg1Q00iU3/z1/IH1DKsygrNzN2tNT8cUoFHIK9Mlqn0xEla/R2yZ73abCQYpqmE0CI5g
         c/HtF02LQv8kK/E/P5ijYrZs5fEDGFy2M0s628WByu93BNNu+apaun2Z43tKCqQlYGEq
         rRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+VCA9no/Ln2NNk2FWtJDPMM11nAYWPOAuLaSKJuSRE=;
        b=HIER5x9lWag4eCLagHuse2JihNgQnneeX5VNjpdYKrNSxXch/7Ollld1+T6RgTYxc2
         oKGoM5zCw73JqNfvIbwmYTnURay2XVlMEViGPRv7Qpt9kKHk9w0TGdm5drZ8YZ7QgGkV
         0upk2Zc9YGU53U8/bVg1qH2fAll/XCXKzTnKc1BiTgteYHava+fAQZiiyAVXpqMaLBt/
         XSuPkWOIeNad+d+Fqp8o6995TJmQcHvRR6oebD/+NbkjDkeNnU9U55DJql1HCt7yqNjg
         f7j9rpnHtaJrfw7Q77pKbMdkecAkUuFWTnz0R5XlcS2al9mNzS8lBetsg9UldyRB9GJQ
         FSWA==
X-Gm-Message-State: APjAAAWdvS9dPVBaqhyehNNVF+1+aXrs+8Nfr6kwFaAT/s/9UU/gwiWE
        YBx4jR3JgEsrumRj1hH+JZEi5sNOlek=
X-Google-Smtp-Source: APXvYqwCV5mMhvjroL70trrDVmC+Lkd0peDym8B0r+Wq14NCfArS4Dnyyn/0eNuNZzEM41AalpbzXw==
X-Received: by 2002:a6b:b887:: with SMTP id i129mr5598913iof.231.1573680729102;
        Wed, 13 Nov 2019 13:32:09 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 6sm304872iov.45.2019.11.13.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:32:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     paulmck@kernel.org
Subject: [PATCHSET v2] Improve io_uring cancellations
Date:   Wed, 13 Nov 2019 14:32:03 -0700
Message-Id: <20191113213206.2415-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hot on the heels of v1, here's v2 of this patchset. Due to some
brainfart on my end, I forgot that we have the worker ref count
to prevent workers from going away. So we don't need the ->exiting
change from v1. The other two items were totally valid, however.
To summarize, they are:

- While the wqe->lock protects the stability of the worker->cur_work
  pointer, it does NOT stabilize the actual work item. For cancelling
  specific work, io_uring needs to dereference it to see if it matches.

- We're not consistent in comparing worker->cur_work and sending a
  signal to cancel it.

These three patches fix the above issues. The first is a prep patch that
adds referencing of work items, which makes it safe to dereference
->cur_work if we ensure that ->cur_work itself is stable. The second
closes the hole that currently exists with signaling specific work for
cancellation, and the last one closes a tiny hole where we might miss a
worker during list iteration.

Changes since v1:
- Get rid of ->exiting, we don't need it
- Add third patch on closing list iteration hole

 fs/io-wq.c    | 113 +++++++++++++++++++++++++++-----------------------
 fs/io-wq.h    |   7 +++-
 fs/io_uring.c |  17 +++++++-
 3 files changed, 84 insertions(+), 53 deletions(-)

-- 
Jens Axboe



