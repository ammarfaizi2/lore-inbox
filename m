Return-Path: <SRS0=rKMY=5K=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199E8C1975A
	for <io-uring@archiver.kernel.org>; Wed, 25 Mar 2020 03:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E596220724
	for <io-uring@archiver.kernel.org>; Wed, 25 Mar 2020 03:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCYDbt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:31:49 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:41131 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCYDbt (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 24 Mar 2020 23:31:49 -0400
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id EE9A3261A11;
        Wed, 25 Mar 2020 11:31:45 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Chucheng Luo <luochucheng@vivo.com>
Subject: [PATCH] io_uring:fix missing 'return' in comment
Date:   Wed, 25 Mar 2020 11:31:38 +0800
Message-Id: <20200325033138.21488-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVDSUhLS0tPSEpLTUtMQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxQ6Mio6MTgyMCwyDzAuEhgC
        EwoaCRFVSlVKTkNOSktMSktNSE9LVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTFlXWQgBWUFKTUpMNwY+
X-HM-Tid: 0a710fbef9be9375kuwsee9a3261a11
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

the missing 'return' work may make it hard
for other developers to understand it.

Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5a826017ebb8..4b971c7b4483 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2379,7 +2379,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 		else
 			ret2 = loop_rw_iter(WRITE, req->file, kiocb, &iter);
 		/*
-		 * Raw bdev writes will -EOPNOTSUPP for IOCB_NOWAIT. Just
+		 * Raw bdev writes will return -EOPNOTSUPP for IOCB_NOWAIT. Just
 		 * retry them without IOCB_NOWAIT.
 		 */
 		if (ret2 == -EOPNOTSUPP && (kiocb->ki_flags & IOCB_NOWAIT))
-- 
2.17.1

