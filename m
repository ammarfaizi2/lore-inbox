Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161549AbWAMPYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161549AbWAMPYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWAMPYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:24 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:49276 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964974AbWAMPYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=NMwXFyN+jUm1VTwqKSpndKpgeTzFMXHuiSSJDzLbAeFkzXuX6Mor5Iz0+MhFLIJWmz+IYWlN6JmTbFjDkoB0lCW5a1MHkjbXlzQWhgLZVlMsq1EhEAxtGEXX7jgU4irFs2XzGtWICspHjl23LfNVxpPjnCG3eNGM4RYAt1bnoCk=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/8] highmem: include asm/kmap_types.h in linux/highmem.h
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:16 +0900
Message-Id: <11371658562238-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures where highmem isn't used, arguments to kmap/unmap are
simply thrown away without being evaluated.  This is fine until a
wrapper function is written.  Even though it got ignored in the end,
the arguments are evaulated.  As asm/highmem.h is not included by
linux/highmem.h when CONFIG_HIGHMEM is off, none of KM_* constants get
defined which results in error if those are evaluated.

This patch makes linux/highmem.h include asm/kmap_types.h regardless
of CONFIG_HIGHMEM.  To deal with the same problem, crypto subsystem
used to include asm/kmap_types.h directly.  This patch kills it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 crypto/internal.h       |    1 -
 include/linux/highmem.h |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

4e0462fa09e87da901867f37b2c7311ef714c3e7
diff --git a/crypto/internal.h b/crypto/internal.h
index 959e602..4188672 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -21,7 +21,6 @@
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
-#include <asm/kmap_types.h>
 
 extern struct list_head crypto_alg_list;
 extern struct rw_semaphore crypto_alg_sem;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6bece92..c605f01 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/kmap_types.h>
 
 #ifdef CONFIG_HIGHMEM
 
-- 
1.0.6


