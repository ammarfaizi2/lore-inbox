Return-Path: <SRS0=wdjZ=AV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4095DC433E0
	for <io-uring@archiver.kernel.org>; Fri, 10 Jul 2020 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F8A2063A
	for <io-uring@archiver.kernel.org>; Fri, 10 Jul 2020 14:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJO1E (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:27:04 -0400
Received: from sym2.noone.org ([178.63.92.236]:46840 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgGJO1E (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 10 Jul 2020 10:27:04 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4B3Fjg4QyWzvjc1; Fri, 10 Jul 2020 16:27:03 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     io-uring@vger.kernel.org
Subject: [PATCH] test/statx: test for ENOSYS in statx_syscall_supported
Date:   Fri, 10 Jul 2020 16:27:03 +0200
Message-Id: <20200710142703.32444-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

errno will be ENOSYS, not EOPNOTSUPP if the syscall is not there. This
also matches what errno is set to in do_statx if __NR_statx is not
defined.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 test/statx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/statx.c b/test/statx.c
index 66f333f93cf9..c846a4ad5b9f 100644
--- a/test/statx.c
+++ b/test/statx.c
@@ -51,7 +51,7 @@ static int create_file(const char *file, size_t size)
 
 static int statx_syscall_supported(void)
 {
-	return errno == EOPNOTSUPP ? 0 : -1;
+	return errno == ENOSYS ? 0 : -1;
 }
 
 static int test_statx(struct io_uring *ring, const char *path)
-- 
2.27.0

