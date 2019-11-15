Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9FCC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E6820732
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y73XatIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKOTkv (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:40:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37274 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKOTku (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 14:40:50 -0500
Received: by mail-io1-f66.google.com with SMTP id 1so11692891iou.4
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KWd4WvqIdKsuAtcf7EW7UDGGZSRzre1Mwnulmg9/DNk=;
        b=Y73XatIwQh/W/d2aW41Dg2huXRboeVadqyLAEwKcuwVeU9Rx0S7qngTxBPH0XXis03
         Vm9eHtTJopw/XjxKEsTIC8tYdBDVhhEb7y5Eg+hUi4BjqrPzRbjUUODvmD1RzWN0T2IB
         ZI7yv7g/zYIfpdMKTPlux19I0EVlbMt6N3tY9DIuUulhBXrLyTSScxhCdzZ+u6Z2roHq
         Mg82Jfq/mT55plYz/ZUy9rnaIo+07GCC7kCqTpWceTrdJlObWms0AX9zlgtJsXZFVwil
         leU/F2I7Onxv1Jm+cpKeoDtOwY7ntuLLOs1I7hF56GtaCu+NK1sIolvG2KnpAFkBUOWe
         aKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KWd4WvqIdKsuAtcf7EW7UDGGZSRzre1Mwnulmg9/DNk=;
        b=WSPgUYvRVLauhuZL2ZfZwnS7Q7nqimZDOYtlOsBI5OO5+0bxqjMr4Gr2DK8HmpRU8z
         AygO9j4z5nFGNeVRgs/z9mGFyjQ36gj5xlca83V48TmnujAwMqtc4dAnPYSAUKz8yLLY
         PX9BKECzrc/i6+QAEW2Lxiu4tuoVgRUW5XGH4NqTD69DF9bebrqi/49UptD5ZKNzNijq
         nVatofD1cNOO1BEZTBPB/z50aURXn3Rh7Wi7/ZLSc8CqPsFkCU6teVLiB1bI1Me3bhwA
         +vTE8ER5jikwMpPfdwAtNFF2FuicoM9rUxWzEkC8v7oLTg9XpKjsc4b5QgrHa2ZS32W9
         FC6g==
X-Gm-Message-State: APjAAAVY9013VsqyFcd1WbPb5wIwBaIZA01RckVKxfULuhGFx1JO8HG2
        gG+uiRU0I+zvFSjllbDJI4t6S298lt8=
X-Google-Smtp-Source: APXvYqzx18IX/DyVN6h9/vjvNNa+JaKbDk2F/5LOqHLAdObhk5QnTiJpy0GW6JVUTWLnuPNQ8O/uIQ==
X-Received: by 2002:a05:6638:a27:: with SMTP id 7mr2168776jao.114.1573846849366;
        Fri, 15 Nov 2019 11:40:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k199sm1827239ilk.20.2019.11.15.11.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 11:40:48 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Fixes for 5.4-rc8/final
Message-ID: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
Date:   Fri, 15 Nov 2019 12:40:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Linus,

We have a few fixes that should make it into this release. This pull
request contains:

- io_uring:
	- The timeout command assumes sequence == 0 means that we want
	  one completion, but this kind of overloading is unfortunate as
	  it prevents users from doing a pure time based wait. Since
	  this operation was introduced in this cycle, let's correct it
	  now, while we can. (me)
	- One-liner to fix an issue with dependent links and fixed
	  buffer reads. The actual IO completed fine, but the link got
	  severed since we stored the wrong expected value. (me)
	- Add TIMEOUT to list of opcodes that don't need a file. (Pavel)

- rsxx missing workqueue destry calls. Old bug. (Chuhong)

- Fix blk-iocost active list check (Jiufei)

- Fix impossible-to-hit overflow merge condition, that still hit some
  folks very rarely (Junichi)

- Fix bfq hang issue from 5.3. This didn't get marked for stable, but
  will go into stable post this merge (Paolo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191115


----------------------------------------------------------------
Chuhong Yuan (1):
      rsxx: add missed destroy_workqueue calls in remove

Jens Axboe (2):
      io_uring: make timeout sequence == 0 mean no sequence
      io_uring: ensure registered buffer import returns the IO length

Jiufei Xue (1):
      iocost: check active_list of all the ancestors in iocg_activate()

Junichi Nomura (1):
      block: check bi_size overflow before merge

Paolo Valente (1):
      block, bfq: deschedule empty bfq_queues not referred by any process

Pavel Begunkov (1):
      io_uring: Fix getting file for timeout

 block/bfq-iosched.c       | 32 ++++++++++++++++++++++++++------
 block/bio.c               |  2 +-
 block/blk-iocost.c        |  8 ++++++--
 drivers/block/rsxx/core.c |  2 ++
 fs/io_uring.c             | 32 ++++++++++++++++++++++++--------
 5 files changed, 59 insertions(+), 17 deletions(-)

-- 
Jens Axboe

