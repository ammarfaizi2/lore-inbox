Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF061FC6194
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2B8217F4
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F9fxDCwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfKFXxP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:53:15 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41456 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKFXxP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 18:53:15 -0500
Received: by mail-pg1-f181.google.com with SMTP id h4so279889pgv.8
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Meh5vxfYr1NflhjDrTcwDcLSoTmidOfklYId46u5pAg=;
        b=F9fxDCwhIYQO1GtoJOTQ3X5zERTnjlrBTBrSLEYO6zaFwviBXaBUYq9Nq1yIPCwJo4
         rlV4g+cw/GxJeaeWS2ajz5ilOXX1OHnXLqkwAZy1EHbAKNq1I0DGVM+q2nb/TFScsjv4
         9PU1ks6TAfFPa4aQyPVGcs2MVlVhBaEnDxZsfedoBuTQAUyWptL0deMiRuLwEDh80KuV
         zljDY1fBKJFRceiru6YUb+VBVNgsVIxojGVbj1YDW8WuRKPf9vl+6lF+2PiKGiK81MvX
         sP242xtVEakhLRoPp5lMo3EhtMsXTIuUSmjtUegQiICvok4uPYvm8HzoZAn90InE/4pJ
         kwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Meh5vxfYr1NflhjDrTcwDcLSoTmidOfklYId46u5pAg=;
        b=iIOGqGZELI5B8+0JQj3B4gBBj9K1vVOMhQLQ72tIxH0H7kruDh017H7Ca0hdBUjyg5
         /Xs36ga1O5YgJ856CBLqTWcksLZ1FRDVMNRAnBLkDh1u/9DLyf8sgid0kfClWSpyM/dy
         LSI3XZCaUEwJ3lCw7d22ab/2p1DyPAWbUZRPoUsAptFKaPBS6ZGBS1VZFxX/lL/6hyK0
         oG9axWGmLtWzFU1rQFxL+Xp1S5IcPFO2XkWxnISacxYxc9fCZu2VxyU8bWm2tmUd8hha
         /t2v1/o/GeX7rKfjFIFX+W08dV2GgQ3vIlNnVABoiBtybzQ4JSGEL0KO4L2/WRw05Xic
         5eIw==
X-Gm-Message-State: APjAAAVV4dw/7pY+lOP/GENO+x25RJ+JpcrHB68mOCm3mzYGB2PciHWp
        4/pNfiaC1A2lKzLYQV/V1eD/0iD63ks=
X-Google-Smtp-Source: APXvYqztc+RlFRn7uf18lRbsZj4QcNjxb+vGy503ualpfk/4fKWg57p2aygF3Tlj0riwh2haVcgc9w==
X-Received: by 2002:a63:5960:: with SMTP id j32mr630409pgm.281.1573084392104;
        Wed, 06 Nov 2019 15:53:12 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x125sm109137pfb.93.2019.11.06.15.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:53:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com
Subject: [PATCHSET v2 0/3] io_uring CQ ring backpressure
Date:   Wed,  6 Nov 2019 16:53:04 -0700
Message-Id: <20191106235307.32196-1-axboe@kernel.dk>
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

Changes since v1:

- Drop the cqe_drop structure and allocation, simply use the io_kiocb
  for the overflow backlog
- Rebase on top of Pavel's series which made this cleaner
- Add prep patch for the fill/add CQ handler changes

 fs/io_uring.c                 | 203 +++++++++++++++++++++++-----------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 138 insertions(+), 66 deletions(-)

-- 
Jens Axboe


