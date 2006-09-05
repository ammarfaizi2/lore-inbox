Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWIEPbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWIEPbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWIEPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:31:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965128AbWIEPbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:31:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060905132530.GD9173@stusta.de> 
References: <20060905132530.GD9173@stusta.de>  <20060901015818.42767813.akpm@osdl.org> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Provide page_mkclean() for NOMMU
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 16:29:33 +0100
Message-ID: <6081.1157470173@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Provide a page_mkclean() implementation for NOMMU.  This doesn't do anything
except return successfully as there are no PTEs for it to play with.

This is only relevant to the -mm kernels.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 nommu-page_mkclean-2618rc5mm1.diff 
 include/linux/rmap.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff -urp ../kernels/linux-2.6.18-rc5-mm1/include/linux/rmap.h linux-2.6.18-rc5-mm1-frv/include/linux/rmap.h
--- ../kernels/linux-2.6.18-rc5-mm1/include/linux/rmap.h	2006-09-04 18:03:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-frv/include/linux/rmap.h	2006-09-05 15:34:35.000000000 +0100
@@ -120,6 +120,12 @@ int page_mkclean(struct page *);
 #define page_referenced(page,l) TestClearPageReferenced(page)
 #define try_to_unmap(page, refs) SWAP_FAIL
 
+static inline int page_mkclean(struct page *page)
+{
+	return 0;
+}
+
+
 #endif	/* CONFIG_MMU */
 
 /*
