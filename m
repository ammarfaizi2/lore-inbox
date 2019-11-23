Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36983C432C3
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 21:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F198F206D4
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nPXvOTmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKWV1S (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:27:18 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43631 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWV1S (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 16:27:18 -0500
Received: by mail-pl1-f176.google.com with SMTP id q16so534860plr.10
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdR+fOWOXTaHGK56KazV3JC50sh8Nx5JD/1Vsro/I3g=;
        b=nPXvOTmB+ToT5tep2B45o6uHDZuqO09bZVj1j1M0iiawyQZz2L5qmc+8LC5Eim/9CP
         XcAnQZMkPy0Z76af+tlVrHg5hWrjWKm0OhUU/OrPu+aKidQy7goWkkZ/T4q/EZBwfDIZ
         drBAa0DK/YZq343S45/KVkwkkOIta0blCibdcoFgUowToRYP2pWJQLkJQCdtvwpfweV6
         M9aHFfOmbN7yTFXkuLdwOgABgh9U2C9IjLyu3vZwy6VrzXHOZLXUQVb57p1dNoQT2fYE
         iE6MzxWiLwHNgxM5mD3tW/unYv/icyW1T7w85n0oeNRIBcdhW1PgLPf37T3VTR/hx6CS
         p7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdR+fOWOXTaHGK56KazV3JC50sh8Nx5JD/1Vsro/I3g=;
        b=Ikap7DxxRSlyHLWHDYnz4nbrzNvuSdGnGTb2Pt2b0R/Q4uXox/Xh418pyUOO3e0KKY
         EIvYSTXBTbgeT0KXRfYcryRgOA9ZkBiZWFuytc5oLzyFKy2DWXba14/KGUg5KbcZPS86
         WbqjBX3eg0pGamCX+VIUXqjLfQ1/YwkN9fgkC8w2aORJjgI1uvl9IzMo3FNyzLCXDcmL
         yfo/AoM+N2yE9fsjSXPiMkL7pFiFtqWS4gB4+Mfo5fEKS53srmnC6yb2NnNNh/EDQ7hj
         wEBPfnYb4t778DuUVyjL1qbvWioYr/nnxWu1b1LZfQEem9mmVG4iyWy5I2yh7rcREEKS
         TeKQ==
X-Gm-Message-State: APjAAAXRWo4Mipak3fNxmX0HIvXQFFigLhbElfBVw10ASYVlxCgcal9R
        LUWQ97LFrhmSoJRcrJncRO2XdlLrO+wMUw==
X-Google-Smtp-Source: APXvYqwGG4ole6+3DlOJeO7VR3vTKapuCsbcjekkYaKxdF52tagORWOrUXg1GsyzHscM//z41qdCaA==
X-Received: by 2002:a17:90b:3d3:: with SMTP id go19mr27965056pjb.78.1574544435357;
        Sat, 23 Nov 2019 13:27:15 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id gx16sm2981169pjb.10.2019.11.23.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:27:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCHSET 0/2] io_uring: add support for connect()
Date:   Sat, 23 Nov 2019 14:27:07 -0700
Message-Id: <20191123212709.4598-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Pretty trivially done, now that we support file table inheritance.
This is done in a similar fashion to the accept4() support, by adding
a __sys_connect_file() helper and using that from io_uring.

 fs/io_uring.c                 | 37 +++++++++++++++++++++++++++++++++++
 include/linux/socket.h        |  3 +++
 include/uapi/linux/io_uring.h |  1 +
 net/socket.c                  | 30 ++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 8 deletions(-)

-- 
Jens Axboe


