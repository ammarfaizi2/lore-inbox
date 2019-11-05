Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4BC5DF61
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D4621D7C
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UftWM2PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfKEVNW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:13:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40363 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfKEVNW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 16:13:22 -0500
Received: by mail-io1-f68.google.com with SMTP id p6so24311975iod.7
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEfi7pnbeMsyrjoC2uTTfl51COhPWIfmn2lnTRl1G7g=;
        b=UftWM2POKLlVBLzbY0aIeEgKtd72seDyphwYK/uN1GrVKqqYlAcXJt+ZTOqustDkzv
         znUqMNLiOM2itohGQD5JQY9pMPd/Z636kHkAq55NotW2d0qrxROiwaPFspT6J57gTeto
         eQsLHu9mt8ONyr+OjwqdeXxCDd9QhccTervzi0s+CY6ND+0RvWlrkQMLpNoVqLoxpvGR
         CTCo7kfcj+cP1bQV3M+lHq5dvMx3XeCpHkNtHH0rYf3CGvQsFeZLuq1/0OauyPAA8ot2
         t6/Pb35nDM/dSiUvn+xBNefr3Tqe28wog9BNkJuy/9UqLPmDMJLjJoRMoHUmxpv6+JqO
         JaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEfi7pnbeMsyrjoC2uTTfl51COhPWIfmn2lnTRl1G7g=;
        b=EkTziaLfA0eP1jbnnsHCbI/dWejtmm5Ms5lipO3iZ6MUT9ssEfryOsI+AgK/63gYa0
         Yo7+XdBxJYCQ3t6Zbt2yo4/ui1HDoopzG4eAfjGFz5q8wcLj4ocTozf0dOLA8xQQWDDv
         971exbcdMqhazAT1VZg03xN7qc/yhspRQq2/IOW+KDPKG2RlzndLr7DlTxl/x5+tz7/d
         Xug6nXUPT6RONeX323FUa+Yk2OyLQnQIJH7qzdlOr4YLQuugulstMcWHYKiHwk11S8VP
         nC+mLnrnSNKaiSABX3OPOd6zSjfwLcWxaBw5mrB8Y4Pk2VVrcoyKSHJ24urcJKD48Sj1
         uPSQ==
X-Gm-Message-State: APjAAAX+gBTJivVgHzsgDPEA/bcA+03eOIJyCP9SOCvTU2nmbRacJQfe
        PpBNs9RwDUYkbA/2WaR7D0unuum2xnI=
X-Google-Smtp-Source: APXvYqypjF6RDvbQm42/fVspcC6aruNWkmZ4K+PgawkfVpGfi3cPIAvdYhtaTEc7Vo8hzpzTeIq97Q==
X-Received: by 2002:a02:a09:: with SMTP id 9mr6866280jaw.84.1572988399449;
        Tue, 05 Nov 2019 13:13:19 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q69sm3065721ilb.4.2019.11.05.13.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:13:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, asml.silence@gmail.com, liuyun01@kylinos.cn
Subject: [PATCHSET 0/2] io_uring support for linked timeouts
Date:   Tue,  5 Nov 2019 14:11:29 -0700
Message-Id: <20191105211130.6130-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

First of all, if you haven't already noticed, there's a new and shiny
io_uring mailing list. It's:

io-uring@vger.kernel.org

Subscribe if you are at all interested in io_uring development. It's
meant to cover both kernel and user side, and everything from questions,
bugs, development, etc.

Anyway, this is support for IORING_OP_LINK_TIMEOUT. Unlike the timeouts
we have now that work on purely the CQ ring, these timeouts are
specifically tied to a specific command. They are meant to be used to
auto-cancel a request, if it hasn't finished in X amount of time. The
way to use then is to setup your command as you usually would, but then
mark is IOSQE_IO_LINK and add an IORING_OP_LINK_TIMEOUT right after it.
That's how linked commands work to begin with. The main difference here
is that links are normally only started once the dependent request
completes, but for IORING_OP_LINK_TIMEOUT they are armed as soon as we
start the dependent request.

If the dependent request finishes before the linked timeout, the timeout
is canceled. If the timeout finishes before the dependent request, the
dependent request is attempted canceled.

IORING_OP_LINK_TIMEOUT is setup just like IORING_OP_TIMEOUT in terms
of passing in the timespec associated with it.

I added a bunch of test cases to liburing, currently residing in a
link-timeout branch. View them here:

https://git.kernel.dk/cgit/liburing/commit/?h=link-timeout&id=bc1bd5e97e2c758d6fd975bd35843b9b2c770c5a

Patches are against for-5.5/io_uring, and can currently also be found in
my for-5.5/io_uring-test branch.

 fs/io_uring.c                 | 203 +++++++++++++++++++++++++++++++---
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 187 insertions(+), 17 deletions(-)

-- 
Jens Axboe


