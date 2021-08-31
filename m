Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA366C432BE
	for <io-uring@archiver.kernel.org>; Tue, 31 Aug 2021 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9732B61075
	for <io-uring@archiver.kernel.org>; Tue, 31 Aug 2021 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhHaQbt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhHaQbs (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 31 Aug 2021 12:31:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8FC061575
        for <io-uring@vger.kernel.org>; Tue, 31 Aug 2021 09:30:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso2612059wmc.5
        for <io-uring@vger.kernel.org>; Tue, 31 Aug 2021 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da22K+Vlt5mSdJsH6D2vyeOqCgD/wEy9Ws4WqnEok4U=;
        b=JTKMBvphJ03XXZyH0OG6J8N5I7D2JciDfBB930ShwxMLMuFaKVU/4bnuwJUZBfro0/
         dGlCy++PpjJrR9Q+qGehszsIyPs8IfZA96rkpFDZEzpxlaBPcosoxlLSVz6YSWrAuhyq
         BbiXETbl0tCQbtfo8KKBxFyRKi9U+Ba51WPmRydx6zwuY6gcxjeE3LY+k3D500dbL0gn
         LsSYAs2Eny3GT9h3KPHU3L2jCPsqDOhvYwcnGxq0z/KIszxlVNZkn1IONpSRvu4Le4zq
         uuTPmLUSI/D4A124W4KypFpCUs9QV1mNpxJcVCjyxrInb6zixIDr25jbDbXNm3OvgKIr
         Jk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da22K+Vlt5mSdJsH6D2vyeOqCgD/wEy9Ws4WqnEok4U=;
        b=txsHfQve+YWH7jo6vRM03/u8N4tCXr0trA4H3frifwUwlJqwkaXL8x2LxYMJx4G+8S
         Qj0ErRDf6ikw7Nx/bQLCYSnfss3l72uqeJ/yjcfDjD8JgZ9yfteOymJv+ayVIqDyn+DN
         p426VdKmJFGSFO4Xq+y26405M8H3X7fs+zHR9q+ewz4CaRj/oswXPA5DCtIzdcyzhklh
         iNP/9EAzDB8u0GvhkmP1xJCJSWkjQyM1XFf6dGLu7FxID8qUZgw8R2sujljy2mUqIZbL
         IZgcEs9jK4ltizjq5czFi6pzLxmZtUEowoe8iWdkqtLr/58FBbWfrxOUG5bkxMwaRMq6
         bcvA==
X-Gm-Message-State: AOAM531Iz/7lij5/8dCYmVom+BpNeRTeV8RqWJXoGcvsTNaYLgKQrq7C
        tChQYkeZS5IZs0XqD/audf5fuM5+0tw=
X-Google-Smtp-Source: ABdhPJzfQ/aVlDIHH1jtuQCpYEq88jb2wea0+AI999crhMqB2I88FDKQZQEG3mreyGCWyo1gKsEB1A==
X-Received: by 2002:a05:600c:4b88:: with SMTP id e8mr5192660wmp.164.1630427451900;
        Tue, 31 Aug 2021 09:30:51 -0700 (PDT)
Received: from localhost.localdomain ([148.252.133.138])
        by smtp.gmail.com with ESMTPSA id n4sm22403209wro.81.2021.08.31.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:30:51 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH liburing 0/2] add direct open/accept helpers
Date:   Tue, 31 Aug 2021 17:30:11 +0100
Message-Id: <cover.1630427247.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Add helpers for direct open/accept. Also, use them in tests as an
example.

Pavel Begunkov (2):
  liburing: add helpers for direct open/accept
  tests: use helpers for direct open/accept

 src/include/liburing.h | 38 ++++++++++++++++++++++++++++++++++++++
 test/accept.c          |  7 ++++---
 test/openat2.c         | 27 +++++++++++++++------------
 3 files changed, 57 insertions(+), 15 deletions(-)

-- 
2.33.0

