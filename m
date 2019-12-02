Return-Path: <SRS0=qbp9=ZY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF42DC432C0
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 09:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89956215E5
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 09:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBJPC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:15:02 -0500
Received: from smtpbg511.qq.com ([203.205.250.109]:36589 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfLBJPC (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 2 Dec 2019 04:15:02 -0500
X-QQ-mid: Xesmtp5t1575278096tmzqwmmso
Received: from byteisland.com (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 02 Dec 2019 17:14:55 +0800 (CST)
X-QQ-SSF: 01000000000000B0SF101F00000000K
X-QQ-FEAT: t18+5aPmYSovp6wNNyLpLArVtOc0V6cYyWIVp/iXSqWOXnzi7Z9hWG9qiFVZ5
        TMh4GrOmgf1fvebaaIaj2dFDTCT3l8xqJLnBljFpI24DzwsyU7FARxE3tDkRNjhq5o2HspI
        D8DXchE2qw8YDJbsFxpbtGrT78bCp6WuSt8Rrcv6FsUxXIZhx6wxmIL6Ls9EIl25wbDiQkf
        ZXE2x5PWKxGXao8kqV4WhqUngTUjqr5vAKsjtMzF4K+j15WP90pRZKqFNsUlmyQDV97tGBW
        fntQ5AzX1yJWQbG7eF2s3gCWc=
X-QQ-GoodBg: 0
From:   Jackie Liu <jackieliu@byteisland.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [PATCH 2/2] io_uring: remove io_wq_current_is_worker
Date:   Mon,  2 Dec 2019 17:14:53 +0800
Message-Id: <20191202091453.3038-2-jackieliu@byteisland.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202091453.3038-1-jackieliu@byteisland.com>
References: <20191202091453.3038-1-jackieliu@byteisland.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb4
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Since commit b18fdf71e01f ("io_uring: simplify io_req_link_next()"),
the io_wq_current_is_worker function is no longer needed, clean it
up.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io-wq.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/io-wq.h b/fs/io-wq.h
index 600e0158cba7..771f3cda5ffd 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -118,10 +118,6 @@ static inline void io_wq_worker_sleeping(struct task_struct *tsk)
 static inline void io_wq_worker_running(struct task_struct *tsk)
 {
 }
-#endif
+#endif /* CONFIG_IO_WQ */
 
-static inline bool io_wq_current_is_worker(void)
-{
-	return in_task() && (current->flags & PF_IO_WORKER);
-}
-#endif
+#endif /* INTERNAL_IO_WQ_H */
-- 
2.17.1

