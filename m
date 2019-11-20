Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9847AC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562EA2075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WYvklue+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKTUMN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:12:13 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36926 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKTUMM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:12:12 -0500
Received: by mail-il1-f194.google.com with SMTP id s5so879405iln.4
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cBwKstGmtZFYq+6i5Q+8O7xsBlhUONpsH/hZTeqAr0=;
        b=WYvklue+0TTWtAv2lFXBoIUBVPGp8alxMvb02znEsxFs2lIDrx1+f4C93gGV3tgI10
         ULjuXPNbZkSYVwpr2mKZNnVJHNlzJ5TA5KWXUwCVtXdwUKq0qDdr1Q115HIH08GRFAJi
         jY1PHFXKxloG+u/V6WJ8PXSq54s/eyvv1vuFx25M7mryEcez083lSWJW4LbQSjqnh4cr
         UJbz3oSLnDyXPNw/landDCj9OLPBSmD9uODw/T951/h/3m9GmAIq5lG2i7c7o0ZKyf9+
         V8Y+LR0Dbqvut4JFgYWYEg1t6w+LF7azbBshMu6dJNE6U2wIutSewpkyioGtL15WDH+w
         DQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cBwKstGmtZFYq+6i5Q+8O7xsBlhUONpsH/hZTeqAr0=;
        b=nTMe5zgEwHH3V/svelkCu9X7RgR2rYg1wB8yp37gaEHwdEAZcLI9clUpQkB8imTxfr
         pk2EiPbmglgip3XLNT4EXv3JmAkxKX4Su0jXHoi3H8s6+nZg4XiJz+4fijIxofmO/Qg0
         fNYaXnKh/yz9WNByjz/C+gYcGHHnxRy2DZ8YZqlbL4eXJgMllFy08kOcwVB3UERCjz/w
         4wnK/2LGFGFFky9Nuib4coIgWglI2JYmlLQg4WFM1ZiPdrSlkvz5mxDIWItx7ZiEG6hC
         hbsy6ALu/+MZbedj0Mzpq3xMCULxmjT5HXUPGAi1rx9Y2DI2Vw7N+ji0x68wMJ72j1tz
         7N2g==
X-Gm-Message-State: APjAAAWHCxrVEMsBPAFvyrhv3VaD8yhEU/iG3zO1CKqU1ogM2sF6WMI2
        hnJRSUS6YJI6ywrLLwx4wuhGFnZ0wz32lQ==
X-Google-Smtp-Source: APXvYqxW7F6mKROHg9+Xn8vvDzuz6hVY4LJWx4hiTgDdx2w2kJBiGzCFlabaRW1iIhfdCM9StrYYug==
X-Received: by 2002:a92:bb95:: with SMTP id x21mr5537514ilk.128.1574280730212;
        Wed, 20 Nov 2019 12:12:10 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w75sm53350ill.78.2019.11.20.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:12:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCHSET v2 0/2] io_uring: close lookup gap for dependent work
Date:   Wed, 20 Nov 2019 13:12:04 -0700
Message-Id: <20191120201206.22799-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

(resend as v2, as v1 had some older patches mixed into the series)

As discussed earlier today on this list, there's a gap between finding
dependent work and ensuring we can look it up for cancellation purposes.
On top of that, we also currently NEVER find dependent work due to how
we do lookups of it, so that is fixed in patch 1 while patch 2
implements the fix for the lookup gap.

Patches are against for-5.5/io_uring-post

 fs/io-wq.c    |  3 +++
 fs/io-wq.h    | 12 +++++++++++-
 fs/io_uring.c | 34 +++++++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 8 deletions(-)

--
Jens Axboe


