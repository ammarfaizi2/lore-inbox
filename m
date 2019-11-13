Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A6DC432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A131206EC
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VJLaxljG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKMToA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:44:00 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:32978 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfKMTn7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 14:43:59 -0500
Received: by mail-il1-f181.google.com with SMTP id m5so2948182ilq.0
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1gIE5pObmaB9nKbwRpxfYUGdFYC18JPT+HArca8CK88=;
        b=VJLaxljGZ+mW5mrrIVCpCJBGnuIA59nkOmOA5cv/uRGBmHXbINcNxESIixIxPXYHvN
         UrLBIv038ZjSwe/grAlMVNYBBi2TVdF1ocCmFg3bI4rYeevbWbJ7qDCY/p0lWqit+tqz
         iNS3fMesncG01ohKMJ25DZ0qbp6uzFLRI/DaS8EPqYv4Lqe9nIBQG3qDnk96Gzvri3am
         rNcYJGf1k6vmCaBRpMhNsJfAw7JwGwH/Vz9+hSuVtxNajLUbt6WeWeQ5/xibgScG4ljG
         jjPYaidC+Hb8YGayTKZfskitIdzX3kvI15w2D9CAPnRjdsBvZLGVCCN1yrvrSUOYL6Dj
         /PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1gIE5pObmaB9nKbwRpxfYUGdFYC18JPT+HArca8CK88=;
        b=WObQ7RErklPv8s0l76TI5ome69ScZsqr60+MpUXPaFT/vdU6uBRkOa8oZUQwLm7gO0
         cvv5rxstFZrHI1xh9TN8jTRfYTDgcIzMA1biaK4pOiMzGLXUV5bgV/pjELvuWA32nvHN
         m77/nhOlFSiuu+sHGDNYxP4KVt5OaLSeZAMsxcWrYCxrlMnRhv5nDIJ78YI1Ijjeg8zo
         2e0sWmPIOrdzoLjfZIvkG+QgGbReTIMDIyj//YExcg8b+yWK2LF7xU5cjLcmi02kJ4Ts
         MonjqPou+eNBl9479mQ+/a+T0MOswIfTn1j7ZpkMsPV7Dov2zoQDeHH7sZs1mJCic9FE
         yUlA==
X-Gm-Message-State: APjAAAXgwuCw53ODxfMo9ZgPkvn+pg8pELYtDe45M1NLrCPSC13BBeF7
        +Pk3yWIhO9njWgdVfA+ALN1IZhofx2A=
X-Google-Smtp-Source: APXvYqx2Oac273WiSGWZOUTZqwLYgEXkZWW/IGh8aWwpGjucSNZ6yEi8yxncFRlqjzIwAjkEfFmN+Q==
X-Received: by 2002:a92:a189:: with SMTP id b9mr6179439ill.259.1573674238541;
        Wed, 13 Nov 2019 11:43:58 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p2sm295812iod.39.2019.11.13.11.43.57
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 11:43:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET] Improve io_uring cancellations
Date:   Wed, 13 Nov 2019 12:43:53 -0700
Message-Id: <20191113194355.12107-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We have a few issues currently:

- While the wqe->lock protects the stability of the worker->cur_work
  pointer, it does NOT stabilize the actual work item. For cancelling
  specific work, io_uring needs to dereference it to see if it matches.

- While we know the worker structure won't go away under the RCU read
  lock, the worker might exit. It's not safe to wake up or signal this
  process without ensuring it's still alive.

- We're not consistent in comparing worker->cur_work and sending a
  signal to cancel it.

These two patches fix the above issues. The first is a prep patch that
adds referencing of work items, which makes it safe to dereference
->cur_work if we ensure that ->cur_work itself is stable. The other
patch reworks how we ensure that tasks are alive for signaling, and
that we have a consistent view of ->cur_work while sending a signal.

We add a new lock for ->cur_work, as we cannot safely use wqe->lock
for this. See comment in patch 2 on signalfd usage.

 fs/io-wq.c    | 91 +++++++++++++++++++++++++++++++++++++--------------
 fs/io-wq.h    |  7 +++-
 fs/io_uring.c | 17 +++++++++-
 3 files changed, 89 insertions(+), 26 deletions(-)

-- 
Jens Axboe


