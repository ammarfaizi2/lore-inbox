Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B49FC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7062166E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTnwxO7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfKFSMc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:12:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFSMc (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 13:12:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id w30so4398596wra.0;
        Wed, 06 Nov 2019 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tDfwaqxb1M4UbCJEjna0w9A0Ql9gQ1jxNo5SgDvoKU=;
        b=tTnwxO7Hgj899HpTs2ymdSb6286hfIsmNV0BVLNfUclNbzFHoTVyeWzDYoYNtK1KH4
         EPzYu7zp5c/Hs3zePHTZg3gxQD9FhscY6IIAZ5VgbXK5MrVmaILzQ3Js9lOCoeT5Z5T+
         bo/lrjhFq4sTRT4bcKHIXwfxO41vk5C++zTjEuPURVjZUN0bAUlEdIwQqEg8JwxQ71Hr
         2ENgSjv6xPo73YvyhAw2nGh3XZHX1Bi+L8Wk6s4AgkbjGaYsMqis9kt1RTgX0J5UHJQN
         JO6w2KqNnP6YWMbrd+puCoENNbtohvAh5L3WhTi+d24bXn+AjaobcVO38H4AGFrTv16j
         bZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tDfwaqxb1M4UbCJEjna0w9A0Ql9gQ1jxNo5SgDvoKU=;
        b=daMXUgK9pZd4JwQyPi3HTuYYQyXpPYIR9xvmW3KNCDJiTA8qagwDAHKM7r2M3vrnk4
         ZZJSatJEZxu8C0kTKZtWrH4vHlyjqOeKL2I3vGN8xq/mLUTPOVW3wUyyee/wuC8ayQD8
         HMwt54CiDmCqwiK71UV///U/vn8eLutDPeOWAQ21ozPcTOZKp81tZ4blivbc48P3Pje8
         swGKwkFHojPXLkEexJXTD0ISvbb88dNuUbslGuiz8u+oSluRykLhQszN1eRilgFrSBd0
         7sN8dvVm88v0N759jBaEEwGy3vsoxC4nu05PpX7Ybc0W9rKwmxVHJURYxmvCg5f+jdQu
         v4/w==
X-Gm-Message-State: APjAAAVqMPOqpV9bCmpbCL/kzMxrljBZ1SbctXcNlL6DfgkUNKmsfelD
        7v1Hf8jnN86pjJS307QpPfY=
X-Google-Smtp-Source: APXvYqxpoFbYdrJV97T0YEdaz2jhVMLklrjlyU+jXhMOcVA/tRacXq6i70vwd+niqPOogiM+5CDGJg==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr3956886wrm.123.1573063950384;
        Wed, 06 Nov 2019 10:12:30 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id o187sm3564564wmo.20.2019.11.06.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 10:12:29 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Bob Liu <bob.liu@oracle.com>
Subject: [PATCH 1/1] io_uring: Remove extra io_commit_sqring()
Date:   Wed,  6 Nov 2019 21:12:08 +0300
Message-Id: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

io_submit_sqes() calls io_commit_sqring() at the end, so there is no
need for sq_thread to repeat it.

Fixes: 09c0eb1f1b93b9cf ("io_uring: Merge io_submit_sqes and
io_ring_submit").

Reported-by: Bob Liu <bob.liu@oracle.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ba77475c1cec..6524898831e0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2868,9 +2868,6 @@ static int io_sq_thread(void *data)
 		to_submit = min(to_submit, ctx->sq_entries);
 		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
 					   true);
-
-		/* Commit SQ ring head once we've consumed all SQEs */
-		io_commit_sqring(ctx);
 	}
 
 	set_fs(old_fs);
-- 
2.23.0

