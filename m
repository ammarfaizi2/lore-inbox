Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E4C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3C92240E
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4Q2CpE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKSUdQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:33:16 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55253 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUdQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:33:16 -0500
Received: by mail-wm1-f45.google.com with SMTP id z26so4669703wmi.4
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3h8MV3ZJ6kjYUUhlkQ9JuTTLTLJRIgOJ7DylIQgyCKE=;
        b=d4Q2CpE1CCK5oDYTkIxdFsdxKjCW/OmeGVXy7NEh6DNF2vioTmNyAZD4EIjMTrW36c
         fCL82qS8oXrMjDzI/Eta0Bp6noIjHkUj0k2vHhawwETOpkLOQ4fTvnUSXjnYUxrU0IHt
         rJGhzv3W0tm8+Fn/LupOIXECOJNinpiwiLJQWUlAFptgmi6diT/jG/ZModdF3OoSknJK
         9iLxFmJR/1wpwViZrhhgODemhtPCgq+6z3WyDijXircpF5aYemExKUxRwRBiRc3TU2s9
         C3AehwcI1oXsgp89QEIgOzD3/isMnTFE594i7HWaP1JfSJTyBdKuTsi5JmEgyoIwWvHB
         yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3h8MV3ZJ6kjYUUhlkQ9JuTTLTLJRIgOJ7DylIQgyCKE=;
        b=Gt17giWNJSAEFtfmyVmG96UvyP5dzKicvwwUTW2YVqAvfmyIRmzePZ/Ko7cVhpAmRn
         fkVvsy5d7Q22+JWMYJ99Zp3v+a0MshbMBXs69FQvxTYsz3l7cNqU/AP16LUofsNiUt1z
         NRBls6mEHegJcbmQ3gq8nH0Y1jeLQLFbM8UOjUquGfIO4CF795fQYPmeLHyeeynN0h6C
         iFF9sR7y4DTtm2pOUYbMz6Dc5aQHccwgJOnqkl8Notv4AHHLRH9PPHOKSV/MxRchlgxK
         o9KSldNYgAi72FFH1XC+YGngOtmsyzPqnqnEsddHjt0jQcYw7SCRKxGJ7ObpoKPHzwtO
         Kdgg==
X-Gm-Message-State: APjAAAXBnNKNx1VQgYSvmYJ55aG+Uo4KXcbELDvFSue38UNpod5ApGkH
        BApj/lnmhuQkZ4kddg0+b68=
X-Google-Smtp-Source: APXvYqzBOSeW4oZ1o3dB3JaNbrdObMFmqkWn0BQJsuF5QasrN7Z4hMPjDEznb2dLwMGVfcBNnnjRLQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr8079326wmi.16.1574195593825;
        Tue, 19 Nov 2019 12:33:13 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id g184sm4605981wma.8.2019.11.19.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:33:13 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCHSET 0/4][io_uring-post] cleanup after linked timeouts
Date:   Tue, 19 Nov 2019 23:32:46 +0300
Message-Id: <cover.1574195129.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The second fixes mild misbehaving for a very rare case.
The last one fixes a nasty bug, which leaks request with a uring
reference, so hunging a process.

Pavel Begunkov (4):
  io_uring: Always REQ_F_FREE_SQE for allocated sqe
  io_uring: break links for failed defer
  io_uring: remove redundant check
  io_uring: Fix leaking linked timeouts

 fs/io_uring.c | 58 ++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

-- 
2.24.0

