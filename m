Return-Path: <SRS0=3fu8=DC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC1C4727E
	for <io-uring@archiver.kernel.org>; Fri, 25 Sep 2020 04:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C022621D91
	for <io-uring@archiver.kernel.org>; Fri, 25 Sep 2020 04:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pu6N7lQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIYEwC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 25 Sep 2020 00:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYEwB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 25 Sep 2020 00:52:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE87C0613D6;
        Thu, 24 Sep 2020 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tfXqHGtFwgmM6UcSRx58+EM7ODTSdMOtwKoRg1u1yAY=; b=Pu6N7lQCb1Rzn/vuEAM+5KPGjX
        BkFo8T9dzxv/0bLMSXXve2AJx7GLCk5CC3R4Ai3QXXAsQD0Esc5mldBbPrIULY45pPbpDbvoDrrU5
        0y/rZt3NdsMe0g/YSE/jtyenAi2xicarompLKMm3oxiJQBJl3sVJebhfDzjP4rb2MDDW6NJFyk043
        bn005DtQkC0IcvqnCKWfSkFaGle8WWvJyIl1xKl1G7YhMMOzx5EoA1Ngf8NCwxfsbgxynDDaCVTgh
        BNKEdqs8oHltVqpj2BB8Ry/WCaQYj1FyeT/89FBsvMGDD1Te4BzMLY8sgN68ceoHuYqHSSvbf9L6H
        RjKlFFzQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLfi1-0002pi-5S; Fri, 25 Sep 2020 04:51:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/9] compat.h: fix a spelling error in <linux/compat.h>
Date:   Fri, 25 Sep 2020 06:51:38 +0200
Message-Id: <20200925045146.1283714-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925045146.1283714-1-hch@lst.de>
References: <20200925045146.1283714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There is no compat_sys_readv64v2 syscall, only a compat_sys_preadv64v2
one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index b354ce58966e2d..654c1ec36671a4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -812,7 +812,7 @@ asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
 		const struct compat_iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
 #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
-asmlinkage long  compat_sys_readv64v2(unsigned long fd,
+asmlinkage long  compat_sys_preadv64v2(unsigned long fd,
 		const struct compat_iovec __user *vec,
 		unsigned long vlen, loff_t pos, rwf_t flags);
 #endif
-- 
2.28.0

