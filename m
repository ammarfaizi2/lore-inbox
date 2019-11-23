Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E29FC432C0
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326D320706
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOr+JcfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKWWuN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:50:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41482 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWWuN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 17:50:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so12908618wrj.8
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 14:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/Jj+P6LURDgNN6MQYAa0q5eo670hcJ4Vx83EAn1ILs=;
        b=eOr+JcfKUvZb2fKgmkEY+v30GtRHApE8qOw0jecSNef74wHQLv6d+/SRWMu8yeWwe5
         PjUYhWMy2Yn903TakjbJvnp9ypmMd4EmMJzBb7Mv1SR7HXJMB0QOooMQghRscCkyMd/S
         q26Gi98fMRUOv5XIBFVnQQY8UwqLLyTQV8dgi4kgbWgkjVCQHgL8PTijd/G2xW84337R
         o5ZzX+TUjP6xDGwFiRPkmp0kA5zjUtp6FUM8xoSH4bZraeWkEQq8J99daNh4ypEYXZEj
         JTrUzFEPY/dYWY1WTaLQzmwln/CDqbRGyGcEVy6eEhMz2w7R/mYp3YHt+VELGY68rD7u
         BtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/Jj+P6LURDgNN6MQYAa0q5eo670hcJ4Vx83EAn1ILs=;
        b=dvepkP8kSweJy2rMSpjnO+h9qLiB6lUm8/vnk4LoguaRg5jz6hgJF8sPOJYqAADmqO
         K/DOls2v+KxIXvP88O3eU1cv1XxJ6ND0Hi8qThs96ZLbL6g01ycgnmz02xb5QX8OROE9
         TOVLZDwB1T5U7V6rFBE4t0ykGylrGKJULXp9VioyqItSen4NA/PC6AfcAHsyS1111nWS
         hNr84feoqj7eynvl8Z1n1wGMrRSKbboPlm8MumHvdYPpW0L8q/tsuvbvxk8VpyHxCzMt
         KctY/fBit8Bj93cDKLAjzORbHwf90Ml7JsYfAHX0qdgLVVm8mAU5KBLqEF2K2enhceTQ
         9pow==
X-Gm-Message-State: APjAAAUMmCVuh38l12dRe6ZBG0kpgDr2rfBWoh5cjCgnk3NgXcqxfThy
        3feqoHUJMC9z7838EcFDNfwOyD2b
X-Google-Smtp-Source: APXvYqwdW0HeiaMXMZ7gxB9FFKST87qT2CxMy7ADS8l0/y35q4tK+SosLMKc2yFs1AFOnn/lxL99NA==
X-Received: by 2002:a5d:4d0c:: with SMTP id z12mr22400823wrt.139.1574549411369;
        Sat, 23 Nov 2019 14:50:11 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l10sm4110745wrg.90.2019.11.23.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 14:50:10 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [RFC 0/2] fix in-kernel segfault
Date:   Sun, 24 Nov 2019 01:49:42 +0300
Message-Id: <cover.1574549055.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There is a bug hunging my system when run fixed-link with /dev/urandom
instead of /dev/zero (see patch 1/2).

As for me, the easiest way to fix is to grab mm and use userspace
address for this specific case (as it's done in patches). The other
way is to kmap/vmap, but the first should be short-lived and the
second needs mm anyway.

Ideas how to do it better way? Suggestions and corrections are welcome.

P.S. It seems for some reason it fails a bunch of unrelated tests,
that's POC and not meant to be applied yet.


Pavel Begunkov (2):
  io_uring: fix dead-hung for non-iter fixed rw
  io_uring: fix linked fixed !iter rw

 fs/io_uring.c | 95 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 35 deletions(-)

-- 
2.24.0

