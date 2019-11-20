Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C79C432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689F62075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ak5um8o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfKTUJ7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:59 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40931 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTUJ7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:59 -0500
Received: by mail-il1-f195.google.com with SMTP id d83so854898ilk.7
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Ze3Sz9/DbtHT92Ms4t7Qc6Y4JvnSHBAHM7NU0ru5wA=;
        b=ak5um8o/xGFcQB9xKv6AhBeBFMQDyb3e3oQvQtqoBNkh/sPrv7AimkRu95oVh00zu1
         w4bDsqKA5H/X7Db0W7yi8O+cVaPw+6czJdaSMpLzz90jpEQIhT8j7NYH6zZiH0gfGIG3
         qrXRllhk+xX1gX0VbASHWBMRx/PJ+6HvEtpH4MwH97qzGxpaVOJuZ/3YzJJ76PREer7V
         LU1zasryUJVSNWzlyiRdbhNAuGgx7n5zzs9bklSyORiDqz51eBXpFBO3x4bBMNo2sm0I
         4ODaidK4wQPbmpHZbgXlJIT+1IyUatFMX7Z6wcxtRaV7lcXEn9Ab+HcPTebVZOxFLGs4
         mkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ze3Sz9/DbtHT92Ms4t7Qc6Y4JvnSHBAHM7NU0ru5wA=;
        b=qUTQBUU/iSMezxdGlWBj9th0gU2CnpmgEMOnMCD4RkrDRO30ob//siVxEfj263rTpc
         rLVO5tN3BzhdRinSP1EbcMQWecsiEgPD1eT/coKGQQvwDvGQ7NmvUQ410DTTnAdDzevS
         X3mhw1hVzwaL93UE96xGCDW2XXdCCC4rO10mubhB7TG7x8E0b6RMT18zP2ASdZ0XHKbK
         00oNiRG6CMz9a867fOojQYYkisRvwk2ola9sdOEWVQgNnNpCXjGzojgMJSCzYVu39a8N
         b3BpaFx4u6mXB0io4Oq9uuKA6EHGqEEHyVZFMBBwrj9BmQiF2lUSbNRQz4W8GtSp/P0p
         28dg==
X-Gm-Message-State: APjAAAXhPWB/pMyXpCfzX3QH6WtKxKMqo3iaUvLnmdHJKr5KifzaTQ0N
        U+dIoTn73fisZaStMI/6YhKrY+KvRXvwww==
X-Google-Smtp-Source: APXvYqxxMeN8hluorjAIxP+5hNYS2UwjUOubixfAiri3GUkI2CxCxu3UYf3oUIloZuZT6uSxqr/exQ==
X-Received: by 2002:a92:35dd:: with SMTP id c90mr5231745ilf.191.1574280597801;
        Wed, 20 Nov 2019 12:09:57 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/7] io_uring: remove redundant check
Date:   Wed, 20 Nov 2019 13:09:34 -0700
Message-Id: <20191120200936.22588-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Pass any IORING_OP_LINK_TIMEOUT request further, where it will
eventually fail in io_issue_sqe().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7b9bd6ad4fb9..8d25e157b4d8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3064,10 +3064,6 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
-	} else if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
-		/* Only valid as a linked SQE */
-		ret = -EINVAL;
-		goto err_req;
 	} else {
 		io_queue_sqe(req);
 	}
-- 
2.24.0

