Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVGZIXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVGZIXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVGZIWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:22:30 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:20147 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261859AbVGZITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:19:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=5Yld8Ibi6T4pwplkzOIgfpCZBGJGoLGwflkyo19zDwof59HXbvkkcOtUx9nyOuZk7S28cboPQZAm9yi2rlWt5ys/cVIjsgqnHmOQjLbVByTJ8xWmsDBp/zL1Qp8dql3zORVcQCg3Oinqj98rxuNCyLTpvv50sfnn35Z4YlVUYSw=  ;
Message-ID: <42E5F21B.8090900@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:19:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 4/6] mm: remove atomic
References: <42E5F139.70002@yahoo.com.au> <42E5F173.3010409@yahoo.com.au> <42E5F19A.6050407@yahoo.com.au> <42E5F1BF.7060604@yahoo.com.au>
In-Reply-To: <42E5F1BF.7060604@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------000907000908000308050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907000908000308050602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/6

OK, these first 4 patches don't have much to do with removing
PageReserved, but I put them in this series because that's how
I have them arranged.


--------------000907000908000308050602
Content-Type: text/plain;
 name="mm-remove-atomic-bitop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-remove-atomic-bitop.patch"

This bitop does not need to be atomic because it is performed when
there will be no references to the page (ie. the page is being freed).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -329,7 +329,7 @@ static inline void free_pages_check(cons
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))
-		ClearPageDirty(page);
+		__ClearPageDirty(page);
 }
 
 /*
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -194,6 +194,7 @@ extern void __mod_page_state(unsigned lo
 #define SetPageDirty(page)	set_bit(PG_dirty, &(page)->flags)
 #define TestSetPageDirty(page)	test_and_set_bit(PG_dirty, &(page)->flags)
 #define ClearPageDirty(page)	clear_bit(PG_dirty, &(page)->flags)
+#define __ClearPageDirty(page)	__clear_bit(PG_dirty, &(page)->flags)
 #define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)
 
 #define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)

--------------000907000908000308050602--
Send instant messages to your online friends http://au.messenger.yahoo.com 
