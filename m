Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19364C4332B
	for <io-uring@archiver.kernel.org>; Wed, 23 Dec 2020 11:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CE8222F9
	for <io-uring@archiver.kernel.org>; Wed, 23 Dec 2020 11:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgLWL1J (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:27:09 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59312 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728352AbgLWL1J (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 23 Dec 2020 06:27:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UJXjw8Y_1608722785;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UJXjw8Y_1608722785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Dec 2020 19:26:26 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        io-uring@vger.kernel.org
Subject: [PATCH RFC 4/7] block: define blk_qc_t as uintptr_t
Date:   Wed, 23 Dec 2020 19:26:21 +0800
Message-Id: <20201223112624.78955-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223112624.78955-1-jefflexu@linux.alibaba.com>
References: <20201223112624.78955-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

To support iopoll for bio-based device, the returned cookie is actually
a pointer to an implementation specific object, e.g. an object
maintaining all split bios.

In such case, blk_qc_t should be large enough to contain one pointer,
for which uintptr_t is used here. Since uintptr_t is actually an integer
type in essence, there's no need of type casting in the original mq
path, while type casting is indeed needed in bio-based routine.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index da5ca7e1bea9..f6301014a459 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -126,7 +126,7 @@ typedef u64 sector_t;
 typedef u64 blkcnt_t;
 
 /* cookie used for IO polling */
-typedef unsigned int blk_qc_t;
+typedef uintptr_t blk_qc_t;
 
 /*
  * The type of an index into the pagecache.
-- 
2.27.0

