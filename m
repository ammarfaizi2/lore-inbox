Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8356AC4338F
	for <io-uring@archiver.kernel.org>; Thu, 19 Aug 2021 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5005E610A7
	for <io-uring@archiver.kernel.org>; Thu, 19 Aug 2021 11:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbhHSL5m (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 19 Aug 2021 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhHSL5l (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 19 Aug 2021 07:57:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C38C061575
        for <io-uring@vger.kernel.org>; Thu, 19 Aug 2021 04:57:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so8698817wrr.9
        for <io-uring@vger.kernel.org>; Thu, 19 Aug 2021 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WqiqKD7ntgisHEr92imWxbzVOIVlvfvXBJLb0ZwN5zA=;
        b=t0/aEGg8llJzcwqYDA6TuLCFovfR+FS3+AfFBottgqAeEt9FjpIWfwsvswbUC0CjFT
         cgG03Kd6dc2SdjKxsfBRh/sXbTnYi4M/Lf4pn+KJ5qf6EPwFs5bsZvJX0s/ezVis5tt2
         FE0ltHnslKx4277WNvMQQtWYej00JfWVJmQS8IJQCOyZyaBEKzP3fIIHtiDM9Htv/r2x
         ZpAcN9TEymzfLUO/j9qB6l5U5eqHwq50Jv3GAzIgDCVl1ckYasvObDQT/Vy2vQddk50O
         EiLNHqYOY3VCR6AllGHnBhKubpenfceoIvJWfjJzo4fxus99Vc+qbD6/oROLSkTXHcWO
         LHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WqiqKD7ntgisHEr92imWxbzVOIVlvfvXBJLb0ZwN5zA=;
        b=RXQChdzIRO2dMoiqfER63MG0CEphwGNsMsfuaJhMJJTFK0l7hq2NwKWQM9AsyygO8w
         GjFHfe44OIVdjznYAULWJGp/6/FyX4U3968LG0vINJyCGvTbKqqgTPH2hhZn5Eoh9SLq
         LoED6zVvrGtx1NBJ8Qpoi35xjB71g6B0X+GkAQQK+VMQFsDs/lN58w6MDoR0ylm+CStn
         WLrDu6rRg14B6xvfXMtGDmNTqmF02DIMz4dxBhcQnhWR/dbrGdi5orhDtSKbCRnmAWZh
         0zEsjTgBY4jrPpe1EzvcZJ5anSMMC8eqNvVQg6+OJCiLLCmneM9yX7lgTe5ncN5CQLkj
         HRfQ==
X-Gm-Message-State: AOAM533xKI0PXhB7030Ix2ISZemzWrzMA/grnQ0m9dyNF82T1zVEIHAK
        rc5nG0RR1C0WANgDyR+g0zY=
X-Google-Smtp-Source: ABdhPJzAnig7Ro32sY9Rs3C0Biw734HBfylJ+cvQpxBGpZtX6Qgdqin1VGe00vr6LvdgleUAlT5l6Q==
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr3391994wrt.68.1629374223387;
        Thu, 19 Aug 2021 04:57:03 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.21])
        by smtp.gmail.com with ESMTPSA id r10sm2700906wrp.28.2021.08.19.04.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:57:02 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH for-next 0/2] tw handlers cleanups
Date:   Thu, 19 Aug 2021 12:56:24 +0100
Message-Id: <cover.1629374041.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Two simple patches cleaning task_work handlers.

Pavel Begunkov (2):
  io_uring: remove mutex in io_req_task_cancel()
  io_uring: dedup tw-based request failing

 fs/io_uring.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

-- 
2.32.0

