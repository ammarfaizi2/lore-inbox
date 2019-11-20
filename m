Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12310C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42DF2240E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKTDOh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:14:37 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:42225 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfKTDOh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 22:14:37 -0500
X-QQ-mid: bizesmtp12t1574219666t3ksz79r
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 20 Nov 2019 11:14:26 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZVF0000A0000000
X-QQ-FEAT: ekydxxszt+9k+IliPyB+e/nh+JpYSFRHMhyiEA0RhmJBkVVpRJSmwSOzKssBE
        ImDou9cvGSYZa2fe3ZP2TZ8FgpGt3sVUaMgnjjMP4j/2ANz4Gulchjv1sVDMocjXSaJBayk
        fLHuyyo6ipV3B3eNreYNuOHofYIXGcv1BKUhJukxPOLHQxuJShrv2Q0aPPeX5565jPxPVmn
        2mBZMGo+yNZ3L3R5yiKBUYbAHh0dp0Dg+Ku6BGu5lnpiU8BvFCKfHyBKlpRYL6AwT83/ZB8
        /ewjVXK7JFzunzY0YMua+9YOZsW/CEogsOm+cl2qfh0lXqvS0swZiT+zlkGHTrA2UeNxWSi
        CrslgiGfvUQWWDNPwjL9/xdGvMryA==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [PATCH liburing 2/3] Avoid redefined warning of "SIGSTKSZ"
Date:   Wed, 20 Nov 2019 11:14:21 +0800
Message-Id: <20191120031422.49382-2-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120031422.49382-1-liuyun01@kylinos.cn>
References: <20191120031422.49382-1-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

ucontext-cp.c:24:0: warning: "SIGSTKSZ" redefined
 #define SIGSTKSZ 8192

In file included from /usr/include/signal.h:316:0,
                 from ucontext-cp.c:13:
/usr/include/aarch64-linux-gnu/bits/sigstack.h:30:0: note: this is the location of the previous definition
 #define SIGSTKSZ 16384

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 examples/ucontext-cp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/examples/ucontext-cp.c b/examples/ucontext-cp.c
index 3e95b15..d521e94 100644
--- a/examples/ucontext-cp.c
+++ b/examples/ucontext-cp.c
@@ -21,7 +21,9 @@
 #define QD	64
 #define BS	1024
 
+#ifndef SIGSTKSZ
 #define SIGSTKSZ 8192
+#endif
 
 typedef struct {
 	struct io_uring *ring;
-- 
2.17.1



