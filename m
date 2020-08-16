Return-Path: <SRS0=xRDk=B2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E52C433E1
	for <io-uring@archiver.kernel.org>; Sun, 16 Aug 2020 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9E320708
	for <io-uring@archiver.kernel.org>; Sun, 16 Aug 2020 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lnZ4ysom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgHPMWT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgHPMWN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 16 Aug 2020 08:22:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D53C061786
        for <io-uring@vger.kernel.org>; Sun, 16 Aug 2020 05:22:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so6813757pfh.3
        for <io-uring@vger.kernel.org>; Sun, 16 Aug 2020 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JiyQ0hn30lqOvJM/11zRcWta3YTwWRdZptnKCK7iwBM=;
        b=lnZ4ysom0mqu5MpA/BUZirTsvxQ6LDK3pBXy9TnUdYnNAKPENV/i9h3MUtvJyouSGR
         i7BZGOejlKqVyD/LFrPvz+ZPaa/1hmznIkHanjuCuu8kZCW42qSYieVP2aVSgOd0kQGY
         J8wq5fVRDJiXubw0L8FpNzldeTJRSqa1+6dxF1z3wgDz2HUjDWOpN4oQQ0I4Y6hEcRn1
         M/NRp1pzwAc01464TNzSz06zfhSEJvfrJIT6PhrX88dH8DITzDcfhXPw7Ww/p5eFn9G+
         kPACAhRkaHUh38sL9y9Sdh/3rTQnR/QDy47RQ87Hxatek5TNoWzm2GM+9DcimplHV5L2
         DNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JiyQ0hn30lqOvJM/11zRcWta3YTwWRdZptnKCK7iwBM=;
        b=SoI5PDTa+DGHLYx6ilHV5aIptDvxKp/6SJHi+uN2F/7JsT0IxGRsK+SwN+mrGZ08C+
         ZzruFVimgBQpA8sT7L9U8JucyUnUsHU9SjWgQny3qHJKM1SN6GZ3PEazkvRZ1CKgQ2ou
         IELTUGcyJkqu9peviYDvq8z9KsrSBT4cf0hxUExll6LH5tJDaCM/Uvi/C3Iu5vFKGHqm
         Uyau9625BkkG4C15fhSQQG/UmItGuIAx0uC+78NL6BXiV+UkXWl6V3S6baadRWMQ9m9y
         JE6q5OwaDWi40pEEjj6ONoui3KgRYNLzekS71NHdzexNWehh2KqN5uG/eOyNpJVykA8W
         SMzA==
X-Gm-Message-State: AOAM530qPneS1zoOKRSXu8aAuSCnjxqefdzn6Ey6HgRMeMPsSYofoZOx
        cEC4E0iAcQZmsIosG9+eSuOVOw==
X-Google-Smtp-Source: ABdhPJwLRmFR2xE68+0VS0RTzj2P6F8SubmURo0FhsSur3WgNEKARmK//UKbNZ7IlXsaF9Hxpm77/g==
X-Received: by 2002:a62:52d6:: with SMTP id g205mr8163291pfb.144.1597580531195;
        Sun, 16 Aug 2020 05:22:11 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:80d9:87c:7a0f:8256? ([2605:e000:100e:8c61:80d9:87c:7a0f:8256])
        by smtp.gmail.com with ESMTPSA id b20sm15294245pfo.88.2020.08.16.05.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 05:22:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final io_uring changes for 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <32d4a5ea-514f-cb79-94ff-83b0c4e1d47b@kernel.dk>
Date:   Sun, 16 Aug 2020 05:22:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Linus,

A few differerent things in here. Seems like syzbot got some more
io_uring bits wired up, and we got a handful of reports and the
associated fixes are in here. General fixes too, and a lot of them
marked for stable. Lastly, a bit of fallout from the async buffered
reads, where we now more easily trigger short reads. Some applications
don't really like that, so the io_read() code now handles short reads
internally, and got a cleanup along the way so that it's now easier to
read (and documented). We're now passing tests that failed with current
-git.

In detail:

- Fail read/writes if no ->read/write or iter based versions exist.
  (Guoyu)

- Cleanups based on the wait_on_page_bit_common() rewrite

- Add comments explaining the task_work based flow

- Use TWA_SIGNAL for everything. This comes with a fix from Oleg that
  ensures that repeated task_work_add(..., TWA_SIGNAL) isn't overly
  expensive. The 5.8 eventfd fix that drove the addition of TWA_SIGNAL
  has counterparts that can trigger without eventfd, so this removes the
  eventfd check and just does it unconditionally. Thanks to Peter
  Zijlstra, Oleg Nesterov, and Jann Horn for helping get this done.

- syzbot related fixes:
	- Recursive locking for overflows with links
	- File table dropping fix
	- Hold 'ctx' ref around task_work
	- Double poll issue

- Netty implementation found two bugs, fixes:
	- Enable cancellation of 'head' link of file table grabbing
	  requests 
	- TWA_SIGNAL change

- Fix a regression with RWF_NOWAIT now triggering read-ahead, whereas
  before it did not.

- Handling of short page cache reads, by cleaning up io_read() and
  having the iov_iter be persistent across retries. As a nice side
  effect, this is also more efficient internally, and now io_read() has
  a codeflow that is actually readable. Similarly, having a persistent
  struct iov_iter instead of maintaining separate state is a lot less
  error prone too, and eliminates magic storing/restoring of said state.
  Thanks a lot to Andres Freund for diligently testing this change.

Please pull!


The following changes since commit e4cbce4d131753eca271d9d67f58c6377f27ad21:

  Merge tag 'sched-core-2020-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-08-03 14:58:38 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-15

for you to fetch changes up to f91daf565b0e272a33bd3fcd19eaebd331c5cffd:

  io_uring: short circuit -EAGAIN for blocking read attempt (2020-08-15 15:58:42 -0700)

----------------------------------------------------------------
io_uring-5.9-2020-08-15

----------------------------------------------------------------
Guoyu Huang (1):
      io_uring: Fix NULL pointer dereference in loop_rw_iter()

Jens Axboe (17):
      io_uring: io_async_buf_func() need not test page bit
      io_uring: add comments on how the async buffered read retry works
      io_uring: set ctx sq/cq entry count earlier
      io_uring: account locked memory before potential error case
      io_uring: use TWA_SIGNAL for task_work uncondtionally
      io_uring: fix recursive completion locking on oveflow flush
      io_uring: add missing REQ_F_COMP_LOCKED for nested requests
      io_uring: defer file table grabbing request cleanup for locked requests
      fs: RWF_NOWAIT should imply IOCB_NOIO
      io_uring: hold 'ctx' reference around task_work queue + execute
      io_uring: fail poll arm on queue proc failure
      io_uring: enable lookup of links holding inflight files
      task_work: only grab task signal lock when needed
      io_uring: retain iov_iter state over io_read/io_write calls
      io_uring: internally retry short reads
      io_uring: sanitize double poll handling
      io_uring: short circuit -EAGAIN for blocking read attempt

 fs/io_uring.c      | 539 ++++++++++++++++++++++++++++++++++++++---------------
 include/linux/fs.h |   2 +-
 kernel/signal.c    |  16 +-
 kernel/task_work.c |   8 +-
 4 files changed, 409 insertions(+), 156 deletions(-)

-- 
Jens Axboe

