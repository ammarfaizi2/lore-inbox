Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A8CC433B4
	for <io-uring@archiver.kernel.org>; Thu, 15 Apr 2021 12:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369D861152
	for <io-uring@archiver.kernel.org>; Thu, 15 Apr 2021 12:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhDOMMV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhDOMMU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 15 Apr 2021 08:12:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692CC061574
        for <io-uring@vger.kernel.org>; Thu, 15 Apr 2021 05:11:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so23098194wrr.2
        for <io-uring@vger.kernel.org>; Thu, 15 Apr 2021 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psLR/tmeODEatdr9QvbEvap2eK3UTdgvkGAHujVN5JU=;
        b=oyPbpbTzoXK0uGTFVk9cH+kGRq+BicPIoK1yy8hFbO9bjQPy87P9ykwPXtcO9Z4JWb
         TRYgwh0ge6MgOSy+kOzWeBKGYnliB4qq/zI8jp1AIxZv3Lt7oCPJUV1izudZ9zjSbxkj
         2RPWTTbWhzEtTESnXS4ouVOZQKNPoPZYdd61nUrDWIiqxl5xJA9Mmu93lbVnAG2O+1jy
         ojfol8uNPBBSBEuGcfvwwa0J4vPMI9Yw5iDtJ9QBvC5E1OGw9xJUQ7jqU8uewbrduKQt
         +NP0qaUzdcPWcUty5/gHZWR05MyiMx7AxlXvo1NRV1AU3/TcZuGNOSdfIWun2Ku3ydYX
         tb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psLR/tmeODEatdr9QvbEvap2eK3UTdgvkGAHujVN5JU=;
        b=kpBDusVLbo8dzJ45VDGjgKXqhQOvLFSXO7NUMpn4Kc+7iTXOcy8P5gz+8upKjOIeDF
         jB4TG9UYdnlpix6WUO0F0oT+7/VxPilJy19fE/CrHMftmLOFnDmbUsy+DBSo1FHcJZ73
         VDA88vGfSmGq+vfxAshlFNds/oS2/0BIygKIcjpEK43m3375R/mCDFNWw6WNKpu/z43J
         +w/DXDvQMrACT5xSDrY/YLh8I+ft6lf7vrsG0acPKHiGm0IIq5wL3LzZg74LKEN5H3Gp
         eb3Is/OtYKrEQETGgl00Y/andN17QUZ83PQ6aw41EGtGQTNplJDmjkWXO84wxWmtZhY1
         je2A==
X-Gm-Message-State: AOAM530yClxvMXku88hYyNztGseALhfscSmbJJgO5u1RruBcaTqZ8DVX
        K3Ts72b4hVz8CUHB/+aLsVHKeRMNGya4xw==
X-Google-Smtp-Source: ABdhPJw67N+BApbA2JBg26u2Z9H4FQb50cWj6F4DN3ojfZUatI6viTH8JCdP6QlXmDkeaXelTkC+nw==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr3121595wrw.172.1618488716330;
        Thu, 15 Apr 2021 05:11:56 -0700 (PDT)
Received: from localhost.localdomain ([185.69.144.21])
        by smtp.gmail.com with ESMTPSA id j30sm3015275wrj.62.2021.04.15.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 05:11:55 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 0/2] two small patches
Date:   Thu, 15 Apr 2021 13:07:38 +0100
Message-Id: <cover.1618488258.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Small patches improving userspace values handling.

Pavel Begunkov (2):
  io_uring: fix overflows checks in provide buffers
  io_uring: check register restriction afore quiesce

 fs/io_uring.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

-- 
2.24.0

