Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018DC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B702240E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKTDOc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:14:32 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:58557 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfKTDOc (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Tue, 19 Nov 2019 22:14:32 -0500
X-QQ-mid: bizesmtp12t1574219664t3pblo7k
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 20 Nov 2019 11:14:23 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZVF0000A0000000
X-QQ-FEAT: Br92wPWbhaco1QJUQUMUwphcYNYbUdTtQTFmH2NBtgX2TeXjpIWCAUBxwJjFz
        u+UF1gwU58hXOc39UXrNjry55Cpk6hd4y9fRDj9W54sW25PFmQlk811y1Ytux0AYIpcKqFP
        WQdKjZYxqkYyTI9eh6g+z9S2NFpM7uIXwxOLL7HZ5JKXoXTpELqsO9GhpG943xGJ22UNU/3
        TLL2yV9dWeBgUDqicLAMkqtRZSgVb2CTBgKxp4sUKkNB+Lq6bTfuYMjjFQEzcEbZUTFQ/p6
        NlG3X9dYclm6ZKQdw4JhxzCIR6pMjgOpB/WqZ65/qL8Ghyi4229oPdUHWwKOfoj3XCZOouf
        CgnWZTApYZQKIxembc=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [PATCH liburing 1/3] mktemp is dangerous, better use mkostemp
Date:   Wed, 20 Nov 2019 11:14:20 +0800
Message-Id: <20191120031422.49382-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

jackieliu@aarch64:~/liburing$ make -C test
...
/tmp/ccoJ4CQ4.o: In function `main':
/home/jackieliu/liburing/test/500f9fbadef8-test.c:41: warning: the use of `mktemp' is dangerous, better use `mkstemp' or `mkdtemp'

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 test/500f9fbadef8-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/test/500f9fbadef8-test.c b/test/500f9fbadef8-test.c
index 88602ad..b480944 100644
--- a/test/500f9fbadef8-test.c
+++ b/test/500f9fbadef8-test.c
@@ -38,10 +38,9 @@ int main(int argc, char *argv[])
 	}
 
 	sprintf(buf, "./XXXXXX");
-	mktemp(buf);
-	fd = open(buf, O_WRONLY | O_DIRECT | O_CREAT, 0644);
+	fd = mkostemp(buf, O_WRONLY | O_DIRECT | O_CREAT);
 	if (fd < 0) {
-		perror("mkstemp");
+		perror("mkostemp");
 		return 1;
 	}
 
-- 
2.17.1



