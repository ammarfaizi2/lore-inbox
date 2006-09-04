Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWIDHwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWIDHwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWIDHwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:52:19 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:15866 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932464AbWIDHwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:52:17 -0400
Subject: Re: 2.6.18-rc5-mm1: MMU=n compile error
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <20060903221700.GH4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060903221700.GH4416@stusta.de>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 09:44:32 +0200
Message-Id: <1157355872.14324.6.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 00:17 +0200, Adrian Bunk wrote:
> mm-tracking-shared-dirty-pages.patch breaks CONFIG_MMU=n architectures:
> 
> <--  snip  -->
> 
> ....
>   CC      mm/page-writeback.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/page-writeback.c: In function 'test_clear_page_dirty':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/page-writeback.c:867: error: implicit declaration of function 'page_mkclean'
> make[2]: *** [mm/page-writeback.o] Error 1

This might fix it, but I don't have a cross compiler for any nommu arch,
nor an emulator so I can't test. - Will try to build me a toolchain but
this could take some time.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/rmap.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-mm/include/linux/rmap.h
===================================================================
--- linux-mm.orig/include/linux/rmap.h	2006-09-04 08:31:57.000000000 +0200
+++ linux-mm/include/linux/rmap.h	2006-09-04 08:33:44.000000000 +0200
@@ -120,6 +120,8 @@ int page_mkclean(struct page *);
 #define page_referenced(page,l) TestClearPageReferenced(page)
 #define try_to_unmap(page, refs) SWAP_FAIL
 
+#define page_mkclean(page)	(0)
+
 #endif	/* CONFIG_MMU */
 
 /*



-- 
VGER BF report: H 0.393012
