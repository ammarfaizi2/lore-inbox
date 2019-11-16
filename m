Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D8C432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FB2073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d+g4Rog0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKPBxW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:22 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44526 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBxW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:22 -0500
Received: by mail-pg1-f172.google.com with SMTP id f19so6773845pgk.11
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FL/1AMyYNNwBfpSQ6qrlsDzfar5dc1BrzXEetCXF24g=;
        b=d+g4Rog0dWINpJN436db7+pD06KMUhD4/Zd2A1V1OeuBG2xvByNahReWAoxi4bdvSj
         tWYLVWZmSg/kKy1U4uL/S4m2PI20jbhyJKTOX2a8OezB517QLFROtVkiZnZLmiQxDwhG
         oIpOtJXnpuouASh7Ox0n2GjMlfvM1SLlieTy2bQqRqtHShjZzFK1g+dCVwkIjL1cUtlK
         PU6gVS4LWEnvh4jzwrI07epCaJtuuprBxRqdsFxSoraUfF7b6BIBOpoS2DOGjaVMg1OQ
         JsA04JTq9EoYaO0LPI9iMEWLde1A+O5BdVKhHlHIABlbPWg/BVP+ajIx2fhVNtgo1xfi
         4Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FL/1AMyYNNwBfpSQ6qrlsDzfar5dc1BrzXEetCXF24g=;
        b=fmOVKv1aJAsTcRbq8tdx4uHRK32+atIqO68fQxtORNl1K4ucJ85gZdNZ58694O6heQ
         BOifolGUHGw/eMq3/CE+O5zMJw43MuCrlooWU+aI0Nh3M82z4Uw04QJMWvAspMJphZU8
         yp5ZD9wtNEf7W/5h54NUD8JM8FGyb7OnK1KUvf9rhcTk6NM3JLltGHdnShQxUs/aGxav
         bu/YQWWgcV/mNmsffBS3/wMJHn6EoAWsOyaI3Amlg4tXfK4DC8tLLZtgD9DN95A1TbPh
         gb2bMwY8tHmpB+uYAJ44oQQj1HnDawsk3UKh93i3UNJwapt8VknxFmCQvJDhBJ3wnyIW
         GaVA==
X-Gm-Message-State: APjAAAW6Qb7qRqa6MRuZAfLcGqmB/LHsTYJzD3lN6XPvRhr4aD63rsGJ
        QF0snC09T9xOILjc2QcpaoXQEWI/hRE=
X-Google-Smtp-Source: APXvYqx0vdKnLBZFF8uI38n5305IkJJD8LEJYk4+vlG8tjP+D9N6c5SBw5SU706snwO/VKx+7mi7cw==
X-Received: by 2002:a62:8748:: with SMTP id i69mr4946987pfe.224.1573869201166;
        Fri, 15 Nov 2019 17:53:21 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCHSET] Pending io_uring items not yet queued up for 5.5
Date:   Fri, 15 Nov 2019 18:53:06 -0700
Message-Id: <20191116015314.24276-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

A bit of a mix, some of them posted before. But this contains:

- Removal of io_wq_nulls_list
- rbtree for poll, making them scale better
- A few trivial cleanups, some of them just cleanups, some of them
  prep for changes
- Hopefully fix all the linked commands sequencing faults

Can also be found in my for-5.5/io_uring-post repo.

 fs/io-wq.c    |  29 ++---
 fs/io_uring.c | 333 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 215 insertions(+), 147 deletions(-)

-- 
Jens Axboe


