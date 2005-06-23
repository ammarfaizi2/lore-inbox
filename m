Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbVFWIT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbVFWIT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVFWIRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:17:12 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:49546 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262571AbVFWHH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:07:29 -0400
Message-ID: <42BA5FA8.7080905@yahoo.com.au>
Date: Thu, 23 Jun 2005 17:07:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
CC: Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: [patch][rfc] 3/5: remove atomic bitop when freeing page
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au>
In-Reply-To: <42BA5F7B.30904@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030309030609000306020200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030309030609000306020200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/5

--------------030309030609000306020200
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

--------------030309030609000306020200--
Send instant messages to your online friends http://au.messenger.yahoo.com 
