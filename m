Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6242C43215
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951542068E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YjOG7dt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfKYQsY (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:48:24 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:38957 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfKYQsY (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 11:48:24 -0500
Received: by mail-io1-f45.google.com with SMTP id k1so17000078ioj.6
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhZacaQ+dquaXjFwgQ3cbVgKQ9hF+FLHOChoGjJ3c/U=;
        b=YjOG7dt0CXL7FbXG1+Ga/9CwgSmEYeL5yJpm49Znx831Vm/PKbapvNP/ocGxXJmnVj
         73fFtAbR7IEZNrLgScayE3vA+d7WWHRgJLmJ25IOhb4m4cwx7oBW7Y7fQXjLriZQmt6M
         AyU0Ibq8kiaBiFmJSU7Cv4d/1+9e92xwzpgQ5qPWg+tPeQM9OFrb642VdrzZdkiSoPAI
         CeKPgrKPL4Ix+rFg7hasmcxAtJM7NWeia+RvBVsF2sGMdd0ykD5XNf7HeJ7dM6adksSV
         BJnJtWpDP5N2oEwEnQTppRhDavZYkgECsZ88cywx4ol1D7iT48ek5xGHOK1serRBURHn
         5QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhZacaQ+dquaXjFwgQ3cbVgKQ9hF+FLHOChoGjJ3c/U=;
        b=VooumLG4MH94w6U/mJBtxmvvV9rzQES4HmjLNB/npNjn7DosqLsaj1eplTTTdB2KcT
         9Bkj8zG6ZFh2U4Qz5NZOFlL3vNmwLG46rxPQimp033G4ND3x5xezt+0/V8HFVWwwJ5XT
         VOuTjrNSJ9eDCq0Z9MDDRPC9vS6CrdaUOQIXlZYq+76m1tDQpK+e+LxptFzpX/2dW7jI
         z7ure40bVIpIDaoM2HRPPEBRJ+uquBZW5Qn5OqCYFoMVR9dIncAHHZGUxAB1t9D54AnG
         IevXcAkoGtbsIDlOfJv2qWI5hejz/Mgb9Lna2lNelH0pvuJFQdcTtb/Lmn58XaEhdxEJ
         /1SA==
X-Gm-Message-State: APjAAAU/5/XRnE6Fxj2ntebvwfENp97Su0XGWvlQmcsuTqZvnq0C9agS
        CGjcoUr2royVFezfxrEF83DU+sHqcooMwA==
X-Google-Smtp-Source: APXvYqym+x94QShFddUgVaWeCWf1VZKSKGZLsmxpkIxEvpSfkNMS02TOtbD6gWnr4TNVFDWY6jSBaw==
X-Received: by 2002:a5d:9913:: with SMTP id x19mr21561556iol.46.1574700501386;
        Mon, 25 Nov 2019 08:48:21 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm1944788iof.61.2019.11.25.08.48.19
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:48:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Subject: [PATCHSET 0/2] io_uring: ensure we inherit task creds
Date:   Mon, 25 Nov 2019 09:48:15 -0700
Message-Id: <20191125164818.16414-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

As referenced in patch #2, fuse + fsync fails with aio because of the
async punt of fsync not inheriting the original task creds. Apply the
same sort of fix for io_uring, and apply it globally to all requests
so we ensure we always present the rights creds when offloaded.

 fs/io-wq.c    | 24 ++++++++++++++++--------
 fs/io-wq.h    | 13 ++++++++++---
 fs/io_uring.c | 23 +++++++++++++++++++++--
 3 files changed, 47 insertions(+), 13 deletions(-)

-- 
Jens Axboe


