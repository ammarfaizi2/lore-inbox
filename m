Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95EDC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B7B2075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nhiVCdc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKTUKE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:10:04 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39572 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKTUKE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:10:04 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so862472ild.6
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ttAnQr/b1G17Kqhx6Whp6JZsHbNbNjNWOAyibxt0eDM=;
        b=nhiVCdc1uhkG4onQi2duXGaQSNXnIcWrQdiwbtKc7nRXO/Htii0VnegO5/AbHcVM07
         5vyNKKFhMz8/vXcqLvZbXbgXSKAfk0Xvo395uau21+4RwQcPMIXL+Mkb2+UdFrARounW
         +fQBxx6FKk1ktdJJY+9YINRiSgOBdQYuy2UMLgVkRD5f5C3iM7fzrgUbZkcfkVeZjYrv
         JMsExe+FBQxqUQJhKKZAOaKNST6qPRALTbNcM8Z6244LsvMI7fxIyje8RcbFLAGxeYDa
         dmzBXcRGyq2nP/yjA3ls5SGSkfnNpR56+SROfcP5wsk7ZpGk5bxOsLgngFo6AYBvWLD8
         qIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ttAnQr/b1G17Kqhx6Whp6JZsHbNbNjNWOAyibxt0eDM=;
        b=HgFmAzW+v/2ic+IzEQcu37IwmM6p3mX30mKaEgkTZwuYn337443umtbXlRO1NEi0ri
         /9A+sJHOw9vZq6tnX9QCVSTC+l1T9YYMwEQKCjVGB59VNqM6SFAAcbvk26ocsJ2EQgXl
         bO1uOwDfvKR4nyFflaqyseaMWEH55IU1981XVb4DTCw3zEpPZpZ6sF9z2Jp6Fxnm/WMN
         dCwCBAq6R25dSGV8P2TfbL0P30gsRiggTr1r/u03lG+BXiIxAxsN86Byp07t7/0U3Xip
         SYydGHDle+j2tD9yGgPjk3oYsDa817hiR+u1Wes9C0uROtOz8ePWW34ORj8k8+uqM0Kz
         je7w==
X-Gm-Message-State: APjAAAWJS/Gmn6VkZFRKXbfM/Srur3Xu4hmO1LW47q01q5JLsGqqYhe5
        nHFhKt5Xc5jhME11MwKD0Yk0QxlZrN7Iyw==
X-Google-Smtp-Source: APXvYqwEG3ryid0IX1CPfaOapbtCWJh9EMk4rGeQkPvcb6TkHvtpXfxhztqWSB4+lF1ceiP55yx9Yg==
X-Received: by 2002:a92:6a10:: with SMTP id f16mr5669016ilc.175.1574280602774;
        Wed, 20 Nov 2019 12:10:02 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] io_uring: io_fail_links() should only consider first linked timeout
Date:   Wed, 20 Nov 2019 13:09:36 -0700
Message-Id: <20191120200936.22588-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We currently clear the linked timeout field if we cancel such a timeout,
but we should only attempt to cancel if it's the first one we see.
Others should simply be freed like other requests, as they haven't
been started yet.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a79ef43367b1..d1085e4e8ae9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -937,12 +937,12 @@ static void io_fail_links(struct io_kiocb *req)
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
-			req->flags &= ~REQ_F_LINK_TIMEOUT;
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
 			__io_double_put_req(link);
 		}
 		kfree(sqe_to_free);
+		req->flags &= ~REQ_F_LINK_TIMEOUT;
 	}
 
 	io_commit_cqring(ctx);
-- 
2.24.0

