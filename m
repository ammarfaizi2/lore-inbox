Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFBAC433DB
	for <io-uring@archiver.kernel.org>; Mon,  4 Jan 2021 23:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6163A2253D
	for <io-uring@archiver.kernel.org>; Mon,  4 Jan 2021 23:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbhADXj3 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbhADXj2 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 4 Jan 2021 18:39:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136BC061574
        for <io-uring@vger.kernel.org>; Mon,  4 Jan 2021 15:38:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so756602wmz.0
        for <io-uring@vger.kernel.org>; Mon, 04 Jan 2021 15:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=obzkBNSGHF6dBR/ceI85LoADRI7lg0YEJ6SFiyPVz+w=;
        b=W711LJM5HCyNX/W7GM08cyfZsTpeYwTUotYrnwsYnhGdLDGNC639ruYKJyKfAixmx/
         iL0r7VlhdDrC1wKF2kw/qWqVtZMMVtV9aSYICNadPGTc447W5wrD41RHla70V2VlSRbN
         ciehGYwDftiQIPt3PG7yYTUSA2AWzVnAXUtf1YXA11ybLPA8RV/N1Xo0klK4ZeqoNhi3
         WW4Yq73dyFTsKdjqGfDwMvshqfJOC1QiaYYsxkBsIa9lSAGJvuVh0QKsW+4FRutlvQJP
         S2/3tqNL0MNZnUu8CCxgvfjG4DopWu39b8QkhFkZwX2abObDeT87eGlxrC3qD86zkfyd
         ChRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=obzkBNSGHF6dBR/ceI85LoADRI7lg0YEJ6SFiyPVz+w=;
        b=ZwCrD9NHIO6J0Y0Ub6kOvybaSZvWhI0ai0XQkS7lHzOsQl+N3RPP33xJsHUXFN9MoG
         GKuesVDFMURKzhAOYWmO97blvEg/gil/AXRBxkg8MXMTIFY6hbQU3UB49QDyPmiExlDT
         IxqnH/3i8/JQqJQvKIrMhtzH0R5302NwBToXiZsV6f7txjvLaMfEDg3J3jOYd8BRFX1Q
         TqiPBobKRoLGALkndyIxYDLpwbXa0ccw7KvleBVB2f5iQmQHXRlv+9sQZQwRIKpnVj9O
         5aOGOpG4yC0A7n1nbCdHvA+0OG9P59C81KvrB/00IJw/upEDbY4JS5o2YKjmdNXiiZDr
         q0cg==
X-Gm-Message-State: AOAM530V1YJFf8SkCEMkvzN5oGKluc1of+J3XMGxlxaqTMFFNPdOWmbk
        7YutcZJ4lVZgeE3Oua/Gln2Rm6IW5vV+gw==
X-Google-Smtp-Source: ABdhPJwXt+09umujtmuYwirF+yEFDGoPC+TjQyYbq21YGoAjeElRQqHrVk4hvnjWp1qC5nm5vK5w1A==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr570883wmc.102.1609793225902;
        Mon, 04 Jan 2021 12:47:05 -0800 (PST)
Received: from localhost.localdomain ([85.255.233.205])
        by smtp.gmail.com with ESMTPSA id n16sm54715017wrj.26.2021.01.04.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 12:47:05 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 0/2] cancellation fixes
Date:   Mon,  4 Jan 2021 20:43:28 +0000
Message-ID: <cover.1609792653.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org
Message-ID: <20210104204328.wHGbXvumQRJdfuN2RzdMCdunUs4OkhsLi2K3AxMyCtE@z>

[previously a part of "bunch of random fixes"]
haven't changed since then

Pavel Begunkov (2):
  io_uring: drop file refs after task cancel
  io_uring: cancel more aggressively in exit_work

 fs/io_uring.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

-- 
2.24.0

