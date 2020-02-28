Return-Path: <SRS0=enxk=4Q=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE2C3F2CF
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCDB222C2
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 07:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPqwCQ0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB1Hhf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:37:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40213 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1Hhf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 28 Feb 2020 02:37:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id d138so513521wmd.5
        for <io-uring@vger.kernel.org>; Thu, 27 Feb 2020 23:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gF45BYLB9ceh5G9c8Z2yJ5iVK4ezA8ynxM/533/3s8=;
        b=oPqwCQ0L+epHuS1V0HUrOymE1w5EOoo3pW4k/XJ8YpUfVv3IBsSGzmemyp9lbtxGt6
         iTuRX2t63q+ONVdBzROR1lTdTLGeIyWZMJGbU8qE6eqGLCVC2oD10rOWAcMCX+CR6Jgl
         jdy/NzXGwKh7sKU4tLyeIjjagRQjUlYiHw206WnJ7fyRAD/c/AXzdgCY/wWyzFDu+SxQ
         UHCEuPwROMCbXgj48eivn02TD9GSS2Zj+bwgQBZgLSaFb0CEj3aZx3WskEyj3QNqag95
         0eWU7AwDFmN+lZ0HES5cSKjhJ18vyzfYmmwNyXOyR1tlFc0MNT+VE/bIqpIIu7VKduIM
         EdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gF45BYLB9ceh5G9c8Z2yJ5iVK4ezA8ynxM/533/3s8=;
        b=P6Gxko1KaQGzbsCKBXUMgxIhENqRj/ukgEkzGNg6/XZ2S63DEDM77jL0RprMJkbBpn
         NaSmlWLJopSC80bE+ZYL1h4aWwM/KHPrBNyw4jq2hx98F8M87noEcsIwewQg8VMOn5P0
         FWJezz6zhx1iOmuEML3Mc/61xt2rfUnXUscEBbV1axO2sd4RDR97Pg+lFIK8w1JHxf6p
         dvZjvj5bUaSu5gNZKzrQvObqLPMLHqQ13urARVBDSVI1V5j696YvHa336b8PpvG6vCje
         vzwcvulfOHCGFyyfI3XU5wE2rO7hAolg/QI2vtqzfkLEuS6OEsYc/Jdv1SpeL704qqtZ
         58Dg==
X-Gm-Message-State: APjAAAVVb5cIJ7B3YHxLxwT54GjhymddO7Klkk3uBqCKw5GtGuz8esyv
        2luJMV8BxzatjtAmQz5h9G2DgLdl
X-Google-Smtp-Source: APXvYqxE4WhZTrjZvIXXqrdPy8t1MpP+NWCah08EBE1iOpXwAXXPjubWZndRewuC27oRccUwq66dXA==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr3370127wme.75.1582875453282;
        Thu, 27 Feb 2020 23:37:33 -0800 (PST)
Received: from localhost.localdomain ([109.126.130.242])
        by smtp.gmail.com with ESMTPSA id h2sm11369425wrt.45.2020.02.27.23.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 23:37:32 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 0/5] random io-wq and io_uring bits
Date:   Fri, 28 Feb 2020 10:36:34 +0300
Message-Id: <cover.1582874853.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

A bunch of unconnected patches, easy and straightworward.
Probably could even be picked separately.

The only thing could be of concern is [PATCH 4/5]. I assumed that
work setup is short (switch creds, mm, fs, files with task_[un]lock),
and arm a timeout after it's done.

Pavel Begunkov (5):
  io_uring: clean io_poll_complete
  io_uring: extract kmsg copy helper
  io-wq: remove unused IO_WQ_WORK_HAS_MM
  io_uring: remove IO_WQ_WORK_CB
  io-wq: use BIT for ulong hash

 fs/io-wq.c    | 11 +++--------
 fs/io-wq.h    |  2 --
 fs/io_uring.c | 51 +++++++++++++++++++++------------------------------
 3 files changed, 24 insertions(+), 40 deletions(-)

-- 
2.24.0

