Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWIRPcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWIRPcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWIRPcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:32:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59065 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751777AbWIRPcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:32:46 -0400
Subject: [TRIVIAL PATCH] mm: Make filemap_nopage use NOPAGE_SIGBUS
From: Adam Litke <agl@us.ibm.com>
To: trivial@kernel.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 10:32:35 -0500
Message-Id: <1158593555.12797.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

