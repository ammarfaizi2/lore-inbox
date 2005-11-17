Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVKQRAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVKQRAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKQRAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:00:50 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:63678
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S932416AbVKQRAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:00:49 -0500
Date: Thu, 17 Nov 2005 17:00:31 +0000
To: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] ppc64 need HPAGE_SHIFT when huge pages disabled
Message-ID: <20051117170031.GA30223@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the new powerpc architecture we don't seem to be able to disable
huge pages anymore.

    mm/built-in.o(.toc1+0xae0): undefined reference to `HPAGE_SHIFT'
    make: *** [.tmp_vmlinux1] Error 1

We seem to need to define HPAGE_SHIFT to something when HUGETLB_PAGE isn't
defined.  This patch defines it to 0 when we have no support.

How does this look?  Against 2.6.15-rc1-mm1.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/include/asm-powerpc/page_64.h current/include/asm-powerpc/page_64.h
--- reference/include/asm-powerpc/page_64.h
+++ current/include/asm-powerpc/page_64.h
@@ -86,7 +86,11 @@ static inline void copy_page(void *to, v
 extern u64 ppc64_pft_size;
 
 /* Large pages size */
+#ifdef CONFIG_HUGETLB_PAGE
 extern unsigned int HPAGE_SHIFT;
+#else
+#define HPAGE_SHIFT 0
+#endif
 #define HPAGE_SIZE		((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
