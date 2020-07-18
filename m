Return-Path: <SRS0=TYfi=A5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E1C433E2
	for <io-uring@archiver.kernel.org>; Sat, 18 Jul 2020 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD33A2073E
	for <io-uring@archiver.kernel.org>; Sat, 18 Jul 2020 08:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4puuJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgGRIet (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 18 Jul 2020 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgGRIet (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 18 Jul 2020 04:34:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228BC0619D2;
        Sat, 18 Jul 2020 01:34:48 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so15263180lji.9;
        Sat, 18 Jul 2020 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LxBXucu22MekJzjcm9McVLQ6xx8d1C2UxhUn5AUQVA=;
        b=iU4puuJ1t9aQMFxcrQUpwAs55vm9CVnCD+SxkQcdPDYW5ntHPRX0LUfd0sKfC71g1g
         DckdRLgA9DgEKRohMh5hy2PUfgl5+HH/dcJqJRIXgPYa5agDwpAwdA6xJSKtQIccyaXJ
         vshX+FmSy0o70KEY8Fvh2j9p5t4yECPswn4rh1g+vEPTX4VnoAgLl5O9uGcxoq2HgbV4
         Vrxfh0mKMUGq86Hglo5ypwPKHrJBHmrzzSKPMS7HGACzXjbHGtn20ykZfhVsgZHgZUhQ
         iEXhlWxHfXj3lMfnI/dKxPlb95aqYYv1qu2SYILEfMffZoH6ziqjSt7938R8szpinQhr
         3qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LxBXucu22MekJzjcm9McVLQ6xx8d1C2UxhUn5AUQVA=;
        b=sDSwhFH3HAV1ZHRaQwbKqe/9Myt0gfYKgaBLyes5Lj74Qd1mzh3J5bAgazzJrvQiZ+
         /eoLWU46bo+yRKLjJYOxdbiGmhfow2PeowX0iQsd2Sidq2zMLxKB6gAR6rm2G6c+1iRw
         Iz4kofBtoYjhbRaOeCK3lh8FQtHy3JSlN+T7j+nOT5nBzm8ICxC1PwXywkMRQJDwRIKS
         Jiqw3NNIDu/7ZG2IUy/uA0H9y8SsDkfT7+FU9VZYh2P/yFMJmVH2dJPbrZAf+8qF9i8D
         PdHFSJBKc+toyEuAH4EJ9OJ63wsmSYhiyM1FHAaEpH1oTZwm3p7oSB268Dy3Rg0Q2sjY
         nvew==
X-Gm-Message-State: AOAM5321n+W2BSvUtBgMm0pJWF0GwfcUPN5tSGwj+DKFweqiDT4UKfVk
        m9lgAiQbYv1ZZOBGV2YFsl/MO3xN
X-Google-Smtp-Source: ABdhPJwfdy/KeGasBEr5jNeY291r6rmQZNvkJfzhUpsbYSckT2da/NemRlp8JGmePxIYJmPxAtS5AA==
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr5560378ljh.239.1595061287383;
        Sat, 18 Jul 2020 01:34:47 -0700 (PDT)
Received: from localhost.localdomain ([82.209.196.123])
        by smtp.gmail.com with ESMTPSA id u26sm2789226lfq.72.2020.07.18.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 01:34:46 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] task_put batching
Date:   Sat, 18 Jul 2020 11:32:50 +0300
Message-Id: <cover.1595021626.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

For my a bit exaggerated test case perf continues to show high CPU
cosumption by io_dismantle(), and so calling it io_iopoll_complete().
Even though the patch doesn't yield throughput increase for my setup,
probably because the effect is hidden behind polling, but it definitely
improves relative percentage. And the difference should only grow with
increasing number of CPUs. Another reason to have this is that atomics
may affect other parallel tasks (e.g. which doesn't use io_uring)

before:
io_iopoll_complete: 5.29%
io_dismantle_req:   2.16%

after:
io_iopoll_complete: 3.39%
io_dismantle_req:   0.465%


Pavel Begunkov (2):
  tasks: add put_task_struct_many()
  io_uring: batch put_task_struct()

 fs/io_uring.c              | 28 ++++++++++++++++++++++++++--
 include/linux/sched/task.h |  6 ++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.24.0

