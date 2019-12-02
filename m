Return-Path: <SRS0=qbp9=ZY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5D2C432C3
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA830215E5
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 09:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLBJPL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:15:11 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:57089 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBJPL (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 2 Dec 2019 04:15:11 -0500
X-QQ-mid: Xesmtp5t1575278094tdxggm4vz
Received: from byteisland.com (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 02 Dec 2019 17:14:54 +0800 (CST)
X-QQ-SSF: 01000000000000B0SF101F00000000K
X-QQ-FEAT: SBuRo+ovjF6vcSdhVwujCvFul8D7tj4p1Zbn0z2nq2gTjc67WgH0yE/6feJ/v
        E33eHS0zfLp9ACeBuX76qoeFKSW+h2qOw9MlxdkOMnPns7uM91h0C2UYAHp7ig6qZJbFBzH
        Wu/sWsR986jBaN2uvyaQuTdjRnrJqnQIuBTzeGWnXgxwrGGIZcmh2f3O/3QRogN4DeA/GUB
        vMxE7fABgZc7ynPTzghKMACMJwhoi7E425A3e10Bcb3rzLHphd7a8VZSiPlA+vk13FEq/pc
        RDz2DP9cdF89NfzNrPuZzm8J6C78UK7y5z2w==
X-QQ-GoodBg: 0
From:   Jackie Liu <jackieliu@byteisland.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [PATCH 1/2] io_uring: remove parameter ctx of io_submit_state_start
Date:   Mon,  2 Dec 2019 17:14:52 +0800
Message-Id: <20191202091453.3038-1-jackieliu@byteisland.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Parameter ctx we have never used, clean it up.

checkpatch.pl said:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2c2e8c25da01..9c55af1c1f22 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3112,7 +3112,7 @@ static void io_submit_state_end(struct io_submit_state *state)
  * Start submission side cache.
  */
 static void io_submit_state_start(struct io_submit_state *state,
-				  struct io_ring_ctx *ctx, unsigned max_ios)
+				  unsigned int max_ios)
 {
 	blk_start_plug(&state->plug);
 	state->free_reqs = 0;
@@ -3196,7 +3196,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		return -EBUSY;
 
 	if (nr > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, ctx, nr);
+		io_submit_state_start(&state, nr);
 		statep = &state;
 	}
 
-- 
2.17.1



