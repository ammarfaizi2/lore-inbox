Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWI1TKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWI1TKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWI1TKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:10:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34026 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751436AbWI1TKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:10:02 -0400
Subject: [TRIVIAL PATCH] mm: Make filemap_nopage use NOPAGE_SIGBUS
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, hugh@veritas.com
Content-Type: text/plain
Organization: IBM
Date: Thu, 28 Sep 2006 19:09:52 +0000
Message-Id: <1159470592.12797.23334.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.  This is just a "nice to have" cleanup patch.  Any chance on
getting it merged (lest I forget about it again)?  Thanks.

While reading trough filemap_nopage() I found the 'return NULL'
statements a bit confusing since we already have two constants defined
for ->nopage error conditions.  Since a NULL return value really means
NOPAGE_SIGBUS, just return that to make the code more readable.

Signed-off-by: Adam Litke <agl@us.ibm.com> 

 filemap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
diff -upN reference/mm/filemap.c current/mm/filemap.c
--- reference/mm/filemap.c
+++ current/mm/filemap.c
@@ -1454,7 +1454,7 @@ outside_data_content:
 	 * accessible..
 	 */
 	if (area->vm_mm == current->mm)
-		return NULL;
+		return NOPAGE_SIGBUS;
 	/* Fall through to the non-read-ahead case */
 no_cached_page:
 	/*
@@ -1479,7 +1479,7 @@ no_cached_page:
 	 */
 	if (error == -ENOMEM)
 		return NOPAGE_OOM;
-	return NULL;
+	return NOPAGE_SIGBUS;
 
 page_not_uptodate:
 	if (!did_readaround) {
@@ -1548,7 +1548,7 @@ page_not_uptodate:
 	 */
 	shrink_readahead_size_eio(file, ra);
 	page_cache_release(page);
-	return NULL;
+	return NOPAGE_SIGBUS;
 }
 EXPORT_SYMBOL(filemap_nopage);
 
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

