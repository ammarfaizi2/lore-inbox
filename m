Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC61C43331
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC17721D7B
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cW07Huvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfKGQAu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:00:50 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:36661 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGQAu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 11:00:50 -0500
Received: by mail-il1-f172.google.com with SMTP id s75so2275501ilc.3
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWiaoxJzJr6AurYYp7FjIq/mWHaDg/ddtYufF1Rigrs=;
        b=cW07HuvuTNBCjd1dw+r4nhfKUYZFMAUscTgjvFNpgsR4tlvMnxh5tpIiirfT+32c1r
         U5cDlLXS+xCBuvpEUWuzJcEgPNztW3KKsPxpXiqINXIiC8idVUFz4Ouf/qn+DLjbZy9v
         VYKtPApPORJF1wRm8F4u+Ivx5ChD0OgjZl7tlnq+FY9Rc59VgL/QWVImXAD/1s23anw8
         v/+mEGc7Dktzxr3TwJz9L1mdPCGyELYGX4ADgZkDy7RH+KDiiQFGAcwPoXN7loiLHPCt
         qdST6ZzikfhhLXVKDt0DrWVhY61zYJ47DuTBC9OMeYnAW42KZ3e+g8Oix7Ip1XvtTqtZ
         eeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWiaoxJzJr6AurYYp7FjIq/mWHaDg/ddtYufF1Rigrs=;
        b=gHBtT3pRZkEHbzzZfBLl0CiCFRNlhdo86BW6FY9TfyTwn69RSS5iR48giff7tTmBNd
         N8nbSB/D6KPty0xvLkL8SJzYGOj5QVyup6mSSRjeEEsF17AfklXTvgVPiZcKRrIUQ28J
         utESM37MMVcl1EtgvWVQiYtG893+9dcPP8NjgLBMlAcVSCXq9Z1T5oY2Ys3nfapxuiFV
         SlHgutxEwNY+s4wP1dvB/JYIPuI82gh6ZD5bq/ZvResNve6xxQ3TfNbaWxxzY5ZtR6wD
         /odKcM6+MfvaPRQk8YaOgi95xaXiHaMFo8SDEKjHGXs2LAHddzdhG5HE00jenVfKduBY
         9LwQ==
X-Gm-Message-State: APjAAAVSkYnEKzzsfV20QX9Cd5FaKTbxm+w1nXDFS9915c/OdsraHqOl
        tQHO8PV6fo6r9lTSRDdl6DJsQDRysXE=
X-Google-Smtp-Source: APXvYqz+Vm4tBA37hhSWQC4GGytsxsYORfBP/94O7A3ETJXnXvD6mGP7Q/Ubg4Ka6iUhFJA7k773bg==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr5541669ilh.230.1573142447882;
        Thu, 07 Nov 2019 08:00:47 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v130sm210438iod.32.2019.11.07.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:00:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com
Subject: [PATCHSET v3 0/3] io_uring CQ ring backpressure
Date:   Thu,  7 Nov 2019 09:00:40 -0700
Message-Id: <20191107160043.31725-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we drop completion events, if the CQ ring is full. That's fine
for requests with bounded completion times, but it may make it harder to
use io_uring with networked IO where request completion times are
generally unbounded. Or with POLL, for example, which is also unbounded.

This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
for CQ ring overflows. First of all, it doesn't overflow the ring, it
simply stores backlog of completions that we weren't able to put into
the CQ ring. To prevent the backlog from growing indefinitely, if the
backlog is non-empty, we apply back pressure on IO submissions. Any
attempt to submit new IO with a non-empty backlog will get an -EBUSY
return from the kernel.

I think that makes for a pretty sane API in terms of how the application
can handle it. With CQ_NODROP enabled, we'll never drop a completion
event, but we'll also not allow submissions with a completion backlog.

Changes since v2:

- Add io_double_put_req() helper for the cases where we need to drop both
  the submit and complete reference. We didn't need this before as we
  could just free the request unconditionally, but we don't know if that's
  the case anymore if add/fill grabs a reference to it.
- Fix linked request dropping.

Changes since v1:

- Drop the cqe_drop structure and allocation, simply use the io_kiocb
  for the overflow backlog
- Rebase on top of Pavel's series which made this cleaner
- Add prep patch for the fill/add CQ handler changes

 fs/io_uring.c                 | 209 +++++++++++++++++++++++-----------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 143 insertions(+), 67 deletions(-)

-- 
Jens Axboe


