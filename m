Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6357C63798
	for <io-uring@archiver.kernel.org>; Wed, 18 Nov 2020 14:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C0024727
	for <io-uring@archiver.kernel.org>; Wed, 18 Nov 2020 14:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP8fFV+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKRO7n (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgKRO7m (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 18 Nov 2020 09:59:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93DC0613D4
        for <io-uring@vger.kernel.org>; Wed, 18 Nov 2020 06:59:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a65so3012470wme.1
        for <io-uring@vger.kernel.org>; Wed, 18 Nov 2020 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tnkpewdjoEB5SNh9n29h1yqFZFl5bNnKBgbqLGebCkk=;
        b=aP8fFV+ecepkO3kPO27uTOv2nATWz0fEKdwZhcQ6IjOGpopezJhlm0ZfUgZyI8Q8Eo
         HF//a3tWX7x86MaNftEt71DqGm3UGjKtmrM1ndDimfazhhGrHpxy+pGAFflHHML+rhCF
         U0BX4G3rMPxhZfGinkp2tfUWnivqreioF/lDxpmxIbuMSSDNCjZmVWgENoNEYS6PBchE
         80UCyZKXfpKJtAcfjcpJay0WPucB8gdr9cG2TyaeF2tnl+kk5bVRqbfTxv78deIy6sVE
         V39fED93xDwjSWSEbMAfuNLu5Xm3KE2OW6lF2dRQaQtROj1qy1DkpnNnyTMS0If2fJWH
         Aqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tnkpewdjoEB5SNh9n29h1yqFZFl5bNnKBgbqLGebCkk=;
        b=o5HKJt883QyUOfVUDdtxREChLq0PlxcQsiYu1SZUW6K2V+zmM/SIbxZ/6LBen2yTFj
         Y5E9FvBQcP275DD70QC29nGKtJ+J8uR/ekwyCctb2ky8KinvZwMu1SMbEWjqyJP8PF7A
         zU3dxm78rULxLl46MT4V0g2in316DMX7IhWzV0O1kZ5ywf1526uihz/PMUCmZvZkSxjX
         hqpcnNyUkqwU/WRVUPo049RDowTOKSxZJUuT9PV/W5lXP1oJMawSITyNs+3C7N70D+fZ
         Xeut833dxyQ6NBM4f+EW1JSF6ImDCMEJHI27KLELaJmhJM3jkj4SG3zNRVxPYexCQrFe
         P1fQ==
X-Gm-Message-State: AOAM531TzMrDYmhgfS1dWf1a4Gji0NCLITh4ugOu5B9s9FP2HVvERBKO
        zpR0AqRg2JTdHCdtgyDBgoKFxM9skVxlXQ==
X-Google-Smtp-Source: ABdhPJxZwzNb5eiYYkwb86z8fZu4ZhzRXHd5LQ5rS0Rr1RDlrdM/Nlu+cOnuSsHwqym343ayjGu7YQ==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr433784wme.85.1605711579814;
        Wed, 18 Nov 2020 06:59:39 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id c4sm13222939wrd.30.2020.11.18.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:59:39 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 5.10 0/2] order fixed files refnode recycling
Date:   Wed, 18 Nov 2020 14:56:24 +0000
Message-Id: <cover.1605710178.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Pavel Begunkov (2):
  io_uring: get an active ref_node from files_data
  io_uring: order refnode recycling

 fs/io_uring.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

-- 
2.24.0

