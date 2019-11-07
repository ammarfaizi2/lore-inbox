Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAC0C43331
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43508218AE
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BcFm6Vno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKGS3d (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:29:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38481 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfKGS3c (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 13:29:32 -0500
Received: by mail-io1-f65.google.com with SMTP id i13so2047962ioj.5
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbZuiXoYbqb8t+/tVx/yaYADCpXsr8TUAPaFDAkuluQ=;
        b=BcFm6VnoJJnXNKLCdB5G2AZJU6UiqOAhXH/Q54zSetPwCbPL7qXERh5Kxb+tpVjFr4
         GMrVu5zcy7J+NgfZubp3GBsSW2Lw8nEHeztFaIKzpU5mTTJbdB+bqOkD+j6lBRww4P0A
         e3sMa8HqlX2E5GVdT7O7gy7cZTFIym4+4ezn69LXDoP1pM3RZkbXAaACu4GTr7h3kIpx
         WJY4LpYoCIRgLdkoTw/Oh2HEsarQOQOYIJhZuT/MRZSJP3DgDLEAmK2BfXH9BOAIZ+cy
         wDqEcEjQ33MrD3cbJ6/rYAwCDumWoEzOEywFBh5LzKm2ViHVUfFVpChPyAi4TaUZZcew
         A01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbZuiXoYbqb8t+/tVx/yaYADCpXsr8TUAPaFDAkuluQ=;
        b=aK/A7rP2K6yPfoIg2BsYWMRdsZ/0s8Zzy52eMQPdK7h6xXclkRjZCSVzN5KHG14vJc
         1EB0ghaHwtgzxS+IwkDSZyayOGOLKWhDHrZyYJ6T3T6tzdAAQKGS4USke0UZX7sDtTJO
         d4fn4upVPYIBsqTRwZasI23PNYUH0OuqDG8EV0WRQIUCzNpmBt5tnvvbBf6YedguJGpV
         qzJgUkwToZWY8wXInftjZObxoDf1eAiNAQcNNqkNz4Fhj0WWKzTjDSSyZ6SLipdw94TS
         8+oTeuKfzfusYVDsHECwqhjkQ9A267fsp7TcGZrbIsoPyno5EF9UItUSKnFDU5JpfGGg
         EAeQ==
X-Gm-Message-State: APjAAAUG7yq8izJf8kuQ8UBv4/hOQ/mt6+GdgfL3GU2dS5bRzCvoV7ox
        2uuxONQLVlS7VqzdSvnNRmKiw9cW/+8=
X-Google-Smtp-Source: APXvYqzuTMlOEE6FS9yfkP+dIiK24jMx2+brUac2q4PIDZ7vcdlOTlJuDSkVFhAeh+iEvzwWfFg4qw==
X-Received: by 2002:a6b:ee06:: with SMTP id i6mr5087020ioh.250.1573151370045;
        Thu, 07 Nov 2019 10:29:30 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm243727iog.55.2019.11.07.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:29:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: properly mark async work as bounded vs unbounded
Date:   Thu,  7 Nov 2019 11:29:20 -0700
Message-Id: <20191107182920.21196-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107182920.21196-1-axboe@kernel.dk>
References: <20191107182920.21196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Now that io-wq supports separating the two request lifetime types, mark
the following IO as having unbounded runtimes:

- Any read/write to a non-regular file
- Any specific networked IO
- Any poll command

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c48b891b962f..f8344f95817e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -505,6 +505,20 @@ static inline bool io_prep_async_work(struct io_kiocb *req)
 		case IORING_OP_WRITEV:
 		case IORING_OP_WRITE_FIXED:
 			do_hashed = true;
+			/* fall-through */
+		case IORING_OP_READV:
+		case IORING_OP_READ_FIXED:
+		case IORING_OP_SENDMSG:
+		case IORING_OP_RECVMSG:
+		case IORING_OP_ACCEPT:
+		case IORING_OP_POLL_ADD:
+			/*
+			 * We know REQ_F_ISREG is not set on some of these
+			 * opcodes, but this enables us to keep the check in
+			 * just one place.
+			 */
+			if (!(req->flags & REQ_F_ISREG))
+				req->work.flags |= IO_WQ_WORK_UNBOUND;
 			break;
 		}
 		if (io_sqe_needs_user(req->submit.sqe))
-- 
2.24.0

