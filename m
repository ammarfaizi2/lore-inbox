Return-Path: <SRS0=jwyC=ZW=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0058C432C0
	for <io-uring@archiver.kernel.org>; Sat, 30 Nov 2019 01:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FFF215E5
	for <io-uring@archiver.kernel.org>; Sat, 30 Nov 2019 01:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfK3BvX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 20:51:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbfK3BvX (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 29 Nov 2019 20:51:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B342732A100D34C66C6;
        Sat, 30 Nov 2019 09:51:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:51:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
        <asml.silence@gmail.com>
CC:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] io_uring: Add missing include <linux/highmem.h>
Date:   Sat, 30 Nov 2019 09:50:42 +0800
Message-ID: <20191130015042.17020-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Fix build error:

fs/io_uring.c:1628:21: error: implicit declaration of function 'kmap' [-Werror=implicit-function-declaration]
fs/io_uring.c:1643:4: error: implicit declaration of function 'kunmap' [-Werror=implicit-function-declaration]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 311ae9e159d8 ("io_uring: fix dead-hung for non-iter fixed rw")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2c2e8c2..745eb00 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -69,6 +69,7 @@
 #include <linux/nospec.h>
 #include <linux/sizes.h>
 #include <linux/hugetlb.h>
+#include <linux/highmem.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
-- 
2.7.4


