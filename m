Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A1C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781BA20643
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqy7b0zS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUUVh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:21:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51976 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUUVh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:21:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so4906993wme.1
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8qRLHLz+Hgz8In/j17aBHwZYXNKi4gMrkopeAA4VkM=;
        b=Eqy7b0zSU50olSSFjZNhgZBE8kljwv33WnDJ9l5zQiMP6ueARnDoH1YrZw1REK3r2r
         wqDBBOAkVjBnAAnpChRTyj0QDETIvaX6s8Mk0ZjwXSrH7z5CQJnFpcEE8xrpF8god8M6
         RKwTw1/lD7eFzL2Qod0GZPretPo7YprM0h62TYUg5tFFO3Sy2rp3G8nSEWLGWt8PNQYR
         vON/yyx76hBmJgUmQrDNx0r9zm14BYuLS5N2Wme1b73660wQ1tGXwgcGnF3z3huArOsr
         u7sy/ABp2wk25ZiZvrKv2ehiPt7MX7Dc8+YNiFWFSk+edFCqv00dBpSTHwZoGjSUMnGe
         oNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8qRLHLz+Hgz8In/j17aBHwZYXNKi4gMrkopeAA4VkM=;
        b=V+G/vrYhGCOjyk5m2ft/h+VushHd3c7e/4E4AtdvihcMlycl9fJyE7xYXotxaBlBW8
         2FzsIfxbaXmq5w4mstZSgCPoW2/a9RElcGCOKbpUADT7MLwbiuvcKVyuWqeUF3Zd7FGe
         FjxowLGJsJ3ImNeEw1rSvHV8gYCaqOfV2DN5jJq7PS2rAghLc/aT+n+JQFOrgyPF8XLM
         J+eICqFJeRjgfZIjoopsIbCHOrKsgJSikGwqcLYS4pXPEXK6FDEpgfLXKP9xmK5yoYDI
         mUyLFd6zE6RMveCLps1QrzB4a9jllN3nPmdHBiQd66i6QzmQFB3FICP9ilsOls2fPF2t
         L3uQ==
X-Gm-Message-State: APjAAAUgPYaG//TQX6st4RKnc4jqvdEIU1p/+NH7vpGFq+SyrXp4s0ts
        qvuboL0qUR/Cs4VnYP40pu4=
X-Google-Smtp-Source: APXvYqzwpeDvVEKF/pqQ19jcqchwJ46T958u+Yoz7Dx2sXWNmWknCPEXl6jXg1tOJnA7L+wQyHR1/g==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr1681827wmo.143.1574367694926;
        Thu, 21 Nov 2019 12:21:34 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id w4sm4646112wrs.1.2019.11.21.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:21:34 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [RFC PATCH 0/4] cleanup io_put/free
Date:   Thu, 21 Nov 2019 23:20:59 +0300
Message-Id: <cover.1574366549.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Nested checking @nxt for non-nullness in io_put_req_find_next() and
friends is a nuisance. Make them accept only non-null @nxt obliging
callers to io_queue_async_work() if they don't need @nxt.

The patchset is a bit rusty (rebased), but still relevant. The part
removing io_wq_current_is_worker() (PATCH 2/4) looks good, but would
like someone to check the assumption.

P.S. it depends on the patch with renaming __io_submit_sqe().


Pavel Begunkov (4):
  io_uring: remove io_free_req_find_next()
  io_uring: pass only !null to io_req_find_next()
  io_uring: simplify io_req_link_next()
  io_uring: only !null ptr to io_issue_sqe()

 fs/io_uring.c | 51 +++++++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

-- 
2.24.0

