Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC0C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA492245C
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuCwzDfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSUhi (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:37:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUhh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:37:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id a17so3400488wmb.0
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yW51+y/AhY9tYfKzqiktSM6WMmROHyBuE9JlOfMRpgk=;
        b=AuCwzDfd6nyVP6SmItmvTmEQhLA5Kj08fSxoOrxZOxREnkMKf3nOt/jhguCel8aO4p
         D16EmdHH7luJnI+Xq+YSvZIW9eniHXTnyfmuwVg5n3UxpaMlnSr5xUuOUL7hWpp78twJ
         SMAHuEv6EL26i5IX6iw541Xqi55Sy+Yq+Hr2JlKv12iYjr7jkNpOQaCX0D5OX9+umGbE
         OzFJdrHGrg2jXviFuKGGw2jT/hn/fv8oI5QPPTgsNP4VMUeg2bgrbmWD4mJh02Ye8j8h
         Kn7gDJdST3RoI8QiQfE84JrzZ0iFxt1+0VJPcBmM85etHtrn8WnZJa1iW9BuGDjXYeLk
         F5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yW51+y/AhY9tYfKzqiktSM6WMmROHyBuE9JlOfMRpgk=;
        b=KXxlJNdbYlbbY33gsr86sbbcU4xqC2dXcObgp3/dNP9DNG52+qadX+0+xJcfOJ4gDv
         Cs5KvdIw1IefVEsZzx6VMjtRBPMNLGZkuOUWhn23B9dqMPATVeBmKBxxn9QoQrPZgm2R
         S/GN+MREQByieeFY9QtoQ5xaqE9vzW4Id7XaDFl0jaaHf4xbdDv8wyySRul4T3yem7R5
         hpqAOg6DAkj2zTCcFkIU2OX+tRTa8b0hFKxCTCXWLKG8qD5pr7vEuoEwJhgOvygyrPo5
         bASrLZW/OT5wBpOdKhmgw+papXKSq8p2RbGuE4AagWH3Hxiiaz2lCRbCmacAVEcjCnjL
         xlpw==
X-Gm-Message-State: APjAAAUEP5w8qsuq3PjGe+oV0Ol04FE65Toa4y2QyWJAXF7SANUr51ZZ
        KMl6gt4DRsC0oCv/fRwS5fBSa5uN
X-Google-Smtp-Source: APXvYqxYPZEpIhdMwqX0GyRmCqwrf3OEmvLvU70XthEUpvua1cTfAkXoOjiT819kMBCs/ilDLI1ofw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr8776987wmc.130.1574195854754;
        Tue, 19 Nov 2019 12:37:34 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id f67sm4455903wme.16.2019.11.19.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:37:34 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH liburing] linked-timeout: check invalid linked timeouts
Date:   Tue, 19 Nov 2019 23:37:05 +0300
Message-Id: <3f42aab361c25ee4122c47a0dbe5a346816c4f5c.1574195785.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Check miscounting references for the following case:
REQ(fail) -> LINKED_TIMEOUT -> LINKED_TIMEOUT

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 test/link-timeout.c | 157 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/test/link-timeout.c b/test/link-timeout.c
index 6fcf701..46d8e93 100644
--- a/test/link-timeout.c
+++ b/test/link-timeout.c
@@ -12,6 +12,150 @@
 
 #include "liburing.h"
 
+static int test_fail_lone_link_timeouts(struct io_uring *ring)
+{
+	struct __kernel_timespec ts;
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	int ret;
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		printf("get sqe failed\n");
+		goto err;
+	}
+	io_uring_prep_link_timeout(sqe, &ts, 0);
+	ts.tv_sec = 1;
+	ts.tv_nsec = 0;
+	sqe->user_data = 1;
+	sqe->flags |= IOSQE_IO_LINK;
+
+	ret = io_uring_submit(ring);
+	if (ret != 1) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = io_uring_wait_cqe(ring, &cqe);
+	if (ret < 0) {
+		printf("wait completion %d\n", ret);
+		goto err;
+	}
+
+	if (cqe->user_data != 1) {
+		fprintf(stderr, "invalid user data %d\n", cqe->res);
+		goto err;
+	}
+	if (cqe->res != -EINVAL) {
+		fprintf(stderr, "got %d, wanted -EINVAL\n", cqe->res);
+		goto err;
+	}
+	io_uring_cqe_seen(ring, cqe);
+
+	return 0;
+err:
+	return 1;
+}
+
+static int test_fail_two_link_timeouts(struct io_uring *ring)
+{
+	struct __kernel_timespec ts;
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	int ret, i;
+
+	ts.tv_sec = 1;
+	ts.tv_nsec = 0;
+
+	/*
+	 * sqe_1: write destined to fail
+	 * use buf=NULL, to do that during the issuing stage
+	 */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		printf("get sqe failed\n");
+		goto err;
+	}
+	io_uring_prep_writev(sqe, 0, NULL, 1, 0);
+	sqe->flags |= IOSQE_IO_LINK;
+	sqe->user_data = 1;
+
+
+	/* sqe_2: valid linked timeout */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		printf("get sqe failed\n");
+		goto err;
+	}
+	io_uring_prep_link_timeout(sqe, &ts, 0);
+	sqe->user_data = 2;
+	sqe->flags |= IOSQE_IO_LINK;
+
+
+	/* sqe_3: invalid linked timeout */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		printf("get sqe failed\n");
+		goto err;
+	}
+	io_uring_prep_link_timeout(sqe, &ts, 0);
+	sqe->flags |= IOSQE_IO_LINK;
+	sqe->user_data = 3;
+
+	/* sqe_4: invalid linked timeout */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		printf("get sqe failed\n");
+		goto err;
+	}
+	io_uring_prep_link_timeout(sqe, &ts, 0);
+	sqe->flags |= IOSQE_IO_LINK;
+	sqe->user_data = 4;
+
+	ret = io_uring_submit(ring);
+	if (ret != 4) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0; i < 4; i++) {
+		ret = io_uring_wait_cqe(ring, &cqe);
+		if (ret < 0) {
+			printf("wait completion %d\n", ret);
+			goto err;
+		}
+
+		switch (cqe->user_data) {
+		case 1:
+			if (cqe->res != -EFAULT) {
+				fprintf(stderr, "write got %d, wanted -EFAULT\n", cqe->res);
+				goto err;
+			}
+			break;
+		case 2:
+			if (cqe->res != -ECANCELED) {
+				fprintf(stderr, "Link timeout got %d, wanted -ECACNCELED\n", cqe->res);
+				goto err;
+			}
+			break;
+		case 3:
+			/* fall through */
+		case 4:
+			if (cqe->res != -ECANCELED && cqe->res != -EINVAL) {
+				fprintf(stderr, "Invalid link timeout got %d"
+					", wanted -ECACNCELED || -EINVAL\n", cqe->res);
+				goto err;
+			}
+			break;
+		}
+		io_uring_cqe_seen(ring, cqe);
+	}
+
+	return 0;
+err:
+	return 1;
+}
+
 /*
  * Test linked timeout with timeout (timeoutception)
  */
@@ -684,7 +828,6 @@ int main(int argc, char *argv[])
 	if (ret) {
 		printf("ring setup failed\n");
 		return 1;
-
 	}
 
 	ret = test_timeout_link_chain1(&ring);
@@ -747,5 +890,17 @@ int main(int argc, char *argv[])
 		return ret;
 	}
 
+	ret = test_fail_lone_link_timeouts(&ring);
+	if (ret) {
+		printf("test_fail_lone_link_timeouts failed\n");
+		return ret;
+	}
+
+	ret = test_fail_two_link_timeouts(&ring);
+	if (ret) {
+		printf("test_fail_two_link_timeouts failed\n");
+		return ret;
+	}
+
 	return 0;
 }
-- 
2.24.0

