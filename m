Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F937C56202
	for <io-uring@archiver.kernel.org>; Wed, 25 Nov 2020 18:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B0520674
	for <io-uring@archiver.kernel.org>; Wed, 25 Nov 2020 18:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxY0wNDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgKYSoq (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 25 Nov 2020 13:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgKYSoq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 25 Nov 2020 13:44:46 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA083C0613D4
        for <io-uring@vger.kernel.org>; Wed, 25 Nov 2020 10:44:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so945988wrn.1
        for <io-uring@vger.kernel.org>; Wed, 25 Nov 2020 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9J1PCFFhysvCCHh1ezpOGgHWFJA71CQwmEFvfsib/9Y=;
        b=pxY0wNDAubkJb/232TLkvpujhUZpUmSdQThD3Lol5owdWhuJ10VpJcZcdbIuZVZ+BK
         NKSm/jlB4J/FDIxP57tl8dUJoZXy0x82ahCUzIr/KBUeMe4Ywjl6QxWz3W//s9Q4YW8A
         1Eh+nYggCVM3inJIwcTs9EAZm+gqne6M5VEZ2d0a325ocmt3Uv3fTSBsBJUHzg20wV4w
         qFzEK7mBay344joXu1eXZARNyd3FxS7wdi1HxUcA+JpDjCF4oRMLhT71MzkrmeH1LoXc
         XLN0V6hceU+ww7CVzZ9J1R00vDNeQUHk2cQ0v02k/RKdzUW9pX/bqjEFw2ljCxupE+mP
         n3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9J1PCFFhysvCCHh1ezpOGgHWFJA71CQwmEFvfsib/9Y=;
        b=Tu/XM2HLCy2+HrfJXp/Ue8OEzYLx8i+4DFh9iYuJlqolek0A8gyg1OGfkbCHFyQNlD
         Mhf20JQyL7WoChLpoufC/lAYf5RRrSe3l3xtrH/2Cd6Y2M4FHjUvg2MUzroVXx+Ff8Xx
         K6bH23ltT05W7MFIkSA/JNk45CUjxEtP00m0WMftFJX/35KtZSiiNUav2GbBei9/o/7l
         Eqv9afFY19XWpcgu8YLmLqjojGUIWDF/XctAJye/thHMyMAFBkOQ3DwAuG0nZqVEF+mZ
         LhmTeFC1oz8Hckke4fSLMnT3Oh8fVOB7l2J5ZLKEA0bHjYCWTyW5MgG17ZgElT1ddJIo
         sFHA==
X-Gm-Message-State: AOAM532hP6M9Uf+BIr5dmwvammqYQc3gL7bf6O3dgkJX5i2D6Ev73ePa
        DJF0ipd9QF33aJEzTGHAxXbJtzdBNAO45w==
X-Google-Smtp-Source: ABdhPJzeg8BEh9YfVJlJ9WlVuQpq3XJ2vd77DhKAvjrxLrRJ7LjQEIztaKA7RIMC50mz3/v9HVI2ow==
X-Received: by 2002:adf:e551:: with SMTP id z17mr5669509wrm.374.1606329884422;
        Wed, 25 Nov 2020 10:44:44 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id l11sm5092483wmh.46.2020.11.25.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 10:44:43 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 5.10] io_uring: fix files grab/cancel race
Date:   Wed, 25 Nov 2020 18:41:28 +0000
Message-Id: <687c411007d0ec6a2be092ddc0274046898e43b5.1606329549.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

When one task is in io_uring_cancel_files() and another is doing
io_prep_async_work() a race may happen. That's because after accounting
a request inflight in first call to io_grab_identity() it still may fail
and go to io_identity_cow(), which migh briefly keep dangling
work.identity and not only.

Grab files last, so io_prep_async_work() won't fail if it did get into
->inflight_list.

note: the bug shouldn't exist after making io_uring_cancel_files() not
poking into other tasks' requests.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ff6deffe5aa9..1023f7b44cea 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1313,22 +1313,6 @@ static bool io_grab_identity(struct io_kiocb *req)
 			return false;
 		req->work.flags |= IO_WQ_WORK_FSIZE;
 	}
-
-	if (!(req->work.flags & IO_WQ_WORK_FILES) &&
-	    (def->work_flags & IO_WQ_WORK_FILES) &&
-	    !(req->flags & REQ_F_NO_FILE_TABLE)) {
-		if (id->files != current->files ||
-		    id->nsproxy != current->nsproxy)
-			return false;
-		atomic_inc(&id->files->count);
-		get_nsproxy(id->nsproxy);
-		req->flags |= REQ_F_INFLIGHT;
-
-		spin_lock_irq(&ctx->inflight_lock);
-		list_add(&req->inflight_entry, &ctx->inflight_list);
-		spin_unlock_irq(&ctx->inflight_lock);
-		req->work.flags |= IO_WQ_WORK_FILES;
-	}
 #ifdef CONFIG_BLK_CGROUP
 	if (!(req->work.flags & IO_WQ_WORK_BLKCG) &&
 	    (def->work_flags & IO_WQ_WORK_BLKCG)) {
@@ -1370,6 +1354,21 @@ static bool io_grab_identity(struct io_kiocb *req)
 		}
 		spin_unlock(&current->fs->lock);
 	}
+	if (!(req->work.flags & IO_WQ_WORK_FILES) &&
+	    (def->work_flags & IO_WQ_WORK_FILES) &&
+	    !(req->flags & REQ_F_NO_FILE_TABLE)) {
+		if (id->files != current->files ||
+		    id->nsproxy != current->nsproxy)
+			return false;
+		atomic_inc(&id->files->count);
+		get_nsproxy(id->nsproxy);
+		req->flags |= REQ_F_INFLIGHT;
+
+		spin_lock_irq(&ctx->inflight_lock);
+		list_add(&req->inflight_entry, &ctx->inflight_list);
+		spin_unlock_irq(&ctx->inflight_lock);
+		req->work.flags |= IO_WQ_WORK_FILES;
+	}
 
 	return true;
 }
-- 
2.24.0

